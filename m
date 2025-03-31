Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819632135A1;
	Mon, 31 Mar 2025 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429795; cv=none; b=Ax+AhYIPJPGui8rZhA/BKrEreCQllhW6DDY+B8exr65AYtMwpnzwFzb2HOFrrP6Zp1wjQQEohBT/Iu6xUNOropS9Uyj6T4t3rId0a7E1P3wddYf+UcSaGbiqdJcVh20TrrdY6J1RMhsMIlGQzehHW2Q9DFJD1A4+JQ0jobGTAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429795; c=relaxed/simple;
	bh=IV6AQiMOtLYl0+CMvLsrqOAEgoR4SrYdwtlngvru1As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzUyfJwN65P/fwAV9g69MvfVpKGl2/382wWmdwJ5YaVY1TbS1yCP+fT+KGv5LOU3u0Q1IgYkzbLt9Ru7tfoWr/xk/tADsfHO1dBqAXrYGN/qBHeDuFBtDgJKOcoAgbddblJQotrIV3iczrvBS8LnkkiXYDFkW5cokGdDzcWIr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECOkNJyn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECOkNJyn"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso44832071fa.3;
        Mon, 31 Mar 2025 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743429791; x=1744034591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsDRNHaLUSPDPOOGzAuyLOo9BSmUJfdX/ybCYwVlk5o=;
        b=ECOkNJynCcclVGAg/SO61ush/YuDpRqq6ANGoZRYchDOVJrKgME5v6/6QeH7RkSchV
         qoVG+8YgrwsCrJ2XY4LLuehBKrv4V7Je+pqsRLsWnkoNTKi+3urTkXoJ2tcvzZ7QB+Er
         dNtbCAhz7zrdk2DxTn3QyTM0E9b1mWLXOscbP6LwqFB+01S0mCX/M9i25jXIDBPVVkPe
         qoORulsLbKtzEOTf6P8c9I0xYVWZq+rgJBqEwcfj1fq4qTbfXAD/54CFy18t3XAl2LO4
         UGGt2KnwPspbKcRNXhJKyDGDlPJa2iAUPfjRNm9xOmEmZw8OpUdfW3Gmmq/X3nkCiy/v
         2msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429791; x=1744034591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsDRNHaLUSPDPOOGzAuyLOo9BSmUJfdX/ybCYwVlk5o=;
        b=a2fDNHl/fL+HIGQ7svGdfugFS40AN+vJuakTDLqWVAUvFfwMy4B6eViAy7blAGPBoH
         aQhJU7yKomneK62uj3zOTXBOzKtgANsyD+W0bg71BIlT/SpOdryMRhi7JYmgwdhCq9eC
         EfZxXiPhKrPmpf/MFuH2Bqjeuve6CqtsINhTd1wribkPyLLA6xezYLLIwDKJgCxEgdjO
         zBeIVghkGvW2hs667c34bzEXNtc3Deu3Iol4sXCo1pSbbLGv0hFAUhccTaRdQrC1nO5C
         kYUlOcMy58fIX5+TA5BQZmpTeUpbM7Zax8mNn2BTrpJeGab3JSdM7KsI/D6MhSCzFLhY
         xblg==
X-Forwarded-Encrypted: i=1; AJvYcCWS+6gElqWTNjfWn/orsx4pJgNIPleZE8uGFxLgH4t4/0QjI7/R9tBFZB9LVowguvWmcYIlewFkXeKe8MvG@vger.kernel.org, AJvYcCWTSgsfxwTg3ouhmIT0R49ZL5nYPNEfkA1eXUM+jbRnGAaw1phR6ixcAn0dY6vwD5pLx8B+2gIw6iXEtKPR+GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQl+s4WmnYYA2TAn2VJnSYZHJ/fAY3eqib/8vZVSMksdNoZvGA
	xbsdN8TOI3iBfGN0J12RcyqfJyT70Hgr6G6lzCzlkZD/hoTyOGK86dMCexZUG+dri9n686hBaro
	pvLMW2neu0WRQf0/fFu8E+3CossMvlw4Y
X-Gm-Gg: ASbGncubr9VXaQLBcJFrg4llGE0O2h3WtVNxoXFZiPQVOPu5p9zLZIVEyJsuAtgPzGg
	Hzk9X2fcF8mpryZt+oW3YsAW6Qp4ps7PWL92wDwmUhj5dNdCHTdVRqXINjqB195C71ttBKPgRPX
	cHHN1nsgUz10kDhVTVQcMI21ET
X-Google-Smtp-Source: AGHT+IELe/T/ayWPrSnwjQ33CCb03t9pk0gTch/PZWWo9/Pb3POHTA7xZ24meQnQjM9ZwekHuX64uGEj9c4h8sF4eAM=
X-Received: by 2002:a05:651c:1581:b0:300:5c57:526b with SMTP id
 38308e7fff4ca-30de024acd7mr30600501fa.11.1743429791060; Mon, 31 Mar 2025
 07:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331083523.1132457-1-chharry@google.com> <CADg1FFfkh9ER-t1WbwwFjqS-MjP_YdfM2Fu9umKpA6f5YJowPw@mail.gmail.com>
In-Reply-To: <CADg1FFfkh9ER-t1WbwwFjqS-MjP_YdfM2Fu9umKpA6f5YJowPw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Mar 2025 10:02:58 -0400
X-Gm-Features: AQ5f1JqlP-0ANRSGQBRNys_Sz3hdDjupTqdB5PQzSYSP8-uPcKEIIv0bMTYosbM
Message-ID: <CABBYNZJRy_J=61zEF3_XS24fcJxe91TQMZ6TPaEOqW=9-VgTcw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Reset altsetting when no SCO connection
To: Hsin-chen Chuang <chharry@google.com>
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Mon, Mar 31, 2025 at 4:45=E2=80=AFAM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> Hi Luiz,
>
> On Mon, Mar 31, 2025 at 4:36=E2=80=AFPM Hsin-chen Chuang <chharry@google.=
com> wrote:
> >
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > Although commit 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting
> > for HCI_USER_CHANNEL") has enabled the HCI_USER_CHANNEL user to send ou=
t
> > SCO data through USB Bluetooth chips, it's observed that with the patch
> > HFP is flaky on most of the existing USB Bluetooth controllers: Intel
> > chips sometimes send out no packet for Transparent codec; MTK chips may
> > generate SCO data with a wrong handle for CVSD codec; RTK could split
> > the data with a wrong packet size for Transparent codec.
> >
> > To address the issue above btusb needs to reset the altsetting back to
> > zero when there is no active SCO connection, which is the same as the
> > BlueZ behavior, and another benefit is the bus doesn't need to reserve
> > bandwidth when no SCO connection.
> >
> > This patch adds a fixed-size array in btusb_data which is used for
> > tracing the active SCO handles. When the controller is reset or any
> > tracing handle has disconnected, btusb adjusts the USB alternate settin=
g
> > correspondingly for the Isoc endpoint.
> >
> > The array size is configured by BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES.
> > If the size is set to zero, the auto set altsetting feature is disabled=
.
> >
> > This patch is tested on ChromeOS devices. The USB Bluetooth models
> > (CVSD, TRANS alt3 and alt6) could pass the stress HFP test narrow band
> > speech and wide band speech.
> >
> > Cc: chromeos-bluetooth-upstreaming@chromium.org
> > Fixes: 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting for HCI_US=
ER_CHANNEL")
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> >
> >  drivers/bluetooth/Kconfig |  18 ++++--
> >  drivers/bluetooth/btusb.c | 116 ++++++++++++++++++++++++++++++--------
> >  2 files changed, 105 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> > index 7771edf54fb3..5c811af8d15f 100644
> > --- a/drivers/bluetooth/Kconfig
> > +++ b/drivers/bluetooth/Kconfig
> > @@ -56,17 +56,23 @@ config BT_HCIBTUSB_POLL_SYNC
> >           Say Y here to enable USB poll_sync for Bluetooth USB devices =
by
> >           default.
> >
> > -config BT_HCIBTUSB_AUTO_ISOC_ALT
> > -       bool "Automatically adjust alternate setting for Isoc endpoints=
"
> > +config BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES
> > +       int "Automatically adjust alternate setting for Isoc endpoints"
> >         depends on BT_HCIBTUSB
> > -       default y if CHROME_PLATFORMS
> > +       default 2 if CHROME_PLATFORMS
> > +       default 0
> >         help
> > -         Say Y here to automatically adjusting the alternate setting f=
or
> > -         HCI_USER_CHANNEL whenever a SCO link is established.
> > +         Say positive number here to automatically adjusting the alter=
nate
> > +         setting for HCI_USER_CHANNEL whenever a SCO link is establish=
ed.
> >
> > -         When enabled, btusb intercepts the HCI_EV_SYNC_CONN_COMPLETE =
packets
> > +         When positive, btusb intercepts the HCI_EV_SYNC_CONN_COMPLETE=
 packets
> >           and configures isoc endpoint alternate setting automatically =
when
> >           HCI_USER_CHANNEL is in use.
> > +         btusb traces at most the given number of SCO handles and inte=
rcepts
> > +         the HCI_EV_DISCONN_COMPLETE and the HCI_EV_CMD_COMPLETE of
> > +         HCI_OP_RESET packets. When the controller is reset, or all tr=
acing
> > +         handles are disconnected, btusb reset the isoc endpoint alter=
nate
> > +         setting to zero.
> >
> >  config BT_HCIBTUSB_BCM
> >         bool "Broadcom protocol support"
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 5012b5ff92c8..31439d66cf0e 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -34,7 +34,7 @@ static bool force_scofix;
> >  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOS=
USPEND);
> >  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SY=
NC);
> >  static bool reset =3D true;
> > -static bool auto_isoc_alt =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_ISOC_=
ALT);
> > +static bool auto_isoc_alt =3D CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HAN=
DLES > 0;
> >
> >  static struct usb_driver btusb_driver;
> >
> > @@ -907,6 +907,8 @@ struct btusb_data {
> >         __u8 cmdreq;
> >
> >         unsigned int sco_num;
> > +       u16 sco_handles[CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES];
> > +
> >         unsigned int air_mode;
> >         bool usb_alt6_packet_flow;
> >         int isoc_altsetting;
> > @@ -1118,40 +1120,108 @@ static inline void btusb_free_frags(struct btu=
sb_data *data)
> >         spin_unlock_irqrestore(&data->rxlock, flags);
> >  }
> >
> > -static void btusb_sco_connected(struct btusb_data *data, struct sk_buf=
f *skb)
> > +static void btusb_sco_changed(struct btusb_data *data, struct sk_buff =
*skb)
> >  {
> >         struct hci_event_hdr *hdr =3D (void *) skb->data;
> > -       struct hci_ev_sync_conn_complete *ev =3D
> > -               (void *) skb->data + sizeof(*hdr);
> >         struct hci_dev *hdev =3D data->hdev;
> > -       unsigned int notify_air_mode;
> >
> > -       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> > -               return;
> > +       if (data->sco_num > CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLE=
S) {
> > +               bt_dev_warn(hdev, "Invalid sco_num to HCI_USER_CHANNEL"=
);
> > +               data->sco_num =3D 0;
> > +       }
> >
> > -       if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_EV_SYNC_CONN_C=
OMPLETE)
> > +       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT || skb->len < size=
of(*hdr))
> >                 return;
> >
> > -       if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->status)
> > -               return;
> > +       switch (hdr->evt) {
> > +       case HCI_EV_CMD_COMPLETE: {
> > +               struct hci_ev_cmd_complete *ev =3D
> > +                       (void *) skb->data + sizeof(*hdr);
> > +               struct hci_ev_status *rp =3D
> > +                       (void *) skb->data + sizeof(*hdr) + sizeof(*ev)=
;
> > +               u16 opcode;
> > +
> > +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) + sizeof(*=
rp))
> > +                       return;
> > +
> > +               opcode =3D __le16_to_cpu(ev->opcode);
> > +
> > +               if (opcode !=3D HCI_OP_RESET || rp->status)
> > +                       return;
> > +
> > +               bt_dev_info(hdev, "Resetting SCO");
> > +               data->sco_num =3D 0;
> > +               data->air_mode =3D HCI_NOTIFY_DISABLE_SCO;
> > +               schedule_work(&data->work);
> >
> > -       switch (ev->air_mode) {
> > -       case BT_CODEC_CVSD:
> > -               notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> >                 break;
> > +       }
> > +       case HCI_EV_DISCONN_COMPLETE: {
> > +               struct hci_ev_disconn_complete *ev =3D
> > +                       (void *) skb->data + sizeof(*hdr);
> > +               u16 handle;
> > +               int i;
> > +
> > +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->sta=
tus)
> > +                       return;
> > +
> > +               handle =3D __le16_to_cpu(ev->handle);
> > +               for (i =3D 0; i < data->sco_num; i++) {
> > +                       if (data->sco_handles[i] =3D=3D handle)
> > +                               break;
> > +               }
> > +
> > +               if (i =3D=3D data->sco_num)
> > +                       return;
> > +
> > +               bt_dev_info(hdev, "Disabling SCO");
> > +               data->sco_handles[i] =3D data->sco_handles[data->sco_nu=
m - 1];
> > +               data->sco_num--;
> > +               data->air_mode =3D HCI_NOTIFY_DISABLE_SCO;
> > +               schedule_work(&data->work);
> >
> > -       case BT_CODEC_TRANSPARENT:
> > -               notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANSP;
> >                 break;
> > +       }
> > +       case HCI_EV_SYNC_CONN_COMPLETE: {
> > +               struct hci_ev_sync_conn_complete *ev =3D
> > +                       (void *) skb->data + sizeof(*hdr);
> > +               unsigned int notify_air_mode;
> > +               u16 handle;
> >
> > +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->sta=
tus)
> > +                       return;
> > +
> > +               switch (ev->air_mode) {
> > +               case BT_CODEC_CVSD:
> > +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> > +                       break;
> > +
> > +               case BT_CODEC_TRANSPARENT:
> > +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANS=
P;
> > +                       break;
> > +
> > +               default:
> > +                       return;
> > +               }
> > +
> > +               handle =3D __le16_to_cpu(ev->handle);
> > +               if (data->sco_num
> > +                   =3D=3D CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES=
) {
> > +                       bt_dev_err(hdev, "Failed to add the new SCO han=
dle");
> > +                       return;
> > +               }
> > +
> > +               bt_dev_info(hdev, "Enabling SCO with air mode %u",
> > +                           ev->air_mode);
> > +               data->sco_handles[data->sco_num++] =3D handle;
> > +               data->air_mode =3D notify_air_mode;
> > +               schedule_work(&data->work);
> > +
> > +               break;
> > +       }
> >         default:
> > -               return;
> > +               break;
> >         }
> > -
> > -       bt_dev_info(hdev, "enabling SCO with air mode %u", ev->air_mode=
);
> > -       data->sco_num =3D 1;
> > -       data->air_mode =3D notify_air_mode;
> > -       schedule_work(&data->work);
> >  }
> >
> >  static int btusb_recv_event(struct btusb_data *data, struct sk_buff *s=
kb)
> > @@ -1161,9 +1231,9 @@ static int btusb_recv_event(struct btusb_data *da=
ta, struct sk_buff *skb)
> >                 schedule_delayed_work(&data->rx_work, 0);
> >         }
> >
> > -       /* Configure altsetting for HCI_USER_CHANNEL on SCO connected *=
/
> > +       /* Configure altsetting for HCI_USER_CHANNEL on SCO changed */
> >         if (auto_isoc_alt && hci_dev_test_flag(data->hdev, HCI_USER_CHA=
NNEL))
> > -               btusb_sco_connected(data, skb);
> > +               btusb_sco_changed(data, skb);
> >
> >         return data->recv_event(data->hdev, skb);
> >  }
> > --
> > 2.49.0.472.ge94155a9ec-goog
> >
>
> Please kindly let me know if you would prefer the below approach:
> - Define a vendor HCI command, which indicates the expected altsetting
>   from the user space program
> - btusb intercepts the command and adjusts the Isoc endpoint correspondin=
gly

Yeah, that would probably be a lot simpler in terms of implementation
and we can signal errors back to upper layers as well, that said that
is the first time we would be doing it so we may need to design it in
a way that it is extensible e.g. just reserve a single opcode and then
use a header to determine the operation in the driver, well that if we
want these operations to be valid for all drivers but perhaps we don't
since in this case specifically it is only really valid for btusb.

Or perhaps we should do:

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 022b86797acd..202e14578a8f 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1852,19 +1852,6 @@ static int hci_sock_sendmsg(struct socket
*sock, struct msghdr *msg,
        skb_pull(skb, 1);

        if (hci_pi(sk)->channel =3D=3D HCI_CHANNEL_USER) {
-               /* No permission check is needed for user channel
-                * since that gets enforced when binding the socket.
-                *
-                * However check that the packet type is valid.
-                */
-               if (hci_skb_pkt_type(skb) !=3D HCI_COMMAND_PKT &&
-                   hci_skb_pkt_type(skb) !=3D HCI_ACLDATA_PKT &&
-                   hci_skb_pkt_type(skb) !=3D HCI_SCODATA_PKT &&
-                   hci_skb_pkt_type(skb) !=3D HCI_ISODATA_PKT) {
-                       err =3D -EINVAL;
-                       goto drop;
-               }
-
                skb_queue_tail(&hdev->raw_q, skb);
                queue_work(hdev->workqueue, &hdev->tx_work);
        } else if (hci_skb_pkt_type(skb) =3D=3D HCI_COMMAND_PKT) {

Then you can use e.g. HCI_VENDOR_PKT (0xff) which can take any form we
like and doesn't use the HCI opcode space, perhaps we can even define
a dedicated packet type for driver communication e.g HCI_DRV_PKT.

--=20
Luiz Augusto von Dentz
