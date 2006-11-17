Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Reiner Klenk <pdq808@t-online.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <455E0CC1.3030706@gmail.com>
References: <455E0CC1.3030706@gmail.com>
Date: Fri, 17 Nov 2006 22:42:27 +0100
Message-Id: <1163799747.9882.7.camel@grappa>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Motorola H500 - Fedora Core 6
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

On Fri, 2006-11-17 at 12:25 -0700, Jonathan Steffan wrote:
> I'm having issues sending audio to my new H500. Per the readme here is
> all my info:

> aplay -B 1000000 -D plughw:Headset sound.wav
> Playing WAVE 'sound.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Stereo
> 

aplay requires that the headset supports a2dp. From descriptions found
on the net I would conclude that the H500 does not. You would need
something like the Motorola HT820 or the Jabra BT620s.

Regards,
Reiner

-- 
debb1046 (gmail.com, gtalk, jabber.org, ekiga.net, last.fm, skype)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
