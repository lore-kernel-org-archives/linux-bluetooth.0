Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: hci_intel: Remove LPM enabling from setup procedure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1468266936-28418-1-git-send-email-loic.poulain@gmail.com>
Date: Mon, 11 Jul 2016 21:59:43 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DAFDADD2-3016-4BF1-A40C-2D15B41DC8CD@holtmann.org>
References: <1468266936-28418-1-git-send-email-loic.poulain@gmail.com>
To: Loic Poulain <loic.poulain@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> LPM can be enabled via a DDC write command at specific DDC ID.
> As any other DDC value, this is up to the DDC config file to
> include (or not) the low power mode configuration.
> 
> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> ---
> drivers/bluetooth/hci_intel.c | 28 +++++++---------------------
> 1 file changed, 7 insertions(+), 21 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

