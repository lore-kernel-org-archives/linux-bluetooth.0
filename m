Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Sep 2015 10:05:34 -0400
From: Kyle McMartin <kyle@infradead.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7265 (C0/D0)
Message-ID: <20150924140534.GA26918@merlin.infradead.org>
References: <20150921115145.694a4f48@tedd-fedora-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150921115145.694a4f48@tedd-fedora-vm>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 21, 2015 at 11:51:45AM -0700, Tedd Ho-Jeong An wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch updates the firmware patch for Intel Bluetooth 7265 (C0/D0)
> also known as Intel StP C0 and StP D0.
> 
> C0 Patch Version: 54
> D0 Patch Version: 15
> 

Shouldn't this be 28 for D0? Going to assume so and fix up the commit
message and apply.

> -Version: STP2_D0_1417_04_patch_15.1
> +Version: STP2_D0_1417_04_patch_28.1

cheers,
--Kyle
