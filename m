Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1283149112-22164-1-git-send-email-realmz6@gmail.com>
References: <1283149112-22164-1-git-send-email-realmz6@gmail.com>
Date: Fri, 17 Sep 2010 11:13:40 +0800
Message-ID: <AANLkTikYNnNk0LrxtB=Y0guGUxgW0tjmU=Q2k=GKmY6A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix unaligned access to l2cap conf data
From: real mz <realmz6@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel-commits@blackfin.uclinux.org,
	realmz <realmz6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Mon, Aug 30, 2010 at 2:18 PM, steven.miao <realmz6@gmail.com> wrote:
> From: realmz <realmz6@gmail.com>
>
> In function l2cap_get_conf_opt() and l2cap_add_conf_opt() the address of
> opt->val sometimes is not at the edge of 2-bytes/4-bytes, so 2-bytes/4 bytes
> access will cause data misalignment exeception. Use get_unaligned_le16/32
> and put_unaligned_le16/32 function to avoid data misalignment execption.
> ---
>  net/bluetooth/l2cap.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index fadf26b..a07dad8 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -2406,11 +2406,11 @@ static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen, unsigned
>                break;
>
>        case 2:
> -               *val = __le16_to_cpu(*((__le16 *) opt->val));
> +               *val = get_unaligned_le16(opt->val);
>                break;
>
>        case 4:
> -               *val = __le32_to_cpu(*((__le32 *) opt->val));
> +               *val = get_unaligned_le32(opt->val);
>                break;
>
>        default:
> @@ -2437,11 +2437,11 @@ static void l2cap_add_conf_opt(void **ptr, u8 type, u8 len, unsigned long val)
>                break;
>
>        case 2:
> -               *((__le16 *) opt->val) = cpu_to_le16(val);
> +               put_unaligned_le16(cpu_to_le16(val), opt->val);
>                break;
>
>        case 4:
> -               *((__le32 *) opt->val) = cpu_to_le32(val);
> +               put_unaligned_le32(cpu_to_le32(val), opt->val);
>                break;
>
>        default:
> --
> 1.5.6.5
>
>
