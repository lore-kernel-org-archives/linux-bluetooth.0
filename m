Return-Path: <conardcox@earthlink.net>
From: Richard Cox <conardcox@earthlink.net>
Reply-To: rcox27@triad.rr.com
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Connection dropped or cannot connect
Date: Sat, 10 Apr 2004 17:31:06 -0400
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <000801c41e98$9e75d080$0100a8c0@terre> <200404101715.20122.conardcox@earthlink.net> <1081632356.5398.48.camel@pegasus>
In-Reply-To: <1081632356.5398.48.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404101731.06127.conardcox@earthlink.net>
List-ID: <bluez-users.lists.sourceforge.net>

On Saturday 10 April 2004 05:25 pm, Marcel Holtmann wrote:
> Hi Richard,
>
> > " Do this adapter have the same problem? Is it CSR based?"
> >
> > Yes, according to the bluez hardware compatibilty list
> > (http://www.holtmann.org/linux/bluetooth/devices.html) it says:
> >
> > Belkin F8T003 USB Adapter  	CSR  	1.1  	hci_usb  	working  	Nayib Kiuhan
>
> you are kidding ;) I actually know what's in my own list, but I wanna be
> sure that the entry is correct. So check with "hciconfig -a".
>
> And "yes" means that the adapter is CSR based or that it have the same
> problem.
>
> > I'll certainly try defining that macro you listed above and see what
> > happens.
>
> Or you can remove these four lines:
>
> 	#ifndef CONFIG_BT_HCIUSB_ZERO_PACKET
> 	#undef  URB_ZERO_PACKET
> 	#define URB_ZERO_PACKET 0
> 	#endif
>
> Regards
>
> Marcel

Heh heh 8^)  Sorry, I'm new to the list and I didn't realize Marcel Holtmann 
== holtmann.org.  Tried that macro, and no luck.  BTW, hciconfig -a returns 
this:

hci0:   Type: USB
        BD Address: 00:0A:3A:51:61:E8 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:32752 acl:250 sco:0 events:339 errors:0
        TX bytes:79048 acl:472 sco:0 commands:16 errors:0
        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

So it does look like a CSR adapter.

Thanks again 

Regards,

Richard
