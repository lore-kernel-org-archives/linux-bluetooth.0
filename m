Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45AFB36A.4040702@free.fr>
Date: Thu, 18 Jan 2007 18:50:34 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200701150326.46855.bluez-devel@huitl.de>	<7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EBF@eumonex01.palmsource.com>	<45AE6C85.90803@free.fr>
	<45AE75CB.6050202@xmission.com>
In-Reply-To: <45AE75CB.6050202@xmission.com>
Subject: Re: [Bluez-devel] RE : a2dpd and mplayer - any chance to
	get	it	working?
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

Brad Midgley wrote:
> Guys
> 
>> What you've done in the a2dp pcm plugin(if i understood well) is to 
>> throttle the application using sleep. But that does not emulate the ring 
>> buffer behaviour well enough, so it breaks MPlayer. :-(
> 
> although vlc works, maybe it is using the same execution thread for both 
> audio and video and getting i/o blocked. when I switch it to a2dp on an 
> older machine, full-motion video goes from smooth to very choppy. this 
> is using the 32-bit codec so it shouldn't take that much cpu.
> 
> is this just a design problem with alsa that should be worked around in 
> players?


I would rather vote for a bug in a2dp plugin. ;-)
Btw, did you try with sco plugin ? Is it better ?

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
