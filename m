Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 30 Nov 2016 09:53:15 -0500
From: Kyle McMartin <kyle@infradead.org>
To: "jaya.p.g" <jaya.p.g@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-firmware@kernel.org
Subject: Re: [PATCH 1/5] linux-firmware: Update firmware patch for,Intel
 Bluetooth 7265 (C0)
Message-ID: <20161130145315.GA11316@merlin.infradead.org>
References: <583F1103.1050604@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <583F1103.1050604@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Nov 30, 2016 at 11:18:51PM +0530, jaya.p.g wrote:
> From b78f54e0f045658dd58ef7270641bb60122b0219 Mon Sep 17 00:00:00 2001
> From: "jaya.p.g" <jaya.p.g@linux.intel.com>
> Date: Wed, 30 Nov 2016 21:07:25 +0530
> Subject: [PATCH 1/5] linux-firmware: Update firmware patch for
>  Intel Bluetooth 7265 (C0)
> 
> This patch updates the firmware patch for Intel Bluetooth 7265 (C0) Also, it
> is known as Intel StP C0
> 
> StP C0 FW Patch Version: 59
> 
> Release Version: 19.30
> 
> Signed-off-by: jaya.p.g <jaya.p.g@linux.intel.com>

That's... almost better. The git binary patch portion was line-wrapped,
and the context on WHENCE was broken, but I've fixed it by hand. Please
verify what I've pushed out to the tree.

Thanks! --Kyle
