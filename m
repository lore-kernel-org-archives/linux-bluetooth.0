Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740E2F28
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741731703; cv=pass; b=kBoAo77Q08Zc+8BOPiKc857iC54ieHQa7jCgXaqwNiCUKExMZ3bSIluyhTOQ2Ho93cObzHdCvZfXjql4rg2rmuJxkIcHIol7C61UOcRlrvFg12tQWsR+YqzlkkymQAlyTd3m+T/6r+HivnVlUXM0Ed1+2RsIVssQ+SecYXSUFhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741731703; c=relaxed/simple;
	bh=8eWDMvPxnO+85YjwhuPuTi+iqZqvOr0TtfoFT4Tio8A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IPzqQ+dIGZ9OJoqjpvvIEq0Qx516aWdtGFqFQaejUFA5ke8fDDIwrTurlbu2I1uD+7xnstbT7gwe0A21qB+mTHQEyTASCaM4zIrUb0Aw3A7+LKOCFzMk9v2uPbMcOZs86eT4oq9evPqJD1jtDSFhkSeo6bfgr0cJBRWa260kjJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=USNiQWlX; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="USNiQWlX"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZC7XC1SLJz49Q32;
	Wed, 12 Mar 2025 00:21:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741731691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QtrqCdzGNyNLqsmUvir19rN4jTEJCwRpobP1EXPvMdU=;
	b=USNiQWlXgjNiCaIgM5oetF0P15XgfiLY7RoYwOoBk2JY5ZK3eGdsHB8EZICjPsJmBWlndi
	cf8ug5zbLdFCMU/D3GYdCtJHbASnOprlQUsYSkUuy/hvnV+S+uV4z7TF7rHlYItgZfJTT+
	yRVMNuukZxpqmSJAYnJMvZfLSbnwyN+0mrMPmN1zSQuq9sSPlj+G0FNLta6d+2Xf5/XeEF
	CgSBPCi1+5ell5Y7ag+z2LXtUBLZ35LMRblRGxZEIfr6XFSBoUlEy0KUjKOLMZi+0HfmmJ
	KGJOneZGTrOj+VbWKcH6JHrFLjRK/7pb9bOW1YpM/lLM6uh/ztUkfmfRLzs8Eg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741731691; a=rsa-sha256;
	cv=none;
	b=BHQiTk0Atau6ucnzZ9pzfLt2IMFXrasgqnErZXbJllzbpulq7rW/2NSrYHpsMAwerqVcZe
	DK4yQyuXz8icxg7oNKUKCa5o04wiSTSpaJz7YKIgy/eAW3gM88NP2omeHPdd8Vk+ntABty
	y7+5cfoMKHgJdgejLkrEVTZ5bbsZQt92fohtAJpJ2vft5PiPMcG2hjmWJzGtgoetITLrlx
	0kj1WWi4FAjyThbkV9Pr4NVuoBmeyvFb5iUpByAMYFMkSe/DEeGyAMkdhJjNLtxw8OM3G4
	0i0WL53Ke1h+4fEqFoiPhUj/P/wPuyYhvR9DprGTqTQ1W+VSc24v3ySqccnb2w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741731691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QtrqCdzGNyNLqsmUvir19rN4jTEJCwRpobP1EXPvMdU=;
	b=ZaOb+aTlrIL+1LGnms+/3LSiVPJl1VUuZvqwDsy0C7xYhlcQ5W0bav9MIOtQa2PxZgyKNO
	d+Z5AC4PAV8DMrg1/d5edIWTxhdxNhBxBKOjEoqt+xRjXOdvpo4wcMyWh8T/9wk9Z576Nm
	e6GQ8nmaP7NM2RVLuKfnLISH3nua5Xm0eYNdOMXIhj+hGtIzhQZwD1+wWwm56ADCOzFgV2
	j4ViKD80pXHyppJ+kVkMKobGbOM+hbleGgWrl69Cmb3H5D1n7a6JWXDuLxDVNXYFvNWFn/
	9V662vvoTZecoaTHbGsn9TaHeRM+C1XbdvG/o8PK+C725nd0SbxvO5zOj360rw==
Message-ID: <a52405aac2e8b90b4fca840f9c606cf1a0085e30.camel@iki.fi>
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_core: Enable buffer flow control
 for SCO/eSCO
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Wed, 12 Mar 2025 00:21:28 +0200
In-Reply-To: <20250311195528.41993-1-luiz.dentz@gmail.com>
References: <20250311195528.41993-1-luiz.dentz@gmail.com>
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

ti, 2025-03-11 kello 15:55 -0400, Luiz Augusto von Dentz kirjoitti:
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
> To fix the code will now attempt to enable buffer flow control:
>=20
> < HCI Command: Write Sync Fl.. (0x03|0x002f) plen 1
>         Flow control: Enabled (0x01)
> > HCI Event: Command Complete (0x0e) plen 4
>       Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
>         Status: Success (0x00)
>=20
> And then test it by sending an empty packet to confirm the controller
> will generate HCI_EV_NUM_COMP_PKTS events:

It's not doing this any more in this version.

>=20
> sco-tester[40]: < SCO Data TX:.. flags 0x00 dlen 9
> > HCI Event: Number of Completed P.. (0x13) plen 5
>         Num handles: 1
>         Handle: 42 Address: 00:AA:01:01:00:00 (Intel Corporation)
>         Count: 1
>         #103: len 10 (40 Kb/s)
>         Latency: 2 msec (2-2 msec ~2 msec)
>=20
> Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci.h      | 13 +++++++
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 67 ++++++++++++++++----------------
>  net/bluetooth/hci_event.c        |  2 +
>  net/bluetooth/hci_sync.c         | 24 ++++++++++++
>  5 files changed, 74 insertions(+), 33 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index b99818df8ee7..3c8f95174fcf 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -208,6 +208,13 @@ enum {
>  	 */
>  	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> =20
> +	/* When this quirk is set consider Sync Flow Control as supported by
> +	 * the driver.
> +	 *
> +	 * This quirk must be set before hci_register_dev is called.
> +	 */
> +	HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED,
> +
>  	/* When this quirk is set, the LE states reported through the
>  	 * HCI_LE_READ_SUPPORTED_STATES are invalid/broken.
>  	 *
> @@ -448,6 +455,7 @@ enum {
>  	HCI_WIDEBAND_SPEECH_ENABLED,
>  	HCI_EVENT_FILTER_CONFIGURED,
>  	HCI_PA_SYNC,
> +	HCI_SCO_FLOWCTL,
> =20
>  	HCI_DUT_MODE,
>  	HCI_VENDOR_DIAG,
> @@ -1544,6 +1552,11 @@ struct hci_rp_read_tx_power {
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
> index 7966db4038cc..f78e4298e39a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1858,6 +1858,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
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
> index 012fc107901a..efba2b539902 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3552,51 +3552,52 @@ static void __check_timeout(struct hci_dev *hdev,=
 unsigned int cnt, u8 type)
>  }
> =20
>  /* Schedule SCO */
> -static void hci_sched_sco(struct hci_dev *hdev)
> +static void hci_sched_sco_type(struct hci_dev *hdev, __u8 type)
>  {
>  	struct hci_conn *conn;
>  	struct sk_buff *skb;
>  	int quote;
> +	unsigned int pkts;
> =20
> -	BT_DBG("%s", hdev->name);
> +	bt_dev_dbg(hdev, "type %u", type);
> =20
> -	if (!hci_conn_num(hdev, SCO_LINK))
> +	if (!hci_conn_num(hdev, type))
>  		return;
> =20
> -	while (hdev->sco_cnt && (conn =3D hci_low_sent(hdev, SCO_LINK, &quote))=
) {
> +	/* Use sco_pkts if flow control has not been enabled yet which will
> +	 * limit the amount of buffer sent in a row.
> +	 */
> +	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> +		pkts =3D hdev->sco_pkts;
> +	else
> +		pkts =3D hdev->sco_cnt;
> +
> +	if (!pkts)
> +		return;
> +
> +	while (pkts && (conn =3D hci_low_sent(hdev, type, &quote))) {
>  		while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {

hci_low_sent -> hci_quote_sent uses the current value of hdev->sco_cnt
to determine `quote`, which can then be larger than pkts, possibly
causing it to underflow here.

I guess this is why the other sched() functions are doing the (*cnt)--
thing.

>  			BT_DBG("skb %p len %d", skb, skb->len);
>  			hci_send_frame(hdev, skb);
> =20
> +			pkts--;
> +
> +			if (hdev->sco_cnt > 0)
> +				hdev->sco_cnt--;
> +
>  			conn->sent++;
>  			if (conn->sent =3D=3D ~0)
>  				conn->sent =3D 0;
>  		}
>  	}
> -}
> =20
> -static void hci_sched_esco(struct hci_dev *hdev)
> -{
> -	struct hci_conn *conn;
> -	struct sk_buff *skb;
> -	int quote;
> -
> -	BT_DBG("%s", hdev->name);
> -
> -	if (!hci_conn_num(hdev, ESCO_LINK))
> -		return;
> -
> -	while (hdev->sco_cnt && (conn =3D hci_low_sent(hdev, ESCO_LINK,
> -						     &quote))) {
> -		while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
> -			BT_DBG("skb %p len %d", skb, skb->len);
> -			hci_send_frame(hdev, skb);
> -
> -			conn->sent++;
> -			if (conn->sent =3D=3D ~0)
> -				conn->sent =3D 0;
> -		}
> -	}
> +	/* Rescheduled if all packets were sent and flow control is not enabled
> +	 * as there could be more packets queued that could not be sent and
> +	 * since no HCI_EV_NUM_COMP_PKTS event will be generated the reschedule
> +	 * needs to be forced.
> +	 */
> +	if (!pkts && !hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
> +		queue_work(hdev->workqueue, &hdev->tx_work);
>  }
> =20
>  static void hci_sched_acl_pkt(struct hci_dev *hdev)
> @@ -3632,8 +3633,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
>  			chan->conn->sent++;
> =20
>  			/* Send pending SCO packets right away */
> -			hci_sched_sco(hdev);
> -			hci_sched_esco(hdev);
> +			hci_sched_sco_type(hdev, SCO_LINK);
> +			hci_sched_sco_type(hdev, ESCO_LINK);
>  		}
>  	}
> =20
> @@ -3688,8 +3689,8 @@ static void hci_sched_le(struct hci_dev *hdev)
>  			chan->conn->sent++;
> =20
>  			/* Send pending SCO packets right away */
> -			hci_sched_sco(hdev);
> -			hci_sched_esco(hdev);
> +			hci_sched_sco_type(hdev, SCO_LINK);
> +			hci_sched_sco_type(hdev, ESCO_LINK);
>  		}
>  	}
> =20
> @@ -3734,8 +3735,8 @@ static void hci_tx_work(struct work_struct *work)
> =20
>  	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
>  		/* Schedule queues and send stuff to HCI driver */
> -		hci_sched_sco(hdev);
> -		hci_sched_esco(hdev);
> +		hci_sched_sco_type(hdev, SCO_LINK);
> +		hci_sched_sco_type(hdev, ESCO_LINK);
>  		hci_sched_iso(hdev);
>  		hci_sched_acl(hdev);
>  		hci_sched_le(hdev);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 19e19c9f5e68..6d0138b778aa 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4445,9 +4445,11 @@ static void hci_num_comp_pkts_evt(struct hci_dev *=
hdev, void *data,
>  			break;
> =20
>  		case SCO_LINK:
> +		case ESCO_LINK:
>  			hdev->sco_cnt +=3D count;
>  			if (hdev->sco_cnt > hdev->sco_pkts)
>  				hdev->sco_cnt =3D hdev->sco_pkts;
> +
>  			break;
> =20
>  		case ISO_LINK:
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c4c2cf51b219..609b035e5c90 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3769,6 +3769,28 @@ static int hci_write_ca_timeout_sync(struct hci_de=
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
> +	if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)) ||
> +	    !test_bit(HCI_QUIRK_SYNC_FLOWCTL_SUPPORTED, &hdev->quirks))
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
> @@ -3787,6 +3809,8 @@ static const struct hci_init_stage br_init2[] =3D {
>  	HCI_INIT(hci_clear_event_filter_sync),
>  	/* HCI_OP_WRITE_CA_TIMEOUT */
>  	HCI_INIT(hci_write_ca_timeout_sync),
> +	/* HCI_OP_WRITE_SYNC_FLOWCTL */
> +	HCI_INIT(hci_write_sync_flowctl_sync),
>  	{}
>  };
> =20

