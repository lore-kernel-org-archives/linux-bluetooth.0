Return-Path: <cyrus@holtmann.org>
Message-ID: <479C6A60.5080705@naustech.com>
Date: Sun, 27 Jan 2008 12:26:24 +0100
From: Gabriele Oberhammer <gabriele@naustech.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4795D6EB.2080209@naustech.com>	<1201018471.24085.4.camel@littletux>	<47986354.2080205@naustech.com>
	<alpine.LNX.1.00.0801270455220.19860@nge2.ngu.pk>
In-Reply-To: <alpine.LNX.1.00.0801270455220.19860@nge2.ngu.pk>
Subject: Re: [Bluez-users] Headset half working using Bluez's ALSA plugin
Reply-To: gabriele@naustech.com,
	BlueZ users <bluez-users@lists.sourceforge.net>
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

Thanks a lot for a so detailed answer! :-D

I know CVS is only for development, but I tried it because in some posts 
I red that building from CVS solved a problem similar to mine for 
someone because a patch concerning audio capture was recently added in CVS.

I had already solved the problem of missing alsa-modules before reading 
your post. The module was not built because '--enable-all' switch for 
configure seems *not* to enable all!
Using configure with all the '--enable-*' (as you suggested too) 
correctly built all modules and services.
I've also installed everything under root directories (i.e. /bin, /sbin, 
/etc, /lib, etc) (obviously after removing&purging old packages).
I guess I did everything right because now all is working fine.
But the problem with headset audio capture persists, i.e. I can do 
everything but capturing my voice.

By the way, thanks you again for your time and your suggestions.
I'll keep trying to solve the problem.
Best regards, Gabriele


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
