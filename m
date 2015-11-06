Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: Make bt_cb()->pkt_type and bt_cb()->except HCI specific
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1446716280-49570-1-git-send-email-marcel@holtmann.org>
Date: Fri, 6 Nov 2015 14:46:38 +0900
Message-Id: <795EAA9F-1E14-4DF5-9AC9-CCFFC34035F6@holtmann.org>
References: <1446716280-49570-1-git-send-email-marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The two fields for pkt_type and expect inside the bt_cb() structure are
> highly HCI specific and only used by HCI drivers. So instead of keeping
> them global, move them into the union entry for HCI.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> include/net/bluetooth/bluetooth.h | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

actually there might be some side affects with this patch. I have not tracked down if it is this one or some of my experimental patches. However I do not think it is safe to apply this one at the moment.

Regards

Marcel

