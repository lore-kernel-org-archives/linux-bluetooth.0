Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=JEhr6nO7WqBm2=bGrpCxuc6daG_hMGMd_-hxY@mail.gmail.com>
References: <AANLkTi=JEhr6nO7WqBm2=bGrpCxuc6daG_hMGMd_-hxY@mail.gmail.com>
Date: Thu, 16 Sep 2010 12:00:50 +0300
Message-ID: <AANLkTingGbnYQuyQvjPcK-=zSvo-RCpq2tGioysEMYNk@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix bug in l2cap_parse_conf_rsp()
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: haijun liu <liuhaijun.er@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"dantian.ip" <dantian.ip@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Duplicated:
http://www.spinics.net/lists/linux-bluetooth/msg07366.html

BTW: How long will it tale to get the patch in?

On Thu, Sep 16, 2010 at 11:26 AM, haijun liu <liuhaijun.er@gmail.com> wrote:
>  Acording bluetooth spec [Host Volume] chapter, section
>  of "7.1.2 Response path", in l2cap_parse_conf_rsp(), MTU should be
>  incoming mtu, not outgoing mtu.
>
> Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>
> ---
>  net/bluetooth/l2cap.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 23e487e..1797277 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -2771,10 +2771,10 @@ static int l2cap_parse_conf_rsp(struct sock
> *sk, void *rsp, int len, void *data,
>                case L2CAP_CONF_MTU:
>                        if (val < L2CAP_DEFAULT_MIN_MTU) {
>                                *result = L2CAP_CONF_UNACCEPT;
> -                               pi->omtu = L2CAP_DEFAULT_MIN_MTU;
> +                               pi->imtu = L2CAP_DEFAULT_MIN_MTU;
>                        } else
> -                               pi->omtu = val;
> -                       l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->omtu);
> +                               pi->imtu = val;
> +                       l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->imtu);
>                        break;
>
>                case L2CAP_CONF_FLUSH_TO:
> --
> 1.6.3.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
