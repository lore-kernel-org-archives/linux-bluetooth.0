Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] ISSC USB Dongle does not work with current bluez?
References: <200407222124.44032.Andreas.Krause@web.de> <200407231251.27478.Andreas.Krause@web.de> <1090579838.4791.20.camel@pegasus>
In-Reply-To: <1090579838.4791.20.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200407231422.04259.cijoml@volny.cz>
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
Date: Fri, 23 Jul 2004 14:22:03 +0200

Marcel,

everything is about money. And paying programmers costs money :(

Michal

Dne p=E1 23. =E8ervence 2004 12:50 Marcel Holtmann napsal(a):
> Hi Andreas,
>
> > > > And here's the dump for "hcitool inq":
> > > > < HCI Command: Inquiry (0x01|0x0001) plen 5
> > > >   33 8B 9E 08 64
> > > >
> > > > > HCI Event: Command Status (0x0f) plen 4
> > > >
> > > >   00 01 01 04
> > >
> > > I miss the inquiry complete event.
> >
> > There's no other output. 'hcitool scan' terminates with "Inquiry failed:
> > Connection timed out". No other events shown by hcidump. Sorry.
>
> very nice :(
>
> Another buggy Bluetooth chip with a stupid link manager. Is it really so
> hard to get a correct HCI implementation before manufacturing end-user
> products?
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=3D4721&alloc_id=3D10040&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
