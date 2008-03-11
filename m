Return-Path: <cyrus@holtmann.org>
From: "Andrew Kohlsmith (lists)" <aklists@mixdown.ca>
To: bluez-users@lists.sourceforge.net
Date: Tue, 11 Mar 2008 13:19:21 -0400
References: <mailman.551346.1203302340.26582.bluez-users@lists.sourceforge.net>
	<BLU140-W15FA67671DB5E1E6450FBECB220@phx.gbl>
	<47BB5F2D.8010706@wershofen.de>
In-Reply-To: <47BB5F2D.8010706@wershofen.de>
MIME-Version: 1.0
Message-Id: <200803111319.21563.aklists@mixdown.ca>
Subject: Re: [Bluez-users] Twinkle and bluetooth headset's microphone
Reply-To: akohlsmith-lists@mixdown.ca,
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

On February 19, 2008 05:58:53 pm Wolfgang Wershofen wrote:
> Anyway, rapid closing and reopening a handle isn't anything rogue at all.

There was a fix committed to utils CVS not too long ago (1 week, maybe 2) 
which fixes this by waiting a few seconds before actually closing down the 
audio link to the headset.  It certainly solved my Twinkle problems.

Twinkle also released a new version last week which doesn't rapidly close and 
reopen the audio device, so the problem has been fixed from both sides.

Regards,
Andrew

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
