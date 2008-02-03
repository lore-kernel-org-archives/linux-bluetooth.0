Return-Path: <cyrus@holtmann.org>
Message-ID: <47A54226.2040703@gmx.de>
Date: Sun, 03 Feb 2008 05:25:10 +0100
From: Daniel Stumpner <bigstumpi@gmx.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <47A274DB.9020808@gmx.de>
	<47A438C6.90700@gmx.de>	<1201948807.11895.10.camel@littletux>
	<alpine.LNX.1.00.0802022032290.23675@nge2.ngu.pk>
In-Reply-To: <alpine.LNX.1.00.0802022032290.23675@nge2.ngu.pk>
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

Hello,

I tried with the Patch for 3.24 and with the new version bluez-utils-3.25.

One Error Message is gone in both cases but the problem is still the
same. Is there a difference between the Authorization Agent and the
Passkey-Agent in log Messages?
(The Message "no default passkey agent" is gone.)


Now I get following output:

hcid[7839]: link_key_request (sba=00:10:C6:F8:11:7C, dba=00:0D:44:30:4B:11)
audio[7846]: Requesting authorization for device 00:0D:44:30:4B:11, UUID
00001112-0000-1000-8000-00805F9B34FB
audio[7846]: State changed /org/bluez/audio/device0:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
audio[7846]: Access denied: Authorization agent does not exist
audio[7846]: State changed /org/bluez/audio/device0:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
hcid[7839]: link_key_notify (sba=00:10:C6:F8:11:7C, dba=00:0D:44:30:4B:11)


Can you tell me what further detailed information you (or I) need to
find the reason for my problem?

Thanks for your time!
Regards, Daniel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
