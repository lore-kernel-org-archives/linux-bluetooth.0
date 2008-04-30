Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5a2c100804301137w1a555aefh87f364275b41048c@mail.gmail.com>
Date: Wed, 30 Apr 2008 15:37:25 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1209548744.5829.5.camel@ubuntu>
MIME-Version: 1.0
References: <1209501760.14773.13.camel@ubuntu>
	<2d5a2c100804291906i261e1bqf5e91539d9cd9df8@mail.gmail.com>
	<821c07e60804292333g4271303lfade6b403acfb8b@mail.gmail.com>
	<1209548744.5829.5.camel@ubuntu>
Subject: Re: [Bluez-devel] bluetoothd-service-network fails to execute ifup
	scripts from network.conf after repeated connection attempts
	(Patched)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

What seems to be triggering the problem is that bnep_if_down is not
been called on disconnect than
the g_slist_find is causing the problem on bnep_if_up as it turn to
return without bringing up the
interface.

Also please make sure you test this against cvs, so we avoid redoing
work already done.

-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
