Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BT950_CS
References: <407195F7.4020907@pobox.com>
In-Reply-To: <407195F7.4020907@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404052141.38457.cijoml@volny.cz>
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
Date: Mon, 5 Apr 2004 21:41:37 +0200

I think that this driver is not ported to 2.6 nor finished. It has many errors 
in 2.4 too, but is compilable.

Michal

Dne po 5. dubna 2004 19:23 Daniel Jimenez napsal(a):
> Hi all. I apologize in advanced for the noobish question. I tried
> RTFMing but couldn't find what I needed.
>
> I have an Ambicom BT2000-CF. According to cardctl ident its:
>
> Socket 0:
>    product info: "AmbiCom,Inc", "BT2000E", "Bluetooth PC/CF Card"
>    manfid: 0x022d, 0x2000
>    function: 2 (serial)
>
> --
>
> The driver I need is either BT950_CS
> (http://www.holtmann.org/linux/bluetooth/bt950.html) or BT2000E
> (http://www.iral.com/~albertr/linux/bt2000e/).
>
> I'm running a vanilla Kernel 2.6.5 with all the bluetooth options
> compiled in (except no drivers).
>
> ...
>
> I've downloaded the source for both of these packages but cannot figure
> out how to compile the modules.
>
>   BT950 came with a make file, but a TON of errors were returned when I
> attempted to make it. I assume it was built for another kernel series
> (maybe 2.4?).
>
>   BT2000E just came with a changelog and a .c file. I did gcc bt2000e.c
> and it returned a whole hell of allot more errors.
>
>
> ...
>
> Is there something I'm missing/not doing? I have bluez-libs installed as
> well. I can post the output of the compiles to a web server if needed.
>
> Thanks!,


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
