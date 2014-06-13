Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1401381413-12782-1-git-send-email-johan.hedberg@gmail.com>
References: <1401381413-12782-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 13 Jun 2014 12:25:37 -0700
Message-ID: <CAHZ1yC=AtZu=hiJpfji4+jyb82J806if+VjwtGcYaDuDUqRdHQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix properly ignoring LTKs of unknown types
From: Scott James Remnant <keybuk@google.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

You cc'd this to stable, but didn't Cc the patch that it modifies.

Just sayin' ;-)

On Thu, May 29, 2014 at 9:36 AM,  <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> In case there are new LTK types in the future we shouldn't just blindly
> assume that != MGMT_LTK_UNAUTHENTICATED means that the key is
> authenticated. This patch adds explicit checks for each allowed key type
> in the form of a switch statement and skips any key which has an unknown
> value.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5e9c21a5525f..0fce54412ffd 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4546,10 +4546,16 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
>                 else
>                         type = HCI_SMP_LTK_SLAVE;
>
> -               if (key->type == MGMT_LTK_UNAUTHENTICATED)
> +               switch (key->type) {
> +               case MGMT_LTK_UNAUTHENTICATED:
>                         authenticated = 0x00;
> -               else
> +                       break;
> +               case MGMT_LTK_AUTHENTICATED:
>                         authenticated = 0x01;
> +                       break;
> +               default:
> +                       continue;
> +               }
>
>                 hci_add_ltk(hdev, &key->addr.bdaddr, addr_type, type,
>                             authenticated, key->val, key->enc_size, key->ediv,
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
