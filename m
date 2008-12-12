Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] sbc: bitstream packing optimization for encoder.
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200812112227.07170.siarhei.siamashka@nokia.com>
References: <200812112227.07170.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Fri, 12 Dec 2008 02:39:34 +0100
Message-Id: <1229045974.22285.18.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> Appears that bitstream packing is also one of the most CPU hungry
> operations in SBC encoder, which did not get proper attention yet.
> Could somebody review this patch and provide feedback/comments?

again thanks for working on this. I am actually willing to include your
patches quickly in one of the next releases to get more wider testing
audience.

One comment from my side is that this should work with little-endian and
big-endian as input streams. Please keep that in mind.

Regards

Marcel


