Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Release RF resource on BT shutdown
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1533280400-11760-1-git-send-email-amit.k.bag@intel.com>
Date: Fri, 3 Aug 2018 11:19:24 +0200
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com
Message-Id: <E1E351BA-328F-4187-BCA2-519FBB9E8DC2@holtmann.org>
References: <1533280400-11760-1-git-send-email-amit.k.bag@intel.com>
To: Amit K Bag <amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amit,

> Issue description: Intel 7265 shares the same RF with Wifi and BT.
> In the shutdown scenario turn off BT, followed by turn WiFi off
> and on causing error in RF calibration in WiFi Module
> 
> Solution: before shutdown BT ensure any RF activity to clear by
> HCI reset command.
> 
> Reference Logs:
> ERR kernel: [ 386.193284] iwlwifi 0000:01:00.0: Failed to run INIT calibrations: -5
> ERR kernel: [ 386.193298] iwlwifi 0000:01:00.0: Failed to run INIT ucode: -5
> ERR kernel: [ 386.193309] iwlwifi 0000:01:00.0: Failed to start RT ucode: -5
> 
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> Singed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> ---
> drivers/bluetooth/btusb.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

