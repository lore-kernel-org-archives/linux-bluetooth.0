Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 14:53:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Temporary keys should be retained during
 connection
Message-ID: <20120404115301.GA5081@x220>
References: <1333539940-29061-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333539940-29061-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Wed, Apr 04, 2012, Vishal Agarwal wrote:
> If a key is non persistent then it should not be used in future
> connections but it should be kept for current connection. And it
> should be removed when connecion is removed.
> 
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |    8 ++++----
>  net/bluetooth/mgmt.c             |    6 ++++++
>  3 files changed, 11 insertions(+), 4 deletions(-)

Firstly, did you verify that this fixes your test case? You still didn't
tell us what test case this is, btw.

> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1330,10 +1330,10 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>  
>  	mgmt_new_link_key(hdev, key, persistent);
>  
> -	if (!persistent) {
> -		list_del(&key->list);
> -		kfree(key);
> -	}
> +	if (persistent)
> +		conn->temp_link_key = false;
> +	else
> +		conn->temp_link_key = true;
>  
>  	return 0;
>  }
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index b4f7e32..bc6f89e 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3060,12 +3060,18 @@ int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  {
>  	struct mgmt_addr_info ev;
>  	struct sock *sk = NULL;
> +	struct hci_conn *conn;
>  	int err;
>  
>  	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
>  
>  	bacpy(&ev.bdaddr, bdaddr);
>  	ev.type = link_to_mgmt(link_type, addr_type);
> +	if (link_type == ACL_LINK) {
> +		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
> +		if (conn->temp_link_key)
> +			hci_remove_link_key(hdev, bdaddr);
> +	}
>  
>  	err = mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev),
>  			 sk);

Since setting the flag is outside of mgmt.c I think the removal should
also be. That way you also avoid an extra call to
hci_conn_hash_lookup_ba. I.e. please put the removal in
hci_disconn_complete_evt.

I'd also still like to hear your opinion of the second option I
proposed. If you had a reference to struct link_key in hci_conn then
you'd just need to call list_del() and nothing else to remove it (i.e.
no iteration of hdev->link_keys necessary.

Johan
