Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Control ACL link from user-space?
References: <200403222018.55288.cijoml@volny.cz> <1079998205.2663.296.camel@pegasus>
In-Reply-To: <1079998205.2663.296.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403230814.25505.cijoml@volny.cz>
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
Date: Tue, 23 Mar 2004 08:14:25 +0100

Dne =FAt 23. b=F8ezna 2004 00:30 jste napsal(a):
> Hi Michal,
>
> > is it possible to control ACL link of HID devices from userspace?
> > When my screen-saver starts, it should call ACL disconnect to save power
> > of mouse and keyboard.
>
> the current bthid contains an idle timeout after that it disconnects the
> two L2CAP channels and thus the ACL link. However the HID specification
> makes it clear that the HID device itself has to ensure that is consumes
> less power as possible. The Microsoft devices are very good with power
> saving, but the Apple devices are not so good. Actually the use of sniff
> mode saves already much power.

Hmmm...I thougth if I my own could disconnect ACL link? It's clear, that=20
devices knows it. But for example my MS disconnects after 12 mins, but=20
sometimes I need disconnect it imeditially - when I close my laptop etc.

Does the norm allow it?=20

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
