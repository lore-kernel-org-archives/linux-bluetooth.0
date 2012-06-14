Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJx1FMNQGqwg+rn7pQ50JSBTS2sPjfemLMqVU6bpjVH=PkYXTA@mail.gmail.com>
References: <1339681903-24764-1-git-send-email-luiz.dentz@gmail.com>
	<CAJx1FMNQGqwg+rn7pQ50JSBTS2sPjfemLMqVU6bpjVH=PkYXTA@mail.gmail.com>
Date: Thu, 14 Jun 2012 20:12:57 +0300
Message-ID: <CABBYNZ+4Agh-LChRDab368Oro2bgkmQQhsB2piZ8x5JnWzfWaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/5] audio: Remove internal audio IPC
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Chanyeol,Park" <chanyeol.park@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyeol,

On Thu, Jun 14, 2012 at 6:58 PM, Chanyeol,Park <chanyeol.park@gmail.com> wrote:
> Hi
>
> 2012/6/14 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> With unix socket and ALSA removed there is no longer any use for the
>> internal IPC.
>> ---
>>  Makefile.am                        |    4 +-
>>  Makefile.tools                     |    5 +-
>>  audio/device.c                     |    1 -
>>  audio/gstavdtpsink.c               | 1107
>> ++++-------------------------------
>>  audio/gstavdtpsink.h               |    1 -
>>  audio/ipc.c                        |  134 -----
>>  audio/ipc.h                        |  361 ------------
>>  audio/manager.c                    |    1 -
>>  test/ipctest-a2dp-easy.test        |    8 -
>>  test/ipctest-a2dp-resume-fast.test |   82 ---
>>  test/ipctest-hsp-a2dp-switch.test  |   50 --
>>  test/ipctest-hsp-easy.test         |    7 -
>>  test/ipctest-init-shutdown.test    |   59 --
>>  test/ipctest.c                     | 1133
>> ------------------------------------
>>  14 files changed, 112 insertions(+), 2841 deletions(-)
>>  delete mode 100644 audio/ipc.c
>>  delete mode 100644 audio/ipc.h
>>  delete mode 100644 test/ipctest-a2dp-easy.test
>>  delete mode 100644 test/ipctest-a2dp-resume-fast.test
>>  delete mode 100644 test/ipctest-hsp-a2dp-switch.test
>>  delete mode 100644 test/ipctest-hsp-easy.test
>>  delete mode 100644 test/ipctest-init-shutdown.test
>>  delete mode 100644 test/ipctest.c
>>
> I think if you remove audio legacy IPC,
> GST, ALSA audio client have no meaning in the bluez.
>
> If so, is it better to remove the related whole files?

ALSA is gone as well, Im leaving GST just for testing purpose as it
can be used together with simple-endpoint.


-- 
Luiz Augusto von Dentz
