Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Added possibility to analyze 4 blocks at once in SBC
 encoder
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200812311729.30975.siarhei.siamashka@nokia.com>
References: <200812311729.30975.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Thu, 01 Jan 2009 09:54:02 +0100
Message-Id: <1230800042.4530.0.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> With bluez-4.25 release I hope that the SBC encoder sound quality issues are
> now solved (though this is yet to be confirmed).
> 
> Nevertheless, I think it is time to focus on performance :) The attached patch
> contains code preparations which are needed for SIMD optimizations for
> the analysis filter. Also theoretically it should be possible to tweak code to
> have both 32-bit and 16-bit fixed point analysis filter compiled in and switch
> between them at runtime (at user's request or semi-intelligently depending
> on audio bitrate).
> 
> This patch should be stable and ready to be committed.

your patch has been applied. Thanks.

Regards

Marcel


