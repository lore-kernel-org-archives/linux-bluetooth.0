Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How to initiate a Pin-Exchange?
References: <200404142203.21126.panizzon@woody.ch>
In-Reply-To: <200404142203.21126.panizzon@woody.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404142211.55534.cijoml@volny.cz>
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
Date: Wed, 14 Apr 2004 22:11:55 +0200

Dne st 14. dubna 2004 22:03 Benoit Panizzon napsal(a):
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi all
>
> Probably this is a often asked Question and would belong into the FAQ
> section. I was not able to find out how to search this list's archive so I
> probably ask again :-)
>
> There are some devices which cannot initiate a pin-exchange but await that
> the computer does that task.
> Same if you try to do a bluez - bluez connection.
>
> How can I start the pin exchange with bluez?
> bluez-pin does nothing at all as I see with hcidump.

It's used when second site request pin when connecting

>
> What is bluez-pin exaclty for?
>
> PS: Are Sitecom CN-500 USB Dongels know to OOPS Kernel 2.6.5 when plugged
> or unplugged? Any workaround?

install 2.6.5-mh3 patch from Marcel's site

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
