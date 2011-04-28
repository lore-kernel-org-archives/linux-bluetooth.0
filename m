Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Apr 2011 16:18:42 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 12/12] Bluetooth: Fix updating conn->auth_type in
 hci_io_capa_request_evt
Message-ID: <20110428191842.GC2302@joana>
References: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
 <1304015344-12238-12-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304015344-12238-12-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-04-28 11:29:04 -0700]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> In some circumstances hci_get_auth_req will return a value different
> from the current conn->auth_type. In these cases update conn->auth_type
> so that when a user confirm request comes it doesn't falsely trigger
> auto-accept.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  net/bluetooth/hci_event.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 8dfd386..f6219e2 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2447,7 +2447,8 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
>  
>  		bacpy(&cp.bdaddr, &ev->bdaddr);
>  		cp.capability = conn->io_capability;
> -		cp.authentication = hci_get_auth_req(conn);
> +		conn->auth_type = hci_get_auth_req(conn);
> +		cp.authentication = conn->auth_type;
>  
>  		if ((conn->out == 0x01 || conn->remote_oob == 0x01) &&
>  				hci_find_remote_oob_data(hdev, &conn->dst))

All applied, thanks for fixes.

-- 
Gustavo F. Padovan
http://profusion.mobi
