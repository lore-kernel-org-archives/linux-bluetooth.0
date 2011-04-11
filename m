Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Apr 2011 15:34:27 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com
Subject: Re: [PATCH] Bluetooth: Fix refcount balance for hci connection
Message-ID: <20110411183427.GC2195@joana>
References: <1302177590-4107-1-git-send-email-ville.tervo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302177590-4107-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Ville Tervo <ville.tervo@nokia.com> [2011-04-07 14:59:50 +0300]:

> hci_io_capa_reply_evt() holds reference for hciconnection. It's useless since
> hci_io_capa_request_evt()/hci_simple_pair_complete_evt() already protects the
> connection. In addition it leaves connection open after failed SSP pairing.
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> ---
>  net/bluetooth/hci_event.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 7a3398d..6b878c8 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2419,8 +2419,6 @@ static inline void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *s
>  	if (!conn)
>  		goto unlock;
>  
> -	hci_conn_hold(conn);
> -

Patch has been applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
