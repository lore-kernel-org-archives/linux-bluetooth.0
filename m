Return-Path: <cyrus@holtmann.org>
Message-ID: <5555F464.7020404@intel.com>
Date: Fri, 15 May 2015 15:28:04 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth-next HCI user channel issue
References: <5534D661.1000703@intel.com> <A7E7D666-B172-4A02-A7E9-86483D630C81@holtmann.org> <4B296AC8-6E0A-4EB4-B1BD-892449AD4ED6@holtmann.org>
In-Reply-To: <4B296AC8-6E0A-4EB4-B1BD-892449AD4ED6@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel,

On 13/05/2015 23:10, Marcel Holtmann wrote:
> Hi Loic,
>
>>> Seems there is a regression in bluetooth-next.
>>> I'm unable to communicate with my Intel WP chip via HCI User channel.
>>> To test user channel, I use bluemoon:
>>> $ hciconfig hci0 down
>>> $ bluemoon -i hci0
>>> Bluemoon configuration utility ver 5.30
>>>
>>> Then bluemoon hangs up, no HCI event...
>>>
>>> HCI packet seems successfully sent, but no HCI response:
>>> [  491.525914] Bluetooth: hci0
>>> [  491.525918] Bluetooth: hci0
>>> [  491.525924] Bluetooth: hci0
>>> [  491.525927] Bluetooth: hci0
>>> [  491.525964] Bluetooth: hci0
>>> [  491.526114] Bluetooth: hci0 urb ffff8800c1f320c0 status 0 count 3
>>>
>>> When I kill bluemoon, I get same kind of issue (cmd timeout):
>>> [  895.603661] Bluetooth: hci0 urb ffff8802f89d5b40 status 0 count 3
>>> [  897.606323] Bluetooth: hci0 command 0xfc3f tx timeout
>>> [  897.606350] Bluetooth: hci0
>>> [  897.607011] Bluetooth: hci0 urb ffff88030c2c83c0 status 0 count 244
>>> [  899.612007] Bluetooth: hci0 command 0x0c52 tx timeout
>>>
>>> After that, device still usable by other sockets (hciconfig, hcitool...)
>>>
>>> I wonder if you reproduce this issue on your side?
>>
>> can you git bisect this to pin point the patch that broke this for you.
>
> any chance you did git bisect this and tell us which patch broken this?

I'll give you a answer/status before the end of next week.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
