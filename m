Return-Path: <SRS0+568a86f7f2f31b2d34f2+355+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: RE: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092391122.28711.220.camel@pegasus>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
	 <1092315210.15466.220.camel@hades.cambridge.redhat.com>
	 <1092391122.28711.220.camel@pegasus>
Content-Type: text/plain
Message-Id: <1092394568.10618.16.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 13 Aug 2004 11:56:08 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2004-08-13 at 11:58 +0200, Marcel Holtmann wrote:
> is it verified that this works with every GCC release? Some people still
> use a 2.95 or older.

Should do -- GCC behaviour w.r.t. packed structures has been that way
for as long as I can remember. A quick test on ARM with 2.95.2 shows
that get_unaligned() seems to do the right thing.

-- 
dwmw2
