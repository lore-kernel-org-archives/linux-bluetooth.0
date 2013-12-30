Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMudyAv386wWW8YQKY9u_6SV6ZaSijwxm=qud0rk6sTtKsgRog@mail.gmail.com>
References: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1388398647-25420-7-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZKAqa=conbeaakt_hE1p_bqOsiGritjqvCf8JYiWAwQUA@mail.gmail.com>
	<CAMudyAv386wWW8YQKY9u_6SV6ZaSijwxm=qud0rk6sTtKsgRog@mail.gmail.com>
Date: Mon, 30 Dec 2013 15:07:23 +0200
Message-ID: <CABBYNZK-c_AD2ZkxGs0XE4SkNwGnVxNByv-c-erV9DFJ9mry_w@mail.gmail.com>
Subject: Re: [RFC 6/6] android/audio: Add listener thread on the Audio HAL socket
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Dec 30, 2013 at 1:40 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Hi Luiz,
>
> On 30 December 2013 12:31, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> Hi Lukasz,
>>
>> On Mon, Dec 30, 2013 at 12:17 PM, Lukasz Rymanowski
>> <lukasz.rymanowski@tieto.com> wrote:
>>> This patch add thread which is reponsible for listen on audio HAL
>>> socket, register a2dp endpoint(s) and maintain socket.
>>> When bluetooth daemon goes down, HAL audio plugin starts to listen on Audio HAL
>>> socket again.
>>>
>>> ---
>>>  android/Makefile.am |   2 +
>>>  android/hal-audio.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  android/hal-audio.h |  18 +++++++
>>>  3 files changed, 165 insertions(+)
>>>  create mode 100644 android/hal-audio.h
>>>
>>> diff --git a/android/Makefile.am b/android/Makefile.am
>>> index eaf39bd..bd90c13 100644
>>> --- a/android/Makefile.am
>>> +++ b/android/Makefile.am
>>> @@ -112,6 +112,8 @@ android_libaudio_internal_la_SOURCES = android/hal-audio.c \
>>>
>>>  android_libaudio_internal_la_CFLAGS = -I$(srcdir)/android
>>>
>>> +android_libaudio_internal_la_LDFLAGS = -pthread
>>> +
>>>  endif
>>>
>>>  EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
>>> diff --git a/android/hal-audio.c b/android/hal-audio.c
>>> index 011a699..0e3bc70 100644
>>> --- a/android/hal-audio.c
>>> +++ b/android/hal-audio.c
>>> @@ -16,18 +16,30 @@
>>>   */
>>>
>>>  #include <errno.h>
>>> +#include <pthread.h>
>>> +#include <poll.h>
>>>  #include <stdio.h>
>>>  #include <stdlib.h>
>>>  #include <string.h>
>>> +#include <sys/socket.h>
>>> +#include <sys/un.h>
>>> +#include <unistd.h>
>>>
>>>  #include <hardware/audio.h>
>>>  #include <hardware/hardware.h>
>>>
>>> +#include "hal-audio.h"
>>>  #include "hal-log.h"
>>>
>>>  struct a2dp_audio_dev {
>>>         struct audio_hw_device dev;
>>>         struct a2dp_stream_out *stream_out;
>>> +
>>> +       pthread_t bt_watcher;
>>> +       pthread_mutex_t hal_sk_mutex;
>>> +       pthread_cond_t bt_watcher_cond;
>>> +
>>> +       int hal_sk;
>>>  };
>>>
>>>  struct a2dp_stream_out {
>>> @@ -384,15 +396,135 @@ static int audio_dump(const audio_hw_device_t *device, int fd)
>>>
>>>  static int audio_close(hw_device_t *device)
>>>  {
>>> +       struct audio_hw_device *dev = (struct audio_hw_device *)device;
>>> +       struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)dev;
>>> +

Hmm, Im afraid these are not the same pointers as you do  *device =
&a2dp_dev->dev.common; so this will probably cause invalid accesses.

>>>         DBG("");
>>> +
>>> +       if (a2dp_dev) {
>>> +               /* TODO: We could try to unregister Endpoint here */
>>> +               shutdown(a2dp_dev->hal_sk, 2);
>>> +
>>> +               pthread_mutex_lock(&a2dp_dev->hal_sk_mutex);
>>> +               pthread_cond_signal(&a2dp_dev->bt_watcher_cond);
>>> +               pthread_mutex_unlock(&a2dp_dev->hal_sk_mutex);
>>> +
>>> +               (void) pthread_join(a2dp_dev->bt_watcher, NULL);
>>> +               free(a2dp_dev);
>>> +       }
>>> +
>>>         free(device);
>>>         return 0;
>>>  }
>>>
>>> +static int wait_for_client(void)
>>> +{
>>> +       struct sockaddr_un addr;
>>> +       int err;
>>> +       int sk;
>>> +       int new_sk;
>>> +
>>> +       DBG("");
>>> +
>>> +       sk = socket(PF_LOCAL, SOCK_SEQPACKET, 0);
>>> +       if (sk < 0) {
>>> +               err = errno;
>>> +               error("Failed to create socket: %d (%s)", err, strerror(err));
>>> +               return -1;
>>> +       }
>>> +
>>> +       memset(&addr, 0, sizeof(addr));
>>> +       addr.sun_family = AF_UNIX;
>>> +
>>> +       memcpy(addr.sun_path, BLUEZ_AUDIO_HAL_SK_PATH,
>>> +                                       sizeof(BLUEZ_AUDIO_HAL_SK_PATH));
>>> +
>>> +       if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
>>> +               err = errno;
>>> +               error("Failed to bind socket: %d (%s)", err, strerror(err));
>>> +               goto error;
>>> +       }
>>> +
>>> +       if (listen(sk, 1) < 0) {
>>> +               err = errno;
>>> +               error("Failed to bind socket: %d (%s)", err, strerror(err));
>>> +               goto error;
>>> +       }
>>> +
>>> +       new_sk = accept(sk, NULL, NULL);
>>> +       if (new_sk < 0) {
>>> +               err = errno;
>>> +               error("Failed to accept socket: %d (%s)", err, strerror(err));
>>> +               goto error;
>>> +       }
>>> +
>>> +       close(sk);
>>> +       return new_sk;
>>> +
>>> +error:
>>> +       close(sk);
>>> +       return -1;
>>> +}
>>> +
>>> +static void *bluetoothd_watcher(void *data)
>>> +{
>>> +       int err;
>>> +       struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)data;
>>> +       struct pollfd pfd;
>>> +       struct timeval now;
>>> +       struct timespec timeout;
>>> +
>>> +       DBG("");
>>> +
>>> +       while (1) {
>>> +               a2dp_dev->hal_sk = wait_for_client();
>>> +               if (a2dp_dev->hal_sk < 0) {
>>> +                       error("Failed to create listening socket");
>>> +                       continue;
>>> +               }
>>> +
>>> +               DBG("Audio IPC: Connected");
>>> +
>>> +               /* TODO: Register ENDPOINT here */
>>> +
>>> +               memset(&pfd, 0, sizeof(pfd));
>>> +               pfd.fd = a2dp_dev->hal_sk;
>>> +               pfd.events = POLLHUP | POLLERR | POLLNVAL;
>>> +
>>> +               pthread_mutex_lock(&a2dp_dev->hal_sk_mutex);
>>> +
>>> +               /* Check if socket is still alive */
>>> +               err = poll(&pfd, 1, -1);
>>> +               if (pfd.revents & (POLLHUP | POLLERR | POLLNVAL)) {
>>> +                       info("Audio HAL: Socket closed");
>>> +                       a2dp_dev->hal_sk = -1;
>>> +               }
>>> +
>>> +               /* Maybe audio system is closing and audio_close() has been called? */
>>> +               gettimeofday(&now, NULL);
>>> +               timeout.tv_sec = now.tv_sec;
>>> +               timeout.tv_nsec = now.tv_usec * 1000;
>>> +               timeout.tv_sec += 1;
>>> +
>>> +               err = pthread_cond_timedwait(&a2dp_dev->bt_watcher_cond,
>>> +                                       &a2dp_dev->hal_sk_mutex, &timeout);
>>> +
>>> +               pthread_mutex_unlock(&a2dp_dev->hal_sk_mutex);
>>> +               if (err != ETIMEDOUT)
>>> +                       /* Seems that device has been closed */
>>> +                       break;
>>> +       }
>>> +
>>> +       info("Closing bluetooth_watcher thread");
>>> +       pthread_exit(NULL);
>>> +       return NULL;
>>> +}
>>> +
>>>  static int audio_open(const hw_module_t *module, const char *name,
>>>                                                         hw_device_t **device)
>>>  {
>>>         struct a2dp_audio_dev *a2dp_dev;
>>> +       int err;
>>>
>>>         DBG("");
>>>
>>> @@ -427,6 +559,19 @@ static int audio_open(const hw_module_t *module, const char *name,
>>>
>>>         *device = &a2dp_dev->dev.common;
>>>
>>> +       a2dp_dev->hal_sk = -1;
>>> +
>>> +       pthread_mutex_init(&a2dp_dev->hal_sk_mutex, NULL);
>>> +       pthread_cond_init(&a2dp_dev->bt_watcher_cond, NULL);
>>> +
>>> +       err = pthread_create(&a2dp_dev->bt_watcher, NULL, bluetoothd_watcher, a2dp_dev);
>>> +       if (err < 0) {
>>> +               a2dp_dev->bt_watcher = 0;
>>> +               error("Failed to start bluetoothd watcher thread: %d (%s)", -err,
>>> +                                                               strerror(-err));
>>> +               return (-err);
>>> +       }
>>> +
>>>         return 0;
>>>  }
>>>
>>> diff --git a/android/hal-audio.h b/android/hal-audio.h
>>> new file mode 100644
>>> index 0000000..93e49f6
>>> --- /dev/null
>>> +++ b/android/hal-audio.h
>>> @@ -0,0 +1,18 @@
>>> +/*
>>> + *
>>> + * Copyright (C) 2013 Intel Corporation
>>> + *
>>> + * Licensed under the Apache License, Version 2.0 (the "License");
>>> + * you may not use this file except in compliance with the License.
>>> + * You may obtain a copy of the License at
>>> + *
>>> + *      http://www.apache.org/licenses/LICENSE-2.0
>>> + *
>>> + * Unless required by applicable law or agreed to in writing, software
>>> + * distributed under the License is distributed on an "AS IS" BASIS,
>>> + * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
>>> + * See the License for the specific language governing permissions and
>>> + * limitations under the License.
>>> + *
>>> + */
>>> +static const char BLUEZ_AUDIO_HAL_SK_PATH[] = "\0bluez_audio_socket";
>>> --
>>> 1.8.4
>>
>> Ive started working on the daemon side and should be able to post some
>> patches today, Im not really sure we are going to need a thread for
>> command handling since all the commands will be sent by the plugin
>> side so they can be synchronous, the only problem would be if the
>> plugin cannot really block even for a short period.
>>
>
> This Thread is only going to be used for accept, endpoint register and
> then listening for socket close (so we can start listen for connection
> from new bluetoothd).
>
> Commands and response will be handled in main thread (ex.
> audio_open(), out_write()) and we can block there for a while - no
> problem with that

Well it seems the init/listen stage needs to be non-blocking so we
don't interrupt the audio init procedure which may block bluetooth HAL
to initialized, the endpoint then should be registered whenever
bluetoothd connects.


-- 
Luiz Augusto von Dentz
