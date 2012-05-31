Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 May 2012 10:39:16 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/5] Bluetooth: Simplify a the connection type handling
Message-ID: <20120531073914.GB17461@aemeltch-MOBL1>
References: <1338423620-32578-1-git-send-email-vinicius.gomes@openbossa.org>
 <1338423620-32578-4-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338423620-32578-4-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, May 30, 2012 at 09:20:19PM -0300, Vinicius Costa Gomes wrote:
> Now that we have separate ways of doing connections for each link type,
> we can do better than an "if" statement to handle each link type.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 320cc5d..8848a1e 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -563,13 +563,16 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
>  {
>  	BT_DBG("%s dst %s", hdev->name, batostr(dst));
>  
> -	if (type == LE_LINK)
> +	switch (type) {
> +	case LE_LINK:
>  		return add_le_conn(hdev, dst, dst_type, sec_level, auth_type);
> -
> -	if (type == ACL_LINK)
> +	case ACL_LINK:
>  		return add_acl_conn(hdev, dst, sec_level, auth_type);
> +	case SCO_LINK:
> +		return add_sco_conn(hdev, dst, sec_level, auth_type);

The patches looks OK but somehow I do not like much returns in switch.
Some parsers will notice missing breaks which are not needed here...

Best regards 
Andrei Emeltchenko 

