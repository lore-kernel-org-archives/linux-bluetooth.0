Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Apr 2011 16:09:55 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: Re: [bluetooth-next 08/15] Bluetooth: Minor fix in SMP methods
Message-ID: <20110406190955.GA2228@joana>
References: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
 <1302054716-24534-9-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302054716-24534-9-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-04-05 22:51:49 -0300]:

> From: Anderson Briglia <anderson.briglia@openbossa.org>
> 
> Minor fix in smp_conn_security function.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/smp.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index fd9c3ff..f03513d 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -355,11 +355,12 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
>  
>  int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
>  {
> +	struct hci_conn *hcon = conn->hcon;
>  	__u8 authreq;
>  
> -	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, conn->hcon, sec_level);
> +	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
>  
> -	if (IS_ERR(conn->hcon->hdev->tfm))
> +	if (IS_ERR(hcon->hdev->tfm))

Merge these changes in the commits that add this code for the first time,
patch 01 and others.

>  		return 1;
>  
>  	switch (sec_level) {
> @@ -378,7 +379,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
>  		return 1;
>  	}
>  
> -	if (conn->hcon->link_mode & HCI_LM_MASTER) {
> +	if (hcon->link_mode & HCI_LM_MASTER) {

Same here.

-- 
Gustavo F. Padovan
http://profusion.mobi
