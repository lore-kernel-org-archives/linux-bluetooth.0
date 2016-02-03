Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 3 Feb 2016 10:54:40 -0500
From: Kyle McMartin <kyle@infradead.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-firmware@kernel.org
Subject: Re: [PATCH 2/3] linux-firmware: Update firmware patch for Intel
 Bluetooth 7260 (B5/B6)
Message-ID: <20160203155440.GA8399@merlin.infradead.org>
References: <20160129161908.7e7f0d81@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160129161908.7e7f0d81@fedora-linux-22.shared>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jan 29, 2016 at 04:19:08PM -0800, Tedd Ho-Jeong An wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch updates the firmware patch for Intel Bluetooth 7260 (B5/B6)
> also known as Intel WP2 B5 and WP1 B6.
> 
> Patch Version: 37
> 
> Release Version: 18.15
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  WHENCE                                   |   4 ++--
>  intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq  | Bin 21161 -> 21908 bytes
>  intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq | Bin 20997 -> 21727 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/WHENCE b/WHENCE
> index ee8569d..e418b92 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -2663,9 +2663,9 @@ Version: WP_1303_02_patch_0.0.83.1
>  File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
>  Version: WP_1303_02_patch_0.0.83.1
>  File: intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
> -Version: WP_1345_01_patch_0.0.34.1
> +Version: BT_WilkinsPeak_B5_REL_37_0001
>  File: intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
> -Version: WP_1345_01_patch_0.0.34.1
> +Version: BT_WilkinsPeak_B5_REL_37_0001
>  File: intel/ibt-hw-37.8.bseq
>  Version: 1339_02.00
>  File: intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq

Should this be BT_WilkinsPeak_B6_REL_37_0001 on the second addition?

I've applied it anyway, I'll fix it up later if you say so. Ditto
with the B3/B3 in the 3/3 patch?

regards, --Kyle
