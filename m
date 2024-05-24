Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209822F03
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521790; cv=none; b=kOwDcdZWqK7JRuNfMjgcsUTXAFybFHTzTlb2cgSvFDtLCd6z48SCCAC7JqkJI6sN9jIA0TT7hLTnLp8S4cBk1ZExzH+o6Q/5VCqj7yGScRjSwxvSVe+c7YbzR6SkkabC6t05YNhvFrQFbvGB580HWsh0MHChYqj+k8Sk1JXkYUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521790; c=relaxed/simple;
	bh=njn3ZSsQADSh1M5hWmKHI6B2nRPBr2eH8pLPPwf8W4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1HarKYN3+qjnpqQG+UqQFbuyL47P5DZ0B7Y09chgnojtPSgH5R7DCHTRsTjzouVRovv9EpL/TTfGKG+0pfnt7N9i9TlaCV2/JJVcNvvgNCKeLntgpBghdQuTqpaQtiid7aNRQIAqMU8hQG1t1Vvk+fZQ9G1PzTARMOQFLBf0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QwWP97nh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QwWP97nh"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57851ba16bdso376511a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 20:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716521787; x=1717126587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvqR2HI4wGJZSYx5d6cdYSO9SOYSnPRTRO4QAEGsUG8=;
        b=QwWP97nh0eZVv5dTYIZzvLIWz5/c9QyCRXsvXq4B14ruUf68tkZHeFlpy3O/wlJS/M
         cx/E3/uAHVvJy9AGvRaz/2fgk9k3RIcr6ZQMWqVd+NV06ZIo788rODS602wLKrcyz+hp
         cBLocVOr5fTtgEmJWzPsjAhA0dK9dSjzgVaw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521787; x=1717126587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvqR2HI4wGJZSYx5d6cdYSO9SOYSnPRTRO4QAEGsUG8=;
        b=RMevEA+Cy5dD7Ye7mBJxGcVijUS4FmPPEwz/RoUWTHrDm/e48SZb94+3MMVqYnfnAn
         eAOPp9mZ70k39Q0Q44Q1IYhtKdJ63DZvewLHo6HRi9RP0Z9/OqvlM6AqTa3o1CO37MJM
         iTAPgjxFPxN+ELGoItc2+cWFGq2uKE7KbSMkIIJMCjp1wzPttbIavXxSSNrpCKazxnEw
         M5mhQt13yZcAIvsNKh+2s56mn4SPkV9370xo2+ZsuEVqQfTS1Pty3t+mHrlrEwLi6FOv
         3QHYoKgxE0gdwWTJsj5qaqCI18kjpKF0Oib/FaXLyct9ZwxPjOrgLkBKkFEIFSPAY9lQ
         MyvQ==
X-Gm-Message-State: AOJu0Yw6ZSk2hxP6YgVtqe/jAUQ3ONscOxLPxVfws+XnaNCWUhrkp233
	x4SpJvcUQR06SYHpq4R39wdseq+NsO43agru/EV+QRsizgKTYetY/m4BpVu9MQX3xUYVumNOoWc
	=
X-Google-Smtp-Source: AGHT+IG9Ov+AgFYPJyJvj2xx/8PzEgFRs7YPLVux54wPOpZ73XmRRdypGzWxjr8GFMF43j6IDugwVQ==
X-Received: by 2002:a17:906:184d:b0:a5a:8c59:d6d with SMTP id a640c23a62f3a-a62641c7f50mr52961766b.17.1716521786640;
        Thu, 23 May 2024 20:36:26 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c937b92sm53759466b.68.2024.05.23.20.36.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 20:36:26 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6265d3ccf7so34004866b.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 20:36:25 -0700 (PDT)
X-Received: by 2002:a17:906:aa4c:b0:a59:cf38:5338 with SMTP id
 a640c23a62f3a-a62641c8f04mr59702466b.19.1716521785172; Thu, 23 May 2024
 20:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523060934.2883716-1-yinghsu@chromium.org> <CABBYNZKwLTri10NfQ07sywymPCFq2mwvb8==Zjn1QMD-kwpobA@mail.gmail.com>
In-Reply-To: <CABBYNZKwLTri10NfQ07sywymPCFq2mwvb8==Zjn1QMD-kwpobA@mail.gmail.com>
From: Ying Hsu <yinghsu@chromium.org>
Date: Fri, 24 May 2024 11:35:48 +0800
X-Gmail-Original-Message-ID: <CAAa9mD2cq=Px2=HLzVNaBfPugEgYD5FdqhyMvOx8VDpzxmEAMg@mail.gmail.com>
Message-ID: <CAAa9mD2cq=Px2=HLzVNaBfPugEgYD5FdqhyMvOx8VDpzxmEAMg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add vendor-specific packet classification
 for ISO data
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

I'm happy to move btusb_intel_classify_pkt_type into btintel.c in the
next patcheset.
As I only tested it on Intel USB BT controllers, I suggest Intel
further assess its applicability to other transports and future BT
controllers in another change.


On Thu, May 23, 2024 at 10:23=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Ying,
>
> On Thu, May 23, 2024 at 2:09=E2=80=AFAM Ying Hsu <yinghsu@chromium.org> w=
rote:
> >
> > When HCI raw sockets are opened, the Bluetooth kernel module doesn't
> > track CIS/BIS connections. User-space applications have to identify
> > ISO data by maintaining connection information and look up the mapping
> > for each ACL data packet received. Besides, btsnoop log captured in
> > kernel couldn't tell ISO data from ACL data in this case.
> >
> > To avoid additional lookups, this patch introduces vendor-specific
> > packet classification for Intel BT controllers to distinguish
> > ISO data packets from ACL data packets.
> >
> > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > ---
> > Tested LE audio unicast recording on a ChromeOS device with Intel AX211
> >
> > Changes in v2:
> > - Adds vendor-specific packet classificaton in hci_dev.
> > - Keeps reclassification in hci_recv_frame.
> >
> >  drivers/bluetooth/btusb.c        | 19 +++++++++++++++++++
> >  include/net/bluetooth/hci_core.h |  1 +
> >  net/bluetooth/hci_core.c         | 16 ++++++++++++++++
> >  3 files changed, 36 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 79aefdb3324d..75561e749c50 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -966,6 +966,24 @@ static void btusb_intel_cmd_timeout(struct hci_dev=
 *hdev)
> >         gpiod_set_value_cansleep(reset_gpio, 0);
> >  }
> >
> > +#define BT_USB_INTEL_ISODATA_HANDLE_BASE 0x900
> > +
> > +static u8 btusb_intel_classify_pkt_type(struct hci_dev *hdev, struct s=
k_buff *skb)
>
> We might as well move this to btintel.c since it should not be USB specif=
ic.
>
> > +{
> > +       /*
> > +        * Distinguish ISO data packets form ACL data packets
> > +        * based on their conneciton handle value range.
> > +        */
> > +       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> > +               __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->handle=
);
> > +
> > +               if (hci_handle(handle) >=3D BT_USB_INTEL_ISODATA_HANDLE=
_BASE)
> > +                       return HCI_ISODATA_PKT;
> > +       }
> > +
> > +       return hci_skb_pkt_type(skb);
> > +}
> > +
> >  #define RTK_DEVCOREDUMP_CODE_MEMDUMP           0x01
> >  #define RTK_DEVCOREDUMP_CODE_HW_ERR            0x02
> >  #define RTK_DEVCOREDUMP_CODE_CMD_TIMEOUT       0x03
> > @@ -4451,6 +4469,7 @@ static int btusb_probe(struct usb_interface *intf=
,
> >                 /* Transport specific configuration */
> >                 hdev->send =3D btusb_send_frame_intel;
> >                 hdev->cmd_timeout =3D btusb_intel_cmd_timeout;
> > +               hdev->classify_pkt_type =3D btusb_intel_classify_pkt_ty=
pe;
> >
> >                 if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
> >                         btintel_set_flag(hdev, INTEL_ROM_LEGACY_NO_WBS_=
SUPPORT);
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 9231396fe96f..7b7068a84ff7 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -649,6 +649,7 @@ struct hci_dev {
> >         int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
> >                                      struct bt_codec *codec, __u8 *vnd_=
len,
> >                                      __u8 **vnd_data);
> > +       u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *s=
kb);
> >  };
> >
> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index b3ee9ff17624..8b817a99cefd 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2941,15 +2941,31 @@ int hci_reset_dev(struct hci_dev *hdev)
> >  }
> >  EXPORT_SYMBOL(hci_reset_dev);
> >
> > +static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_bu=
ff *skb)
> > +{
> > +       if (hdev->classify_pkt_type)
> > +               return hdev->classify_pkt_type(hdev, skb);
> > +
> > +       return hci_skb_pkt_type(skb);
> > +}
> > +
> >  /* Receive frame from HCI drivers */
> >  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
> >  {
> > +       u8 dev_pkt_type;
> > +
> >         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
> >                       && !test_bit(HCI_INIT, &hdev->flags))) {
> >                 kfree_skb(skb);
> >                 return -ENXIO;
> >         }
> >
> > +       /* Check if the driver agree with packet type classification */
> > +       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev, skb);
> > +       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
> > +               hci_skb_pkt_type(skb) =3D dev_pkt_type;
> > +       }
> > +
> >         switch (hci_skb_pkt_type(skb)) {
> >         case HCI_EVENT_PKT:
> >                 break;
> > --
> > 2.45.1.288.g0e0cd299f1-goog
> >
>
>
> --
> Luiz Augusto von Dentz
