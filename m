Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pand seem to ignore any pin configurations
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200505081508.10056.rdorsch@web.de>
References: <200505072203.45598.rdorsch@web.de>
	 <200505072339.13643.rdorsch@web.de> <1115503367.9031.31.camel@pegasus>
	 <200505081508.10056.rdorsch@web.de>
Content-Type: text/plain
Message-Id: <1115559373.9031.60.camel@pegasus>
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
Date: Sun, 08 May 2005 15:36:13 +0200

Hi Rainer,

> > > thanks for the quick reply. Where would I specify the PIN on the PANU?
> > > Should pin_helper in hcid.conf provide this? Where would I specify the
> > > PIN on the NAP?
> >
> > if you use "security user" then the PIN is provided through the PIN
> > helper script.
> 
> and auto just uses the pin in 
> 
> /etc/bluetooth/pin ?

for incoming connection, yes.

> Then all the helper scripts in the net which print out
> 
> PIN: <content of /etc/bluetooth/pin>
> 
> are nonsense?

No. Why should they. The script got called and then it reads the pin and
writes it to standard out. Think about it ;)

> When security user on NAP and PANU, is pin_helper called both on PANU and NAP 
> and the pins just should be the same?

Yes.

> > > There is no --auth for pand:
> >
> > You read my answer, do you? I said that I realized that it is missing
> > and that you should use --encrypt instead. It is fixed in the CVS.
> 
> I apologize for not carefully reading.

No problem. Next version will include it.

> > > When I do have them and the --encrypt option for pand on the NAP
> > >
> > > rd@silverboxy:~$ ps uaxwww|grep pand|grep -v grep
> > > root     15840  0.0  0.1  1548  536 ?        Ss   23:32   0:00
> > > /usr/bin/pand --encrypt --listen --persist --role NAP --pidfile
> > > /var/run/pand.pid rd@silverboxy:~$
> > >
> > > I still get pinless authentification (or they somehow match, though I
> > > tried to make them different in all files).
> >
> > Check with "hcidump -X -V" is you are not already paired and both sides
> > only authenticate with a link key. You can also use "hcitool auth" do
> > trigger the authentication by hand.
> 
> hcitool auth is pretty transparent. When I dump on the PANU and run hcitool 
> auth <PANU-addr> on the NAP, I get no output at all from hcidump, when I run 
> hcitool auth <NAP-addr>, I get (again from hcidump on PANU):

Make sure you start "hcidump" as root.

> < HCI Command: Authentication Requested (0x01|0x0011) plen 2
>   0000: 29 00                                             ).
> > HCI Event: Command Status (0x0f) plen 4
>     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> > HCI Event: Auth Complete (0x06) plen 3
>     status 0x00 handle 41
> 
> 
> Hmm....is pairing persistent over rebooting one or both systems (NAP: security 
> auto and PANU: security user)? At least that is what I did and I did not 
> enter a password. pin_helper is bluez-pin on the PANU, so I expect that PANU 
> should have querried for a password in any case.

The pairing itself is persistent over reboots and also unplugging. The
link keys are also cached inside the chip and so Authentication
Requested must not always result in asking for the link key or pin code.

> Replugging the usb bt dongle restarts bluez-utils. Is pairing persistent over 
> restarting bluez-utils?
> 
> Is it ok that pand on the PANU dies after connection establishment?
> 
> root      4296  0.0  0.2  1548  492 ?        S<   14:48   0:00 /usr/bin/pand 
> --nodetach --role PANU --search --encrypt
> root      4303  0.0  0.2  1548  472 pts/2    S+   14:49   0:00 grep pand
> topsi:~# ps uaxwww|grep pand
> root      4397  0.0  0.2  1548  472 pts/2    S+   14:50   0:00 grep pand
> topsi:~# 
> 
> 
> I did an hcidump after replugging the bt usb dongle on PANU, hcidump is also 
> on PANU:
>
> > HCI Event: Link Key Request (0x17) plen 6
>   0000: 9f 24 82 61 04 00                                 .$.a..
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>   0000: 9f 24 82 61 04 00 bf 9c  53 9d f1 8e fb 60 50 c7  .$.a....S....`P.
>   0010: 11 26 ac e3 16 06                                 .&....
> > HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Reply (0x01|0x000b) ncmd 1
>     0000: 00 9f 24 82 61 04 00                              ..$.a..

It asks for the link key and so you are pairing. To always be asked for
the PIN code I think you need to change hcid to allow a mode where you
always have to redo the pairing. In this case the Link Key Request must
be answered with a Link Key Request Negative Reply. This effect can also
be reached by deleted the link key from the local storage.

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
