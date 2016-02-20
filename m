Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: btbcm: Fix handling of firmware not found
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1455134446-70401-1-git-send-email-pgynther@google.com>
Date: Fri, 19 Feb 2016 17:16:10 -0800
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>
Message-Id: <98BC9B26-451D-48B7-AE82-DE985270584D@holtmann.org>
References: <1455134446-70401-1-git-send-email-pgynther@google.com>
To: Petri Gynther <pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

> If the call to request_firmware() fails in btbcm_setup_patchram(),
> the BCM chip will be operating with its default firmware.
> 
> In this case, btbcm_setup_patchram() should not return immediately
> but instead should skip to btbcm_check_bdaddr() and quirk setup.
> 
> Signed-off-by: Petri Gynther <pgynther@google.com>
> ---
> drivers/bluetooth/btbcm.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

