Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] keys under 2.6.5 and bthid
References: <200404200032.51458.cijoml@volny.cz> <1082414314.4403.84.camel@pegasus>
In-Reply-To: <1082414314.4403.84.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404200044.02565.cijoml@volny.cz>
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
Date: Tue, 20 Apr 2004 00:44:02 +0200

Dne =FAt 20. dubna 2004 00:38 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > Now I looked into dmesg and thereis:
> >
> > atkbd.c: Unknown key released (translated set 2, code 0x7a on
> > isa0060/serio0). atkbd.c: This is an XFree86 bug. It shouldn't access
> > hardware directly. atkbd.c: Unknown key released (translated set 2, code
> > 0x7a on isa0060/serio0). atkbd.c: This is an XFree86 bug. It shouldn't
> > access hardware directly.
> >
> > Maybe this will help?
>
> as the error says, this is a XFree86 bug and not a kernel bug ;)

Hmmm but I don't understand, why this doesn't happens under 2.4?

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
