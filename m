Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: jp-www@dcs.gla.ac.uk
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [ANNOUNCE] ALSA Bluetooth Headset Driver
Message-ID: <20030926085100.GA1280@air.luon.net>
References: <Pine.LNX.4.54.999.0309150112530.29667@sibu.dcs.gla.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.54.999.0309150112530.29667@sibu.dcs.gla.ac.uk>
From: sjoerd@air.luon.net (Sjoerd Simons)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 26 Sep 2003 10:51:00 +0200

On Mon, Sep 15, 2003 at 01:21:39AM +0100, jp-www@dcs.gla.ac.uk wrote:
> Hi,
> 
> Having recently got a Bluetooth headset (HBH-60), I've put together a
> preliminary ALSA driver which works with bluez.
> 
> 	http://www.dcs.gla.ac.uk/~jp/snd-bluez-sco/
> 
> I'd appreciate any feedback on this. The code is a bit messy at the
> moment, but I've had fairly good results with it.

Works fine with a globecom BT1000 headset and a csr usb dongle. Only the
record latency is bad (> 1 second).

I'm using it in combination with gnomemeeting and besides the latency no
problems, nice work :)

  Sjoerd
-- 
Reality is nothing but a collective hunch.
	-- Lily Tomlin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
