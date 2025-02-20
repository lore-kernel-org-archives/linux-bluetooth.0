Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724CE264F81
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088810; cv=none; b=ONW87d/SrdlwevVhoj44Bw9jpeZHURnLvQaYoqNoDwB0G2aQhAX3H9FtggErZe4rKhtnAHmHqGpaD3TaH4+/xQbyYdtPDIipNoFv+nrPk2Hj011fVtvjoRh5ioUuQqx9kVQZDi7utHKeA32bTuuaLoqNfLqohZT8FScTDwOUD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088810; c=relaxed/simple;
	bh=EHiCBK/B98tY3fV7OWCIHW+DFZxPtYJNoF7w4fIYPVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LFaEXJ2dyRDhi3hbPVfhBy0OVLBUB+GF/StnSXaHgnYCeIIGCv1mlcYEETp14dHLi3ptyRm+GxaqU9u6XCE7BlXe4QMwEvypPPUfOefnknFzA5CXanv7bUYc5XD7jBgPfJbqgwtwLzEy6wubzfUG7iTrE0pckLAQMmrFBCxaJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsNwnwn5; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsNwnwn5"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30930b0b420so12704281fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 14:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740088806; x=1740693606; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrvheOtxbTohsvw/bwM6vnV0Xj4sMpMamNt4e4j7V0s=;
        b=GsNwnwn5fUemliha6JL5a9lSapq8u/pxf8TrW3LaUfu/c+d1YoFuXOydMgXTMZrX+9
         pMDOFFhNQV++BzVy1cwMpXD63XSoZF/aNEYLvyw9gXUwQjatDbp9OBHDjspfFedJNv2g
         eZngziTS2F8TGld/0HMSGn/mmJ9psApi1izCss5CayYkY4SGwLINHomQZChcOrm0a9Kb
         8GeEfMKO6kdQAAA8pTJOhwgTdfK7jiOgGy7Dx1hGgvWMYpDKfzvhEM/pB5LGDvgQGUzv
         liem7Ou16qbUtaFOhAbnchFRl7ljcDmNmJOQqHEsVcbQ6s0arNj+cjL2asc3Q4VFTxYM
         YqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740088806; x=1740693606;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrvheOtxbTohsvw/bwM6vnV0Xj4sMpMamNt4e4j7V0s=;
        b=sK2PbzAD9iYk9HCQ9Tm6hLXNoAGYbv/mnd2neEnizgbijG8XhHysEC+83xIg1EXScM
         owqJrDwOL2Qq4UdL1cg0CJzIuNyD3qyJLhbKBTtWm09APMNr/ViCYcEHtVgqf2J8DWg+
         f/lMnUZ8o2v73zWv9b7Xnyuxvw4kDBU1OYkSxTA05NP2ZUsZOweHo8NhcjyQbFoPwEhb
         sSD1Ej61u6TS3Lcx+mowuarwEzTwwEqbC9P7g82fnF2ymAPH2hLmTIogDSf6nZhdJGd/
         IJXCYXljNSJhrxBEkNGGH/WXR9+j3QmRqlO6tBHUrokJD/NNxKY9IKGmNuSlP1M0nj9F
         IMEw==
X-Gm-Message-State: AOJu0YwRc5Lv0M7367JpPhKqcqw6xKSVYBBMbGqhngbVvEo5nOQBQFi+
	cYRp7cKg3VR1QLnv3C6hpwzGI+4hAXFPyITXIGBwZkU9/ZBTD3AsrOrppi45YorGLoxT4yOSf4Z
	61fn8Ag4OQeFw6uHGd9R72STUbT92c1pQ
X-Gm-Gg: ASbGncs58j5Lep1vfVvrA2UQLmY756jwplt4fXb91xgwTnuHk6yPTSi5w2ZuEXbK57R
	fCk1NBRnNaJ6NgsHhi/hriBctowyium7PpWKL39h3dwuPzh8W+1b90iBFQYq0AK1zKORgW8Np6A
	==
X-Google-Smtp-Source: AGHT+IE6eaIWRxyUHJVxN6Mf3FaSuki4OdXlNAD4memfPf8PZqbDL6rtqtbxX+cWDeYWXoCjusgYmLy8yqxwWoy+nmo=
X-Received: by 2002:a2e:b006:0:b0:308:f01f:182c with SMTP id
 38308e7fff4ca-30a59898391mr2315151fa.12.1740088805326; Thu, 20 Feb 2025
 14:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220215727.2035833-1-luiz.dentz@gmail.com>
In-Reply-To: <20250220215727.2035833-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Feb 2025 16:59:52 -0500
X-Gm-Features: AWEUYZmlw8z5TRcRAxEsjVw5t0yre7Xtjx0d_bbx98G1eqSKEDT1ruC6-D2betY
Message-ID: <CABBYNZK+GhCuRQApr4F81Y3a4a4KzuJ2nNPJ=wN+4EhBOJ1RCw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
To: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Feb 20, 2025 at 4:57=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This enables buffer flow control for SCO/eSCO
> (see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable),
> recently this has caused the following problem and is actually a nice
> addition for the likes of Socket TX complete:
>
> < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > HCI Event: Command Complete (0x0e) plen 11
>       Read Buffer Size (0x04|0x0005) ncmd 1
>         Status: Success (0x00)
>         ACL MTU: 1021 ACL max packet: 5
>         SCO MTU: 240  SCO max packet: 8
> ...
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > HCI Event: Hardware Error (0x10) plen 1
>         Code: 0x0a
>
> Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci.h      |  6 ++++++
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 15 +++++++++++++++
>  net/bluetooth/hci_sync.c         | 23 +++++++++++++++++++++++
>  4 files changed, 45 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0d51970d809f..a6a375cf97f9 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -432,6 +432,7 @@ enum {
>         HCI_WIDEBAND_SPEECH_ENABLED,
>         HCI_EVENT_FILTER_CONFIGURED,
>         HCI_PA_SYNC,
> +       HCI_SCO_FLOWCTL,
>
>         HCI_DUT_MODE,
>         HCI_VENDOR_DIAG,
> @@ -1528,6 +1529,11 @@ struct hci_rp_read_tx_power {
>         __s8     tx_power;
>  } __packed;
>
> +#define HCI_OP_WRITE_SYNC_FLOWCTL      0x0c2f
> +struct hci_cp_write_sync_flowctl {
> +       __u8     enable;
> +} __packed;
> +
>  #define HCI_OP_READ_PAGE_SCAN_TYPE     0x0c46
>  struct hci_rp_read_page_scan_type {
>         __u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index f756fac95488..6abe1115fa92 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1857,6 +1857,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>  #define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD)
>  #define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIFF)
>  #define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK)
> +#define lmp_sco_capable(dev)       ((dev)->features[0][1] & LMP_SCO)
>  #define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI_INQ=
)
>  #define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO)
>  #define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO_BRE=
DR))
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e7ec12437c8b..a0a14fb8a496 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3564,11 +3564,19 @@ static void hci_sched_sco(struct hci_dev *hdev)
>                         BT_DBG("skb %p len %d", skb, skb->len);
>                         hci_send_frame(hdev, skb);
>
> +
> +                       hdev->sco_cnt--;
>                         conn->sent++;
>                         if (conn->sent =3D=3D ~0)
>                                 conn->sent =3D 0;
>                 }
>         }
> +
> +       /* Restore sco_cnt if flow control has not been enabled as
> +        * HCI_EV_NUM_COMP_PKTS won't be generated.
> +        */
> +       if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> +               hdev->sco_cnt =3D hdev->sco_pkts;
>  }
>
>  static void hci_sched_esco(struct hci_dev *hdev)
> @@ -3588,11 +3596,18 @@ static void hci_sched_esco(struct hci_dev *hdev)
>                         BT_DBG("skb %p len %d", skb, skb->len);
>                         hci_send_frame(hdev, skb);
>
> +                       hdev->sco_cnt--;
>                         conn->sent++;
>                         if (conn->sent =3D=3D ~0)
>                                 conn->sent =3D 0;
>                 }
>         }
> +
> +       /* Restore sco_cnt if flow control has not been enabled as
> +        * HCI_EV_NUM_COMP_PKTS won't be generated.
> +        */
> +       if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> +               hdev->sco_cnt =3D hdev->sco_pkts;
>  }
>
>  static void hci_sched_acl_pkt(struct hci_dev *hdev)
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index dd770ef5ec36..42ee9c5e11ad 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3766,6 +3766,27 @@ static int hci_write_ca_timeout_sync(struct hci_de=
v *hdev)
>                                      sizeof(param), &param, HCI_CMD_TIMEO=
UT);
>  }
>
> +/* Enable SCO flow control if supported */
> +static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
> +{
> +       struct hci_cp_write_sync_flowctl cp;
> +       int err;
> +
> +       /* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLO=
WCTL */
> +       if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
> +               return 0;
> +
> +       memset(&cp, 0, sizeof(cp));
> +       cp.enable =3D 0x01;
> +
> +       err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
> +                                   sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +       if (!err)
> +               hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
> +
> +       return err;
> +}
> +
>  /* BR Controller init stage 2 command sequence */
>  static const struct hci_init_stage br_init2[] =3D {
>         /* HCI_OP_READ_BUFFER_SIZE */
> @@ -3784,6 +3805,8 @@ static const struct hci_init_stage br_init2[] =3D {
>         HCI_INIT(hci_clear_event_filter_sync),
>         /* HCI_OP_WRITE_CA_TIMEOUT */
>         HCI_INIT(hci_write_ca_timeout_sync),
> +       /* HCI_OP_WRITE_SYNC_FLOWCTL */
> +       HCI_INIT(hci_write_sync_flowctl_sync),
>         {}
>  };
>
> --
> 2.48.1
>

Let me know if this addresses your concerns, I figure this was why we
could not track packet completion of SCO/eSCO so I guess it is a plus
if we can finally enable it across all sockets.

--=20
Luiz Augusto von Dentz
