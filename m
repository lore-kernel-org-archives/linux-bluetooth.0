Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 12 Sep 2007 11:13:28 +0200
From: Stefan Seyfried <seife@suse.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070912091328.GA6594@suse.de>
References: <iafkr4-c36.ln1@tisnix.motzarella.org>
MIME-Version: 1.0
In-Reply-To: <iafkr4-c36.ln1@tisnix.motzarella.org>
Subject: Re: [Bluez-users] Bluetooth mouse not connecting using Lenny
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

On Wed, Sep 12, 2007 at 08:58:58AM +0200, wimpunk wrote:
> Hi List,
> =

> Since my upgrade to Lenny, my mouse doesn't connect automatically
> anymore.  To get my mouse working, I have to remove my USB bluetooth
> dongle and put it back.  I've compared the modules before and after but
> everything is the same.
> I've asked this on the debian mailinglist but nobody had an answer so
> maybe the bluez-user list can.
> When I try to connect after startup I get:
> =

> $ hidd --connect 00:30:05:00:04:13
> Can't get device information: Connection timed out

Use recent bluez-libs/utils, they don't need hidd anymore.

> I remove the BT dongle and put it back:
> $ hidd --connect 00:30:05:00:04:13
> $
> =

> Any one a suggestion what's going wrong?

No. I see similar looking problems sometimes, that is having to unplug
the dongle before my mouse will reconnect again, but this surely has
a different reason.
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
