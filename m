Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pand seem to ignore any pin configurations
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200505081727.29246.rdorsch@web.de>
References: <200505072203.45598.rdorsch@web.de>
	 <200505081508.10056.rdorsch@web.de> <1115559373.9031.60.camel@pegasus>
	 <200505081727.29246.rdorsch@web.de>
Content-Type: text/plain
Message-Id: <1115567196.9031.113.camel@pegasus>
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
Date: Sun, 08 May 2005 17:46:36 +0200

Hi Rainer,

> > > > if you use "security user" then the PIN is provided through the PIN
> > > > helper script.
> > >
> > > and auto just uses the pin in
> > >
> > > /etc/bluetooth/pin ?
> >
> > for incoming connection, yes.
> >
> > > Then all the helper scripts in the net which print out
> > >
> > > PIN: <content of /etc/bluetooth/pin>
> > >
> > > are nonsense?
> >
> > No. Why should they. The script got called and then it reads the pin and
> > writes it to standard out. Think about it ;)
> 
> Wouldn't be
> 
> security auto 
> 
> the same as
> 
>         security user
>         # PIN helper
>         # pin_helper /usr/bin/bluez-pin;
>         pin_helper /usr/local/sbin/mypin
> 
>  and /usr/local/sbin/mypin, containing 
> 
>         #!/bin/sh
>         PIN=`cat /etc/bluetooth/pin`
>         echo "PIN:$PIN"
> 
> ?

in this special case, yes. But in most cases you use a graphical PIN
helper.

> > > Hmm....is pairing persistent over rebooting one or both systems (NAP:
> > > security auto and PANU: security user)? At least that is what I did and I
> > > did not enter a password. pin_helper is bluez-pin on the PANU, so I
> > > expect that PANU should have querried for a password in any case.
> >
> > The pairing itself is persistent over reboots and also unplugging. The
> > link keys are also cached inside the chip and so Authentication
> > Requested must not always result in asking for the link key or pin code.
> >
> > > Replugging the usb bt dongle restarts bluez-utils. Is pairing persistent
> > > over restarting bluez-utils?
> > >
> > > Is it ok that pand on the PANU dies after connection establishment?
> > >
> > > root      4296  0.0  0.2  1548  492 ?        S<   14:48   0:00
> > > /usr/bin/pand --nodetach --role PANU --search --encrypt
> > > root      4303  0.0  0.2  1548  472 pts/2    S+   14:49   0:00 grep pand
> > > topsi:~# ps uaxwww|grep pand
> > > root      4397  0.0  0.2  1548  472 pts/2    S+   14:50   0:00 grep pand
> > > topsi:~#
> > >
> > >
> > > I did an hcidump after replugging the bt usb dongle on PANU, hcidump is
> > > also
> > >
> > > on PANU:
> > > > HCI Event: Link Key Request (0x17) plen 6
> > >
> > >   0000: 9f 24 82 61 04 00                                 .$.a..
> > > < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> > >   0000: 9f 24 82 61 04 00 bf 9c  53 9d f1 8e fb 60 50 c7 
> > > .$.a....S....`P. 0010: 11 26 ac e3 16 06                                
> > > .&....
> > >
> > > > HCI Event: Command Complete (0x0e) plen 10
> > >
> > >     Link Key Request Reply (0x01|0x000b) ncmd 1
> > >     0000: 00 9f 24 82 61 04 00                              ..$.a..
> >
> > It asks for the link key and so you are pairing. To always be asked for
> > the PIN code I think you need to change hcid to allow a mode where you
> > always have to redo the pairing. In this case the Link Key Request must
> > be answered with a Link Key Request Negative Reply. This effect can also
> > be reached by deleted the link key from the local storage.
> 
> Not asking for a PIN each time is actually fine (persisten pairing is a nice 
> invention;-). I just want to check that the system really wants to see a PIN 
> when a new device comes in.
> 
> Are you saying when I delete
> 
> 	/etc/bluetooth/link_key
> 
> on both NAP and PANU I should be askef for a password?

Yes. And with bluez-utils-2.16 the link key storage has been changed.
Check the mailing list archive for more details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
