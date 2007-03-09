Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45F1A28D.7070502@xmission.com>
Date: Fri, 09 Mar 2007 11:08:13 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45F08496.8000806@wershofen.de>
In-Reply-To: <45F08496.8000806@wershofen.de>
Subject: Re: [Bluez-users] headsetd(plugz) vs. btsco - My experiences with
 BT	telephony
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Wolfgang

Did you patch your kernel with the flowcontrol patch (plugz/patches)? It 
might help the loud noise. Are you trying a recent version of plugz?

It sounds like you may have an audio server introducing latency with 
btsco. It's more likely to happen with btsco accidentally since it shows 
up as a "real" alsa kernel device.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
