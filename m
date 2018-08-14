Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1532951815-9726-1-git-send-email-amit.k.bag@intel.com>
 <1532951815-9726-5-git-send-email-amit.k.bag@intel.com> <EFE6F46E14A5F445949D76A8CAC224005832797D@PGSMSX105.gar.corp.intel.com>
In-Reply-To: <EFE6F46E14A5F445949D76A8CAC224005832797D@PGSMSX105.gar.corp.intel.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 14 Aug 2018 10:03:56 -0400
Message-ID: <CA+5PVA58CC+NcrUAKrPdPn2ArXpXu9M8Wsjy6eA2NMg9Og1ZJw@mail.gmail.com>
Subject: Re: [PATCH 5/5] linux-firmware:Update firmware patch for Intel
 Bluetooth 7265 (D1)
To: "Bag, Amit K" <amit.k.bag@intel.com>
Cc: Linux Firmware <linux-firmware@kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 13, 2018 at 8:12 AM Bag, Amit K <amit.k.bag@intel.com> wrote:
>
> Hello All,
>
> This patch I have raised more than 1 month ago but it is not yet merged.

1/2 a month, technically.

> Could you please merge the changes.

Today.  Does this series resolve CVE-2018-5383 for the specific Intel
devices?  If it does, I'd like to include that in the changelog.

josh

>
> Thanks & Regards,
> Amit Bag
>
>
> -----Original Message-----
> From: Bag, Amit K
> Sent: Monday, July 30, 2018 5:27 PM
> To: linux-firmware@kernel.org
> Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Bag, Amit K <amit.k.bag@intel.com>
> Subject: [PATCH 5/5] linux-firmware:Update firmware patch for Intel Bluetooth 7265 (D1)
>
> This patch updates the firmware file for Intel Bluetooth 7265 Also it is known as Intel stonePeak(STPD1).
>
> FW Build: REL_52_00005
>
> Release Version: 20.70.0.4
>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
>  WHENCE                                     |   2 +-
>  intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq | Bin 47463 -> 48587 bytes
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/WHENCE b/WHENCE
> index 454e31192b3a..4f9e93bf9944 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -3079,7 +3079,7 @@ Version: BT_StonePeak_C0_REL_59_0001
>  File: intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
>  Version: BT_StonePeak_D0_REL_50_0002
>  File: intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
> -Version: BT_StonePeak_D1_REL_54_00003
> +Version: BT_StonePeak_D1_REL_52_00005
>  File: intel/ibt-11-5.ddc
>  Version: LnP/SfP_REL0487
>  File: intel/ibt-11-5.sfi
> diff --git a/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq b/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
> index e3c3a88396cd45ced2b8f6828a86cbb35b808f25..302239aa68979d1351e5c5960784afcdffe24bd3 100644 GIT binary patch delta 17393 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
>
> delta 16087
> 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
>
> --
> 2.7.4
>
