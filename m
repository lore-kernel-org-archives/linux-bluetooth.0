Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40337B23.9070207@bris.ac.uk>
From: George Billios <gb3080@bristol.ac.uk>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Many hci devices (?)
References: <40335E98.9070405@bris.ac.uk> <1077111647.2676.2.camel@pegasus>
In-Reply-To: <1077111647.2676.2.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 18 Feb 2004 14:48:03 +0000

Ok, thanks, I just renamed the module and it is working now. I think 
those virtual devices also caused some problem with kde-bluetooth 
causing a warning before, cause now everything is working fine.

Thank you

Marcel Holtmann wrote:
> Hi George,
> 
> 
>>I have a Bluetooth USB dongle which in general works fine. The only 
>>problem is that if I run hciconfig I get multiple devices:
>>
>>hci0:   Type: USB
>>         BD Address: 00:04:61:80:84:25 ACL MTU: 192:8  SCO MTU: 64:8
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:87 acl:0 sco:0 events:11 errors:0
>>         TX bytes:39 acl:0 sco:0 commands:10 errors:0
>>
>>hci1:   Type: VHCI
>>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>>         DOWN
>>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>>         TX bytes:4 acl:0 sco:0 commands:1 errors:0
>>
>>hci2:   Type: VHCI
>>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>>         DOWN
>>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>>
>>hci3:   Type: VHCI
>>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>>         DOWN
>>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>>
>>I get the above order (the USB dongle on hci0) only if I start the 
>>computer with the dongle plugged in. If I start the computer and then 
>>plug the dongle in, it gets hci3 while the other "devices" get 
>>hci0,hci1,hci2,hci4 .  This is a problem because I'm using kde-bluetooth 
>>which only connects through device hci0.
>>My question is what are these devices and how can I make the USB Dongle 
>>take hci0?
> 
> 
> these devices are virtual HCI device from the hci_vhci driver, which is
> used by hciemu. I think this is a misc device minor problem and if you
> don't plan to use hciemu, remove the hci_vhci kernel module from your
> harddrive.
> 
> Regards
> 
> Marcel
> 
> 


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
