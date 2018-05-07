Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20180503115552epcas2p1e103d03dbad9393e092f4d61174e385f@epcas2p1.samsung.com>
 <1525348543-6037-1-git-send-email-nagaraj.dr@samsung.com>
In-Reply-To: <1525348543-6037-1-git-send-email-nagaraj.dr@samsung.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 07 May 2018 09:41:20 +0000
Message-ID: <CABBYNZJVCbZpAqMmg2FB=XA4kjMSBQW35Ft26QOgnkcK1hybUA@mail.gmail.com>
Subject: Re: [PATCH v2] src/device.c : Fix BREDR-ATT MTU issue
To: nagaraj.dr@samsung.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Syam Sidhardhan <s.syam@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
On Thu, May 3, 2018 at 2:57 PM Nagaraj D R <nagaraj.dr@samsung.com> wrote:

> For BREDR-ATT, according to spec, ATT MTU is same has
> L2CAP configured MTU on which ATT is running and there won't be
> ATT MTU exchange procedure. So, set the MTU to L2CAP MTU for
> BREDR-ATT and for LE-ATT adjust the ATT MTU based on
> EXCHANGE_MTU request and response.
> ---
>   src/device.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/src/device.c b/src/device.c
> index f693b70..02bdd7c 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4922,7 +4922,10 @@ bool device_attach_att(struct btd_device *dev,
GIOChannel *io)
>          }

>          dev->att_mtu = MIN(mtu, BT_ATT_MAX_LE_MTU);
> -       attrib = g_attrib_new(io, BT_ATT_DEFAULT_LE_MTU, false);
> +       if (cid == ATT_CID)
> +               attrib = g_attrib_new(io, BT_ATT_DEFAULT_LE_MTU, false);
> +       else
> +               attrib = g_attrib_new(io, dev->att_mtu, false);
>          if (!attrib) {
>                  error("Unable to create new GAttrib instance");
>                  return false;
> --
> 1.9.1

Applied, thanks.

Note that I did modify the patch a little bit while preserving the logic
behind it.


-- 
Luiz Augusto von Dentz
