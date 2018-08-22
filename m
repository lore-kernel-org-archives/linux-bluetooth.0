Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 22 Aug 2018 14:35:00 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Raghuram Hegde <raghuram.hegde@intel.com>, amit.k.bag@intel.com,
        linux-bluetooth@vger.kernel.org, kbuild-all@01.org,
        sukumar.ghorai@intel.com, chethan.tumkur.narayan@intel.com,
        Philip Li <philip.li@intel.com>
Subject: Re: [PATCH] Bluetooth: btintel: fix ptr_ret.cocci warnings
Message-ID: <20180822063500.jjugs2gerob7mxfq@wfg-t540p.sh.intel.com>
References: <1534844080-31240-1-git-send-email-raghuram.hegde@intel.com>
 <20180822015950.cgvy5wvcdwarka7r@wfg-t540p.sh.intel.com>
 <CD7560BA-BAFD-4C3B-9591-B6CA213052D6@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <CD7560BA-BAFD-4C3B-9591-B6CA213052D6@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

>this does not apply cleanly to bluetooth-next tree. And then I
>realized this is against a patch that I have not applied. So sorry
>for the noise.

Ah never mind, that should be the typical case. As the robot works on
bleeding edge commits and patches, trying to find regressions before
they are merged into maintainer and mainline trees.  :)

Regards,
Fengguang
