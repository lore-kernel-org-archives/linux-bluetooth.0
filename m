Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] sbc: ensure 16-byte buffer position alignment for 4
 subbands encoding
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200903162135.02064.siarhei.siamashka@nokia.com>
References: <200903162135.02064.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Sat, 14 Mar 2009 07:17:33 +0100
Message-Id: <1237011453.24751.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> Buffer position in X array was not always 16-bytes aligned. Strict 16-byte 
> alignment is strictly required for powerpc altivec simd optimizations because
> altivec does not have support for unaligned vector loads at all.

patch has been applied. Thanks.

Regards

Marcel


