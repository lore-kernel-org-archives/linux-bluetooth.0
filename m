Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD71DB12C
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410710; cv=none; b=EpRNT8bX0d00e7ppH6qRfcn9p39JsCenQM7//F1NJsajJH4TP0IEVtTRUwoELjVRtSo3MfaMLEYqCbyhWmreDgHEvVhooDBLTVAFPl5RHzpaeFSPkivrj1MdFtpIryb6vrbV+3ujFbDrZyNaaUe93DljWfskOVsj+Q1GtyerqfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410710; c=relaxed/simple;
	bh=kNa4S4bKnkv7Hy8onoChualYx1peC5JNLj8drBcbwis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKEL7zuvBxyhhuekaNNI9zTVOvwkO8+Z2JfPACiaITgw5Y3CUGtN3ij49QXjkdY/8iK/dLDhsuXkdL2jlEwOFratkho4wISAF2F4RrTQ88LldCfUVHqD/MVdBIDkZ3JXN8/YPx0hv/ONWRcpAfO61PoPIJd7AieO64Sq/SAKpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/ElIceQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/ElIceQ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ff27ad48beso38186677b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743410708; x=1744015508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTYGAT1NKDFJHzR8IpOoE56rtF7Y56h9sq+etxbfjKM=;
        b=Y/ElIceQQgyqQduLPanPZDeBZ6y+0ZtmqpuAztG+30prFuC8br3rYHXZdvVg28rVqu
         SWFG9CfA2xhgpn8RxTIeKn/OGI5VH8Wr1gN6HvG9EwJ/V0IGWWZJynaL5tf4MFrs6Zg/
         4rlzb34FPUxQFiCO2uPzjy4xPUICNZXmUpNURyDI58MzRghvslTmZrELuWv1yTkFdEZT
         GUO5h5fyhqz/P3B7Q/fkWq/+XDICKxxFAVoCqs0hXxx28BQ/34JjuJgnnHkBMcuUekqE
         ao8scurqKkLPP47sxMw5U2Tmoa24q/5U8zyCzD4jg67axredJeW+DORApMaH2Q/2OqPJ
         /aDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743410708; x=1744015508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTYGAT1NKDFJHzR8IpOoE56rtF7Y56h9sq+etxbfjKM=;
        b=KKaspM2L+4NPjrjaKF36AO0JPwQlWsbLaRbvU5RvPRJfVNQo7Cd0eGG4QnAmiyqxW8
         l+YW37fGr0X2/Ow5yS9rYVCRB6m+n9t0U0eesMRF4cpDl6ysuopZASf+BZjzF5Q3BL5x
         teTNaO/FRDT3Lva+QK305WYqXFcUTMO7J4beuUps7nxsSe0xaCZxxa3DNxFbSMRhNd8b
         T47+RS3B7u/NuYIbRd614yrhrhSNQOgktP2G6FKlOLm4Q7b3/tjGrxD6IHVBR/PxHpUW
         KGLfLYKIendU9YiEWsVgL/eguMIYkwZgh+reGcbrOmtZSUh++qkBXzHUv/RwXE2k295i
         ke5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQRyccY/souN1VIe5SrGHb8V2N3XS39lzj1j9wq9lYpoUK4xbziMsHjMzz0O1nex3QmVyb/zn43MfbXHKOdQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiT3jS8lRLLazv87unXggErOvV6nxOIWA6jFnAnLLKeTJsgJzG
	QFPT6hykkzgAvO0NtaPMn+37+4RTRBcMnBevjMyGi5Tf6A9RUDo1h0ex+L3udfi1wqclMKk06et
	AMM4Ry3RR2av/R4TegEXT0FopfdF2U3O8fmpG
X-Gm-Gg: ASbGncuQtxc34wjDu7JojlV1Ejw9/UxzdxW9vcOVZnoTCV08eyLIyVprvnAZGz4xuPr
	P26zkIWBLQzk7Vs7Ce8C++YhH89D1YvEkREWG5lzWDb8Rjy7BRVifi19EtOjGdsT1vIVxQFY0ZU
	/f16z7500LdoNiqVcreX3x79vtWrdlLDmKcf2KWQ==
X-Google-Smtp-Source: AGHT+IGk/6IZpbYJZnUA++pmTtyHXBNYpKNKOrKqYJzEW+yShSWf6/iRH5UondauFSIQirjIeHC1Q6ebM0FH936fGds=
X-Received: by 2002:a05:690c:7249:b0:6f9:7ec7:386a with SMTP id
 00721157ae682-7025710de5fmr106438527b3.21.1743410707490; Mon, 31 Mar 2025
 01:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331083523.1132457-1-chharry@google.com>
In-Reply-To: <20250331083523.1132457-1-chharry@google.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Mon, 31 Mar 2025 16:44:30 +0800
X-Gm-Features: AQ5f1Jq393L4BFK91lRa5wTBPt9F8fIZDeaxoTGH7dbJTeYJ0zADzxF9SvcLA8M
Message-ID: <CADg1FFfkh9ER-t1WbwwFjqS-MjP_YdfM2Fu9umKpA6f5YJowPw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Reset altsetting when no SCO connection
To: luiz.dentz@gmail.com
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, Mar 31, 2025 at 4:36=E2=80=AFPM Hsin-chen Chuang <chharry@google.co=
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

Please kindly let me know if you would prefer the below approach:
- Define a vendor HCI command, which indicates the expected altsetting
  from the user space program
- btusb intercepts the command and adjusts the Isoc endpoint correspondingl=
y


Best Regards,
Hsin-chen
