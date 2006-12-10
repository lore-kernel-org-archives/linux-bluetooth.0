Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <457C2D1F.1050605@free.fr>
Date: Sun, 10 Dec 2006 16:51:59 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] [RFC] : Bluez audio routing: introducing switch alsa
	plugin
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

All,

I got here a suggestion for audio routing.
I take here as assumption that it is a possibility that sco and a2dp
plugins are different.

The idea is to bring in the picture a new plugin that i would call
conveniently the 'switch' plugin.
As its name suggests, its role would be to route to either one PCM
stream or another PCM.

We could imagine that per default the plugin would route audio to wired
PCM IO, and when notified that a alternate PCM is ready, would switch to
this plugin.

This would give sth like that:

audio application --> switch plugin --> wired io PCM
			|
			|
			----> bluetooth plugin --> bt.audiod


This is an audio routing suggestion that could be used for both SCO and
A2DP.

as usual, comments are welcomed,

Cheers,

Fabien


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
