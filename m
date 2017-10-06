Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171005131109.13999-1-luiz.dentz@gmail.com>
References: <20171005131109.13999-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Oct 2017 09:44:43 +0300
Message-ID: <CABBYNZ+xHeN8+ndSXa9CA_DS3NDNnAVNMfWOd06_XJ4v2YKtUg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] obex: Fix always searching UUID using 128 bit format
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Oct 5, 2017 at 4:11 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When discovering the SDP records the code should attempt to use
> 16 bit format whenever possible.
> ---
>  obexd/client/bluetooth.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
> index e35124a0c..0c043e0ac 100644
> --- a/obexd/client/bluetooth.c
> +++ b/obexd/client/bluetooth.c
> @@ -306,6 +306,8 @@ static gboolean service_callback(GIOChannel *io, GIOCondition cond,
>         if (bt_string2uuid(&uuid, session->service) < 0)
>                 goto failed;
>
> +       sdp_uuid128_to_uuid(&uuid);
> +
>         search = sdp_list_append(NULL, &uuid);
>         attrid = sdp_list_append(NULL, &range);
>
> --
> 2.13.6
>

Applied.

-- 
Luiz Augusto von Dentz
