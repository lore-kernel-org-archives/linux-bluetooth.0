Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 2/5] android/bluetooth: Use defines for settings and devices files paths
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1699475.kPZvhNixD9@athlon>
Date: Tue, 21 Jan 2014 11:13:22 -0800
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <C8C8C11B-B1C1-455C-BE3C-DDCB846368D1@holtmann.org>
References: <1390316497-18451-1-git-send-email-szymon.janc@tieto.com> <1390316497-18451-3-git-send-email-szymon.janc@tieto.com> <2F525C49-B02B-4A87-8CAE-633BF53A8ADF@holtmann.org> <1699475.kPZvhNixD9@athlon>
To: Szymon Janc <szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> ---
>>> android/bluetooth.c | 24 +++++++++++-------------
>>> 1 file changed, 11 insertions(+), 13 deletions(-)
>>> 
>>> diff --git a/android/bluetooth.c b/android/bluetooth.c
>>> index 8f08122..3314267 100644
>>> --- a/android/bluetooth.c
>>> +++ b/android/bluetooth.c
>>> @@ -54,6 +54,9 @@
>>> 
>>> #define DUT_MODE_FILE "/sys/kernel/debug/bluetooth/hci%u/dut_mode"
>>> 
>>> +#define SETTINGS_FILE ANDROID_STORAGEDIR"/settings"
>>> +#define DEVICES_FILE ANDROID_STORAGEDIR"/devices”
>> 
>> is there any good reason to keep cached devices together with the bonded
>> devices? I get the feeling a cached device should be safe to throw away. So
>> deleting the cache file should not cause any problems. Meaning it should be
>> a separate file.
> 
> I'm fine with having separate files too (even have this implemented on my 
> local branch), but wanted to avoid handling multiple files. Anyway, add/remove 
> bond doesn't happen that often so maybe this is not a problem.
> 
> So, is "device_cache" name OK? Or just "cache”?

I would just do “cache” and see where it takes us.

Regards

Marcel

