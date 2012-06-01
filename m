Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jun 2012 19:57:19 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/5] Bluetooth: Refactor ACL connection into its own
 function
Message-ID: <20120601225719.GE24769@joana>
References: <1338515876-7547-1-git-send-email-vinicius.gomes@openbossa.org>
 <1338515876-7547-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338515876-7547-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2012-05-31 22:57:53 -0300]:

> The hci_connect() function was starting to get too complicated to be
> quickly understood. We can separated the creation of a new ACL
> connection into its own function.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c |   32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 31afef7..79c80b2 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -496,18 +496,10 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
>  	return le;
>  }
>  
> -/* Create SCO, ACL or LE connection.
> - * Device _must_ be locked */
> -struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
> -			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
> +static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
> +						u8 sec_level, u8 auth_type)
>  {

So this is confusing now, we have hci_acl_connect() and now you want to add
hci_connect_acl(). We need better names here. 
Maybe hci_acl_connect() can be turned int hci_acl_create_connetion(), so
can hco_acl_connect_cancel().

	Gustavo
