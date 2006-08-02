Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 2 Aug 2006 09:45:42 +0100
Message-ID: <056BF200E9632F4285220E570FEED673D035B8@GBMDDMH202AMSX.gb001.siemens.net>
In-Reply-To: <44CF7738.6060101@xmission.com>
From: "Waldram, Andrew (SBS UK)" <andrew.waldram@siemens.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
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

Not sure about wavez name as

www.wavez.org is already taken
Wavez.com exists

There appears to be a Wintel program  WaveZ Ver.1.70beta for
Windows95/98/NT4.0/Win2000 in existence

Given this lot isn't the name a little confusing

Also for a release shouldn't a2dpd actualy bahave like a deamon.

i.e

1. confuration file to parse bt id (/etc/bluez/a2dpd.conf ot maybe
/etc/default)
2. runs as a deamon in background as default
3. example init scrips supplies would be cool

At present if you atttempt to run a2dpd in the background from sysv
startup (at least on my Ubuntu 6.06) it locks ths machine solid after
about 30 minutes.

If you attempt to output to a file i.e a2dpd 00:11:22:33:44:55 >
/home/andy/bt.log then nothing is written to the file until you kill
a2dpd 
But if you a2dpd 00:11:22:33:44:55 > /dev/tty1 then it appears on the
terminal

a2dpd 00:11:22:33:44:55 > /dev/null appears to cure the hang so I think
its probably related to all the DEBUG output messages.

After being negative I'd just like to thank you for all the work you've
done it works really well already.


------------------------------------------------------------------------
---------- 

SIEMENS 
Andrew Waldram
Technical Implementations Group 
Server Specialist - South 

*  Tel: +44 (0) 1344 396619
*  Mob: +44 (0) 7808 827469
*   Fax: +44 (0) 1344 358056 
* Email:  Andrew.waldram@siemens.com 

This e-mail contains confidential information and is for the exclusive
use of the addressee/s. If you are not the addressee, then any
distribution, copying or use of this e-mail is prohibited. If received
in error, please advise the sender and delete it immediately. We accept
no liability for any loss or damage suffered by any person arising from
use of this e-mail. 

Siemens Business Services Limited 

Registered No: 1203466 England 
Registered Office: Siemens House, Oldbury, Bracknell, Berkshire, RG12
8FZ 


-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Brad
Midgley
Sent: 01 August 2006 16:46
To: BlueZ development
Subject: Re: [Bluez-devel] a2pd btsco won't compile (FIX) plus xmms
error

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
- obviously refactor the documentation, simplifying btsco and updating
wavez

I want to send the message especially for distros that wavez is where
they should put packaging effort and all the plugins there will be past
experimental and worth giving to users.

Brad

------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
