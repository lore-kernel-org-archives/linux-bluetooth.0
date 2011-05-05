Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 May 2011 17:35:11 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: Double check sec req for pre 2.1 device
Message-ID: <20110505203511.GG2098@joana>
References: <1304604978-17895-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1304604978-17895-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304604978-17895-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> [2011-05-05 16:16:17 +0200]:

> In case of pre v2.1 devices authentication request will return
> success immediately if the link key already exists without any
> authentication process.
> 
> That means, it's not possible to re-authenticate the link if you
> already have combination key and for instance want to re-authenticate
> to get the high security (use 16 digit pin).
> 
> Therefore, it's necessary to check security requirements on auth
> complete event to prevent not enough secure connection.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
> ---
>  include/net/bluetooth/hci_core.h |    4 +++-
>  net/bluetooth/hci_conn.c         |   17 +++++++++++++++++
>  net/bluetooth/rfcomm/core.c      |    2 +-
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 14cc324..1b35c27 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -420,8 +420,10 @@ int hci_conn_del(struct hci_conn *conn);
>  void hci_conn_hash_flush(struct hci_dev *hdev);
>  void hci_conn_check_pending(struct hci_dev *hdev);
>  
> -struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type);
> +struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> +					__u8 sec_level, __u8 auth_type);

Coding styles changes needs a new patch for it. Just leave this out.

-- 
Gustavo F. Padovan
http://profusion.mobi
