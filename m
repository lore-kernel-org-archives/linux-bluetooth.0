Return-Path: <cyrus@holtmann.org>
Message-ID: <47B08D48.7020202@aircable.net>
Date: Mon, 11 Feb 2008 16:00:40 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <200802111731.m1BHVQ9I009663@alumnus.caltech.edu>
In-Reply-To: <200802111731.m1BHVQ9I009663@alumnus.caltech.edu>
Subject: Re: [Bluez-users] failed PIN Code Request
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Russell A. Bell escribi=F3:
> 	Quoth Manuel Naranjo:
> 	'If I'm not wrong it's not your headset the one that closes the
> connection, but rather the kernel.
> 	Solution:
> 	ADDR=3D<SOMETHING> hcitootl cc $ADDR; hcitool auth $ADDR
> 	Still not the preferred way but it works.'
> 	I interpret the contents of hcidump to indicate that the
> kernel closes the connection.  I wonder why.  What you proposed
> doesn't work for me.
>   =

Russel is it much asking that you don't break the threads? It's hard to
track your mails.

If this doesn't work, then you have something else going on, maybe
you're missing the passkey agent or something.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
