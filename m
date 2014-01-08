Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389194371-14595-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389194371-14595-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 8 Jan 2014 17:47:53 +0200
Message-ID: <CABBYNZLEtf5E3r2mGUsp1xipyTUG07ovpNzUpn1WasysOyzS5A@mail.gmail.com>
Subject: Re: [PATCH v2] android/audio: Add listener thread on the Audio HAL socket
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Jan 8, 2014 at 5:19 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> This patch add thread which is reponsible for listen on audio HAL
> socket, open a2dp endpoint(s) and maintain socket.
> When bluetooth daemon goes down, HAL audio plugin starts to listen on Audio HAL
> socket again.
>
> ---
>  android/Makefile.am |   5 ++-
>  android/hal-audio.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 129 insertions(+), 2 deletions(-)
>
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 8810369..88ffa7f 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -112,7 +112,8 @@ android_android_tester_LDFLAGS = -pthread
>
>  noinst_LTLIBRARIES += android/libaudio-internal.la
>
> -android_libaudio_internal_la_SOURCES = android/hal-audio.c \
> +android_libaudio_internal_la_SOURCES = androdid/audio-msg.h \
> +                                       android/hal-audio.c \
>                                         android/hardware/audio.h \
>                                         android/hardware/audio_effect.h \
>                                         android/hardware/hardware.h \
> @@ -120,6 +121,8 @@ android_libaudio_internal_la_SOURCES = android/hal-audio.c \
>
>  android_libaudio_internal_la_CFLAGS = -I$(srcdir)/android
>
> +android_libaudio_internal_la_LDFLAGS = -pthread
> +
>  endif
>
>  EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index 1743b42..12d3e0d 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -16,15 +16,28 @@
>   */
>
>  #include <errno.h>
> +#include <pthread.h>
> +#include <poll.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include <unistd.h>
>
>  #include <hardware/audio.h>
>  #include <hardware/hardware.h>
>
> +#include "audio-msg.h"
>  #include "hal-log.h"
>
> +static int audio_sk = -1;
> +static bool close_thread = false;
> +
> +static pthread_t bt_watcher_th = 0;
> +static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
> +static pthread_mutex_t close_mutex = PTHREAD_MUTEX_INITIALIZER;
> +
>  struct a2dp_audio_dev {
>         struct audio_hw_device dev;
>         struct audio_stream_out *out;
> @@ -384,15 +397,117 @@ static int audio_dump(const audio_hw_device_t *device, int fd)
>
>  static int audio_close(hw_device_t *device)
>  {
> +       struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)device;
> +
>         DBG("");
> -       free(device);
> +
> +       pthread_mutex_lock(&close_mutex);
> +       shutdown(audio_sk, SHUT_RDWR);
> +       close_thread = true;
> +       pthread_mutex_unlock(&close_mutex);
> +
> +       pthread_join(bt_watcher_th, NULL);
> +
> +       free(a2dp_dev);
>         return 0;
>  }
>
> +static bool create_audio_ipc(void)
> +{
> +       struct sockaddr_un addr;
> +       int err;
> +       int sk;
> +
> +       DBG("");
> +
> +       sk = socket(PF_LOCAL, SOCK_SEQPACKET, 0);
> +       if (sk < 0) {
> +               err = errno;
> +               error("Failed to create socket: %d (%s)", err, strerror(err));
> +               return false;
> +       }
> +
> +       memset(&addr, 0, sizeof(addr));
> +       addr.sun_family = AF_UNIX;
> +
> +       memcpy(addr.sun_path, BLUEZ_AUDIO_SK_PATH,
> +                                       sizeof(BLUEZ_AUDIO_SK_PATH));
> +
> +       if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> +               err = errno;
> +               error("Failed to bind socket: %d (%s)", err, strerror(err));
> +               goto failed;
> +       }
> +
> +       if (listen(sk, 1) < 0) {
> +               err = errno;
> +               error("Failed to listen on the socket: %d (%s)", err,
> +                                                               strerror(err));
> +               goto failed;
> +       }
> +
> +       audio_sk = accept(sk, NULL, NULL);
> +       if (audio_sk < 0) {
> +               err = errno;
> +               error("Failed to accept socket: %d (%s)", err, strerror(err));
> +               goto failed;
> +       }
> +
> +       close(sk);
> +       return true;
> +
> +failed:
> +       close(sk);
> +       return false;
> +}
> +
> +static void *bluetoothd_watcher_thread(void *data)
> +{
> +       bool done = false;
> +       struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) data;
> +       struct pollfd pfd;
> +
> +       DBG("");
> +
> +       while (!done) {
> +               if(!create_audio_ipc()) {
> +                       error("Failed to create listening socket");
> +                       sleep(1);
> +                       continue;
> +               }
> +
> +               DBG("Audio IPC: Connected");
> +
> +               /* TODO: Register ENDPOINT here */
> +
> +               memset(&pfd, 0, sizeof(pfd));
> +               pfd.fd = audio_sk;
> +               pfd.events = POLLHUP | POLLERR | POLLNVAL;
> +
> +               /* Check if socket is still alive. Empty while loop.*/
> +               while (poll(&pfd, 1, -1) < 0 && errno == EINTR);
> +
> +               if (pfd.revents & (POLLHUP | POLLERR | POLLNVAL)) {
> +                       info("Audio HAL: Socket closed");
> +                       audio_sk = -1;
> +               }
> +
> +               /*Check if audio_dev is closed */
> +               pthread_mutex_lock(&close_mutex);
> +               done = close_thread;
> +               close_thread = false;
> +               pthread_mutex_unlock(&close_mutex);
> +       }
> +
> +       info("Closing bluetooth_watcher thread");
> +       return NULL;
> +}
> +
>  static int audio_open(const hw_module_t *module, const char *name,
>                                                         hw_device_t **device)
>  {
>         struct a2dp_audio_dev *a2dp_dev;
> +       int err;
>
>         DBG("");
>
> @@ -430,6 +545,15 @@ static int audio_open(const hw_module_t *module, const char *name,
>          * audio_hw_device. We will rely on this later in the code.*/
>         *device = &a2dp_dev->dev.common;
>
> +       err = pthread_create(&bt_watcher_th, NULL, bluetoothd_watcher_thread,
> +                                                                       NULL);
> +       if (err < 0) {
> +               bt_watcher_th = 0;
> +               error("Failed to start bluetoothd watcher thread: %d (%s)",
> +                                                       -err, strerror(-err));
> +               return (-err);
> +       }
> +
>         return 0;
>  }
>
> --
> 1.8.4

Pushed after stripping out some code not really used and fix a type in
Makefile.am.


-- 
Luiz Augusto von Dentz
