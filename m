Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] Bluetooth: Remove redundant disable_advertising()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1513004207-2584-1-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Mon, 11 Dec 2017 20:02:27 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <40130F26-DD0E-4BEC-95F4-F6EB80CB8D4E@holtmann.org>
References: <1513004207-2584-1-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> There is already __hci_req_disable_advertising() function for disabling,
> so use it.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
> ---
> net/bluetooth/hci_request.c | 9 +--------
> 1 file changed, 1 insertion(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

