Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 8 Jul 2016 21:07:43 -0400
From: Kyle McMartin <kyle@infradead.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-firmware@kernel.org
Subject: Re: [PATCH] linux-firmware: Fix the filename for WsP to align with
 device HW_VARIANT
Message-ID: <20160709010743.GE8680@merlin.infradead.org>
References: <20160706114456.34d2985b@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160706114456.34d2985b@fedora-linux-22.shared>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 06, 2016 at 11:44:56AM -0700, Tedd Ho-Jeong An wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> There was a driver (btusb.c) change to include the device's
> HW_VARIANT in the filename to support multiple devices and
> this patch fixes the firmware filename for WsP to align with
> that patch.
> 
> WsP(WindStorm Peak) is also known as Intel Bluetooth 8264.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>

applied, thanks Tedd.

cheers, --Kyle

> ---
>  WHENCE              |   4 ++--
>  intel/ibt-11-16.ddc | Bin 9 -> 0 bytes
>  intel/ibt-11-16.sfi | Bin 584264 -> 0 bytes
>  intel/ibt-12-16.ddc | Bin 0 -> 9 bytes
>  intel/ibt-12-16.sfi | Bin 0 -> 584264 bytes
>  5 files changed, 2 insertions(+), 2 deletions(-)
>  delete mode 100644 intel/ibt-11-16.ddc
>  delete mode 100644 intel/ibt-11-16.sfi
>  create mode 100644 intel/ibt-12-16.ddc
>  create mode 100644 intel/ibt-12-16.sfi
> 
