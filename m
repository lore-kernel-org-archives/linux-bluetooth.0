Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Piconet problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <IAAY31$664B7AA9753F60F7A4D5D72B66AB0F53@libero.it>
References: <IAAY31$664B7AA9753F60F7A4D5D72B66AB0F53@libero.it>
Content-Type: text/plain
Message-Id: <1105737535.7525.48.camel@pegasus>
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
Date: Fri, 14 Jan 2005 22:18:55 +0100

Hi Jers,

> > send us the outputs of "hciconfig -a" for all of your devices. And don't 
> > play with "hcitool cc". If you wanna test stuff then use l2test. 
>  
> hci0:   Type: USB 
>         BD Address: 00:08:E0:01:9E:86 ACL MTU: 192:8  SCO MTU: 64:8 
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:653 acl:0 sco:0 events:19 errors:0 
>         TX bytes:314 acl:0 sco:0 commands:18 errors:0 
>         Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00 
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'PC A' 
>         Class: 0x3e0100 
>         Service Classes: Networking, Rendering, Capturing 
>         Device Class: Computer, Uncategorized 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c 
>         Manufacturer: Cambridge Silicon Radio (10) 
>  
> hci0:   Type: USB 
>         BD Address: 00:E0:98:85:A1:64 ACL MTU: 192:8  SCO MTU: 64:8 
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:99 acl:0 sco:0 events:13 errors:0 
>         TX bytes:296 acl:0 sco:0 commands:12 errors:0 
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00 
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'BlueZ (0)' 
>         Class: 0x3e0100 
>         Service Classes: Networking, Rendering, Capturing 
>         Device Class: Computer, Uncategorized 
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175 
>         Manufacturer: Cambridge Silicon Radio (10) 

the 0x175 firmwares are not HCI 16.4 and thus don't support scatternet
and are difficult to connect.
 
> > > After that, I tried to create the second connection on slave2 side by running the same command (hcitool cc 
> <master_addr>) and I obtain the following error: 
> > > # Can't create connectio: input/output error. 
> >  
> > Run "hcidump -x" as root and show us the output. 
>  
> HCIDump - HCI packet analyzer ver 1.16 
> device: hci0 snap_len: 1028 filter: 0xffffffff 

What about trying to connect now, so we see traffic?

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
