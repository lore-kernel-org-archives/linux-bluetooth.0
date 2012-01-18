Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1326912717-6347-8-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	<1326912717-6347-8-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 18 Jan 2012 15:18:33 -0400
Message-ID: <CAJdJm_MfgdPvF00C2M=huzPk3TpZu5JivN2WdAK0-=BBJhyYsA@mail.gmail.com>
Subject: Re: [PATCH 07/15] Bluetooth: Merge device class into the EIR data in mgmt_ev_device_found
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Jan 18, 2012 at 2:51 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> +static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
> +                                                               u16 data_len)
> +{
> +       eir[eir_len++] = sizeof(type) + data_len;

Isn't it better to have data_len as u8? It is impossible for a EIR or
AD entry to have more than 255 octets (given the length field is one
octet).

> +       eir[eir_len++] = type;
> +       memcpy(&eir[eir_len], data, data_len);
> +       eir_len += data_len;
> +
> +       return eir_len;
> +}

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
