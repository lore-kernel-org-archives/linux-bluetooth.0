Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334726339-21809-1-git-send-email-hemant.gupta@stericsson.com>
References: <1334726339-21809-1-git-send-email-hemant.gupta@stericsson.com>
Date: Wed, 18 Apr 2012 14:46:08 +0530
Message-ID: <CACj007kQ+BhttkCr9SM3OdiGOb15E5=Csi07U4gsYR+6E3wTog@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Don't distribute keys in case of Encryption Failure
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Hemant Gupta <hemant.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Please ignore this patch, will send new patch shortly.

On Wed, Apr 18, 2012 at 10:48 AM, Hemant Gupta
<hemant.gupta@stericsson.com> wrote:
> SMP Keys should only be distributeed when encryption is successful.
>
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 20dbebb..42d3e97 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4812,7 +4812,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>
>        BT_DBG("conn %p", conn);
>
> -       if (hcon->type == LE_LINK) {
> +       if (hcon->type == LE_LINK && !status && encrypt) {
>                smp_distribute_keys(conn, 0);
>                cancel_delayed_work(&conn->security_timer);
>        }
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
