Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43EFCEFF.60707@purdue.edu>
From: Chase Douglas <cndougla@purdue.edu>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Developing Broadcom driver support
References: <e44ae5e0602111105n6bacb4e8i@mail.gmail.com>	 <43EED2E4.1000308@xmission.com> <495ce9180602121500i5cb97395o@mail.gmail.com>
In-Reply-To: <495ce9180602121500i5cb97395o@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 12 Feb 2006 19:12:47 -0500

I have an iogear gb211, which has a broadcom chipset.

localhost chase # hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:72:C3:C5:2E ACL MTU: 377:10 SCO MTU: 16:8
        UP RUNNING PSCAN ISCAN
        RX bytes:14392 acl:25 sco:0 events:799 errors:0
        TX bytes:4813 acl:18 sco:0 commands:752 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0xff0408
        Service Classes: Positioning, Networking, Rendering, Capturing
        Device Class: Audio/Video, Hands-free
        HCI Ver: 1.2 (0x2) HCI Rev: 0x14 LMP Ver: 1.2 (0x2) LMP Subver: 
0x309
        Manufacturer: Broadcom Corporation (15)

localhost chase # hciconfig hci0 scomtu 64:8
localhost chase # hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:72:C3:C5:2E ACL MTU: 377:10 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:14392 acl:25 sco:0 events:799 errors:0
        TX bytes:4813 acl:18 sco:0 commands:752 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0xff0408
        Service Classes: Positioning, Networking, Rendering, Capturing
        Device Class: Audio/Video, Hands-free
        HCI Ver: 1.2 (0x2) HCI Rev: 0x14 LMP Ver: 1.2 (0x2) LMP Subver: 
0x309
        Manufacturer: Broadcom Corporation (15)

I can't get anything from or to my headset, although I can transmit and 
receive when using a D-Link DBT-120 rev. B4. I had also applied the 
first patch about the mtu stuff, but not the one to set the mtu by default.

Let me know if you know of anything to try.

Thanks

Mario wrote:

>2006/2/12, Brad Midgley <bmidgley@xmission.com>:
>  
>
>>We should find out exactly what that second poster "whoopie" was doing
>>to set the mtu. Apparently he was only asking if the modified patch
>>would work but he had gotten it working by using the original patch and
>>tweaking the mtu at runtime.
>>    
>>
>
>It's incredible! Without any patch to the kernel.
>
>hciconfig hci0 scomtu 64:8
>
>IT WORKS!! A nasty Broadcom BT Chipset works! :\
>
>root@legolas:~# hciconfig hci0 revision
>hci0:   Type: USB
>        BD Address: 00:10:C6:59:7A:FC ACL MTU: 377:10 SCO MTU: 16:0
>        Firmware 2.105 / 97
>
>root@legolas:~# hciconfig hci0 scomtu 64:8
>
>root@legolas:~# hciconfig hci0 revision
>hci0:   Type: USB
>        BD Address: 00:10:C6:59:7A:FC ACL MTU: 377:10 SCO MTU: 64:8
>        Firmware 2.105 / 97
>
>Now my Plantronics Voyager 510 BT headset works (I have to test it
>better with applications now...).
>
>Mario :D
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://sel.as-us.falkag.net/sel?cmd_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
