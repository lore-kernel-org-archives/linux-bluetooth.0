Return-Path: <cyrus@holtmann.org>
Message-ID: <47AD98EF.2030706@aircable.net>
Date: Sat, 09 Feb 2008 10:13:35 -0200
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <200802090347.m193lOJq023253@alumnus.caltech.edu>
	<alpine.LNX.1.00.0802082340390.12621@nge2.ngu.pk>
In-Reply-To: <alpine.LNX.1.00.0802082340390.12621@nge2.ngu.pk>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


> the other side, computer to device. I believe that's 'hcitool cc <address>' 
> then 'hcitool auth <address>' but my headset doesn't seem to like to operate 
> this way and wants to disconnect quickly due to not being used for sound.
>   
If I'm not wrong it's not your headset the one that closes the
connection, but rather the kernel.

Solution:
ADDR=<SOMETHING> hcitootl cc $ADDR; hcitool auth $ADDR

Still not the preferred way but it works.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
