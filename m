Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44CF7738.6060101@xmission.com>
Date: Tue, 01 Aug 2006 09:46:00 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <056BF200E9632F4285220E570FEED673D03062@GBMDDMH202AMSX.gb001.siemens.net>
	<44CF529B.2000503@palmsource.com>
In-Reply-To: <44CF529B.2000503@palmsource.com>
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmms error
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

Guys

>>Maybe the build doc in the plugin directory needs updating ???

I've been waffling on how to go forward. What do you think of this plan?

- minimal update to btsco documents to bring in line
- make a btsco snapshot release .43
- use new wavez sourceforge project for alsa (both sco and a2dp)
plugins, for a2play test code and eventually gstreamer plugins
- create wavez as a cvs project (was tempted by svn but there's a
learning curve for everyone)
- leave out libsbc from the new project so we cleanly use the standalone
library
- eventually remove pieces from bluetooth-alsa's btsco project (alsa
plugins etc) to leave it mostly as it originally was, just the kernel
sco audio
- obviously refactor the documentation, simplifying btsco and updating wavez

I want to send the message especially for distros that wavez is where
they should put packaging effort and all the plugins there will be past
experimental and worth giving to users.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
