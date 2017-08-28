Return-Path: <vbabka@suse.cz>
Subject: Re: WARNING: CPU: 3 PID: 2952 at drivers/base/firmware_class.c:1225
 _request_firmware+0x329/0x890
From: Vlastimil Babka <vbabka@suse.cz>
To: Richard Weinberger <richard@sigma-star.at>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>,
 kernel list <linux-kernel@vger.kernel.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
References: <2237498.dXpkGoRScD@blindfold>
 <C551B3EE-FC6F-4FDA-8B32-270AAC18D958@holtmann.org>
 <25498655.5hsXaGAV9U@blindfold>
 <0df95753-038b-42bd-c6d5-091d7d5bd741@suse.cz>
Message-ID: <31bd1615-7b0a-dc94-8795-f9cca2f74d35@suse.cz>
Date: Mon, 28 Aug 2017 14:45:26 +0200
MIME-Version: 1.0
In-Reply-To: <0df95753-038b-42bd-c6d5-091d7d5bd741@suse.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/28/2017 01:50 PM, Vlastimil Babka wrote:
> On 08/15/2017 01:41 PM, Richard Weinberger wrote:
>> Marcel,
>>
>> Am Dienstag, 15. August 2017, 12:22:27 CEST schrieb Marcel Holtmann:
>>>> Is this known?
>>>
>>> It is not known, but it is also unclear why this happens. Basically the card
>>> looses power and thus ends up in bootloader mode.
>>>
>>
>> Hm, maybe a BIOS issue?
> 
> Same here on a T460, also happens on resume from suspend to RAM. Looks
> like a regression though. First instance I found in the logs is from
> 4.13-rc2. Looks like previously I've been running 4.11, and managed to
> skip 4.12 on this laptop. Can check 4.12, though.

Yep, seems to work on 4.12.8, this after resume:

[  178.837204] PM: Finishing wakeup.
[  178.837207] OOM killer enabled.
[  178.837211] Restarting tasks ... done.
[  178.844792] thermal thermal_zone3: failed to read out thermal zone (-5)
[  178.849009] [drm] RC6 on
[  178.851064] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[  178.858072] Bluetooth: hci0: Device revision is 5
[  178.858076] Bluetooth: hci0: Secure boot is enabled
[  178.858077] Bluetooth: hci0: OTP lock is enabled
[  178.858078] Bluetooth: hci0: API lock is enabled
[  178.858078] Bluetooth: hci0: Debug lock is disabled
[  178.858079] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[  178.858082] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi

...

[  180.402942] Bluetooth: hci0: Waiting for firmware download to complete
[  180.403039] Bluetooth: hci0: Firmware loaded in 1516730 usecs
[  180.403048] Bluetooth: hci0: Waiting for device to boot
[  180.414070] Bluetooth: hci0: Device booted in 10769 usecs
[  180.414074] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
[  180.418111] Bluetooth: hci0: Applying Intel DDC parameters completed

>> Thanks,
>> //richard
>>
> 
