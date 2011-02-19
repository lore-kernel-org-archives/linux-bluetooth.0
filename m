Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298068173-16518-6-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
	<1298068173-16518-6-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 18 Feb 2011 21:53:03 -0300
Message-ID: <AANLkTiksnZJZBDWS496B654kBLsmpTRx=8NH2gea_WSC@mail.gmail.com>
Subject: Re: [RFC v2 05/14] Convert to network order before use it on sdp_uuid128_to_uuid
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Feb 18, 2011 at 7:29 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> ---
>  lib/sdp.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/lib/sdp.c b/lib/sdp.c
> index d5f8984..3c4cd50 100644
> --- a/lib/sdp.c
> +++ b/lib/sdp.c
> @@ -2713,18 +2713,19 @@ uuid_t *sdp_uuid_to_uuid128(const uuid_t *uuid)
>  int sdp_uuid128_to_uuid(uuid_t *uuid)
>  {
>        uint128_t *b = &bluetooth_base_uuid;
> -       uint128_t *u = &uuid->value.uuid128;
> +       uint128_t u;
>        uint32_t data;
>        unsigned int i;
>
> +       hton128(&uuid->value.uuid128, &u);
>        if (uuid->type != SDP_UUID128)
>                return 1;
>
>        for (i = 4; i < sizeof(b->data); i++)
> -               if (b->data[i] != u->data[i])
> +               if (b->data[i] != u.data[i])
>                        return 0;
>
> -       memcpy(&data, u->data, 4);
> +       memcpy(&data, u.data, 4);
>        data = htonl(data);
>        if (data <= 0xffff) {
>                uuid->type = SDP_UUID16;

As we discussed off-line, there might be a bug on the original code.
Using htonl() (instead of ntohl()) on data that comes from a 128-bit
UUID looks suspicious.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
