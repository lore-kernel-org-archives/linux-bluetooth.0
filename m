Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298068173-16518-3-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
	<1298068173-16518-3-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 18 Feb 2011 19:50:33 -0300
Message-ID: <AANLkTikJR1-B8V35ZRY7AS=Opp0hLYkVmqs+fNBp0V7a@mail.gmail.com>
Subject: Re: [RFC v2 02/14] Use host byte order when converting UUID16/32 to UUID128
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Feb 18, 2011 at 7:29 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> @@ -2646,11 +2647,16 @@ void sdp_uuid16_to_uuid128(uuid_t *uuid128, const uuid_t *uuid16)
>        data1 += htons(uuid16->value.uuid16);
>
>        /* set bytes 2 and 3 of the 128 bit value */
> -       memcpy(&uuid128->value.uuid128.data[2], &data1, 2);
> +       memcpy(&n128.data[2], &data1, 2);
> +
> +       uuid128->type = SDP_UUID128;
> +       ntoh128(&n128, &uuid128->value.uuid128);
>  }

For consistency with patch 4/14, what about declaring a "uint128_t
h128" and using:

ntoh128(&n128, &h128);
sdp_uuid128_create(uuid128, &h128);

> @@ -2668,7 +2673,10 @@ void sdp_uuid32_to_uuid128(uuid_t *uuid128, const uuid_t *uuid32)
>        data0 += htonl(uuid32->value.uuid32);
>
>        /* set the 4 bytes of the 128 bit value */
> -       memcpy(&uuid128->value.uuid128.data[0], &data0, 4);
> +       memcpy(&n128.data[0], &data0, 4);
> +
> +       uuid128->type = SDP_UUID128;
> +       ntoh128(&n128, &uuid128->value.uuid128);
>  }

Same here. Note this is just a suggestion for better readability, the
behavior is unchanged compared to your current patch.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
