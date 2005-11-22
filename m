Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] symbol lookup error
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7846f1440511211104p22ad2e23x719cc21ae6ea1d46@mail.gmail.com>
References: <7846f1440511211104p22ad2e23x719cc21ae6ea1d46@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1132657352.24113.8.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 22 Nov 2005 12:02:32 +0100

Hi Arthur,

> I compiled blueZ libs and utils without a problem. (using ./configure
> for libs and ./configure --enable-test for utils)
> After this, I ran hciconfig hci0 up, then hciconfig, both ran fine:
> hci0:   Type: USB
>         BD Address: 00:11:67:0F:C0:E7 ACL MTU: 678:8 SCO MTU: 48:10
>         UP RUNNING PSCAN ISCAN
>         RX bytes:77 acl:0 sco:0 events:9 errors:0
>         TX bytes:34 acl:0 sco:0 commands:9 errors:0
> 
> However, when I try to run hcitool -i hci0 inq:
> 
> Inquiring ...
>         00:0D:93:0F:32:F5       clock offset: 0x34fa    class:
> 0x102104
>         00:0D:93:17:D7:C1       clock offset: 0x15f1    class:
> 0x102104
>         00:0E:07:15:64:B3       clock offset: 0x1069    class:
> 0x520204
>         00:13:46:A7:12:CE       clock offset: 0x4c61    class:
> 0x000000
>         00:0D:93:19:E8:D4       clock offset: 0x2966    class:
> 0x102104
>         00:0D:93:1C:2E:31       clock offset: 0x18cb    class:
> 0x102104
>         00:0D:93:16:49:33       clock offset: 0x38ca    class:
> 0x102104
> hcitool: symbol lookup error: hcitool: undefined symbol: bt_free  
> 
> I get this symbol lookup error. Then when I try hcitool -i hci0 scan:
> 
> Scanning ...
> hcitool: symbol lookup error: hcitool: undefined symbol:
> hci_read_remote_name_with_clock_offset

this is a library mismatch. Make sure that you delete the old Bluetooth
libraries (maybe plural) on your system and make a clean re-install.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
