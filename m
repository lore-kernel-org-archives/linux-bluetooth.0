Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 30 Oct 2017 12:31:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "jaya.p.g" <jaya.p.g@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, "An, Tedd" <tedd.an@intel.com>,
        anand.kalyanakrishnan@intel.com, ravishankar.srivatsa@intel.com,
        amit.k.bag@intel.com, sukumar.ghorai@intel.com
Subject: Re: [PATCH] Bluetooth: btusb: Update firmware filename for Intel
 9x60 and,later
Message-ID: <20171030103154.GB30418@x1c.lan>
References: <59B7D929.7060908@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59B7D929.7060908@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaya,

On Tue, Sep 12, 2017, jaya.p.g wrote:
> From: Jaya P G <jaya.p.g@intel.com>
> Date: Wed, 6 Sep 2017 19:51:26 +0530
> Subject: [PATCH] Bluetooth: btusb: Update firmware filename for Intel 9x60 and
>  later
> 
> The format of Intel Bluetooth firmware for bootloader product is
> ibt-<hw_variant>-<device_revision_id>.sfi and .ddc.
> 
> But for the SKU's 9x60, there a 3 variants of FW, which cannot be
> differentiated just with hw_variant and devision_revision_id.
> So to pick the appropriate FW file for 9x60 SKU's, it will be
> differentiated using hw_variant, hw_revision and fw_revision rather
> than hw_variant and device_revision_id only.
> 
> Format will be like this:
> ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi and .ddc
> 
> Signed-off-by: Jaya P G <jaya.p.g@intel.com>
> ---
>  drivers/bluetooth/btusb.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
