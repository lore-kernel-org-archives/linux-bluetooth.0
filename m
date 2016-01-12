Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 12 Jan 2016 14:18:18 -0500
From: Kyle McMartin <kyle@infradead.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-firmware@kernel.org
Subject: Re: [PATCH v2] linux-firmware: Update firmware patch for Intel
 Bluetooth 7265 (D1)
Message-ID: <20160112191818.GM32062@merlin.infradead.org>
References: <20160111171645.2631d5d2@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160111171645.2631d5d2@fedora-linux-22.shared>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 11, 2016 at 05:16:45PM -0800, Tedd Ho-Jeong An wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch updates the firmware patch for Intel Bluetooth 7265 (D1)
> Also, this device is known as Intel StP D1
> 
> StP D1 FW Patch Version: 13
> 
> Release Version: 18.15
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>

Applied. Although I had to fix up the git diff hunk for the binary file
again, it looks like it got line wrapped and some newlines got zapped?

regards, --Kyle

> ---
>  WHENCE                                     |   2 +-
>  intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq | Bin 13239 -> 30307 bytes
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/WHENCE b/WHENCE
> index 5112709..74d55de 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -2650,7 +2650,7 @@ Version: BT_StonePeak_C0_REL_55_0001
>  File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
>  Version: BT_StonePeak_D0_REL_32_0002
>  File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
> -Version: STP_D1_REL_9
> +Version: STP_D1_REL_13
>  File: intel/ibt-11-5.ddc
>  Version: LnP/SfP_REL0190
>  File: intel/ibt-11-5.sfi
> diff --git a/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
> b/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq index
> 8c5ab79a9e1a560a231f26b1624b174df42cf366..11625aa5a0dad00be26fd74123a1389b77b59452
> 100644 GIT binary patch literal 30307
