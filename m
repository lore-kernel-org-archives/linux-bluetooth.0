Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [RFC] Bluetooth: Fix spurious error message
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180329094117.25855-1-szymon.janc@codecoup.pl>
Date: Wed, 18 Apr 2018 09:04:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6B83B342-1195-4E83-9B81-CB66DA3A0A0A@holtmann.org>
References: <20180329094117.25855-1-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>,
        Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This message was debug message before 2064ee332e4c1b7495cf68b. Looks
> like it was changed by accident in that patch. This is causing some
> error messages when doing BR/EDR discovery since Inquiry Command
> generates Command Status event, not Command Complete.
> 
> I'm sending this as RFC for now since while things seem to work fine
> despite this condition (and it was like that for quite some time) it
> feels like this is indeed case that should be handled by HCI request
> code.
> 
> Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
> ---
> net/bluetooth/hci_event.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index cd3bbb766c24..3f111343f57b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5207,8 +5207,7 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
> 	}
> 
> 	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
> -		bt_dev_err(hdev, "last event is not cmd complete (0x%2.2x)",
> -			   hdr->evt);
> +		BT_DBG("last event is not cmd complete (0x%2.2x)", hdr->evt);
> 		return false;
> 	}

I changed this intentionally since it looked like an error to me. However Johan needs to have a look at this and we need to get a proper fix. Just hiding it behind a debug statement is not helping.

Regards

Marcel

