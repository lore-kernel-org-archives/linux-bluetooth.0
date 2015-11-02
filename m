Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <56373965.3090300@steev.me.uk>
Date: Mon, 02 Nov 2015 10:22:29 +0000
From: Steven Davies <linux-bluetooth-list@steev.me.uk>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: After bluetoothd disconnects a LE device only restart of kernel
 modules allows it to reconnect
References: <562BBBFF.9000805@steev.me.uk> <1E7A740C-DA0A-45F0-8F03-BA21BC5F37B2@holtmann.org> <562F5063.2020809@steev.me.uk>
In-Reply-To: <562F5063.2020809@steev.me.uk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
>> Hi Steven,
>>
>>> I'm using bluez-5.35 with kernel 4.2 and am seeing that after a while (could be minutes, hours or days, I don't know what the trigger is) a BLE device will disconnect and the only way to reconnect to it is to rmmod the bluetooth  modules and re-modprobe them. Obviously this shouldn't happen. I'm seeing the following output from bluetoothd (sorry for the huge log, let me know if a full pastebin would be better). Can anyone offer any insight into why once this happens, I can't talk to the device through Bluetooth?
>> can you also show the btmon for this situation. And any chance to test 4.2.x stable kernel. A few patches went into stable kernel that might fix this. I would be also great if you can do a quick test with 4.3-rc7 and bluetooth-next kernels to see if this might be something that we already fixed.
> The best I can do at the moment is 4.3-rc6 since this is running on an
> ARM dev board that needs a special set of kernel patches. I've started
> my program running on that and am running btmon as well. If the issue
> happens again I'll post back with the btmon log.
I have seen this again but the btmon log is quite long. Would you like
me to send the whole thing to the list or would a pastebin work better?
Does the list have a preference as to which?

Thanks
Steven Davies
