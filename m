Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] uinput and modules.conf
References: <200403160905.27291.cijoml@volny.cz> <200403161746.03391.cijoml@volny.cz> <1079456964.3307.116.camel@pegasus>
In-Reply-To: <1079456964.3307.116.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403162226.46383.cijoml@volny.cz>
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
Date: Tue, 16 Mar 2004 22:26:45 +0100

Dne =FAt 16. b=F8ezna 2004 18:09 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > > You started bthid as root, right? The device node for uinput must be
> > > writeable.
> >
> > yes, as root, is writable...
>
> add extra syslog() statement to see where your code fails. It is working
> perfect with all my Bluetooth HID devices.

Marcel I looked through code too and haven't seen any bugs too, but it does=
n't=20
work as you seen.

When I try Peter's bthid 0.8 with fake module, everything works perfectly.

Thats really strange - but I found one thing.

Starts peter's bthid
rmmod fake;modprobe uinput;killall bthid
start yours bthid and keyboard connets=20
stop bthid
start it again
keyboard doesn't reconnect

this happens everytime

Michal

>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
