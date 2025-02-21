Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B232505D3
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163928; cv=pass; b=u+BoQ+Dg5cGdWtXZWzFRi5PxQdFS3zqorDnXCfqX0By/0jldwa0HooutdlQ0OK1eMpS82Enjc45kVdPlfJVSJ+2eH96tOeonj0LkLIdU8WKySFt954YaTwQb0YWrRNQq8TuZ8FkwCTx8SO0QWEDobve/6wlPxApgbyBFFLtzYwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163928; c=relaxed/simple;
	bh=Jcm3UZf/wDHgleC/V3q3ZjoF3pj7wjaS1JRxT3wQAKY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhBRdqvwmybmi8qq/V89GPDFExL8nHLpWDepvr5Js0xqS8f2JkOaxJ8i5V65QHMeVRNT3LBSKKyOYr+yziaFgvynF2YAZwcexF3hjp0mCf4Wc1fZ8nP80YQarmdmkNYilr0j+3uzmMgnOlA6OoOaCRQhjQAaGlPzIXKUDsFhXJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=b69DK0qA; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="b69DK0qA"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Yzzkg4KTzz49QB3;
	Fri, 21 Feb 2025 20:51:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740163915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GpnGQuIBVONVeYCclHBfB3bZxHcjNJ41wa/r+ZPYAyE=;
	b=b69DK0qANLf7NvHVyzDNh+laZc9KuEXhDoHgw7CwBQu7RekfEM8ksJopUVvjjG81wFjm+M
	2UHCdWrCkFQ4h0hVju/9RJxCjA4ZX3g2CGas53sFVrS8A/SAian9QTjH5C0z9RXDgmAJKe
	hiadeC1ajDRBs4lSp4IhZqGztkbUY9ymocXquBj0kLLHBoPVuw6lhDciwZs+zwgu4onafG
	z60/LdumSbW9pWl/Vz4xyM2r558OWtmyVreG2aSH/jkywRrMCrVmaCgVuaP5+dDyTrbm0G
	c+rGAx1Wc/ZDY4B6tsw4e0Fq1Sdz7FDyG2XCWNHRmAJLz7FaQGs4oFRL7DUyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740163915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GpnGQuIBVONVeYCclHBfB3bZxHcjNJ41wa/r+ZPYAyE=;
	b=lorRfl8a2kgDfd2eP9qfgkFKsRw+RLFjdq3EmN4rJXfaKqdlnG4kPMYqfuUpmqjIbH/X5F
	TC2WYzDw26LdE9Y+anRUlVJZw7wUZ6aAlqG7oWgdbhHcNCXsWTryA7Kr9A3SrgbK1PNYTM
	BOTs0fhponJ9+Q/aJO06zhDzE0np82UNgx8K9rLu4MJpUw8tlWe0RP+L0ogAbVJoyMA4Iy
	uVquamgqFmkwppVQeLrrrvlgKa45RnTiRT6aWmW3M4RH5C8D/TOIOJTuWKhwR3Z+9yJEdV
	7ziwlgHn+Gxes/VJqYmwneUwYvT7GulCL7PW0ZORU1QK7Ge/je/5A3ipKs0tQA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740163915; a=rsa-sha256;
	cv=none;
	b=Ppf0gjWsvkl9GYB7w/QsFP+oqXh/iFAwWwVPWqnmP82pkl2jCarIGu51DnsV4E2q0hN3Xd
	FViyl1eGnTJ3RyW5b+BT/WZ9TE0eOngPyxP67353QJHyyufDx2WxOzN7R4H0iGi9hik2Br
	ZwViFwdhrZLc/AMU3nMAPHoGCd10jVq9U5vadyL0APbdBV0fAk7C3/C9hmU8EtUA6/JECe
	8/+SYBgrfyS2jkdP8YWJQEY8+BfBqIHe8IxgDPEOb4ykkxRUZV7biJwbFLi2ks60qdBp2Y
	/mkhIQY+CT8uzeKqj/eXKNwMSBydEYQXjGJPmi/2ts+CFZu/xeDxDIwhbkoz3g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <a8bc82f46e64e060cc3469f3db97f453f70ec871.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Enable buffer flow control for
 SCO/eSCO
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Fri, 21 Feb 2025 20:51:54 +0200
In-Reply-To: <CABBYNZK+GhCuRQApr4F81Y3a4a4KzuJ2nNPJ=wN+4EhBOJ1RCw@mail.gmail.com>
References: <20250220215727.2035833-1-luiz.dentz@gmail.com>
	 <CABBYNZK+GhCuRQApr4F81Y3a4a4KzuJ2nNPJ=wN+4EhBOJ1RCw@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2025-02-20 kello 16:59 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Thu, Feb 20, 2025 at 4:57=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >=20
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >=20
> > This enables buffer flow control for SCO/eSCO
> > (see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable),
> > recently this has caused the following problem and is actually a nice
> > addition for the likes of Socket TX complete:

I tested this on Intel AX210 (current firmware) -- it doesn't seem to
work:

< HCI Command: Write Sync Flow Control Enable (0x03|0x002f) plen 1         =
                         #43 [hci0] 7.611473
        Flow control: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                =
                         #44 [hci0] 7.612831
      Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
        Status: Success (0x00)
...
> SCO Data RX: Handle 257 flags 0x00 dlen 48                               =
                       #494 [hci0] 21.120883
> SCO Data RX: Handle 257 flags 0x00 dlen 48                               =
                       #495 [hci0] 21.120883
wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48            =
                       #496 [hci0] 21.131190
wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48            =
                       #497 [hci0] 21.131272
> SCO Data RX: Handle 257 flags 0x00 dlen 48                               =
                       #498 [hci0] 21.132282
> SCO Data RX: Handle 257 flags 0x00 dlen 48                               =
                       #499 [hci0] 21.132287
> SCO Data RX: Handle 257 flags 0x00 dlen 48                               =
                       #500 [hci0] 21.132288
> SCO Data RX: Handle 257 flags 0x00 dlen 48                               =
                       #501 [hci0] 21.132288
wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48            =
                       #502 [hci0] 21.137072
wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48            =
                       #503 [hci0] 21.137144
> SCO Data RX: Handle 257 flags 0x00 dlen 48                               =
                       #504 [hci0] 21.140898
> SCO Data RX: Handle 257 flags 0x00 dlen 48                               =
                       #505 [hci0] 21.140903
> SCO Data RX: Handle 257 flags 0x00 dlen 48                               =
                       #506 [hci0] 21.140903
wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48            =
                       #507 [hci0] 21.142969
wireplumber[1533]: < SCO Data TX: Handle 257 flags 0x00 dlen 48            =
                       #508 [hci0] 21.143108
> SCO Data RX: Handle 257 flags 0x00 dlen 48                               =
                       #509 [hci0] 21.150848
> SCO Data RX: Handle 257 flags 0x00 dlen 48                               =
                       #510 [hci0] 21.150854

No Number of Completed Packets are generated for SCO Data TX, so it
gets stuck here and no sound output.

Same situation with Realtek 8761BU.

Maybe that hardware does not seem to be implementing this as required
in spec, is the reason why flow control for SCO was not enabled?

> >=20
> > < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > > HCI Event: Command Complete (0x0e) plen 11
> >       Read Buffer Size (0x04|0x0005) ncmd 1
> >         Status: Success (0x00)
> >         ACL MTU: 1021 ACL max packet: 5
> >         SCO MTU: 240  SCO max packet: 8
> > ...
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > > HCI Event: Hardware Error (0x10) plen 1
> >         Code: 0x0a
> >=20
> > Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/hci.h      |  6 ++++++
> >  include/net/bluetooth/hci_core.h |  1 +
> >  net/bluetooth/hci_core.c         | 15 +++++++++++++++
> >  net/bluetooth/hci_sync.c         | 23 +++++++++++++++++++++++
> >  4 files changed, 45 insertions(+)
> >=20
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 0d51970d809f..a6a375cf97f9 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -432,6 +432,7 @@ enum {
> >         HCI_WIDEBAND_SPEECH_ENABLED,
> >         HCI_EVENT_FILTER_CONFIGURED,
> >         HCI_PA_SYNC,
> > +       HCI_SCO_FLOWCTL,
> >=20
> >         HCI_DUT_MODE,
> >         HCI_VENDOR_DIAG,
> > @@ -1528,6 +1529,11 @@ struct hci_rp_read_tx_power {
> >         __s8     tx_power;
> >  } __packed;
> >=20
> > +#define HCI_OP_WRITE_SYNC_FLOWCTL      0x0c2f
> > +struct hci_cp_write_sync_flowctl {
> > +       __u8     enable;
> > +} __packed;
> > +
> >  #define HCI_OP_READ_PAGE_SCAN_TYPE     0x0c46
> >  struct hci_rp_read_page_scan_type {
> >         __u8     status;
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index f756fac95488..6abe1115fa92 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1857,6 +1857,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> >  #define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD)
> >  #define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIFF)
> >  #define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK)
> > +#define lmp_sco_capable(dev)       ((dev)->features[0][1] & LMP_SCO)
> >  #define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI_I=
NQ)
> >  #define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO)
> >  #define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO_B=
REDR))
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index e7ec12437c8b..a0a14fb8a496 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3564,11 +3564,19 @@ static void hci_sched_sco(struct hci_dev *hdev)
> >                         BT_DBG("skb %p len %d", skb, skb->len);
> >                         hci_send_frame(hdev, skb);
> >=20
> > +
> > +                       hdev->sco_cnt--;
> >                         conn->sent++;
> >                         if (conn->sent =3D=3D ~0)
> >                                 conn->sent =3D 0;
> >                 }
> >         }
> > +
> > +       /* Restore sco_cnt if flow control has not been enabled as
> > +        * HCI_EV_NUM_COMP_PKTS won't be generated.
> > +        */
> > +       if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))

I think this check is inverted.

> > +               hdev->sco_cnt =3D hdev->sco_pkts;

If there are unsent SCO skbs in the queue, I think they are not
guaranteed to be sent here.

hdev->tx_work would need to be queued for this to run again. With
FLOWCTL this is guaranteed by hci_num_comp_pkts_evt(), but without it's
not.

Maybe without flowctl this should use the old behavior, like:
=09
	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
		hdev->sco_cnt =3D hdev->sco_pkts;

	while (hdev->sco_cnt && (conn =3D hci_low_sent(hdev, ESCO_LINK,
	...
			if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
				hdev->sco_cnt--;

> >  }
> >=20
> >  static void hci_sched_esco(struct hci_dev *hdev)
> > @@ -3588,11 +3596,18 @@ static void hci_sched_esco(struct hci_dev *hdev=
)
> >                         BT_DBG("skb %p len %d", skb, skb->len);
> >                         hci_send_frame(hdev, skb);
> >=20
> > +                       hdev->sco_cnt--;
> >                         conn->sent++;
> >                         if (conn->sent =3D=3D ~0)
> >                                 conn->sent =3D 0;
> >                 }
> >         }
> > +
> > +       /* Restore sco_cnt if flow control has not been enabled as
> > +        * HCI_EV_NUM_COMP_PKTS won't be generated.
> > +        */
> > +       if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> > +               hdev->sco_cnt =3D hdev->sco_pkts;
> >  }
> >=20
> >  static void hci_sched_acl_pkt(struct hci_dev *hdev)
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index dd770ef5ec36..42ee9c5e11ad 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3766,6 +3766,27 @@ static int hci_write_ca_timeout_sync(struct hci_=
dev *hdev)
> >                                      sizeof(param), &param, HCI_CMD_TIM=
EOUT);
> >  }
> >=20
> > +/* Enable SCO flow control if supported */
> > +static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
> > +{
> > +       struct hci_cp_write_sync_flowctl cp;
> > +       int err;
> > +
> > +       /* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_F=
LOWCTL */
> > +       if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
> > +               return 0;
> > +
> > +       memset(&cp, 0, sizeof(cp));
> > +       cp.enable =3D 0x01;
> > +
> > +       err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
> > +                                   sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +       if (!err)
> > +               hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
> > +
> > +       return err;
> > +}
> > +
> >  /* BR Controller init stage 2 command sequence */
> >  static const struct hci_init_stage br_init2[] =3D {
> >         /* HCI_OP_READ_BUFFER_SIZE */
> > @@ -3784,6 +3805,8 @@ static const struct hci_init_stage br_init2[] =3D=
 {
> >         HCI_INIT(hci_clear_event_filter_sync),
> >         /* HCI_OP_WRITE_CA_TIMEOUT */
> >         HCI_INIT(hci_write_ca_timeout_sync),
> > +       /* HCI_OP_WRITE_SYNC_FLOWCTL */
> > +       HCI_INIT(hci_write_sync_flowctl_sync),
> >         {}
> >  };
> >=20
> > --
> > 2.48.1
> >=20
>=20
> Let me know if this addresses your concerns, I figure this was why we
> could not track packet completion of SCO/eSCO so I guess it is a plus
> if we can finally enable it across all sockets.
>=20

