Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bthid and battery condition and syslog
References: <200403171259.22015.cijoml@volny.cz> <1079525750.3301.14.camel@pegasus>
In-Reply-To: <1079525750.3301.14.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403171320.24816.cijoml@volny.cz>
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
Date: Wed, 17 Mar 2004 13:20:24 +0100

Dne st 17. b=F8ezna 2004 13:15 jste napsal(a):
> Hi Michal,
>
> > is there possible to switch off sysloging battery condition?
> >
> > bthid generates 2KB/10minutes into syslog
> >
> > Maybe there should be in bthid some kind of condition as in nut - UPS
> > battery monitor and not to sysloging?
>
> look at the source code and comment it out.

I better prefer to be bthid abble receive tcp connections a reports via it =
and=20
not into syslog.
It would be used then with some kind of graphical output like mrtg or rrdto=
ol
as soon as I monitor UPS battery

>
> Regards
>
> Marcel

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
