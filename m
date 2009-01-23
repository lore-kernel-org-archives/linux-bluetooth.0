Return-Path: <cyrus@holtmann.org>
Message-Id: <2F09F284-FE76-4B9F-BC81-CDDAFE281FAA@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200901220111.29248.siarhei.siamashka@nokia.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] Audio quality improvement for 16-bit fixed point SBC encoder
Date: Fri, 23 Jan 2009 21:26:10 +0200
References: <200901220111.29248.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Jan 22, 2009, at 1:11, Siarhei Siamashka wrote:
> The attached patch quite noticeably minimizes rounding errors and  
> improves
> audio quality.
>
> I decided to drop non-SIMD variant because it would require quite a  
> bit of
> work to update for better precision. Most of the CPU cores which are
> relevant nowadays have support for some kind of SIMD extension anyway.

This patch is now also pushed upstream. Thanks.

Johan
