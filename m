Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
To: Sjoerd Simons <sjoerd@air.luon.net>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [ANNOUNCE] ALSA Bluetooth Headset Driver
In-Reply-To: <20030926085100.GA1280@air.luon.net>
Message-ID: <Pine.LNX.4.54.999.0309260958140.1399@brava.dcs.gla.ac.uk>
References: <Pine.LNX.4.54.999.0309150112530.29667@sibu.dcs.gla.ac.uk>
 <20030926085100.GA1280@air.luon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Fri, 26 Sep 2003 09:59:43 +0100 (BST)

On Fri, 26 Sep 2003 10:51am +0200, Sjoerd Simons wrote:

> On Mon, Sep 15, 2003 at 01:21:39AM +0100, jp-www@dcs.gla.ac.uk wrote:
> > Hi,
> >
> > Having recently got a Bluetooth headset (HBH-60), I've put together a
> > preliminary ALSA driver which works with bluez.
> >
> > 	http://www.dcs.gla.ac.uk/~jp/snd-bluez-sco/
> >
> > I'd appreciate any feedback on this. The code is a bit messy at the
> > moment, but I've had fairly good results with it.
>
> Works fine with a globecom BT1000 headset and a csr usb dongle. Only the
> record latency is bad (> 1 second).
>
> I'm using it in combination with gnomemeeting and besides the latency no
> problems, nice work :)

Thanks for the info. I'm surprised that the latency is so bad. I didn't
experience similar problems during my testing (although I haven't tested
it with gnomemeeting yet). Can you try any other software to see what the
latency is like?

If you turn on the loopback mode in an ALSA mixer, do you experience
similar latencies (loopback means the audio received is sent straight back
to the headset).



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
