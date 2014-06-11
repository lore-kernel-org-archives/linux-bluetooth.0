Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1402402790-9844-1-git-send-email-johan.hedberg@gmail.com>
References: <1402402790-9844-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Jun 2014 09:02:55 +0200
Message-ID: <CABD6X-Krf6HqLjSxpAL9dXrDAwj5DQF8+vnu3=Wvf=z2fhyx5Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix setting correct authentication information
 for SMP STK
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 10 June 2014 14:19,  <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> When we store the STK in slave role we should set the correct
> authentication information for it. If the pairing is producing a HIGH
> security level the STK is considered authenticated, and otherwise it's
> considered unauthenticated. This patch fixes the value passed to the
> hci_add_ltk() function when adding the STK on the slave side.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/smp.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 3d1cc164557d..f2829a7932e2 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -544,7 +544,7 @@ static u8 smp_random(struct smp_chan *smp)
>                 hci_le_start_enc(hcon, ediv, rand, stk);
>                 hcon->enc_key_size = smp->enc_key_size;
>         } else {
> -               u8 stk[16];
> +               u8 stk[16], auth;
>                 __le64 rand = 0;
>                 __le16 ediv = 0;
>
> @@ -556,8 +556,13 @@ static u8 smp_random(struct smp_chan *smp)
>                 memset(stk + smp->enc_key_size, 0,
>                        SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
>
> +               if (hcon->pending_sec_level == BT_SECURITY_HIGH)
> +                       auth = 1;
> +               else
> +                       auth = 0;
> +
>                 hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
> -                           HCI_SMP_STK_SLAVE, 0, stk, smp->enc_key_size,
> +                           HCI_SMP_STK_SLAVE, auth, stk, smp->enc_key_size,
>                             ediv, rand);
>         }
>
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Tested with Android 4.4.2, host correctly set security level to HIGH if bonding
was initiated by remote and MITM was set in pairing request.

Tested-by: Marcin Kraglak <marcin.kraglak@tieto.com>

BR
Marcin
