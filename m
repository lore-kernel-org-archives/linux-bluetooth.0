Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532611A9B2A;
	Thu, 27 Feb 2025 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692454; cv=none; b=UI8sb9QwwJxZIKo2Muh5OGxS12n+NraWaHQpAcHvsZtZZwT3tDUaBIEFxrunhp14a+HG18mrmPcMj7CQt/evc6hbCaBPR5KH/D73YW4mYZ9t8/VL5NB/XkIGD5JwqjAH2t+T/r6nd4WD0QI9NtljssHucsq7YyjZIVF5nfGRRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692454; c=relaxed/simple;
	bh=L80Hlu8u8o5Ot4DJmrVS3vc1lu4qJoip5Aoy1QOg3tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc0EhZ0tBQDhrvXWZ0Dirf4TKjJVWZBNWODXXvP9b8vu4Et8ZbQmL0oNxTh0s8H766QrzCIbtKY11Bo9QZ54GWD+sz6LEylf9+/e9n9cY4upY0YNcvq1vJkMQ74V5VienNxGHGNkRp75429qjtk7i8FoK0I9RNpbnqyFw6yVJkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifD9LFyf; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifD9LFyf"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54843052bcdso1242378e87.1;
        Thu, 27 Feb 2025 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740692450; x=1741297250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r485+lRjbUqyvnC85LY4WqpLa9nC9htuImJ9LIfqUKQ=;
        b=ifD9LFyfIn0Uce2rcKCD8P/KFpCn5LX9edfRNTMckBQxSAC+UsEpmMPkKuBeikyTaU
         jSG/KgsdMWv/e1/a+1yUikPCkQpKaTAgXofFcMW0x9aReN/6CFauW1VYxke9M+AxMTdc
         I7hs3F69I2A8yY4Pzm3icL6WIFh0ZPXXLiBs2ZtDorv6S0nooZEL3VToMCnl0wVMDosW
         3+Q1kTZ9jyxKDwojMyi+kan//+9cHVkYRFqLL9H6O+jv3hZlbgPr0YNUnriSJIiMCQZQ
         5G64ZOu6EtmSjuwITpldtVHISowibDY24bQB0X6x4jLZBejY5IH6SkiOsABjWhi7cUHS
         6kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692450; x=1741297250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r485+lRjbUqyvnC85LY4WqpLa9nC9htuImJ9LIfqUKQ=;
        b=O6Xg0RsDFwVqo4ww3Xkn7ZfNS8dHsyXv8+m8OPIhB7WlrTiKejvl7KRgo7xVmVFHXL
         cHChmzD59r+HzwkMh5QQ7mw6TGNJUaJlhq1EiV2i7P84dCbMT1GSrC40Bl3+pyjEavQN
         Hz1t4W7aFpBNciYylnSeMuxdq20TDzvg5QaV/MFnszA0ANohmal2vBaPof3Qwxe382rz
         mor/Bvcwa1atnuIMXhZQ6NsI27Xiw6UvmwKdbgEa+qXR4nFdTWl17tfWCB7/MWIDjgY4
         mrGvgrPgYW6bP7FiIx9DS/V6t+DmDzx9M+b+yrHquycSfS35hozlsQppNliC8hV5dFdY
         AyLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlRxo3hzeQC6haJcjgw3/2SWElI579wbXAheoRsEFkNii4xmrNh8bDEkHYKGVU4sReHCrCEy5ZyAXUOWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5ZnUILHG3r1dKu8ZNVruDrWGzGwoVS843xfmkstUdKX/KBoI
	+DBQ0x0AjvBoe32ooQpvE4yEPcF1tdYwionQ5YLlr/snA7HRWEpx73C1wnscgsgc83jOmcnCfzM
	Hb9LTI3kuiWWFVUew8OAID5M1TuzCH4Zz50A=
X-Gm-Gg: ASbGncvqJE8QM8y33nJloMaQgo14YjqAg+axnruRuFH9wNkXg2aHq39SVe7rBUBYw6m
	9K1maPr0C/6BZqdVOm299rf2Ye9knKYfppNZsfYLijtz+AB6kwraHgocZBBdIp0GXP8uzaCYqHR
	Mf+Zak7g==
X-Google-Smtp-Source: AGHT+IHc/Epr7Ps+0AR+8pRbVCia557Ml9EMV/xnohQ/bDgHDHT8kiVp140V7y6FhpaXwbFME5SmOFEqm3/MMUqyuaE=
X-Received: by 2002:a19:521a:0:b0:549:4df0:76 with SMTP id 2adb3069b0e04-5494df00079mr133755e87.4.1740692450037;
 Thu, 27 Feb 2025 13:40:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227171417.4023415-1-chharry@google.com>
In-Reply-To: <20250227171417.4023415-1-chharry@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 28 Feb 2025 02:40:37 +0500
X-Gm-Features: AQ5f1JoMkjAaQBE1fZYPMwpPqsgvE_QCMmnXVYFBRCrp0nJBRvjDWUeAH45XxtE
Message-ID: <CABBYNZ+QdWQ49ZMxPLj86d=kjr7Sf38LR1PrYrPhU8kZMQuh0A@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org, 
	pmenzel@molgen.mpg.de, chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Thu, Feb 27, 2025 at 12:14=E2=80=AFPM Hsin-chen Chuang <chharry@google.c=
om> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> Automatically configure the altsetting for HCI_USER_CHANNEL when a SCO
> is connected.
>
> The motivation is to enable the HCI_USER_CHANNEL user to send out SCO
> data through USB Bluetooth chips, which is mainly used for bidirectional
> audio transfer (voice call). This was not capable because:
>
> - Per Bluetooth Core Spec v5, Vol 4, Part B, 2.1, the corresponding
>   alternate setting should be set based on the air mode in order to
>   transfer SCO data, but
> - The Linux Bluetooth HCI_USER_CHANNEL exposes the Bluetooth Host
>   Controller Interface to the user space, which is something above the
>   USB layer. The user space is not able to configure the USB alt while
>   keeping the channel open.
>
> This patch intercepts the HCI_EV_SYNC_CONN_COMPLETE packets in btusb,
> extracts the air mode, and configures the alt setting in btusb.
>
> This patch is tested on ChromeOS devices. The USB Bluetooth models
> (CVSD, TRANS alt3 and alt6) could work without a customized kernel.
>
> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control US=
B alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
> Changes in v3:
> - Remove module parameter
> - Set Kconfig to default y if CHROME_PLATFORMS
>
> Changes in v2:
> - Give up tracking the SCO handles. Only configure the altsetting when
>   SCO connected.
> - Put the change behind Kconfig/module parameter
>
>  drivers/bluetooth/Kconfig | 11 ++++++++++
>  drivers/bluetooth/btusb.c | 43 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 4ab32abf0f48..cdf7a5caa5c8 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
>           Say Y here to enable USB poll_sync for Bluetooth USB devices by
>           default.
>
> +config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
> +       bool "Auto set isoc_altsetting for HCI_USER_CHANNEL when SCO conn=
ected"
> +       depends on BT_HCIBTUSB
> +       default y if CHROME_PLATFORMS
> +       help
> +         Say Y here to enable auto set isoc_altsetting for HCI_USER_CHAN=
NEL
> +         when SCO connected
> +
> +         When enabled, btusb intercepts the HCI_EV_SYNC_CONN_COMPLETE pa=
ckets
> +         and configures isoc_altsetting automatically for HCI_USER_CHANN=
EL.
> +
>  config BT_HCIBTUSB_BCM
>         bool "Broadcom protocol support"
>         depends on BT_HCIBTUSB
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index de3fa725d210..2642d2ca885f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -34,6 +34,8 @@ static bool force_scofix;
>  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUS=
PEND);
>  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC=
);
>  static bool reset =3D true;
> +static bool auto_set_isoc_alt =3D
> +       IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
>
>  static struct usb_driver btusb_driver;
>
> @@ -1113,6 +1115,42 @@ static inline void btusb_free_frags(struct btusb_d=
ata *data)
>         spin_unlock_irqrestore(&data->rxlock, flags);
>  }
>
> +static void btusb_sco_connected(struct btusb_data *data, struct sk_buff =
*skb)
> +{
> +       struct hci_event_hdr *hdr =3D (void *) skb->data;
> +       struct hci_ev_sync_conn_complete *ev =3D
> +               (void *) skb->data + sizeof(*hdr);
> +       struct hci_dev *hdev =3D data->hdev;
> +       unsigned int notify_air_mode;
> +
> +       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> +               return;
> +
> +       if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_EV_SYNC_CONN_COM=
PLETE)
> +               return;
> +
> +       if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->status)
> +               return;
> +
> +       switch (ev->air_mode) {
> +       case BT_CODEC_CVSD:
> +               notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> +               break;
> +
> +       case BT_CODEC_TRANSPARENT:
> +               notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANSP;
> +               break;
> +
> +       default:
> +               return;
> +       }
> +
> +       bt_dev_info(hdev, "enabling SCO with air mode %u", ev->air_mode);
> +       data->sco_num =3D 1;
> +       data->air_mode =3D notify_air_mode;
> +       schedule_work(&data->work);
> +}
> +
>  static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb=
)
>  {
>         if (data->intr_interval) {
> @@ -1120,6 +1158,11 @@ static int btusb_recv_event(struct btusb_data *dat=
a, struct sk_buff *skb)
>                 schedule_delayed_work(&data->rx_work, 0);
>         }
>
> +       /* Configure altsetting for HCI_USER_CHANNEL on SCO connected */
> +       if (auto_set_isoc_alt &&
> +           hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> +               btusb_sco_connected(data, skb);
> +
>         return data->recv_event(data->hdev, skb);
>  }
>
> --
> 2.48.1.658.g4767266eb4-goog

This has been merged, I did some minor rewording here and there but
the logic remains the same, now we can problem revert b16b327edb4d
("Bluetooth: btusb: add sysfs attribute to control USB alt setting")?

--=20
Luiz Augusto von Dentz
