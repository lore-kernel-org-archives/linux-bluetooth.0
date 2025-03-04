Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D76259C98
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113013; cv=pass; b=XtwrjVRUQwlnp8HuGWoyuo4UPDhWhEZ4oPGUNPgSr4jn743p0xXQLnkpDqIFrfhLBISns4ztT7nO3kAuMEZXTh7rtFm5gb/QJcGUc6SLJ7qtyBZ7l6gqH4Pt+e5fhcneLCMUhW30fXVJwUFX7S4SEjG9O4rRI4TTPvvjDqBQM+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113013; c=relaxed/simple;
	bh=QHrC3GOPyDDLh169uJi1RnFnqRvlY7q5f5p9kWwcyPc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+b2nH/u3P+NJyG44MW2+fW5m/Luh2FJeL9ehyvYoeEa1tq/tRmHODAbSg/G9D2oMMUEAuu3KDfi01BJ92SllMqb6JMnseejacl7a2cjex9dmodaPTtKntpxDvO8m6xrGtdnUGKwDDolKW0wWEo3hhmVjW9/6etxMD/Abb8lb+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=cMMEqx2K; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="cMMEqx2K"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z6kkR3kD5z49Psm;
	Tue,  4 Mar 2025 20:30:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741113007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fhWXWPjpiM1PvduPNsuplUbANGf+WUo8Z0p4WC6CIOQ=;
	b=cMMEqx2K25mx9Bal6XM6+E/xh/Dh7OnKssY8NRqkopxcy6iyBBgMLCab4x7qVOyHudnH45
	KL2MboisFsV23piCUG561CEwJNWpzsIcnutGjquv0H3E6BcBhVccxip+ppx7vLRt32XQlY
	9niWC5x4Ie40Mixu547DXLXxb8Efnl5tTdl1uTdyGiDbgKZdueZ3xXbvhASVAoyhNkGLrf
	i4Mo03PjVXWCZZ2J6SJJ7P64b+z7a+j4YeThyaYVx6ucUpPfJdgRL1+UZTSPnF2QBgBd44
	cLQv3RJdDT9Q8tV1vV2J5nRsCfSfn2kQHf8Tw4tBcThDLcCamF22cU9MUkE7SA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741113007; a=rsa-sha256;
	cv=none;
	b=lrLkqH7AtYJbo4l4eD9gJLg88T3KbB2oZYklZ2vIXi2ERxi6DqW3BASa8BzdPS8RV3jv6s
	sK2JPaOpBLMlPHrMs5IGAENhV9M4FM28J43GtsuvZL/eoSQ86BHPrPJI8Wtcfd3AVSNka2
	J3cmNwnnU+SSb+Up9znpJ2Z2p/81uNm+rNXRbpAMw3+keYMhM6szGIbPTybFN5uZJK7abq
	YgmdtQUsQLwChdcKGBWQI0jzZMTUDXQM0gX2X2qNsXkIXl3RgHkW8/TBF57bLLIP+Ai7FP
	OMdOve9z8vssyDnXnmQj9utjUgpiEWu4rTzRoMfhvsMUXKdu3ZWHgzcd5/s4OA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741113007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fhWXWPjpiM1PvduPNsuplUbANGf+WUo8Z0p4WC6CIOQ=;
	b=fk3DGIDGq46wXPVTnqpPn/pOkGKim6rV8qK6/iiIhbpJSygNCyIjbFpITt+Xds7g0xvlZc
	RNZLQvRKyuN8em1bOEGjFJ304k0Ezb8SnymbQBrdqk0ZSXMsukNiYLfnFesCLBwSvc/HbM
	KoE7VccnqH0CiD1ZrDleDeLu9a81Ygc4KX4XhTmtDTbPfxNtPAG4azpJnvYX4Gnyx1kKpx
	4c2EBVqDE22VQc3SIv0LJeQ9JCBAFtXUf33o22gaTK6O8hiCVScnQZqs1JtuIArGjdRVlm
	QwKqNCRGgNnAJL2Wca7QUpaTriWgo6D30fQsLr/O0N6oDUu/xtK2X6m/lB1Ygg==
Message-ID: <ccded4b8858f3455c832229fd26f63795f5a3030.camel@iki.fi>
Subject: Re: [PATCH v4] Bluetooth: hci_core: Enable buffer flow control for
 SCO/eSCO
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 04 Mar 2025 20:30:06 +0200
In-Reply-To: <20250304162955.149884-1-luiz.dentz@gmail.com>
References: <20250304162955.149884-1-luiz.dentz@gmail.com>
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

ti, 2025-03-04 kello 11:29 -0500, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This enables buffer flow control for SCO/eSCO
> (see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable),
> recently this has caused the following problem and is actually a nice
> addition for the likes of Socket TX complete:
>=20
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
>=20
> Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci.h      |  6 ++++++
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 28 ++++++++++++++++++++++++++++
>  net/bluetooth/hci_sync.c         | 23 +++++++++++++++++++++++
>  4 files changed, 58 insertions(+)
>=20
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index b99818df8ee7..70169533c940 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -448,6 +448,7 @@ enum {
>  	HCI_WIDEBAND_SPEECH_ENABLED,
>  	HCI_EVENT_FILTER_CONFIGURED,
>  	HCI_PA_SYNC,
> +	HCI_SCO_FLOWCTL,
> =20
>  	HCI_DUT_MODE,
>  	HCI_VENDOR_DIAG,
> @@ -1544,6 +1545,11 @@ struct hci_rp_read_tx_power {
>  	__s8     tx_power;
>  } __packed;
> =20
> +#define HCI_OP_WRITE_SYNC_FLOWCTL	0x0c2f
> +struct hci_cp_write_sync_flowctl {
> +	__u8     enable;
> +} __packed;
> +
>  #define HCI_OP_READ_PAGE_SCAN_TYPE	0x0c46
>  struct hci_rp_read_page_scan_type {
>  	__u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 2f320eeddfec..cf18cf65fe5e 100644
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
> index e7ec12437c8b..63eec8b80ff1 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3564,11 +3564,25 @@ static void hci_sched_sco(struct hci_dev *hdev)
>  			BT_DBG("skb %p len %d", skb, skb->len);
>  			hci_send_frame(hdev, skb);
> =20
> +			hdev->sco_cnt--;
>  			conn->sent++;
>  			if (conn->sent =3D=3D ~0)
>  				conn->sent =3D 0;
>  		}
>  	}
> +
> +	/* Restore sco_cnt if flow control has not been enabled as
> +	 * HCI_EV_NUM_COMP_PKTS won't be generated.
> +	 */
> +	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL)) {
> +		hdev->sco_cnt =3D hdev->sco_pkts;
> +
> +		/* As flow control is disabled force tx_work to run if there are
> +		 * still packets left in the queue.
> +		 */
> +		if (conn && !skb_queue_empty(&conn->data_q))

conn may be uninitialized pointer here (if sco_cnt =3D=3D 0 when entering
function).

I think this should be doing something like

	if (hci_low_sent(hdev, SCO_LINK, &quote))
		...

otherwise some other conn than that last seen in the loop may still
have data to send.

> +			queue_work(hdev->workqueue, &hdev->tx_work);
>
> +	}
>  }
> =20
>  static void hci_sched_esco(struct hci_dev *hdev)
> @@ -3588,11 +3602,25 @@ static void hci_sched_esco(struct hci_dev *hdev)
>  			BT_DBG("skb %p len %d", skb, skb->len);
>  			hci_send_frame(hdev, skb);
> =20
> +			hdev->sco_cnt--;
>  			conn->sent++;
>  			if (conn->sent =3D=3D ~0)
>  				conn->sent =3D 0;
>  		}
>  	}
> +
> +	/* Restore sco_cnt if flow control has not been enabled as
> +	 * HCI_EV_NUM_COMP_PKTS won't be generated.
> +	 */
> +	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL)) {
> +		hdev->sco_cnt =3D hdev->sco_pkts;
> +
> +		/* As flow control is disabled force tx_work to run if there are
> +		 * still packets left in the queue.
> +		 */
> +		if (!skb_queue_empty(&conn->data_q))

Same here.

> +			queue_work(hdev->workqueue, &hdev->tx_work);
> +	}
>  }
> =20
>  static void hci_sched_acl_pkt(struct hci_dev *hdev)
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c4c2cf51b219..aaa6164fc3e3 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3769,6 +3769,27 @@ static int hci_write_ca_timeout_sync(struct hci_de=
v *hdev)
>  				     sizeof(param), &param, HCI_CMD_TIMEOUT);
>  }
> =20
> +/* Enable SCO flow control if supported */
> +static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
> +{
> +	struct hci_cp_write_sync_flowctl cp;
> +	int err;
> +
> +	/* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLOWCTL *=
/
> +	if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
> +		return 0;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.enable =3D 0x01;
> +
> +	err =3D __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
> +				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +	if (!err)
> +		hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
> +
> +	return err;
> +}
> +
>  /* BR Controller init stage 2 command sequence */
>  static const struct hci_init_stage br_init2[] =3D {
>  	/* HCI_OP_READ_BUFFER_SIZE */
> @@ -3787,6 +3808,8 @@ static const struct hci_init_stage br_init2[] =3D {
>  	HCI_INIT(hci_clear_event_filter_sync),
>  	/* HCI_OP_WRITE_CA_TIMEOUT */
>  	HCI_INIT(hci_write_ca_timeout_sync),
> +	/* HCI_OP_WRITE_SYNC_FLOWCTL */
> +	HCI_INIT(hci_write_sync_flowctl_sync),
>  	{}
>  };
> =20

--=20
Pauli Virtanen
