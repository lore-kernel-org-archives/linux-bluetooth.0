Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Piconet problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <IAM5FF$26988C38C1B7C74AE27C3AE78F151AF6@libero.it>
References: <IAM5FF$26988C38C1B7C74AE27C3AE78F151AF6@libero.it>
Content-Type: text/plain
Message-Id: <1106225533.8190.178.camel@pegasus>
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
Date: Thu, 20 Jan 2005 13:52:13 +0100

Hi Jers,

> I thank you for your time but, I'm sorry,  I can't display any packet. 
>  
> I changed my dongles. Their firmware is HCI 16.14: 
>  
> hci0:   Type: USB 
>         BD Address: 00:08:E0:01:9E:86 ACL MTU: 192:8 SCO MTU: 64:8 
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:2508 acl:0 sco:0 events:60 errors:0 
>         TX bytes:465 acl:0 sco:0 commands:47 errors:0 
>         Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00 
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'pcB' 
>         Class: 0x000000 
>         Service Classes: Unspecified 
>         Device Class: Miscellaneous, 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c 
>         Manufacturer: Cambridge Silicon Radio (10) 
>  
> I installed linux again (Mandrake 9.1, kernel 2.4.21) and the upgrated BlueZ packages in accordance with readme 
> files of each packages. I tried to create a simple connection. 
>  
> On the master side, I run: 
>  
> modprobe bnep 
> modprobe l2cap 
> hciconfig hci0 up 
> pand --listen --role GN 
>  
> On the slave side, I run; 
>  
> modprobe bnep 
> modprobe l2cap 
> hciconfig hci0 up 
> pand -c <master_addr> 
>  
> At first, "hcidump -x" dispayed packets sent by the pand command. Trying several times, it showed L2CAP and in 
> only one case I showed BNEP. However, no connection was create. 
> Then, maybe after a reboot or a logout, hcidump shows again that pand does not send any packet,. 
> I can't obtain again the same situation and I don't realize why.

show us the hcidump output and leave it to us to interpret it. And btw
what about using a 2.6.10 kernel? I can't tell you anything about any
vendor kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
