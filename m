Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1351011241-32515-5-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	<1351011241-32515-5-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 23 Oct 2012 14:30:03 -0400
Message-ID: <CAJdJm_MhB79eQSAHUqOa7Xwf+ujrnQZtG_jqEgMfEFzuoqB9-w@mail.gmail.com>
Subject: Re: [PATCH 4/7] Bluetooth: Add support for setting LE advertising data
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Oct 23, 2012 at 12:53 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> +       if (hdev->adv_tx_power) {
> +               ptr[0] = 2;
> +               ptr[1] = EIR_TX_POWER;
> +               ptr[2] = (u8) hdev->adv_tx_power;
> +
> +               ad_len += 3;
> +               ptr += 3;
> +       }

0dBm is a valid TX power. Not sure the if() clause is valid here.

Also, I'm worried how we are going to put other advertising data here,
i.e. Manufacturer Specific data or Service Data. On last BlueZ meeting
we proposed (and have been implementing) the Set Controller Data mgmt
command to set them. Is this still an acceptable approach?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
