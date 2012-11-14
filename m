Return-Path: <cyrus@holtmann.org>
Message-ID: <1352904655.20338.11.camel@aeonflux>
Subject: Re: [PATCH v4 00/16] mSBC tests
From: Marcel Holtmann <marcel@holtmann.org>
To: frederic.dalleau@linux.intel.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Nov 2012 23:50:55 +0900
In-Reply-To: <50A36BAC.4090604@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <50A36BAC.4090604@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> > v4 integrate latest comments from Siarhei:
> >   - remove state->pending field from sbc_encoder_state
> >   - add armv6 and iwmmxt primitives
> >   - use simd primitive instead of neon
> >   - reorder patches so that the SBC_MSBC flag is exposed to users only when
> > implementation is complete.
> 
> Any feedback ?

beside a tiny cosmetic comment, I have nothing. However I am not the
expert here. If Siarhei looks over this and is fine with it, I will be
as well.

Regards

Marcel


