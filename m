Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Connection failed error (110)
From: Marcel Holtmann <marcel@holtmann.org>
To: KEYUR DESAI <keyurde@nortelnetworks.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E337F6C8A5154F4C8E95349BA276D63008FBB5@zrtphxm0.corp.nortel.com>
References: 
	 <E337F6C8A5154F4C8E95349BA276D63008FBB5@zrtphxm0.corp.nortel.com>
Content-Type: text/plain
Message-Id: <1098694143.24932.21.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 25 Oct 2004 10:49:03 +0200

Hi Keyur,

> I am using kernel 2.6.10 (fedora core -2) 

actually there is no 2.6.10 kernel out yet ;)

> My hardware is Belkin Dongle
> 
> I have the latest bluez utilities and library files 
> bluez-hcidump-1.12         bluez-libs-2.10      
> bluez-utils-2.10
> 
> 
> [root@localhost Bluez]# hciconfig -a 
> hci0:   Type: USB 
>         BD Address: 00:0A:3A:50:4B:4D ACL MTU: 192:8  
> SCO MTU: 64:8 
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:77 acl:0 sco:0 events:9 errors:0 
>         TX bytes:31 acl:0 sco:0 commands:8 errors:0 
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 
> 0x00 
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 
> HV3 
>         Link policy: 
>         Link mode: SLAVE ACCEPT 
>         Name: 'BlueZ (0)' 
>         Class: 0x000000 
>         Service Classes: Unspecified 
>         Device Class: Miscellaneous, 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 
> (0x1) LMP Subver: 0x20d 
>         Manufacturer: Cambridge Silicon Radio (10) 
>                                                        
> Here is the error.... 
>                           
> [root@localhost Bluez]# hciconfig hci0 up 
> [root@localhost Bluez]# hciconfig hci0 down 
> [root@localhost Bluez]# hciconfig hci0 up 
> Can't init device hci0. Connection timed out(110) [root@localhost
> Bluez]#

run "hcidump -X" as root and send us what it shows when you do this.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
