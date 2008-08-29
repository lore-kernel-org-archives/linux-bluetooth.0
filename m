Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Aug 2008 08:22:59 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <42300.41687.qm@web8406.mail.in.yahoo.com>
Message-ID: <alpine.LNX.1.10.0808290815350.26779@nge2.ngu.pk>
References: <42300.41687.qm@web8406.mail.in.yahoo.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Does not work BT headset
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



On Thu, 28 Aug 2008, pramod gurav wrote:

-> Send the output  of
-> $ hcitool conn
-> It should show both SCO and ACL connections.
-> 
-> and have you run 
-> $ passkey-agent --default 0000 &
-> try running this. This is way to set the PIN for authentication.
->  And how do you connect before running mplayer?
-> When you run mplayer it will automatically establish connection. So no need to do it manually if you are doing so.

The audio player should make the connection itself, I think. Also, he seems to 
have the passkey-agent:

-> Aug 27 19:08:10 darkstar hcid[5728]: Default passkey agent (:1.43,
-> /org/bluez/passkey_agent_5737) registered


I've always used it like so:

passkey-agent --default 0000 <bt address of remote device> &


Does it work with no remote address specified (could be)?


I think it's the auth-agent that is not running. It may be needed. I always 
start this too.

auth-agent &

Here:

-> Aug 27 19:12:13 darkstar audio[5741]: Access denied: Authorization agent
-> does not exist


Is the headset an older Bluetooth 1.* device, or the newer 2.*? If it's 1.*, 
then it won't work without patching the kernel.




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
