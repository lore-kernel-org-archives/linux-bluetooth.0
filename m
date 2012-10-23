Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1351011241-32515-3-git-send-email-johan.hedberg@gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	<1351011241-32515-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 23 Oct 2012 14:51:11 -0400
Message-ID: <CAJdJm_PoB=e_pi2gAN4AOn_ETyHz3nDihUy8yu2bthe0+p5cxw@mail.gmail.com>
Subject: Re: [PATCH 2/7] Bluetooth: mgmt: Restrict BR/EDR settings to
 BR/EDR-only adapters
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Oct 23, 2012 at 12:53 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> @@ -377,15 +377,15 @@ static u32 get_supported_settings(struct hci_dev *hdev)
>         u32 settings = 0;
>
>         settings |= MGMT_SETTING_POWERED;
> -       settings |= MGMT_SETTING_CONNECTABLE;
> -       settings |= MGMT_SETTING_FAST_CONNECTABLE;
> -       settings |= MGMT_SETTING_DISCOVERABLE;
>         settings |= MGMT_SETTING_PAIRABLE;
>
>         if (lmp_ssp_capable(hdev))
>                 settings |= MGMT_SETTING_SSP;
>
>         if (lmp_bredr_capable(hdev)) {
> +               settings |= MGMT_SETTING_CONNECTABLE;
> +               settings |= MGMT_SETTING_FAST_CONNECTABLE;
> +               settings |= MGMT_SETTING_DISCOVERABLE;
>                 settings |= MGMT_SETTING_BREDR;
>                 settings |= MGMT_SETTING_LINK_SECURITY;

"Discoverable" (at least as a Discovery mode from GAP) is mandatory
for LE Peripheral role (see page 1698). Same for "Connectable" (see
page 1706).

Unless you have other plans to implement this for single mode LE
peripherals running bluez?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
