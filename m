Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] sbc: improve compatibility with ARM Cortex-M
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAPWKHJRVP-MwzKTvL5moRa9f=WbT-qqNAH_y=tJ_B-TzXjNcYw@mail.gmail.com>
Date: Tue, 9 Jan 2018 16:27:35 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FB8134DD-2443-4D2F-B2C1-A4DD00B1FDF1@holtmann.org>
References: <CAPWKHJRVP-MwzKTvL5moRa9f=WbT-qqNAH_y=tJ_B-TzXjNcYw@mail.gmail.com>
To: Austin Morton <austinpmorton@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Austin,

> Specifically test the compiler for the feature required to use the
> smuad/smlad instructions when determining if we can build with ARMV6
> primitive support rather than guessing based on thumb version.
> __ARM_FEATURE_SIMD32 is defined in section 9.5.1 of the "ARM C
> Language Extensions 2.1" specification published by ARM.
> 
> Signed-off-by: Austin Morton <austinpmorton@gmail.com>

can I get a patch without SoB line. We are not using that in userspace.

Regards

Marcel

