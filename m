Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Sjoerd Simons <sjoerd@air.luon.net>
To: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [ANNOUNCE] ALSA Bluetooth Headset Driver
Message-ID: <20030926095900.GB1280@air.luon.net>
References: <Pine.LNX.4.54.999.0309150112530.29667@sibu.dcs.gla.ac.uk> <20030926085100.GA1280@air.luon.net> <Pine.LNX.4.54.999.0309260958140.1399@brava.dcs.gla.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.54.999.0309260958140.1399@brava.dcs.gla.ac.uk>
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
Date: Fri, 26 Sep 2003 11:59:00 +0200

On Fri, Sep 26, 2003 at 09:59:43AM +0100, Jonathan Paisley wrote:
> Thanks for the info. I'm surprised that the latency is so bad. I didn't
> experience similar problems during my testing (although I haven't tested
> it with gnomemeeting yet). Can you try any other software to see what the
> latency is like?
> 
> If you turn on the loopback mode in an ALSA mixer, do you experience
> similar latencies (loopback means the audio received is sent straight back
> to the headset).

Sorry my measuring was flawed.. Apperently the h323 latency was caused
by something else and cat /dev/dspX > /dev/dspY always causes a
latency (pulling brown paper bag over head :( )

  Sjoerd
-- 
Don't have good ideas if you aren't willing to be responsible for them.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
