Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] latest modules.conf settings for bluez
References: <200403171309.13660.cijoml@volny.cz> <1079525913.3301.18.camel@pegasus>
In-Reply-To: <1079525913.3301.18.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403171328.28472.cijoml@volny.cz>
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
Date: Wed, 17 Mar 2004 13:28:28 +0100

Dne st 17. b=F8ezna 2004 13:18 jste napsal(a):
> Hi Michal,
>
> > I am sending my latest modules.conf. Can you look at it and tell me if
> > it's complete modules.conf for BlueZ?
> >
> > #BlueZ settings
> > alias net-pf-31 bluez
> > alias bt-proto-0 l2cap
> > alias bt-proto-2 sco
> > alias bt-proto-4 bnep
> > alias tty-ldisc-15 hci_uart
> > alias char-major-10-250 hci_vhci
> > alias bt-proto-3 rfcomm
> > alias char-major-10-223 uinput
> > above uinput mousedev keybdev
> > above bluez hci_usb
>
> I don't know what "above" do. The bluez and hci_usb should be loaded if
> the dongle is plugged in by hotplug.

above is similiar to pre-install bluez modprobe -k hci_usb :)

it's shorter :D
I don't really like hotplug...and I nor don't need it, coz I use BT dongle=
=20
everytime :)

>
> > post-install hci_usb /sbin/hciconfig hci0 lm master
>
> This is not a good idea and does not really work. Put it into hcid.conf,
> but I prefer leaving it "slave,accept". The bthid will itself set to
> master mode.

Thanks removing :)

Michal

>
> Regards
>
> Marcel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
