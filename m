Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimv6CRgS-lPeadePxKXEmNmhEM7oLx-uTHuZfNF@mail.gmail.com>
References: <1274350142-19083-1-git-send-email-sancane@gmail.com>
	 <AANLkTimv6CRgS-lPeadePxKXEmNmhEM7oLx-uTHuZfNF@mail.gmail.com>
Date: Thu, 20 May 2010 15:00:28 +0200
Message-ID: <AANLkTimoISCAwCfv8zktLF7OxT0aT5glDAXYeFM0mUvF@mail.gmail.com>
Subject: Re: [PATCH] Fix device_match_pattern function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 20, 2010 at 2:52 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Santiago,
>
> On Thu, May 20, 2010 at 12:09 PM, Santiago Carot-Nemesio
> <sancane@gmail.com> wrote:
>> This patch fixes a problem adding uuids to list provided when a
>> driver is probed. Without this patch the same uuids were added
>> more than once to list and if two or more uuids were in the
>> same class id list only the first one was included repeatedly
>> ---
>>  src/device.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index 6ba1612..d0768ce 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -1053,7 +1053,7 @@ static GSList *device_match_pattern(struct btd_device *device,
>>                        continue;
>>
>>                if (record_has_uuid(rec, match_uuid))
>> -                       uuids = g_slist_append(uuids, profile_uuid);
>> +                       uuids = g_slist_append(uuids, match_uuid);
>>        }
>>
>>        return uuids;
>
>
> It doesn't look right, if we do that the device will be probed by the
> matched uuid which would not happen to have a record in the storage.
> So in other words the list of uuids you get in the probe may not match
> with the one present in the drivers .uuids. Also this would probably
> break serial driver, did you tried this before submitting this to the
> list?

Ok, I did apply you change to see what it happens, first it didn't
compile, but anyway I add cast just to make sure what would gonna
happen:


bluetoothd[23078]: Probe drivers for /org/bluez/23078/hci0/dev_00_26_CC_77_E3_36
bluetoothd[23078]: serial_probe: path
/org/bluez/23078/hci0/dev_00_26_CC_77_E3_36:
00000003-0000-1000-8000-00805F9B34FB
bluetoothd[23078]: serial_probe: path
/org/bluez/23078/hci0/dev_00_26_CC_77_E3_36:
00000003-0000-1000-8000-00805F9B34FB
bluetoothd[23078]: serial_probe: path
/org/bluez/23078/hci0/dev_00_26_CC_77_E3_36:
00000003-0000-1000-8000-00805F9B34FB
bluetoothd[23078]: serial_probe: path
/org/bluez/23078/hci0/dev_00_26_CC_77_E3_36:
00000003-0000-1000-8000-00805F9B34FB
bluetoothd[23078]: serial_probe: path
/org/bluez/23078/hci0/dev_00_26_CC_77_E3_36:
00000003-0000-1000-8000-00805F9B34FB
bluetoothd[23078]: serial_probe: path
/org/bluez/23078/hci0/dev_00_26_CC_77_E3_36:
00000003-0000-1000-8000-00805F9B34FB
bluetoothd[23078]: serial_probe: path
/org/bluez/23078/hci0/dev_00_26_CC_77_E3_36:
00000003-0000-1000-8000-00805F9B34FB
bluetoothd[23078]: headset_probe: path
/org/bluez/23078/hci0/dev_00_26_CC_77_E3_36

See, instead of the real profile uuid all I got was a multiple rfcomm
uuid which doesn't have any meaning alone.

-- 
Luiz Augusto von Dentz
Computer Engineer
