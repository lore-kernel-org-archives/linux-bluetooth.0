Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] extracted apple firmware
References: <200412271341.10149.cijoml@volny.cz> <1104315512.6319.1.camel@notepaq>
In-Reply-To: <1104315512.6319.1.camel@notepaq>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200412291135.31300.cijoml@volny.cz>
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
Date: Wed, 29 Dec 2004 11:35:31 +0100

My problem was that I haven't access to Apple :) But one guy send me extracted 
1.2 apple's fw and now my dongle is 18.2 with hid proxy :)

Marcel other D-Link DBT-120 B3 success :)

Michal

Dne st 29. prosince 2004 11:18 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > I finally got Dlink DBT-120 rev B3, so I would like upgrade it. Can
> > anybody send me extracted apple's firmware?
>
> I have a link to one somewhere on my page.
>
> > Marcel is this options for flash OK?
> >
> > src/btdfu -d hci0 archive dlink.dfu
> > To backup existing FW,
> > src/btdfu -d hci0 upgrade dlink.dfu
> > To flash a new one?
>
> It is fine, but the -d option is not really supported. You will get a
> menu. And btw you should choose two different names.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
