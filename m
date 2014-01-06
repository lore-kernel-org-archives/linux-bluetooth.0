Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2688157.rF2s9RrCYM@athlon>
References: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
	<2688157.rF2s9RrCYM@athlon>
Date: Mon, 6 Jan 2014 11:06:45 +0200
Message-ID: <CABBYNZJBZdcuSbn_oFOM-5GRUsuk+W1MQ-xyw8YQKq=R2w9YoA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 01/10] android/ipc: Add initial code for audio IPC
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sun, Jan 5, 2014 at 7:43 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> Hi Luiz,
>
> On Thursday 02 January 2014 13:58:25 Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This add initial code for listen and accept connections on the abstract
>> socket defined for the audio IPC.
>> ---
>> v2: Split audio IPC services for HAL services and fix invalid messages or
>> disconnections causing the daemon to exit. The audio HAL is independent of
>> bluetooth and should only affect A2DP service.
>
> What seems to be missing is some way to recover from Audio IPC error.

This has been discussed already with Lukasz, Audio HAL is a little bit
different than Bluetooth HAL because it does not seems to be able to
restart the service from the UI so the Audio IPC disconnecting are
probably due to crashes, we will indeed need a way to recover from
Audio IPC errors but it is not really a feature but more a error
recover which we can be done in a separate set.

Luiz Augusto von Dentz
