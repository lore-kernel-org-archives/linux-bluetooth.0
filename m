Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1ADFED1F-912D-4DF9-A3BB-795F9AB1D1F8@gmail.com>
From: Justin Mattock <justinmattock@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <20110215135245.GA11561@jh-x301>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: bluetooth disabled with current 2.6.38-rc4
Date: Tue, 15 Feb 2011 19:26:12 -0800
References: <1A8743E5-65EA-4625-82FD-658C9722629F@gmail.com> <20110215135245.GA11561@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Feb 15, 2011, at 5:52 AM, Johan Hedberg wrote:

> Hi Justin,
>
> On Sun, Feb 13, 2011, Justin Mattock wrote:
>> maybe I missed something, but my bluetooth is just not functioning  
>> with
>> 2.6.38-rc4(works with 2.6.37-rc4)
>>
>> I've done a bisect on this, but was pointed to:
>> c0e45c1ca3162acb2e77b3d9e152ce6e7b6fa3f5
>> but doesn't look correct to me
>>
>> here is what I am seeing with the bluetooth-applet etc..:
>>
>> working correctly:
>> http://www.flickr.com/photos/44066293@N08/5443727238/
>>
>> not working:
>> http://www.flickr.com/photos/44066293@N08/5443124859/
>>
>> my /var/log/daemon.log shows:
>>
>> Feb 13 17:12:22 Linux-2 acpid: 1 client rule loaded
>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: HCI dev 0 registered
>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: Listening for HCI events
>> on hci0
>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: HCI dev 0 up
>> Feb 13 17:12:23 Linux-2 bluetoothd[1950]: Unable to find matching
>> adapter
>>
>> I can try at another bisect, but might take some time.. let me know
>> if there is something I can test
>> or do.
>
> Are you sure this is a kernel problem? There was a similar issue with
> BlueZ 4.86 or 4.87 which was already fixed. Could you try with 4.88?
>
> Johan

o.k. I built 4.88 and still had the issue show up, except this time no  
icon(instead of the icon, that is not lit up)..


anyways I did do another bisect and had better results(hopefully)this  
time..:

23bb57633df97ede067ea26f3cdc8a7ba2cd8109 is the first bad commit
commit 23bb57633df97ede067ea26f3cdc8a7ba2cd8109
Author: Johan Hedberg <johan.hedberg@nokia.com>
Date:   Tue Dec 21 23:01:27 2010 +0200

    Bluetooth: Fix __hci_request synchronization for hci_open_dev

    The initialization function used by hci_open_dev (hci_init_req)  
sends
    many different HCI commands. The __hci_request function should only
    return when all of these commands have completed (or a timeout  
occurs).
    Several of these commands cause hci_req_complete to be called which
    causes __hci_request to return prematurely.

    This patch fixes the issue by adding a new hdev->req_last_cmd  
variable
    which is set during the initialization procedure. The  
hci_req_complete
    function will no longer mark the request as complete until the  
command
    matching hdev->req_last_cmd completes.

    Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
    Acked-by: Marcel Holtmann <marcel@holtmann.org>
    Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>

:040000 040000 e8d8ae5fab74b2ba73d0c52e7e09b30e5df8484e  
8d1409e8dc2206492cb86e8848c8c23aff182e2a M      include
:040000 040000 07fdb5f6ceadcfde12c46a3b5c82937b7dac892c  
8f3b08fbbc9fcd078d0f5224b8bc818eeb072dc4 M      net



git bisect log
git bisect start
# bad: [c56eb8fb6dccb83d9fe62fd4dc00c834de9bc470] Linux 2.6.38-rc1
git bisect bad c56eb8fb6dccb83d9fe62fd4dc00c834de9bc470
# good: [d9a1abe4844e7591cd82e167a1a09e6546f6c45e] arch/mn10300/kernel/ 
irq.c: fix build
git bisect good d9a1abe4844e7591cd82e167a1a09e6546f6c45e
# bad: [76d9cc454a8d0bb7484616a4b8136280068c8a8b] spi: tegra: don't  
treat NULL clk as an error
git bisect bad 76d9cc454a8d0bb7484616a4b8136280068c8a8b
# bad: [f70f5b9dc74ca7d0a64c4ead3fb28da09dc1b234] Merge git:// 
git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next-2.6
git bisect bad f70f5b9dc74ca7d0a64c4ead3fb28da09dc1b234
# good: [1d212aa96e1b63459486f729af9a3fa38768b801] Merge branch  
'master' of git://git.kernel.org/pub/scm/linux/kernel/git/linville/ 
wireless-next-2.6 into for-davem
git bisect good 1d212aa96e1b63459486f729af9a3fa38768b801
# bad: [4e3dbdb1392a83bd21a6ff8f6bc785495058d37c] cassini: Use local- 
mac-address prom property for Cassini MAC address
git bisect bad 4e3dbdb1392a83bd21a6ff8f6bc785495058d37c
# good: [65a6538a56d4c7ae8465f2a8420ddc65877b6779] mac80211: check for  
CONFIG_MAC80211_LEDS in the tpt_led_trigger declaration
git bisect good 65a6538a56d4c7ae8465f2a8420ddc65877b6779
# good: [dbbe68bb12b34f3e450da7a73c20e6fa1f85d63a] Merge branch  
'master' of master.kernel.org:/pub/scm/linux/kernel/git/davem/net-2.6
git bisect good dbbe68bb12b34f3e450da7a73c20e6fa1f85d63a
# bad: [c9e57f0fdccf74ef7884fed61d212e524b9c4bcd] carl9170: add  
missing return-value check
git bisect bad c9e57f0fdccf74ef7884fed61d212e524b9c4bcd
# good: [a3463a1fdc9aa0881760e54efbd62742275601a5] rndis_wlan: remove  
unused variable from priv structure
git bisect good a3463a1fdc9aa0881760e54efbd62742275601a5
# bad: [17f9cc3124c97f50a19a7597e5f29f915b5b835c] Bluetooth: Improve  
handling of HCI control channel in bind
git bisect bad 17f9cc3124c97f50a19a7597e5f29f915b5b835c
# good: [e41d8b4e131a41f2a3b74aaa783b16aa46376d8e] Bluetooth: Add  
error handling for managment command handlers
git bisect good e41d8b4e131a41f2a3b74aaa783b16aa46376d8e
# good: [f7b64e69c7c75c8e9f2d5e23edec8de1ce883bcc] Bluetooth: Add  
read_info management command
git bisect good f7b64e69c7c75c8e9f2d5e23edec8de1ce883bcc
# bad: [23bb57633df97ede067ea26f3cdc8a7ba2cd8109] Bluetooth: Fix  
__hci_request synchronization for hci_open_dev
git bisect bad 23bb57633df97ede067ea26f3cdc8a7ba2cd8109
# good: [c71e97bfaadfa727669fcfcf12301744fd169091] Bluetooth: Add  
management events for controller addition & removal
git bisect good c71e97bfaadfa727669fcfcf12301744fd169091


reverting that commit gets the icon to show up, as well as the mouse  
to connect..
(hardware is a MacBookPro2,2 and the mouse is a mightmouse) let me  
know if there is anything I can supply

Justin P. Mattock

