Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495671BDD3
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879051; cv=pass; b=i0te1RDIvQS6a9knzpzNzL8xOhmh7LuR8I3Vjz/27VyZf+6M5+cBNw4LBmD/Sn1CHnaNEYhh20jgJLj+36w7syipOcqcCwrzUV9eoXtRJNhS//dMHOPTTyywTtRyjtFUTdEVrJyajytF0bDz3R4UdaLy8j+beo1laiwtiqmVYkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879051; c=relaxed/simple;
	bh=CVk5VWpyr2mtT32/V7gL93UfD3Oxzq9171J/FMfc/Eg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GV5NEeT/T6zjx+ouXwUQPR+1NS/8WWrO9t2EHA7Ll5LWdMl/hU6Pq8tXj2fSl+ShpU2FAFv8nBMxUFZmHIeTm3wxznU73eSbqJFQ6AHH3v/41uHquxanf3SfeBVfcROYeO3iRkgTdUNlI70qqCdR7Pr8h1eW1nDbqUmklNT61Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=WiejO6rO; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="WiejO6rO"
Received: from monolith.lan (91-152-121-138.elisa-laajakaista.fi [91.152.121.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VpNSc0lqYzySG;
	Tue, 28 May 2024 09:50:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1716879040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1dgFwgNBVr9rO+MFSDnnpdEAaL5vprlBnsnVS88uqxI=;
	b=WiejO6rOPlJUha3RiFX3YL3WhYOAMOGYbJ2cFOtK5QZiV9vfCGUdpsmMr9gIe+qRkxLTBw
	/Nl6QYoDyQnMjsO46vm3LzPLYxYm0REMKaCc5/nbYxNE4HlAJ5Z6cxCmPcuP6Mxaq0SHLE
	A2TIVj+DuompupUZ4SZcAlgtmo3wnuE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1716879040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1dgFwgNBVr9rO+MFSDnnpdEAaL5vprlBnsnVS88uqxI=;
	b=RVnl/lDVzeuzjwJQS/teJROW/IwAKXgcMzgm+SCf7M0DeGqwq+G6w5gGvA/ZDb/cXChgJT
	YXtEbz/DLQmcCZL9pQfiEcIWd6RFQVS//0nuHQ9caRA17SSUKg2pK1SLEcwqbQ/4qAsqny
	KJmgAukVau4DBfukVKSFia7Ale+E9yU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1716879040; a=rsa-sha256; cv=none;
	b=YEBRBJS9jrAQZVuFqK53iuPQ2493P6FlkaiLdqtPgdCUzvg2K3vgd5LwWFIrQwtZo/aMmW
	zh0C2VVD17klDjJuXDcM/omweCu12/wSBPGOBDZPF9f9eDGfds6nY6sy9fNq2XaRjWqM2S
	Qq4Lkovk8VAQ61+6MLHtv+CK3C8+ag8=
Message-ID: <c8c193b49aaf9419edceab43855fe471071b1382.camel@iki.fi>
Subject: Re: [PATCH v3] Bluetooth: Add vendor-specific packet classification
 for ISO data
From: Pauli Virtanen <pav@iki.fi>
To: Ying Hsu <yinghsu@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 28 May 2024 09:50:39 +0300
In-Reply-To: <CAAa9mD0XeCEkpAa-ms71MAKMVJ9zcT=jOCDO+LeBL8CmaXjagg@mail.gmail.com>
References: <20240524045045.3310641-1-yinghsu@chromium.org>
	 <CAAa9mD0XeCEkpAa-ms71MAKMVJ9zcT=jOCDO+LeBL8CmaXjagg@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2024-05-28 kello 13:38 +0800, Ying Hsu kirjoitti:
> We just found Rx ACL data packets on the INTEL_STP2_AC7265 BT
> controller are using connection handle value >=3D 0x900 (e.g.
> 3585=3D0xe01):
> ```
> > ISO Data RX: Handle 3585 flags 0x02 dlen 16                            =
                            #536 [hci0] 2024-05-28 00:41:23.779341
> ```
>=20
> To mitigate potential issues, we can limit the patch to verified
> models like AX211. What do you think?

How is this verified, is there a data sheet that says these are the
handle ranges? Will it be changed by later firmware updates
(unlikely?)?

>=20
> On Fri, May 24, 2024 at 12:50=E2=80=AFPM Ying Hsu <yinghsu@chromium.org> =
wrote:
> >=20
> > When HCI raw sockets are opened, the Bluetooth kernel module doesn't
> > track CIS/BIS connections. User-space applications have to identify
> > ISO data by maintaining connection information and look up the mapping
> > for each ACL data packet received. Besides, btsnoop log captured in
> > kernel couldn't tell ISO data from ACL data in this case.
> >=20
> > To avoid additional lookups, this patch introduces vendor-specific
> > packet classification for Intel BT controllers to distinguish
> > ISO data packets from ACL data packets.
> >=20
> > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > ---
> > Tested LE audio unicast recording on a ChromeOS device with Intel AX211
> >=20
> > Changes in v3:
> > - Move Intel's classify_pkt_type implementation from btusb.c to btintel=
.c.
> >=20
> > Changes in v2:
> > - Adds vendor-specific packet classificaton in hci_dev.
> > - Keeps reclassification in hci_recv_frame.
> >=20
> >  drivers/bluetooth/btintel.c      | 19 +++++++++++++++++++
> >  drivers/bluetooth/btintel.h      |  6 ++++++
> >  drivers/bluetooth/btusb.c        |  1 +
> >  include/net/bluetooth/hci_core.h |  1 +
> >  net/bluetooth/hci_core.c         | 16 ++++++++++++++++
> >  5 files changed, 43 insertions(+)
> >=20
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index 27e03951e68b..bf1bd2b13c96 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -3187,6 +3187,25 @@ void btintel_secure_send_result(struct hci_dev *=
hdev,
> >  }
> >  EXPORT_SYMBOL_GPL(btintel_secure_send_result);
> >=20
> > +#define BTINTEL_ISODATA_HANDLE_BASE 0x900
> > +
> > +u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb=
)
> > +{
> > +       /*
> > +        * Distinguish ISO data packets form ACL data packets
> > +        * based on their connection handle value range.
> > +        */
> > +       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> > +               __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->handle=
);
> > +
> > +               if (hci_handle(handle) >=3D BTINTEL_ISODATA_HANDLE_BASE=
)
> > +                       return HCI_ISODATA_PKT;
> > +       }
> > +
> > +       return hci_skb_pkt_type(skb);
> > +}
> > +EXPORT_SYMBOL_GPL(btintel_classify_pkt_type);
> > +
> >  MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> >  MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION)=
;
> >  MODULE_VERSION(VERSION);
> > diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> > index 9dbad1a7c47c..4b77eb8d47a8 100644
> > --- a/drivers/bluetooth/btintel.h
> > +++ b/drivers/bluetooth/btintel.h
> > @@ -245,6 +245,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hd=
ev,
> >  int btintel_shutdown_combined(struct hci_dev *hdev);
> >  void btintel_hw_error(struct hci_dev *hdev, u8 code);
> >  void btintel_print_fseq_info(struct hci_dev *hdev);
> > +u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb=
);
> >  #else
> >=20
> >  static inline int btintel_check_bdaddr(struct hci_dev *hdev)
> > @@ -378,4 +379,9 @@ static inline void btintel_hw_error(struct hci_dev =
*hdev, u8 code)
> >  static inline void btintel_print_fseq_info(struct hci_dev *hdev)
> >  {
> >  }
> > +
> > +static inline u8 btintel_classify_pkt_type(struct hci_dev *hdev, struc=
t sk_buff *skb)
> > +{
> > +       return hci_skb_pkt_type(skb);
> > +}
> >  #endif
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 79aefdb3324d..2ecc6d1140a5 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -4451,6 +4451,7 @@ static int btusb_probe(struct usb_interface *intf=
,
> >                 /* Transport specific configuration */
> >                 hdev->send =3D btusb_send_frame_intel;
> >                 hdev->cmd_timeout =3D btusb_intel_cmd_timeout;
> > +               hdev->classify_pkt_type =3D btintel_classify_pkt_type;
> >=20
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
> >=20
> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index b3ee9ff17624..8b817a99cefd 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2941,15 +2941,31 @@ int hci_reset_dev(struct hci_dev *hdev)
> >  }
> >  EXPORT_SYMBOL(hci_reset_dev);
> >=20
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
> >=20
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
> >=20

--=20
Pauli Virtanen
