Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2573471
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890822; cv=none; b=RzXURZTmlL5AHW/qdEXI5D4XRY796jy/iZe3a11zJCGY/vVLy2uuRBgCfHNZKGdKVED7VBNBVS6cnXBoQR0qyPZaoVFDt+MlX4+X0De/kffGyKT69QY/MU7pzHLQqXuishoazkDmIrswggtgvpImRQt1/wQ4cOFEqhUZaQ1vefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890822; c=relaxed/simple;
	bh=UDrETMMWIh3ILjmaiQoR7Ed8jcnbVodwQ92B9oQ7+jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zsbvivj9CY9IBuyxfHMb+WyKIn1oSqfF+FXI9wVJVexACb5MUZlpuyFO5xMLdX5haXVwzpSr2BKO7JkPAZJs1+N7rC7rDZ4amRpfqTI44j2f3cMiVvKuLaQtY/Ip3uuEh0aQXVomGHokaqyf3wfjafh1ojvAGycr2mIIyzTShRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BlxMQV8m; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BlxMQV8m"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-529644ec0ebso984126e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716890818; x=1717495618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G043ZjxFHuNpDNlbGh8qV2XjgxJz8FA9EiOJfa5X/qQ=;
        b=BlxMQV8ms6lxEpIAH5amndmULZuk2wjiWy4I02M9k3e9Fp4ma73Mkf8demrpS31ADQ
         muXAFfJ9Ks6mYUpLd0eeVhGFauvbQox2GmkTdFl/E8AYU1pn4ZlP1BjR+XkXN99OiC9g
         2Y6EwG1Izfs/AajaFPvPDxXrWOrMUHJYZibIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716890818; x=1717495618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G043ZjxFHuNpDNlbGh8qV2XjgxJz8FA9EiOJfa5X/qQ=;
        b=BipqcbnjZ7F1MRG3CRxeo2g4YECCSJNGOgJu5J+Rp4+g6gVm8rPatj+3fn0HZHc10z
         bLxgCwUyv+kC+2dhXRMBmBwuYYceSCJFaFa7xheN1QGkkChBYPezGtjlsjOSmAIuYaKD
         X7PlyqwBkTj6gYPDJo2+NH9D4MrqXx3Pr6ao5V657Pxq0iqi4rYzSAGymwCaE5BocAqG
         rvBImMoZ/WjB0JbsSu2UKiceFY7DoZ2w3XhUGnBqFp3zuGvCsetj3V7XYdiwB1O8DHVp
         Mtq6IXkeWaAZKGAe6jTmKpGOMwAm6qp8HHHirX8WDqmvmRBGyhwo9CiAfueWyjNe62fn
         6/KA==
X-Gm-Message-State: AOJu0YwS3zm+0+Dy2TZy9ZCBZgiq41czTiNOEPUOYTy1zSZqaIPV61pm
	nZFvvifWeAFys9rUZZ/9UbW46tEX/qoXDxipW1wlNdJijyT4U5pxSYR90enWXFtN6tMVvxkdYhc
	=
X-Google-Smtp-Source: AGHT+IHTkmj13v3y+t6Cmy0AtttEcXG+kV7SWkAxjaDb4TIsQdaeCszqdusBWLCo9t4Y+4+eop49Rg==
X-Received: by 2002:ac2:4a78:0:b0:51c:fd0a:7e37 with SMTP id 2adb3069b0e04-5296594dcdfmr8261480e87.20.1716890817926;
        Tue, 28 May 2024 03:06:57 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b233sm910600e87.135.2024.05.28.03.06.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 03:06:57 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so11368071fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 03:06:56 -0700 (PDT)
X-Received: by 2002:a05:6512:2091:b0:51d:605e:f0ce with SMTP id
 2adb3069b0e04-5296736bd69mr6861070e87.50.1716890816121; Tue, 28 May 2024
 03:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524045045.3310641-1-yinghsu@chromium.org>
 <CAAa9mD0XeCEkpAa-ms71MAKMVJ9zcT=jOCDO+LeBL8CmaXjagg@mail.gmail.com> <c8c193b49aaf9419edceab43855fe471071b1382.camel@iki.fi>
In-Reply-To: <c8c193b49aaf9419edceab43855fe471071b1382.camel@iki.fi>
From: Ying Hsu <yinghsu@chromium.org>
Date: Tue, 28 May 2024 18:06:17 +0800
X-Gmail-Original-Message-ID: <CAAa9mD3Jhm1SS6G5NOFhNXbFYeTanwoHX70mf-HOCD8dgfpDHQ@mail.gmail.com>
Message-ID: <CAAa9mD3Jhm1SS6G5NOFhNXbFYeTanwoHX70mf-HOCD8dgfpDHQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Add vendor-specific packet classification
 for ISO data
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch on a Chromebook with an AX211 BT controller, using
LE Audio earbuds (Samsung Buds 2 Pro), BR/EDR earbuds, and a LE
keyboard.
To my knowledge, connection handle ranges are controlled by Intel's
Bluetooth firmware, and this is Intel specific change.

On Tue, May 28, 2024 at 2:50=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ti, 2024-05-28 kello 13:38 +0800, Ying Hsu kirjoitti:
> > We just found Rx ACL data packets on the INTEL_STP2_AC7265 BT
> > controller are using connection handle value >=3D 0x900 (e.g.
> > 3585=3D0xe01):
> > ```
> > > ISO Data RX: Handle 3585 flags 0x02 dlen 16                          =
                              #536 [hci0] 2024-05-28 00:41:23.779341
> > ```
> >
> > To mitigate potential issues, we can limit the patch to verified
> > models like AX211. What do you think?
>
> How is this verified, is there a data sheet that says these are the
> handle ranges? Will it be changed by later firmware updates
> (unlikely?)?
>
> >
> > On Fri, May 24, 2024 at 12:50=E2=80=AFPM Ying Hsu <yinghsu@chromium.org=
> wrote:
> > >
> > > When HCI raw sockets are opened, the Bluetooth kernel module doesn't
> > > track CIS/BIS connections. User-space applications have to identify
> > > ISO data by maintaining connection information and look up the mappin=
g
> > > for each ACL data packet received. Besides, btsnoop log captured in
> > > kernel couldn't tell ISO data from ACL data in this case.
> > >
> > > To avoid additional lookups, this patch introduces vendor-specific
> > > packet classification for Intel BT controllers to distinguish
> > > ISO data packets from ACL data packets.
> > >
> > > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > > ---
> > > Tested LE audio unicast recording on a ChromeOS device with Intel AX2=
11
> > >
> > > Changes in v3:
> > > - Move Intel's classify_pkt_type implementation from btusb.c to btint=
el.c.
> > >
> > > Changes in v2:
> > > - Adds vendor-specific packet classificaton in hci_dev.
> > > - Keeps reclassification in hci_recv_frame.
> > >
> > >  drivers/bluetooth/btintel.c      | 19 +++++++++++++++++++
> > >  drivers/bluetooth/btintel.h      |  6 ++++++
> > >  drivers/bluetooth/btusb.c        |  1 +
> > >  include/net/bluetooth/hci_core.h |  1 +
> > >  net/bluetooth/hci_core.c         | 16 ++++++++++++++++
> > >  5 files changed, 43 insertions(+)
> > >
> > > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.=
c
> > > index 27e03951e68b..bf1bd2b13c96 100644
> > > --- a/drivers/bluetooth/btintel.c
> > > +++ b/drivers/bluetooth/btintel.c
> > > @@ -3187,6 +3187,25 @@ void btintel_secure_send_result(struct hci_dev=
 *hdev,
> > >  }
> > >  EXPORT_SYMBOL_GPL(btintel_secure_send_result);
> > >
> > > +#define BTINTEL_ISODATA_HANDLE_BASE 0x900
> > > +
> > > +u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *s=
kb)
> > > +{
> > > +       /*
> > > +        * Distinguish ISO data packets form ACL data packets
> > > +        * based on their connection handle value range.
> > > +        */
> > > +       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> > > +               __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->hand=
le);
> > > +
> > > +               if (hci_handle(handle) >=3D BTINTEL_ISODATA_HANDLE_BA=
SE)
> > > +                       return HCI_ISODATA_PKT;
> > > +       }
> > > +
> > > +       return hci_skb_pkt_type(skb);
> > > +}
> > > +EXPORT_SYMBOL_GPL(btintel_classify_pkt_type);
> > > +
> > >  MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> > >  MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSIO=
N);
> > >  MODULE_VERSION(VERSION);
> > > diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.=
h
> > > index 9dbad1a7c47c..4b77eb8d47a8 100644
> > > --- a/drivers/bluetooth/btintel.h
> > > +++ b/drivers/bluetooth/btintel.h
> > > @@ -245,6 +245,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *=
hdev,
> > >  int btintel_shutdown_combined(struct hci_dev *hdev);
> > >  void btintel_hw_error(struct hci_dev *hdev, u8 code);
> > >  void btintel_print_fseq_info(struct hci_dev *hdev);
> > > +u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *s=
kb);
> > >  #else
> > >
> > >  static inline int btintel_check_bdaddr(struct hci_dev *hdev)
> > > @@ -378,4 +379,9 @@ static inline void btintel_hw_error(struct hci_de=
v *hdev, u8 code)
> > >  static inline void btintel_print_fseq_info(struct hci_dev *hdev)
> > >  {
> > >  }
> > > +
> > > +static inline u8 btintel_classify_pkt_type(struct hci_dev *hdev, str=
uct sk_buff *skb)
> > > +{
> > > +       return hci_skb_pkt_type(skb);
> > > +}
> > >  #endif
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index 79aefdb3324d..2ecc6d1140a5 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -4451,6 +4451,7 @@ static int btusb_probe(struct usb_interface *in=
tf,
> > >                 /* Transport specific configuration */
> > >                 hdev->send =3D btusb_send_frame_intel;
> > >                 hdev->cmd_timeout =3D btusb_intel_cmd_timeout;
> > > +               hdev->classify_pkt_type =3D btintel_classify_pkt_type=
;
> > >
> > >                 if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
> > >                         btintel_set_flag(hdev, INTEL_ROM_LEGACY_NO_WB=
S_SUPPORT);
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> > > index 9231396fe96f..7b7068a84ff7 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -649,6 +649,7 @@ struct hci_dev {
> > >         int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
> > >                                      struct bt_codec *codec, __u8 *vn=
d_len,
> > >                                      __u8 **vnd_data);
> > > +       u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff =
*skb);
> > >  };
> > >
> > >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index b3ee9ff17624..8b817a99cefd 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -2941,15 +2941,31 @@ int hci_reset_dev(struct hci_dev *hdev)
> > >  }
> > >  EXPORT_SYMBOL(hci_reset_dev);
> > >
> > > +static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_=
buff *skb)
> > > +{
> > > +       if (hdev->classify_pkt_type)
> > > +               return hdev->classify_pkt_type(hdev, skb);
> > > +
> > > +       return hci_skb_pkt_type(skb);
> > > +}
> > > +
> > >  /* Receive frame from HCI drivers */
> > >  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
> > >  {
> > > +       u8 dev_pkt_type;
> > > +
> > >         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
> > >                       && !test_bit(HCI_INIT, &hdev->flags))) {
> > >                 kfree_skb(skb);
> > >                 return -ENXIO;
> > >         }
> > >
> > > +       /* Check if the driver agree with packet type classification =
*/
> > > +       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev, skb);
> > > +       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
> > > +               hci_skb_pkt_type(skb) =3D dev_pkt_type;
> > > +       }
> > > +
> > >         switch (hci_skb_pkt_type(skb)) {
> > >         case HCI_EVENT_PKT:
> > >                 break;
> > > --
> > > 2.45.1.288.g0e0cd299f1-goog
> > >
>
> --
> Pauli Virtanen
