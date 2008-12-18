Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] sbc: fix for overflow bug in quantization code
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200812172243.27442.siarhei.siamashka@nokia.com>
References: <200812172243.27442.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Thu, 18 Dec 2008 23:59:20 +0100
Message-Id: <1229641160.17082.0.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> This simple patch resolves one more SBC encoding quality issue. Now SBC
> audio encoding quality should be fine in almost all cases after applying it
> together with a new 8 subband filter.
> 
> The patch conflicts with the bitstream packing optimization, but I hope that
> after all the encoding quality problems are fixed, we can get back to it.

both of your patches have been applied and pushed upstream. Please keep
developing against the upstream tree.

Regards

Marcel


