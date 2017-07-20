Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] hciattach: bcm43xx: fix the delay timer for firmware
 download
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1500556499-2146-1-git-send-email-maxin.john@gmail.com>
Date: Thu, 20 Jul 2017 20:23:44 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "Maxin B. John" <maxin.john@intel.com>
Message-Id: <0F93CDF6-8019-4744-B02B-0C9BD44F9D0B@holtmann.org>
References: <1500556499-2146-1-git-send-email-maxin.john@gmail.com>
To: maxin.john@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Maxin,

> From the log in .bcm43xx_load_firmware():
>        /* Wait 50ms to let the firmware placed in download mode */
>        nanosleep(&tm_mode, NULL);
> 
> But timespec tm_mode is real is 50us. Correct the delayed timer count.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Maxin B. John <maxin.john@intel.com>

we are not using signed offs for user space code. So I fixed that up and applied the patch.

However I would prefer if we stop using hciattach and focus on hci_bcm.c support with btattach and serdev.

Regards

Marcel

