Return-Path: <mtortonesi@ing.unife.it>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problems with nc6 with bluez support
Date: Thu, 22 Jan 2004 12:31:10 +0100
References: <200401221042.53134.mtortonesi@ing.unife.it> <200401221127.57516.mtortonesi@ing.unife.it> <1074770040.19046.1.camel@pegasus>
In-Reply-To: <1074770040.19046.1.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200401221231.10350.mtortonesi@ing.unife.it>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thursday 22 January 2004 12:14, you wrote:
> Hi Mauro,
>
> > sorry, i sent the email before it was finished :-( i was saying that when
> > i try to perform data tranfers over sco the bluez/usb subsystem on the
> > receiving host hangs: my dlink dbt120 usb dongle is shut down (the 2 leds
> > switch off) and the system does not recognize it anymore even if i unplug
> > it and plug it in again. and if i then replace the dlink dbt120 with an
> > anycom 220 usb dongle nothing changes: the green led of the anycom dongle
> > lits but the usb subsystem does not even recognize the peripheral.
> >
> > the system keeps refusing to recognize usb dongles even if i unload and
> > reload the hci_usb, bluez, sco and l2cap modules and the hcid and sdpd
> > daemons.
> >
> > how can i solve these problesm? do you have any clues?
>
> as already told, SCO is not for data transfer. 

what do you mean when you say that SCO is not for data transfer? what are the 
limits of SCO sockets?

> But show us the output of "hciconfig hci0 version" and "hciconfig hci0 
> revision" (as root). 

for the dlink dbt120 usb dongle:

[root@giskard root]# hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:0D:88:8E:CA:07 ACL MTU: 192:8  SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
        Manufacturer: Cambridge Silicon Radio (10)
[root@giskard root]# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0D:88:8E:CA:07 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 15.3 (bc02x)

for the anycom 220 usb dongle:

[root@giskard root]# hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:0A:9A:00:EB:B5 ACL MTU: 339:4  SCO MTU: 64:0
        HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver: 0x93
        Manufacturer: Transilica, Inc. (24)
[root@giskard root]# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0A:9A:00:EB:B5 ACL MTU: 339:4  SCO MTU: 64:0
        Unsupported manufacturer

i am using hciconfig from bluez-utils 2.3.

BTW: clearly, when the usb/bluez subsystem hangs after trying to perform sco 
transfers, hciconfig does not recognize any bluetooth interface.

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it
