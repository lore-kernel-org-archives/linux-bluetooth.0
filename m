Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20041207202928.756.qmail@web52005.mail.yahoo.com>
From: sagasola uyeoldum <sagasolauyeoldum@yahoo.com>
Subject: Re: [Bluez-users] bluez nap problems
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1102447685.8447.50.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Tue, 7 Dec 2004 12:29:28 -0800 (PST)

Thank you

I think I messed with the configuration files while
trying to get it up. That solved everything.

--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi,
> 
> > Ok here it goes:
> > 
> > NAP hciconfig -a:
> > 
> > hci0:   Type: USB
> >         BD Address: 00:02:72:03:D3:F2 ACL MTU:
> 192:8 
> > SCO MTU: 64:8
> >         UP RUNNING PSCAN ISCAN
> >         RX bytes:1591 acl:0 sco:0 events:162
> errors:0
> >         TX bytes:1302 acl:0 sco:0 commands:70
> errors:0
> >         Features: 0xff 0xff 0x0f 0x00 0x00 0x00
> 0x00
> > 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
> HV2
> > HV3
> >         Link policy: RSWITCH HOLD SNIFF PARK
> >         Link mode: ACCEPT MASTER
> >         Name: 'BlueZ (0)'
> >         Class: 0x000100
> >         Service Classes: Unspecified
> >         Device Class: Computer, Uncategorized
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver:
> 1.1
> > (0x1) LMP Subver: 0x20d
> >         Manufacturer: Cambridge Silicon Radio (10)
> > 
> > PANU hciconfig -a:
> > 
> > hci0:   Type: USB
> >         BD Address: 00:0D:18:01:19:3B ACL MTU:
> 192:8 
> > SCO MTU: 64:8
> >         UP RUNNING PSCAN ISCAN INQUIRY
> >         RX bytes:122 acl:0 sco:0 events:15
> errors:0
> >         TX bytes:304 acl:0 sco:0 commands:13
> errors:0
> >         Features: 0xff 0xff 0x0f 0x00 0x00 0x00
> 0x00
> > 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
> HV2
> > HV3
> >         Link policy: RSWITCH HOLD SNIFF PARK
> >         Link mode: ACCEPT MASTER
> >         Name: 'miniscule-0'
> >         Class: 0x000100
> >         Service Classes: Unspecified
> >         Device Class: Computer, Uncategorized
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver:
> 1.1
> > (0x1) LMP Subver: 0x36f
> >         Manufacturer: Cambridge Silicon Radio (10)
> 
> how should this work if both sides are fighting for
> the master role? You
> changed default settings without understanding what
> they mean. Use the
> default hcid.conf.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users.
> Discover which products truly live up to the hype.
> Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
