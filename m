Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAN_7+YZs8y-+xcYtJu39MToF5oMu9XGvFfCGCGgacA4doOVM2g@mail.gmail.com>
References: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1388398647-25420-7-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZKAqa=conbeaakt_hE1p_bqOsiGritjqvCf8JYiWAwQUA@mail.gmail.com>
	<CAMudyAv386wWW8YQKY9u_6SV6ZaSijwxm=qud0rk6sTtKsgRog@mail.gmail.com>
	<CABBYNZK-c_AD2ZkxGs0XE4SkNwGnVxNByv-c-erV9DFJ9mry_w@mail.gmail.com>
	<CAN_7+YZs8y-+xcYtJu39MToF5oMu9XGvFfCGCGgacA4doOVM2g@mail.gmail.com>
Date: Tue, 31 Dec 2013 11:08:57 +0200
Message-ID: <CABBYNZL-DEspARC=fnCpgNFsHanT+AT183025JZx4mo-KRF23A@mail.gmail.com>
Subject: Re: [RFC 6/6] android/audio: Add listener thread on the Audio HAL socket
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukazs,

On Mon, Dec 30, 2013 at 10:57 PM, Lukasz Rymanowski
<lukasz.rymanowski@gmail.com> wrote:
> Hi Luiz,
>
> On Mon, Dec 30, 2013 at 2:07 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Lukasz,
>>
>> On Mon, Dec 30, 2013 at 1:40 PM, Lukasz Rymanowski
>> <lukasz.rymanowski@tieto.com> wrote:
>>> Hi Luiz,
>>>
>>> On 30 December 2013 12:31, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>>>> Hi Lukasz,
>>>>
>>>> On Mon, Dec 30, 2013 at 12:17 PM, Lukasz Rymanowski
>>>> <lukasz.rymanowski@tieto.com> wrote:
>>>>> This patch add thread which is reponsible for listen on audio HAL
>>>>> socket, register a2dp endpoint(s) and maintain socket.
>>>>> When bluetooth daemon goes down, HAL audio plugin starts to listen on Audio HAL
>>>>> socket again.
>>>>>
>>>>> ---
>>>>>  android/Makefile.am |   2 +
>>>>>  android/hal-audio.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  android/hal-audio.h |  18 +++++++
>>>>>  3 files changed, 165 insertions(+)
>>>>>  create mode 100644 android/hal-audio.h
>>>>>
>>>>> diff --git a/android/Makefile.am b/android/Makefile.am
>>>>> index eaf39bd..bd90c13 100644
>>>>> --- a/android/Makefile.am
>>>>> +++ b/android/Makefile.am
>>>>> @@ -112,6 +112,8 @@ android_libaudio_internal_la_SOURCES = android/hal-audio.c \
>>>>>
>>>>>  android_libaudio_internal_la_CFLAGS = -I$(srcdir)/android
>>>>>
>>>>> +android_libaudio_internal_la_LDFLAGS = -pthread
>>>>> +
>>>>>  endif
>>>>>
>>>>>  EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
>>>>> diff --git a/android/hal-audio.c b/android/hal-audio.c
>>>>> index 011a699..0e3bc70 100644
>>>>> --- a/android/hal-audio.c
>>>>> +++ b/android/hal-audio.c
>>>>> @@ -16,18 +16,30 @@
>>>>>   */
>>>>>
>>>>>  #include <errno.h>
>>>>> +#include <pthread.h>
>>>>> +#include <poll.h>
>>>>>  #include <stdio.h>
>>>>>  #include <stdlib.h>
>>>>>  #include <string.h>
>>>>> +#include <sys/socket.h>
>>>>> +#include <sys/un.h>
>>>>> +#include <unistd.h>
>>>>>
>>>>>  #include <hardware/audio.h>
>>>>>  #include <hardware/hardware.h>
>>>>>
>>>>> +#include "hal-audio.h"
>>>>>  #include "hal-log.h"
>>>>>
>>>>>  struct a2dp_audio_dev {
>>>>>         struct audio_hw_device dev;
>>>>>         struct a2dp_stream_out *stream_out;
>>>>> +
>>>>> +       pthread_t bt_watcher;
>>>>> +       pthread_mutex_t hal_sk_mutex;
>>>>> +       pthread_cond_t bt_watcher_cond;
>>>>> +
>>>>> +       int hal_sk;
>>>>>  };
>>>>>
>>>>>  struct a2dp_stream_out {
>>>>> @@ -384,15 +396,135 @@ static int audio_dump(const audio_hw_device_t *device, int fd)
>>>>>
>>>>>  static int audio_close(hw_device_t *device)
>>>>>  {
>>>>> +       struct audio_hw_device *dev = (struct audio_hw_device *)device;
>>>>> +       struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *)dev;
>>>>> +
>>
>> Hmm, Im afraid these are not the same pointers as you do  *device =
>> &a2dp_dev->dev.common; so this will probably cause invalid accesses.
>>
> Actually this is same pointer and even I could do here direct cast
> from hw_device_t to a2dp_audio_dev with some comment why I can do it.
> Is that fine?
> Also in audio_open(), to make code less confusing, will do *device =
> (hw_device_t *)a2dp_dev
> Is that fine for you? Not sure how discussion ends or IRC about that
> as I had to go.

It seems the biggest problem with this type of usage of casts is
binary compatibility, but this is a general problem in Android we
can't do anything about and for BlueZ it shouldn't matter that much
since the code should always be available it is just a matter of
recompiling.

-- 
Luiz Augusto von Dentz
