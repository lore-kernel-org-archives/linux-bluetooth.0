Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B723D3234;
	Mon, 31 Mar 2025 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743428791; cv=none; b=MnLAXpKYQzH5MfK3RgVxOassMt65y90RDQrvdASEAZvM+3b2DwP8Ch+TwdIofB6SVyrr29BgRPf6YXGNPP1GP0uG/YNDZdfVzlAghgv+Zi+uhO3eDp9w/PZ8b6AH216wViPIU0nWhkI2TnVD0tKPtRCOlt6Q/ziEB9KVz+q4gWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743428791; c=relaxed/simple;
	bh=DzEibqbNmPkaSC0vpnJfadTHdq4z01v74q1H0+RT5qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nios2o6Lbf5IaU3nqeqApzqf/VFlju8K8F9BLjib70VJvTDsdciuwML+nCGu64HJtd/Z2lwNxWFyhRMRSRJom4uaq6/gDdmwSUP3Alu6RmeSmY6ZOoFk/aPLTArJTyR3WjPONBOnaNhILYKoOKwNQmRCZIx2RwWM1nJXHERBTew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbPDW03S; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbPDW03S"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30db3f3c907so43011501fa.1;
        Mon, 31 Mar 2025 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743428788; x=1744033588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzOdVMm4v145+pvs4RVE05VI4yRCPORO7lTC86T8UjA=;
        b=fbPDW03SQeB24avlT+TUbcDAe9aUZZdYqGeIK3mNJ0X4yojCXm6HSrrhNyHH73cLMI
         GiBHFD66RK+u67hCJmVriL6x2bsfk8ZeWQ48XQUg94dLbeG8PY4zKUavEVPzaLs25Ath
         DJbaDIKiR8RCScVupKRgbrVrdgB1UY9S6/JrLE+g1RiFvjMVIN9vNDMDKDX6mdPbQQri
         XSAftSo3e3dgxZYQHZgzbTNEucdCiCPl7TX3PXWBn7dzN4179DiiWY1gYhwRXHKXT/kU
         u/GCn6oVoS+LeRxbi9MfwllyiUvNyy0OzPOMdAGGs0iglkNM4n0ex1FBubq5HVuwMB51
         d4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743428788; x=1744033588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzOdVMm4v145+pvs4RVE05VI4yRCPORO7lTC86T8UjA=;
        b=rJV/vsGCBrfEvjFP5ZRNmrja9Gvbr2vD5aqNIsppfYn582gSj8HzE0b3tsmPKpfWSV
         g78E+zPWGBKf1t0qocXUQ8YX6hjHPDiDnG6Zjj3tFtBTGWpGR1kVozT9KYgOcIm8zGLI
         Pfpa353Lz412Uc3UPQSWKp6PDk/IYTCo/NPtZH00kx2OCVbVp2JrmBiOcfn5H0QGRS26
         YBKfwn3H/N7TdtK+Qb+P8ym809IEhxet5QqwGW4b/gRoHN5ge0PUGq7DvpMlbuSFNNV2
         ZZn1+r3s3rNmgSSVcRzAPfYyj5UvXdtTcoSZT0GctzvcXH9Yz0YTSN4URB16MEX6I0Ly
         YhLA==
X-Forwarded-Encrypted: i=1; AJvYcCXn3o8pu/r1Ii/BNR62yew+iDfc2aoJLxJC36qmZCtB6D+RuuwNQF/z5trvjieQmxD0TItCQHj/qho2/Jh7@vger.kernel.org, AJvYcCXy5ULSFZ7okp4Wub4GDGWaqKAP+MEyMyngq1ZxT3lPozOdPBmPG5ESWygGv0wZX1i/MHA9DnHJQmKGJodGrqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDFDNTERIyw4MmU9KHuQ2iD4UyK4AzK4TXID/XPWg4Tk6QPbY
	imJEwGPIl+mSW+zk2gor8jUxANKd8Thmf1+lW6TKm71DBSZm/IDOnCeFryP6wjqvVMfinYsESwm
	D9/L/C2eEp1fuK88lLAuKqbkNaUsL/A==
X-Gm-Gg: ASbGnctC4WgFdVjCTvDKL5v1+DFW5J/oM33KdjaynkBTrEZ0imyLUB/VUHEnLxqTxlL
	GmNsZQ9UYtCrHgi8YqsPSZ3Y/lv0olTVapaTd1CMjs9PceltzH0qjPikRKJNnZlmyHeICKGivtd
	KOfal/B7KZLsIcKkM8qdjk9bdt
X-Google-Smtp-Source: AGHT+IHOqoeBC5QTjkTLs+lAv5Xngjdt1hNtSOkh1pA1vadxjWy100A3QxfzEDdoVXDCDzIUUqCmUC+EACHRFWhq2cA=
X-Received: by 2002:a2e:be83:0:b0:30b:b987:b68d with SMTP id
 38308e7fff4ca-30de023160emr27860521fa.8.1743428787614; Mon, 31 Mar 2025
 06:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331083523.1132457-1-chharry@google.com>
In-Reply-To: <20250331083523.1132457-1-chharry@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Mar 2025 09:46:15 -0400
X-Gm-Features: AQ5f1JoZeyFV52eG26oxBfYFIR3RvTet8_pLYO5KsGTe4sWTmPmLpRNq44LClGQ
Message-ID: <CABBYNZKeCY6AU7MBSu-kcv6B=nuS4-yLTfX68uvQW25e1SSeqw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Reset altsetting when no SCO connection
To: Hsin-chen Chuang <chharry@google.com>
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Mon, Mar 31, 2025 at 4:36=E2=80=AFAM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> Although commit 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting
> for HCI_USER_CHANNEL") has enabled the HCI_USER_CHANNEL user to send out
> SCO data through USB Bluetooth chips, it's observed that with the patch
> HFP is flaky on most of the existing USB Bluetooth controllers: Intel
> chips sometimes send out no packet for Transparent codec; MTK chips may
> generate SCO data with a wrong handle for CVSD codec; RTK could split
> the data with a wrong packet size for Transparent codec.
>
> To address the issue above btusb needs to reset the altsetting back to
> zero when there is no active SCO connection, which is the same as the
> BlueZ behavior, and another benefit is the bus doesn't need to reserve
> bandwidth when no SCO connection.
>
> This patch adds a fixed-size array in btusb_data which is used for
> tracing the active SCO handles. When the controller is reset or any
> tracing handle has disconnected, btusb adjusts the USB alternate setting
> correspondingly for the Isoc endpoint.
>
> The array size is configured by BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES.
> If the size is set to zero, the auto set altsetting feature is disabled.
>
> This patch is tested on ChromeOS devices. The USB Bluetooth models
> (CVSD, TRANS alt3 and alt6) could pass the stress HFP test narrow band
> speech and wide band speech.
>
> Cc: chromeos-bluetooth-upstreaming@chromium.org
> Fixes: 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting for HCI_USER=
_CHANNEL")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
>  drivers/bluetooth/Kconfig |  18 ++++--
>  drivers/bluetooth/btusb.c | 116 ++++++++++++++++++++++++++++++--------
>  2 files changed, 105 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 7771edf54fb3..5c811af8d15f 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -56,17 +56,23 @@ config BT_HCIBTUSB_POLL_SYNC
>           Say Y here to enable USB poll_sync for Bluetooth USB devices by
>           default.
>
> -config BT_HCIBTUSB_AUTO_ISOC_ALT
> -       bool "Automatically adjust alternate setting for Isoc endpoints"
> +config BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES
> +       int "Automatically adjust alternate setting for Isoc endpoints"
>         depends on BT_HCIBTUSB
> -       default y if CHROME_PLATFORMS
> +       default 2 if CHROME_PLATFORMS
> +       default 0

We may need to limit to a maximum of 3 given that is the maximum
defined per spec.

>         help
> -         Say Y here to automatically adjusting the alternate setting for
> -         HCI_USER_CHANNEL whenever a SCO link is established.
> +         Say positive number here to automatically adjusting the alterna=
te
> +         setting for HCI_USER_CHANNEL whenever a SCO link is established=
.
>
> -         When enabled, btusb intercepts the HCI_EV_SYNC_CONN_COMPLETE pa=
ckets
> +         When positive, btusb intercepts the HCI_EV_SYNC_CONN_COMPLETE p=
ackets
>           and configures isoc endpoint alternate setting automatically wh=
en
>           HCI_USER_CHANNEL is in use.
> +         btusb traces at most the given number of SCO handles and interc=
epts
> +         the HCI_EV_DISCONN_COMPLETE and the HCI_EV_CMD_COMPLETE of
> +         HCI_OP_RESET packets. When the controller is reset, or all trac=
ing
> +         handles are disconnected, btusb reset the isoc endpoint alterna=
te
> +         setting to zero.
>
>  config BT_HCIBTUSB_BCM
>         bool "Broadcom protocol support"
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5012b5ff92c8..31439d66cf0e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -34,7 +34,7 @@ static bool force_scofix;
>  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUS=
PEND);
>  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC=
);
>  static bool reset =3D true;
> -static bool auto_isoc_alt =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_ISOC_AL=
T);
> +static bool auto_isoc_alt =3D CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDL=
ES > 0;
>
>  static struct usb_driver btusb_driver;
>
> @@ -907,6 +907,8 @@ struct btusb_data {
>         __u8 cmdreq;
>
>         unsigned int sco_num;
> +       u16 sco_handles[CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES];
> +
>         unsigned int air_mode;
>         bool usb_alt6_packet_flow;
>         int isoc_altsetting;
> @@ -1118,40 +1120,108 @@ static inline void btusb_free_frags(struct btusb=
_data *data)
>         spin_unlock_irqrestore(&data->rxlock, flags);
>  }
>
> -static void btusb_sco_connected(struct btusb_data *data, struct sk_buff =
*skb)
> +static void btusb_sco_changed(struct btusb_data *data, struct sk_buff *s=
kb)
>  {
>         struct hci_event_hdr *hdr =3D (void *) skb->data;
> -       struct hci_ev_sync_conn_complete *ev =3D
> -               (void *) skb->data + sizeof(*hdr);
>         struct hci_dev *hdev =3D data->hdev;
> -       unsigned int notify_air_mode;
>
> -       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> -               return;
> +       if (data->sco_num > CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES)=
 {
> +               bt_dev_warn(hdev, "Invalid sco_num to HCI_USER_CHANNEL");
> +               data->sco_num =3D 0;
> +       }
>
> -       if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_EV_SYNC_CONN_COM=
PLETE)
> +       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT || skb->len < sizeof=
(*hdr))
>                 return;
>
> -       if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->status)
> -               return;
> +       switch (hdr->evt) {
> +       case HCI_EV_CMD_COMPLETE: {
> +               struct hci_ev_cmd_complete *ev =3D
> +                       (void *) skb->data + sizeof(*hdr);
> +               struct hci_ev_status *rp =3D
> +                       (void *) skb->data + sizeof(*hdr) + sizeof(*ev);
> +               u16 opcode;
> +
> +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) + sizeof(*rp=
))
> +                       return;
> +
> +               opcode =3D __le16_to_cpu(ev->opcode);
> +
> +               if (opcode !=3D HCI_OP_RESET || rp->status)
> +                       return;
> +
> +               bt_dev_info(hdev, "Resetting SCO");
> +               data->sco_num =3D 0;
> +               data->air_mode =3D HCI_NOTIFY_DISABLE_SCO;
> +               schedule_work(&data->work);
>
> -       switch (ev->air_mode) {
> -       case BT_CODEC_CVSD:
> -               notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
>                 break;
> +       }
> +       case HCI_EV_DISCONN_COMPLETE: {
> +               struct hci_ev_disconn_complete *ev =3D
> +                       (void *) skb->data + sizeof(*hdr);
> +               u16 handle;
> +               int i;
> +
> +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->statu=
s)
> +                       return;
> +
> +               handle =3D __le16_to_cpu(ev->handle);
> +               for (i =3D 0; i < data->sco_num; i++) {
> +                       if (data->sco_handles[i] =3D=3D handle)
> +                               break;
> +               }
> +
> +               if (i =3D=3D data->sco_num)
> +                       return;
> +
> +               bt_dev_info(hdev, "Disabling SCO");
> +               data->sco_handles[i] =3D data->sco_handles[data->sco_num =
- 1];

Not really sure what is the intent of the assignment above, shouldn't
it just be resetting it back to invalid handle?

> +               data->sco_num--;
> +               data->air_mode =3D HCI_NOTIFY_DISABLE_SCO;
> +               schedule_work(&data->work);
>
> -       case BT_CODEC_TRANSPARENT:
> -               notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANSP;
>                 break;
> +       }
> +       case HCI_EV_SYNC_CONN_COMPLETE: {
> +               struct hci_ev_sync_conn_complete *ev =3D
> +                       (void *) skb->data + sizeof(*hdr);
> +               unsigned int notify_air_mode;
> +               u16 handle;
>
> +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->statu=
s)
> +                       return;
> +
> +               switch (ev->air_mode) {
> +               case BT_CODEC_CVSD:
> +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> +                       break;
> +
> +               case BT_CODEC_TRANSPARENT:
> +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANSP;
> +                       break;
> +
> +               default:
> +                       return;
> +               }
> +
> +               handle =3D __le16_to_cpu(ev->handle);
> +               if (data->sco_num
> +                   =3D=3D CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES) =
{
> +                       bt_dev_err(hdev, "Failed to add the new SCO handl=
e");
> +                       return;
> +               }
> +
> +               bt_dev_info(hdev, "Enabling SCO with air mode %u",
> +                           ev->air_mode);
> +               data->sco_handles[data->sco_num++] =3D handle;
> +               data->air_mode =3D notify_air_mode;
> +               schedule_work(&data->work);
> +
> +               break;
> +       }
>         default:
> -               return;
> +               break;
>         }
> -
> -       bt_dev_info(hdev, "enabling SCO with air mode %u", ev->air_mode);
> -       data->sco_num =3D 1;
> -       data->air_mode =3D notify_air_mode;
> -       schedule_work(&data->work);
>  }
>
>  static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb=
)
> @@ -1161,9 +1231,9 @@ static int btusb_recv_event(struct btusb_data *data=
, struct sk_buff *skb)
>                 schedule_delayed_work(&data->rx_work, 0);
>         }
>
> -       /* Configure altsetting for HCI_USER_CHANNEL on SCO connected */
> +       /* Configure altsetting for HCI_USER_CHANNEL on SCO changed */
>         if (auto_isoc_alt && hci_dev_test_flag(data->hdev, HCI_USER_CHANN=
EL))
> -               btusb_sco_connected(data, skb);
> +               btusb_sco_changed(data, skb);
>
>         return data->recv_event(data->hdev, skb);
>  }
> --
> 2.49.0.472.ge94155a9ec-goog
>


--=20
Luiz Augusto von Dentz
