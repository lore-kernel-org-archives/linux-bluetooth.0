Return-Path: <SRS0+4f15b46af01b1a515adc+353+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: [Bluez-devel] Alignment issue
From: David Woodhouse <dwmw2@infradead.org>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Daryl Van Vorst <daryl@wideray.com>,
   "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092216034.25087.1122.camel@baroque.rococosoft.com>
References: <001301c47f09$3900e650$1301010a@baked>
	 <1092179574.4564.216.camel@pegasus>
	 <1092216034.25087.1122.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1092222502.15466.13.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 11 Aug 2004 12:08:23 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-08-11 at 10:20 +0100, Stephen Crane wrote:
> Why are these macros even here? ISTR Max having some reason not to use
> <asm/unaligned.h> but surely that's what it's there for...

No, asm/unaligned.h is there for kernel code only.

-- 
dwmw2
