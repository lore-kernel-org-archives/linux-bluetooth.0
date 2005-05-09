Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Regarding a2recv
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050509033555.12509786.henryk@ploetzli.ch>
References: <20050506060525.32b209ca.henryk@ploetzli.ch>
	 <20050508125039.1494.qmail@web8305.mail.in.yahoo.com>
	 <20050509005413.3787d2d7.henryk@ploetzli.ch>
	 <1115596897.8949.79.camel@pegasus>
	 <20050509025805.331c34c7.henryk@ploetzli.ch>
	 <1115600627.8949.93.camel@pegasus>
	 <20050509033555.12509786.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1115603053.8949.108.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 09 May 2005 03:44:13 +0200

Hi Henryk,

> > you must do it on the HCI level at the correct time. Look at the
> > function hci_switch_role() for more details.
> 
> Ah, thanks, that does it. I copied and adapted the relevant code from
> hcitool.c and it works like a charm. Problem is: When trying to do the
> roleswitch the program can only run as root, which is not exactly what
> I want. I committed it to cvs anyways, but it is #ifdef'd out. Compile
> with -DROLESWITCH to use it.

I know, but it is meant to be a root only command. Some time ago I had
the idea of adding an ioctl() to socket to change the role if no other
part of the HCI core objects. The same goes for the authentication and
the encryption mode. However I never did it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
