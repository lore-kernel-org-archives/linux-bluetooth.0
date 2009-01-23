Return-Path: <cyrus@holtmann.org>
Message-Id: <B3FE9AE2-8C0B-4E30-A633-6D27CAF3993F@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200901212236.49702.siarhei.siamashka@nokia.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] Use of -funroll-loops option to improve SBC encoder performance
Date: Fri, 23 Jan 2009 21:24:36 +0200
References: <200901212236.49702.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

On Jan 21, 2009, at 22:36, Siarhei Siamashka wrote:
> Added the use of -funroll-loops gcc option for SBC. Also in
> order to gain better effect, 'sbc_pack_frame' function
> body moved to an inline function, which gets instantiated
> for 4 different subbands/channels combinations. So that
> 'frame_subbands' and 'frame_channels' arguments become compile
> time constants and can be better optimized by the compiler.

The patch has been pushed upstream. Thanks.

Johan
