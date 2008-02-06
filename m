Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Feb 2008 20:57:46 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <47A8669E.4080308@gmx.de>
Message-ID: <alpine.LNX.1.00.0802052048490.20192@nge2.ngu.pk>
References: <47A274DB.9020808@gmx.de> <1202025949.7162.10.camel@localhost>
	<47A8669E.4080308@gmx.de>
MIME-Version: 1.0
Subject: Re: [Bluez-users] BT Headset connected but no sound
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


On Tue, 5 Feb 2008, Daniel Stumpner wrote:

-> I got it working!

Lucky ;)

I think I have some hardware incompatibility problems, because my 
logs are looking OK now, and the system device appears to transmit sound while 
the headset acts like it's receiving sound (yet no sound).


-> I patched my 2.6.23 kernel with the bluez-patch and attached the
-> force_scofix=1 option (to kernel boot line and to modrobe.conf just to
-> make sure)
-> That didn't change anything for me.
-> Then I installed the bluez-gnome agent and started the applet. That
-> helped me getting rid of the warning that no authorization agent is
-> available.
-> Should't be one in bluez-utils/daemon/auth-agent.c  ???

Yes, there should be a binary auth-agent.

-rwxr-xr-x 1 root bin 8552 2008-02-05 02:13 /usr/bin/auth-agent


-> How can I get this one working?

I've been starting both passkey-agent and auth-agent. I've not seen auth 
failures in my logs now. Start them before you try to use remote device.

passkey-agent --default (pin) (addr of remote device) &
auth-agent &

Both should background. That's from trial and error, I've not seen that 
documented anyplace. But it seems to work. YMMV.





-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
