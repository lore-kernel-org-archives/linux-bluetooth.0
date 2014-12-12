Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2] Bluetooth: btusb: support public address configuration for ath3012
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418410685-29882-1-git-send-email-toshik@chromium.org>
Date: Fri, 12 Dec 2014 23:34:54 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <46D695C0-0CA2-4B68-B1F8-F2F7840CD6C2@holtmann.org>
References: <1418410685-29882-1-git-send-email-toshik@chromium.org>
To: Toshi Kikuchi <toshik@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Toshi,

> Set hdev->set_bdaddr handler for ath3012. It sends the vendor specific HCI
> command to change the public address. The change doesn't persist across
> power cycle.
> 
> Signed-off-by: Toshi Kikuchi <toshik@chromium.org>
> ---
> drivers/bluetooth/btusb.c | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

