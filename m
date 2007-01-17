Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45AE75CB.6050202@xmission.com>
Date: Wed, 17 Jan 2007 12:15:23 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200701150326.46855.bluez-devel@huitl.de>	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EBF@eumonex01.palmsource.com>
	<45AE6C85.90803@free.fr>
In-Reply-To: <45AE6C85.90803@free.fr>
Subject: Re: [Bluez-devel] RE : a2dpd and mplayer - any chance to get
	it	working?
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

> What you've done in the a2dp pcm plugin(if i understood well) is to 
> throttle the application using sleep. But that does not emulate the ring 
> buffer behaviour well enough, so it breaks MPlayer. :-(

although vlc works, maybe it is using the same execution thread for both 
audio and video and getting i/o blocked. when I switch it to a2dp on an 
older machine, full-motion video goes from smooth to very choppy. this 
is using the 32-bit codec so it shouldn't take that much cpu.

is this just a design problem with alsa that should be worked around in 
players?

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
