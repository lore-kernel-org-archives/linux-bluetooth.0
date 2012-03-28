Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 11:48:39 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 2/3] Bluetooth: Add dst_type parameter to hci_connect
Message-ID: <20120328084837.GB21905@aemeltch-MOBL1>
References: <1332892776-12060-1-git-send-email-andre.guedes@openbossa.org>
 <1332892776-12060-3-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332892776-12060-3-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Mar 27, 2012 at 08:59:35PM -0300, Andre Guedes wrote:
> This patch adds the dst_type parameter to hci_connect. This way, we
> use the address type information from upper layer instead of searching
> it on the advertising cache.
> 
> The dst_type parameter is ignored for BR/EDR connection establishment.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_conn.c         |   12 ++++--------
>  net/bluetooth/l2cap_core.c       |    4 ++--
>  net/bluetooth/mgmt.c             |    8 ++++----
>  net/bluetooth/sco.c              |    3 ++-
>  5 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index fa2c778..178eaa1 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -574,7 +574,7 @@ int hci_chan_del(struct hci_chan *chan);
>  void hci_chan_list_flush(struct hci_conn *conn);
>  
>  struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> -						__u8 sec_level, __u8 auth_type);
> +				__u8 dst_type, __u8 sec_level, __u8 auth_type);
>  int hci_conn_check_link_mode(struct hci_conn *conn);
>  int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
>  int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 947172b..4f24d3f 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -514,7 +514,8 @@ EXPORT_SYMBOL(hci_get_route);
>  
>  /* Create SCO, ACL or LE connection.
>   * Device _must_ be locked */
> -struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type)
> +struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> +				__u8 dst_type, __u8 sec_level, __u8 auth_type)
>  {
>  	struct hci_conn *acl;
>  	struct hci_conn *sco;
> @@ -523,21 +524,16 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
>  	BT_DBG("%s dst %s", hdev->name, batostr(dst));
>  
>  	if (type == LE_LINK) {
> -		struct adv_entry *entry;
> -
>  		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
>  		if (le)
>  			return ERR_PTR(-EBUSY);
>  
> -		entry = hci_find_adv_entry(hdev, dst);
> -		if (!entry)
> -			return ERR_PTR(-EHOSTUNREACH);
> -
>  		le = hci_conn_add(hdev, LE_LINK, dst);
>  		if (!le)
>  			return ERR_PTR(-ENOMEM);
>  
> -		le->dst_type = entry->bdaddr_type;
> +		le->dst_type = (dst_type == MGMT_ADDR_LE_RANDOM) ?
> +				ADDR_LE_DEV_RANDOM : ADDR_LE_DEV_PUBLIC;

Is this checking validity of dst_type? Just split to check and then
assign.

Best regards 
Andrei Emeltchenko 
