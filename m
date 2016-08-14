Return-Path: <pavel@ucw.cz>
Date: Sun, 14 Aug 2016 10:51:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>,
	Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 4/7] Bluetooth: hci_uart: Add support for word alignment
Message-ID: <20160814085154.GC21321@amd>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-5-git-send-email-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471058078-5579-5-git-send-email-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat 2016-08-13 05:14:35, Sebastian Reichel wrote:
> This will be used by Nokia's H4+ protocol, which
> adds padding to packets to reach word alignment.

Add a sign-off.

Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks,
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
