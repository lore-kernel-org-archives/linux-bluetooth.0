Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bthid dies via kernel oops in 2.6.5
References: <200404120212.53136.cijoml@volny.cz> <200404121822.44231.cijoml@volny.cz> <1081788433.8634.2.camel@pegasus>
In-Reply-To: <1081788433.8634.2.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404121854.08693.cijoml@volny.cz>
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
Date: Mon, 12 Apr 2004 18:54:08 +0200

Dne po 12. dubna 2004 18:47 jste napsal(a):
> Hi Michal,
>
> > preempt people told me the same as you :D They told, that this is BT
> > problem :D But they are possibly right, coz kernel oopses too, when I use
> > nonpreempt kernel
>
> I used preempt for a long time now and it works for me, but looking at
> the oops this is not a Bluetooth problem. It is the uinput driver that
> causes the problem.

Well and who should I ask for fixing? It is too hard to use Linux without 
console :D

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
