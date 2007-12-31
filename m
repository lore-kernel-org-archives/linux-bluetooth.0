Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300712301821tfb09ed9y92a25672211db355@mail.gmail.com>
Date: Sun, 30 Dec 2007 19:21:45 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <123485.22659.qm@web52907.mail.re2.yahoo.com>
MIME-Version: 1.0
References: <123485.22659.qm@web52907.mail.re2.yahoo.com>
Subject: Re: [Bluez-users] Bluetooth headset failing with lib/utils 3.24 and
	bluez-gnome 0.15
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

Chris

> ALSA lib pcm_bluetooth.c:458:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION failed : Input/output
> error(5)

I'm having the same problem in utils head... bluetooth_hsp_hw_params
addresses one block of memory through three different layered structs
so it's tricky to follow.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
