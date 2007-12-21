Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU117-W236D38B8C3E38C09A75D83885E0@phx.gbl>
From: Benson Dong <dongas86.dev@hotmail.com>
To: Bluez-user <bluez-users@lists.sourceforge.net>
Date: Fri, 21 Dec 2007 14:33:47 +0800
MIME-Version: 1.0
Subject: [Bluez-users] a2dp choppy sound problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0495577296=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0495577296==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi all,
    I get very choppy sound when playback audio through A2DP. Even the application shows playback ends,the headset could still hear the intermittent choppy sound for a few seconds.

Here are some tests:
# aplay -D bluetooth /1.wav
result:choppy
#play --device=bluetooth /1.wav
result:choppy
#mplayer -ao alsa:device=bluetooth
result:choppy

So i think it's possible not audio application problems.
Could some one who knows about this problem give me some help?

Thanks in advance!
Benson


_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/


--===============0495577296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0495577296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0495577296==--
