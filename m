Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Comments about the Logitech/HP stereo headphones
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <426BA787.9060202@xmission.com>
References: <1114345112.10706.64.camel@pegasus>
	 <426BA787.9060202@xmission.com>
Content-Type: text/plain
Message-Id: <1114356659.10706.105.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 24 Apr 2005 17:30:59 +0200

Hi Brad,

> This all sounds very good and I feel like a dope for getting rid of my 
> bluetake headset when I had only ordered, but not received, a 
> replacement. I'm still waiting for my itech. :(

if people start to donate some money, then I can buy you one of the HP
headphones to work with.

> > So what I have done so far is that I extended the pcm_a2dp ALSA plugin
> > in the utils CVS repository with the ability to cache the connection.
> 
> btsco now fires up the connection on demand and drops it immediately 
> after the close. we are going to need caching too. I noticed my phone 
> holds the connection open for about 3-5 seconds after it uses it.

Since I want to realize the headset/handsfree support also as ALSA
plugin, we will need that two. It is only for these buggy players.

> > To fully support all A2DP headphones (including Logitech/HP) this plugin
> > needs a AVDTP implementation. I have a hacked one on my development
> > system and it works fine with the GCT headphones. The code is a little
> > bit messy, but in general it works. It is fully event driven and so it
> > deprecates the idea of the AVDTP library. It is a lot easier to do it
> > directly inside the plugin. I need to cleanup the code and submit it to
> > the CVS when there is a little bit more time.
> 
> I am excited to see this!

Don't expect too much, because I am totally busy next week.

> > all about the timing. The perfect thing now would be if we can tell ALSA
> > to time everything for us. Problem is that I am not an audio expert and
> > also not an ALSA expert. Maybe the SBC encoder should return/store the
> > time the SBC frame is encoded for.
> 
> I think alsa should help us out here. If I have to learn more about the 
> alsa api to help, I will do it.

Please do so. If we can use ALSA itself for timing, then we should get a
full working pcm_a2dp plugin when they finally release the 1.0.9 version
of ALSA.

> Doing a2dp inside an alsa plugin is clearly the right way. Thomas was 
> saying that requiring alsa-lib was not good for embedded. I'm working on 
> an xscale board now and I do have to use a precious 700k of limited 
> flash for alsa-lib, but the alternative is to write something into the 
> kernel that would never be accepted by Linus.

Embedded stuff is always different. If you look at my LinuxTag 2004
slides, I had an audio sublayer inside the Bluetooth core in mind, but I
think that this will never happen.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
