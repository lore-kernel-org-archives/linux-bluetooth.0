Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <11367506.YxsQHOxC66@uw000953>
References: <1397737431-6101-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1397737431-6101-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<11367506.YxsQHOxC66@uw000953>
Date: Tue, 22 Apr 2014 18:36:44 +0300
Message-ID: <CABBYNZ+oiMONBoVxeLKEAWXCvqG3cd5T5BjFKhzBVFFOYJE3GQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] android/hal-audio: Add SCO audio API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Apr 17, 2014 at 4:20 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Andrei,
>
> On Thursday 17 of April 2014 15:23:49 Andrei Emeltchenko wrote:
>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>
>> ---
>>  android/audio-msg.h     |   6 +-
>>  android/hal-audio-hsp.c | 314 +++++++++++++++++++++++++++++++++++++++++++++++-
>>  android/handsfree.c     |  42 +++++++
>>  3 files changed, 358 insertions(+), 4 deletions(-)
>>
>> diff --git a/android/audio-msg.h b/android/audio-msg.h
>> index 5981355..d247c80 100644
>> --- a/android/audio-msg.h
>> +++ b/android/audio-msg.h
>> @@ -24,9 +24,11 @@
>>  #define BLUEZ_AUDIO_MTU 1024
>>
>>  static const char BLUEZ_AUDIO_SK_PATH[] = "\0bluez_audio_socket";
>> +static const char BLUEZ_AUDIO_SCO_SK_PATH[] = "\0bluez_audio_sco_socket";
>>
>>  #define AUDIO_SERVICE_ID             0
>> -#define AUDIO_SERVICE_ID_MAX         AUDIO_SERVICE_ID
>> +#define AUDIO_SERVICE_SCO_ID         1
>> +#define AUDIO_SERVICE_ID_MAX         AUDIO_SERVICE_SCO_ID
>>
>>  #define AUDIO_STATUS_SUCCESS         IPC_STATUS_SUCCESS
>>  #define AUDIO_STATUS_FAILED          0x01
>> @@ -79,3 +81,5 @@ struct audio_cmd_resume_stream {
>>  struct audio_cmd_suspend_stream {
>>       uint8_t id;
>>  } __attribute__((packed));
>> +
>> +#define AUDIO_OP_SCO_GET_FD          0x01

Is this supposed to work with HFP/WBS or just basic HSP? Btw, we
probably can create a loopback for testing in via hal-tester, so
whatever you say on the mic should return to the headset speakers.

>> diff --git a/android/hal-audio-hsp.c b/android/hal-audio-hsp.c
>> index 992066c..cac6c8d 100644
>> --- a/android/hal-audio-hsp.c
>> +++ b/android/hal-audio-hsp.c
>> @@ -16,13 +16,20 @@
>>   */
>>
>>  #include <errno.h>
>> +#include <pthread.h>
>> +#include <poll.h>
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <string.h>
>> +#include <sys/socket.h>
>> +#include <sys/un.h>
>> +#include <unistd.h>
>>
>>  #include <hardware/audio.h>
>>  #include <hardware/hardware.h>
>>
>> +#include "audio-msg.h"
>> +#include "ipc-common.h"
>>  #include "hal-log.h"
>>
>>  #define AUDIO_STREAM_DEFAULT_RATE    44100
>> @@ -30,6 +37,12 @@
>>
>>  #define OUT_BUFFER_SIZE                      2560
>>
>> +static int listen_sk = -1;
>> +static int audio_sk = -1;
>> +
>> +static pthread_t ipc_th = 0;
>> +static pthread_mutex_t sk_mutex = PTHREAD_MUTEX_INITIALIZER;
>> +
>>  struct hsp_audio_config {
>>       uint32_t rate;
>>       uint32_t channels;
>> @@ -38,7 +51,9 @@ struct hsp_audio_config {
>>
>>  struct hsp_stream_out {
>>       struct audio_stream_out stream;
>> +
>>       struct hsp_audio_config cfg;
>> +     int fd;
>>  };
>>
>>  struct hsp_audio_dev {
>> @@ -46,13 +61,178 @@ struct hsp_audio_dev {
>>       struct hsp_stream_out *out;
>>  };
>>
>> +/* Audio IPC functions */
>> +
>> +static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
>> +                     void *param, size_t *rsp_len, void *rsp, int *fd)
>> +{
>
> This is going to be third copy of HAL side command handling. Maybe it is time
> to re-factor code out and make it reusable? Same as was done for daemon part.

Maybe we should create a file to accommodate this is a single place,
how about audio-ipc or just audio{c,h}.

>> +     ssize_t ret;
>> +     struct msghdr msg;
>> +     struct iovec iv[2];
>> +     struct ipc_hdr cmd;
>> +     char cmsgbuf[CMSG_SPACE(sizeof(int))];
>> +     struct ipc_status s;
>> +     size_t s_len = sizeof(s);
>> +
>> +     pthread_mutex_lock(&sk_mutex);
>> +
>> +     if (audio_sk < 0) {
>> +             error("audio: Invalid cmd socket passed to audio_ipc_cmd");
>> +             goto failed;
>> +     }
>> +
>> +     if (!rsp || !rsp_len) {
>> +             memset(&s, 0, s_len);
>> +             rsp_len = &s_len;
>> +             rsp = &s;
>> +     }
>> +
>> +     memset(&msg, 0, sizeof(msg));
>> +     memset(&cmd, 0, sizeof(cmd));
>> +
>> +     cmd.service_id = service_id;
>> +     cmd.opcode = opcode;
>> +     cmd.len = len;
>> +
>> +     iv[0].iov_base = &cmd;
>> +     iv[0].iov_len = sizeof(cmd);
>> +
>> +     iv[1].iov_base = param;
>> +     iv[1].iov_len = len;
>> +
>> +     msg.msg_iov = iv;
>> +     msg.msg_iovlen = 2;
>> +
>> +     ret = sendmsg(audio_sk, &msg, 0);
>> +     if (ret < 0) {
>> +             error("audio: Sending command failed:%s", strerror(errno));
>> +             goto failed;
>> +     }
>> +
>> +     /* socket was shutdown */
>> +     if (ret == 0) {
>> +             error("audio: Command socket closed");
>> +             goto failed;
>> +     }
>> +
>> +     memset(&msg, 0, sizeof(msg));
>> +     memset(&cmd, 0, sizeof(cmd));
>> +
>> +     iv[0].iov_base = &cmd;
>> +     iv[0].iov_len = sizeof(cmd);
>> +
>> +     iv[1].iov_base = rsp;
>> +     iv[1].iov_len = *rsp_len;
>> +
>> +     msg.msg_iov = iv;
>> +     msg.msg_iovlen = 2;
>> +
>> +     if (fd) {
>> +             memset(cmsgbuf, 0, sizeof(cmsgbuf));
>> +             msg.msg_control = cmsgbuf;
>> +             msg.msg_controllen = sizeof(cmsgbuf);
>> +     }
>> +
>> +     ret = recvmsg(audio_sk, &msg, 0);
>> +     if (ret < 0) {
>> +             error("audio: Receiving command response failed:%s",
>> +                                                     strerror(errno));
>> +             goto failed;
>> +     }
>> +
>> +     if (ret < (ssize_t) sizeof(cmd)) {
>> +             error("audio: Too small response received(%zd bytes)", ret);
>> +             goto failed;
>> +     }
>> +
>> +     if (cmd.service_id != service_id) {
>> +             error("audio: Invalid service id (%u vs %u)", cmd.service_id,
>> +                                                             service_id);
>> +             goto failed;
>> +     }
>> +
>> +     if (ret != (ssize_t) (sizeof(cmd) + cmd.len)) {
>> +             error("audio: Malformed response received(%zd bytes)", ret);
>> +             goto failed;
>> +     }
>> +
>> +     if (cmd.opcode != opcode && cmd.opcode != AUDIO_OP_STATUS) {
>> +             error("audio: Invalid opcode received (%u vs %u)",
>> +                                             cmd.opcode, opcode);
>> +             goto failed;
>> +     }
>> +
>> +     if (cmd.opcode == AUDIO_OP_STATUS) {
>> +             struct ipc_status *s = rsp;
>> +
>> +             if (sizeof(*s) != cmd.len) {
>> +                     error("audio: Invalid status length");
>> +                     goto failed;
>> +             }
>> +
>> +             if (s->code == AUDIO_STATUS_SUCCESS) {
>> +                     error("audio: Invalid success status response");
>> +                     goto failed;
>> +             }
>> +
>> +             pthread_mutex_unlock(&sk_mutex);
>> +
>> +             return s->code;
>> +     }
>> +
>> +     pthread_mutex_unlock(&sk_mutex);
>> +
>> +     /* Receive auxiliary data in msg */
>> +     if (fd) {
>> +             struct cmsghdr *cmsg;
>> +
>> +             *fd = -1;
>> +
>> +             for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
>> +                                     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
>> +                     if (cmsg->cmsg_level == SOL_SOCKET
>> +                                     && cmsg->cmsg_type == SCM_RIGHTS) {
>> +                             memcpy(fd, CMSG_DATA(cmsg), sizeof(int));
>> +                             break;
>> +                     }
>> +             }
>> +
>> +             if (*fd < 0)
>> +                     goto failed;
>> +     }
>> +
>> +     if (rsp_len)
>> +             *rsp_len = cmd.len;
>> +
>> +     return AUDIO_STATUS_SUCCESS;
>> +
>> +failed:
>> +     /* Some serious issue happen on IPC - recover */
>> +     shutdown(audio_sk, SHUT_RDWR);
>> +     pthread_mutex_unlock(&sk_mutex);
>> +
>> +     return AUDIO_STATUS_FAILED;
>> +}
>> +
>> +static int ipc_get_sco_fd(int *fd)
>> +{
>> +     DBG("");
>> +
>> +     return audio_ipc_cmd(AUDIO_SERVICE_SCO_ID, AUDIO_OP_SCO_GET_FD, 0,
>> +                                                     NULL, NULL, NULL, fd);
>> +}
>> +
>>  /* Audio stream functions */
>>
>>  static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
>>                                                               size_t bytes)
>>  {
>> +     struct hsp_stream_out *out = (struct hsp_stream_out *) stream;
>> +
>>       /* write data */
>>
>> +     DBG("write to fd %d bytes %zu", out->fd, bytes);
>> +
>>       return bytes;
>>  }
>>
>> @@ -60,7 +240,7 @@ static uint32_t out_get_sample_rate(const struct audio_stream *stream)
>>  {
>>       struct hsp_stream_out *out = (struct hsp_stream_out *) stream;
>>
>> -     DBG("");
>> +     DBG("rate %u", out->cfg.rate);
>>
>>       return out->cfg.rate;
>>  }
>> @@ -74,7 +254,7 @@ static int out_set_sample_rate(struct audio_stream *stream, uint32_t rate)
>>
>>  static size_t out_get_buffer_size(const struct audio_stream *stream)
>>  {
>> -     DBG("");
>> +     DBG("buf size %u", OUT_BUFFER_SIZE);
>>
>>       return OUT_BUFFER_SIZE;
>>  }
>> @@ -182,9 +362,17 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
>>  {
>>       struct hsp_audio_dev *adev = (struct hsp_audio_dev *) dev;
>>       struct hsp_stream_out *out;
>> +     int fd = -1;
>>
>>       DBG("");
>>
>> +     if (!ipc_get_sco_fd(&fd)) {
>> +             error("audio: cannot get fd");
>> +             return -EIO;
>> +     }
>> +
>> +     DBG("got sco fd %d", fd);
>> +
>>       out = calloc(1, sizeof(struct hsp_stream_out));
>>       if (!out)
>>               return -ENOMEM;
>> @@ -212,6 +400,7 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
>>
>>       *stream_out = &out->stream;
>>       adev->out = out;
>> +     out->fd = fd;
>>
>>       return 0;
>>  }
>> @@ -219,9 +408,17 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
>>  static void audio_close_output_stream(struct audio_hw_device *dev,
>>                                       struct audio_stream_out *stream_out)
>>  {
>> -     DBG("");
>> +     struct hsp_audio_dev *hsp_dev = (struct hsp_audio_dev *) dev;
>> +
>> +     DBG("dev %p stream %p fd %d", dev, stream_out, hsp_dev->out->fd);
>> +
>> +     if (hsp_dev->out && hsp_dev->out->fd) {
>> +             close(hsp_dev->out->fd);
>> +             hsp_dev->out->fd = -1;
>> +     }

It is probably a good idea to shutdown before close since the daemon
also have a reference to it.

>>       free(stream_out);
>> +     hsp_dev->out = NULL;
>>  }
>>
>>  static int audio_set_parameters(struct audio_hw_device *dev,
>> @@ -325,10 +522,117 @@ static int audio_close(hw_device_t *device)
>>       return 0;
>>  }
>>
>> +static void *ipc_handler(void *data)
>> +{
>> +     bool done = false;
>> +     struct pollfd pfd;
>> +     int sk;
>> +
>> +     DBG("");
>> +
>> +     while (!done) {
>> +             DBG("Waiting for connection ...");
>> +
>> +             sk = accept(listen_sk, NULL, NULL);
>> +             if (sk < 0) {
>> +                     int err = errno;
>> +
>> +                     if (err == EINTR)
>> +                             continue;
>> +
>> +                     if (err != ECONNABORTED && err != EINVAL)
>> +                             error("audio: Failed to accept socket: %d (%s)",
>> +                                                     err, strerror(err));
>> +
>> +                     break;
>> +             }
>> +
>> +             pthread_mutex_lock(&sk_mutex);
>> +             audio_sk = sk;
>> +             pthread_mutex_unlock(&sk_mutex);
>> +
>> +             DBG("Audio IPC: Connected");
>> +
>> +             memset(&pfd, 0, sizeof(pfd));
>> +             pfd.fd = audio_sk;
>> +             pfd.events = POLLHUP | POLLERR | POLLNVAL;
>> +
>> +             /* Check if socket is still alive. Empty while loop.*/
>> +             while (poll(&pfd, 1, -1) < 0 && errno == EINTR);
>> +
>> +             if (pfd.revents & (POLLHUP | POLLERR | POLLNVAL)) {
>> +                     info("Audio HAL: Socket closed");
>> +
>> +                     pthread_mutex_lock(&sk_mutex);
>> +                     close(audio_sk);
>> +                     audio_sk = -1;
>> +                     pthread_mutex_unlock(&sk_mutex);
>> +             }
>> +     }
>> +
>> +     info("Closing Audio IPC thread");
>> +     return NULL;
>> +}
>> +
>> +static int audio_ipc_init(void)
>> +{
>> +     struct sockaddr_un addr;
>> +     int err;
>> +     int sk;
>> +
>> +     DBG("");
>> +
>> +     sk = socket(PF_LOCAL, SOCK_SEQPACKET, 0);
>> +     if (sk < 0) {
>> +             err = -errno;
>> +             error("audio: Failed to create socket: %d (%s)", -err,
>> +                                                             strerror(-err));
>> +             return err;
>> +     }
>> +
>> +     memset(&addr, 0, sizeof(addr));
>> +     addr.sun_family = AF_UNIX;
>> +
>> +     memcpy(addr.sun_path, BLUEZ_AUDIO_SCO_SK_PATH,
>> +                                     sizeof(BLUEZ_AUDIO_SCO_SK_PATH));
>> +
>> +     if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
>> +             err = -errno;
>> +             error("audio: Failed to bind socket: %d (%s)", -err,
>> +                                                             strerror(-err));
>> +             goto failed;
>> +     }
>> +
>> +     if (listen(sk, 1) < 0) {
>> +             err = -errno;
>> +             error("audio: Failed to listen on the socket: %d (%s)", -err,
>> +                                                             strerror(-err));
>> +             goto failed;
>> +     }
>> +
>> +     listen_sk = sk;
>> +
>> +     err = pthread_create(&ipc_th, NULL, ipc_handler, NULL);
>> +     if (err) {
>> +             err = -err;
>> +             ipc_th = 0;
>> +             error("audio: Failed to start Audio IPC thread: %d (%s)",
>> +                                                     -err, strerror(-err));
>> +             goto failed;
>> +     }
>> +
>> +     return 0;
>> +
>> +failed:
>> +     close(sk);
>> +     return err;
>> +}
>> +
>>  static int audio_open(const hw_module_t *module, const char *name,
>>                                                       hw_device_t **device)
>>  {
>>       struct hsp_audio_dev *adev;
>> +     int err;
>>
>>       DBG("");
>>
>> @@ -338,6 +642,10 @@ static int audio_open(const hw_module_t *module, const char *name,
>>               return -EINVAL;
>>       }
>>
>> +     err = audio_ipc_init();
>> +     if (err < 0)
>> +             return err;
>> +
>>       adev = calloc(1, sizeof(struct hsp_audio_dev));
>>       if (!adev)
>>               return -ENOMEM;
>> diff --git a/android/handsfree.c b/android/handsfree.c
>> index c8026a0..55e151a 100644
>> --- a/android/handsfree.c
>> +++ b/android/handsfree.c
>> @@ -45,6 +45,7 @@
>>  #include "bluetooth.h"
>>  #include "src/log.h"
>>  #include "utils.h"
>> +#include "audio-msg.h"
>>
>>  #define HSP_AG_CHANNEL 12
>>  #define HFP_AG_CHANNEL 13
>> @@ -156,7 +157,9 @@ static struct {
>>  static uint32_t hfp_ag_features = 0;
>>
>>  static bdaddr_t adapter_addr;
>> +
>>  static struct ipc *hal_ipc = NULL;
>> +static struct ipc *audio_ipc = NULL;
>>
>>  static uint32_t hfp_record_id = 0;
>>  static GIOChannel *hfp_server = NULL;
>> @@ -2563,6 +2566,42 @@ static void disable_sco_server(void)
>>       }
>>  }
>>
>> +static void bt_audio_sco_get_fd(const void *buf, uint16_t len)
>> +{
>> +     int fd = -1;
>> +
>> +     connect_audio();
>> +
>> +     if (device.sco)
>> +             fd = g_io_channel_unix_get_fd(device.sco);
>> +
>> +     DBG("sco fd %d", fd);
>> +
>> +     ipc_send_rsp_full(audio_ipc, AUDIO_SERVICE_SCO_ID, AUDIO_OP_SCO_GET_FD,
>> +                                                             0, NULL, fd);
>> +}
>> +
>> +static const struct ipc_handler audio_handlers[] = {
>> +     /* AUDIO_OP_SCO_GET_FD */
>> +     { bt_audio_sco_get_fd, false, 0 }
>> +};
>> +
>> +static bool bt_audio_register(ipc_disconnect_cb disconnect)
>> +{
>> +     DBG("");
>> +
>> +     audio_ipc = ipc_init(BLUEZ_AUDIO_SCO_SK_PATH,
>> +                             sizeof(BLUEZ_AUDIO_SCO_SK_PATH),
>> +                             AUDIO_SERVICE_ID_MAX, false, disconnect, NULL);
>> +     if (!audio_ipc)
>> +             return false;
>> +
>> +     ipc_register(audio_ipc, AUDIO_SERVICE_SCO_ID, audio_handlers,
>> +                                             G_N_ELEMENTS(audio_handlers));
>> +
>> +     return true;
>> +}
>> +
>>  bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
>>  {
>>       DBG("mode 0x%x", mode);
>> @@ -2597,6 +2636,9 @@ done:
>>       hal_ipc = ipc;
>>       ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
>>                                               G_N_ELEMENTS(cmd_handlers));
>> +
>> +     bt_audio_register(NULL);
>> +
>
> You are missing cleanup tasks for this.
>
> Also, do we want to always load it? Maybe it should be configurable?
>
>>       return true;
>>  }
>>
>>
>
> --
> Best regards,
> Szymon Janc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
