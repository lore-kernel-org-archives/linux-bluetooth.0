Return-Path: <SRS0+2f2b06aae31afc370aaa+299+infradead.org+dwmw2@pentafluge-142022.srs.infradead.org>
Subject: Re: [Bluez-devel] Extremely slow printing?
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jon Valvatne <jon@valvatne.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1087473569.23809.7.camel@localhost>
References: <1087431069.6361.26.camel@localhost.localdomain>
	 <1087432013.4309.43.camel@pegasus>
	 <1087438456.2624.64.camel@localhost.localdomain>
	 <1087440365.2624.75.camel@localhost.localdomain>
	 <1087473569.23809.7.camel@localhost>
Content-Type: text/plain
Message-Id: <1087564820.19489.3167.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 14:20:20 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-06-17 at 13:59 +0200, Marcel Holtmann wrote:
> actually this depends on the hardware in your printer. The max transfer
> rate should be something about 700kbps, but this is not a must. Mostly
> the reasons for this are differnt link manager implementations or an
> UART that isn't running with full speed.

The UART speed could be a problem on the client side too. Many CF cards
I've seen are pointlessly crippled and run at 115200 baud, instead of
about ten times faster as they should do.

The sensible ones which run faster will often do so just by tweaking the
input clock to the 16550 UART, so that it runs faster while it _thinks_
it's running at 115200 baud. Use 'pskey' to check what speed the
Bluetooth chip actually thinks it's running at.

Marcel -- it'd be useful if your hardware list would include the maximum
speed, btw.

-- 
dwmw2
