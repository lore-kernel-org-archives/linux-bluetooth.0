Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Aug 2014 10:19:47 -0400
From: Kyle McMartin <kyle@infradead.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-firmware@kernel.org,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>
Subject: Re: linux-firmware: Updated firmware patch for Intel Bluetooth 7265
Message-ID: <20140827141947.GD15412@merlin.infradead.org>
References: <20140826161028.77b7b819@han1-desk-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140826161028.77b7b819@han1-desk-dev>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 26, 2014 at 04:10:28PM -0700, Tedd Ho-Jeong An wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch updates the firmware patch file for Intel Bluetooth 7265
> 
> - Fix HFP issue on EHCI
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>

applied, thanks Tedd.

regards, Kyle

> ---
>  WHENCE                                   |   2 +-
>  intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq | Bin 18017 -> 21775 bytes
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/WHENCE b/WHENCE
> index bd65d8c..1e703b5 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -2311,7 +2311,7 @@ Version: WP_1345_01_patch_0.0.10.1
>  File: intel/ibt-hw-37.8.bseq
>  Version: 1339_02.00
>  File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
> -Version: STP2_C0_1339_02_patch_27.1
> +Version: STP2_C0_1339_02_patch_31.1
>  
>  Licence: Redistributable. See LICENCE.ibt_firmware for details
>  
