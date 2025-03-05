Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77896250C1D
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191179; cv=pass; b=YsqXCC/FMB4qsT6Ga95Sw756V8auBwF7rAjJfFOJTT3vLWua0fFrEBe24tkroiusYgagEkLvtaPbh9hk01vOWOV0902bPdFas8MrBHFjAtrgeFBXWrLVFrBucpmdkbO73LNvFGvvfKo1JEZscF7eeNisq/qVO1nGims2b1bd6r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191179; c=relaxed/simple;
	bh=wdxjdse4188d3x8xAPvqU431JlP6L6TdbtUEiChBIBM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k5UngbRahvDzJME5li50lVRPO6+bWfAjWSNO4bTdKmSP4xLM7DB+KqTwGoqZ4y51lHdxYPO3aCrscU4O3RiG9aQADwREyY2sc4+auD+Meicv51HUnsRHvK3hUr/i6+z0PDhFMr6/LSNLJivQCNQdrqr3qIhJFXNriFuhFVW3X6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=EuAUJuU9; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="EuAUJuU9"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z7Hdd0v06z49Px4;
	Wed,  5 Mar 2025 18:12:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741191173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+Dlisg8mcy1XOfVPaXdmheVuxfmul8AbLTXpw82BXjY=;
	b=EuAUJuU9TXZ3wh13KiIBjYDCsKckB0xTxs7Y45c4T4z/tnJsR7dBrj6Q2GpX9ze4kmXq+V
	Peo3fRnGKmx6d7DdBMLrvpbiXTaQqKLZvcRD/IO4lVdRevDK1LvImV/Hoc1/6235lJssLJ
	oCRpyGE5xzB/02NJ7/iBVHGqnou5F/6xVn07k3lZ5TWxkleNYRQ/Y6KahDPvpI8HHM2Vk2
	l0u7H3caTNBHd1Qp7z/hE61OiP9UxZDHbSBVHNgzhxKN/1SPCh0Y6S05QK155TWQ7bVFRY
	CsunHlEFasWPhdPewHBi+xQyQUrBleJSY3SzHiGWDtM5pe2j6RcJwb3g9LGkQg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741191173; a=rsa-sha256;
	cv=none;
	b=T2YUmdzm7sWCp9+xVFELqx423izjHIhCnRW8WTThgFMhPgtQSSricXPRjxD4fB8H+ncRU5
	WDE8+4C8so8lamQU7UJx5KJxVG/oZWmudu0cpFFbiDxgXClinA8qzVdr81+tkZs3Y/Dke8
	622o8kvD3zrOnQyGleJ71luc0Rc/TwsGRwdQz3wisxoCqJzx+R6jAkELKBc90zdH70J6Lu
	KGD8LubMCsMf2TRL2thVWMuGhA462MSC25r2TxXwUKBVzxRpK8HmywvEzf7G4i80BPtf2O
	zykF87IOlVQ5uWkY3qonO7bQZtFQb9GnubYoZo9X5L6IwaYhekF349lbp0On9A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741191173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+Dlisg8mcy1XOfVPaXdmheVuxfmul8AbLTXpw82BXjY=;
	b=GmGljsTx2+sXU0bmcSsxMg2ftIY8umvl7I6PFnxC/FjpnAqi5ADCNgjGOIOwsDXleNt5+f
	5r66xNwue46koowmyxBWJpn3Kdhrh57N1xo0TTdXE5uDzAJONqD5bHCCgsynANBZWgnfJy
	xiR7cYik6pEf4tpwBLnQIPnjydDr9/OqaoMxwrzPVrr2KnmwblyZQjlI83zmQ1TuPhPBNT
	zG6mvHQHWp+WOXMWUPND8X9JjIHTHrADWQrcIU1Hjf99uGRn4Ik/6HCno0Tg1JzZJCCCD4
	87hlM234OUDAh7d1f+3E6928Y2rQrx/SvMO/ZiAO7/XRz6zx5hcirRWuc5FZfw==
Message-ID: <20363765ef52d51f305476fdd698edd4b79bde6d.camel@iki.fi>
Subject: Re: [PATCH v5] Bluetooth: hci_core: Enable buffer flow control for
 SCO/eSCO
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Wed, 05 Mar 2025 18:12:51 +0200
In-Reply-To: <20250304181019.214207-1-luiz.dentz@gmail.com>
References: <20250304181019.214207-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=mQINBGX+qmEBEACt7O4iYRbX80B2OV+LbX06Mj1Wd67SVWwq2sAlI+6fK1YWbFu5jOWFy
 ShFCRGmwyzNvkVpK7cu/XOOhwt2URcy6DY3zhmd5gChz/t/NDHGBTezCh8rSO9DsIl1w9nNEbghUl
 cYmEvIhQjHH3vv2HCOKxSZES/6NXkskByXtkPVP8prHPNl1FHIO0JVVL7/psmWFP/eeB66eAcwIgd
 aUeWsA9+/AwcjqJV2pa1kblWjfZZw4TxrBgCB72dC7FAYs94ebUmNg3dyv8PQq63EnC8TAUTyph+M
 cnQiCPz6chp7XHVQdeaxSfcCEsOJaHlS+CtdUHiGYxN4mewPm5JwM1C7PW6QBPIpx6XFvtvMfG+Ny
 +AZ/jZtXxHmrGEJ5sz5YfqucDV8bMcNgnbFzFWxvVklafpP80O/4VkEZ8Og09kvDBdB6MAhr71b3O
 n+dE0S83rEiJs4v64/CG8FQ8B9K2p9HE55Iu3AyovR6jKajAi/iMKR/x4KoSq9Jgj9ZI3g86voWxM
 4735WC8h7vnhFSA8qKRhsbvlNlMplPjq0f9kVLg9cyNzRQBVrNcH6zGMhkMqbSvCTR5I1kY4SfU4f
 QqRF1Ai5f9Q9D8ExKb6fy7ct8aDUZ69Ms9N+XmqEL8C3+AAYod1XaXk9/hdTQ1Dhb51VPXAMWTICB
 dXi5z7be6KALQARAQABtCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaWtpLmZpPokCWg
 QTAQgARAIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBGrOSfUCZNEJOswAnOS
 aCbhLOrBPBQJl/qsDAhkBAAoJEOSaCbhLOrBPB/oP/1j6A7hlzheRhqcj+6sk+OgZZ+5eX7mBomyr
 76G+m/3RhPGlKbDxKTWtBZaIDKg2c0Q6yC1TegtxQ2EUD4kk7wKoHKj8dKbR29uS3OvURQR1guCo2
 /5kzQQVxQwhIoMdHJYF0aYNQgdA+ZJL09lDz+JC89xvup3spxbKYc9Iq6vxVLbVbjF9Uv/ncAC4Bs
 g1MQoMowhKsxwN5VlUdjqPZ6uGebZyC+gX6YWUHpPWcHQ1TxCD8TtqTbFU3Ltd3AYl7d8ygMNBEe3
 T7DV2GjBI06Xqdhydhz2G5bWPM0JSodNDE/m6MrmoKSEG0xTNkH2w3TWWD4o1snte9406az0YOwkk
 xDq9LxEVoeg6POceQG9UdcsKiiAJQXu/I0iUprkybRUkUj+3oTJQECcdfL1QtkuJBh+IParSF14/j
 Xojwnf7tE5rm7QvMWWSiSRewro1vaXjgGyhKNyJ+HCCgp5mw+ch7KaDHtg0fG48yJgKNpjkzGWfLQ
 BNXqtd8VYn1mCM3YM7qdtf9bsgjQqpvFiAh7jYGrhYr7geRjary1hTc8WwrxAxaxGvo4xZ1XYps3u
 ayy5dGHdiddk5KJ4iMTLSLH3Rucl19966COQeCwDvFMjkNZx5ExHshWCV5W7+xX/2nIkKUfwXRKfK
 dsVTL03FG0YvY/8A98EMbvlf4TnpyyaytBtQYXVsaSBWaXJ0YW5lbiA8cGF2QGlraS5maT6JAlcEE
 wEIAEEWIQRqzkn1AmTRCTrMAJzkmgm4SzqwTwUCZf6qYQIbAwUJEswDAAULCQgHAgIiAgYVCgkICw
 IEFgIDAQIeBwIXgAAKCRDkmgm4SzqwTxYZD/9hfC+CaihOESMcTKHoK9JLkO34YC0t8u3JAyetIz3
 Z9ek42FU8fpf58vbpKUIR6POdiANmKLjeBlT0D3mHW2ta90O1s711NlA1yaaoUw7s4RJb09W2Votb
 G02pDu2qhupD1GNpufArm3mOcYDJt0Rhh9DkTR2WQ9SzfnfzapjxmRQtMzkrH0GWX5OPv368IzfbJ
 S1fw79TXmRx/DqyHg+7/bvqeA3ZFCnuC/HQST72ncuQA9wFbrg3ZVOPAjqrjesEOFFL4RSaT0JasS
 XdcxCbAu9WNrHbtRZu2jo7n4UkQ7F133zKH4B0SD5IclLgK6Zc92gnHylGEPtOFpij/zCRdZw20VH
 xrPO4eI5Za4iRpnKhCbL85zHE0f8pDaBLD9L56UuTVdRvB6cKncL4T6JmTR6wbH+J+s4L3OLjsyx2
 LfEcVEh+xFsW87YQgVY7Mm1q+O94P2soUqjU3KslSxgbX5BghY2yDcDMNlfnZ3SdeRNbssgT28PAk
 5q9AmX/5YyNbexOCyYKZ9TLcAJJ1QLrHGoZaAIaR72K/kmVxy0oqdtAkvCQw4j2DCQDR0lQXsH2bl
 WTSfNIdSZd4pMxXHFF5iQbh+uReDc8rISNOFMAZcIMd+9jRNCbyGcoFiLa52yNGOLo7Im+CIlmZEt
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

ti, 2025-03-04 kello 13:10 -0500, Luiz Augusto von Dentz kirjoitti:
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

I think this version has the issues:

- If there are more than sco_pkt in conn->data_q, sending will stall,
  if no flow control. At the end of hci_sched_sco_type() probably it
  is needed

	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL) &&
	    hci_low_sent(hdev, SCO_LINK, &quote))
		queue_work(hdev->workqueue, &hdev->tx_work);

- If there are more than sco_pkt in conn->data_q before first NOCP
  event arrives, we are in spec violation, and can no longer know
  how many buffers are in use.

  So I'm not sure how to avoid this except via timer (or sending probe
  SCO Data packet).

It's not so easy to get full conn->data_q in sco-tester, one might need
multiple SCO connections or SMP to be able to fill it faster than
hci_tx_work() manages to empty it. (Sent anyway some patches to the
list that add some necessary btdev/bthost groundwork in case such test
case can be written.)

>=20
> Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci.h      |  6 ++++
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         | 54 +++++++++++++-------------------
>  net/bluetooth/hci_event.c        |  5 +++
>  net/bluetooth/hci_sync.c         | 18 +++++++++++
>  5 files changed, 52 insertions(+), 32 deletions(-)
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
> index e7ec12437c8b..9ea9b4091f8f 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3548,45 +3548,35 @@ static void __check_timeout(struct hci_dev *hdev,=
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
> +	while (pkts && (conn =3D hci_low_sent(hdev, type, &quote))) {
>  		while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
>  			BT_DBG("skb %p len %d", skb, skb->len);
>  			hci_send_frame(hdev, skb);
> =20
> -			conn->sent++;
> -			if (conn->sent =3D=3D ~0)
> -				conn->sent =3D 0;
> -		}
> -	}
> -}
> +			pkts--;
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
> +			if (hdev->sco_cnt > 0)
> +				hdev->sco_cnt--;
> =20
>  			conn->sent++;
>  			if (conn->sent =3D=3D ~0)
> @@ -3628,8 +3618,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
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
> @@ -3684,8 +3674,8 @@ static void hci_sched_le(struct hci_dev *hdev)
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
> @@ -3730,8 +3720,8 @@ static void hci_tx_work(struct work_struct *work)
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
> index 19e19c9f5e68..e6eadcc13484 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4448,6 +4448,11 @@ static void hci_num_comp_pkts_evt(struct hci_dev *=
hdev, void *data,
>  			hdev->sco_cnt +=3D count;
>  			if (hdev->sco_cnt > hdev->sco_pkts)
>  				hdev->sco_cnt =3D hdev->sco_pkts;
> +
> +			/* Enable HCI_SCO_FLOWCTL so sco_cnt is used instead of
> +			 * sco_pkts.
> +			 */
> +			hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
>  			break;
> =20
>  		case ISO_LINK:
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c4c2cf51b219..91cfb7c2cb08 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3769,6 +3769,22 @@ static int hci_write_ca_timeout_sync(struct hci_de=
v *hdev)
>  				     sizeof(param), &param, HCI_CMD_TIMEOUT);
>  }
> =20
> +/* Enable SCO flow control if supported */
> +static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
> +{
> +	struct hci_cp_write_sync_flowctl cp;
> +
> +	/* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLOWCTL *=
/
> +	if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
> +		return 0;
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.enable =3D 0x01;
> +
> +	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
> +				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> +}
> +
>  /* BR Controller init stage 2 command sequence */
>  static const struct hci_init_stage br_init2[] =3D {
>  	/* HCI_OP_READ_BUFFER_SIZE */
> @@ -3787,6 +3803,8 @@ static const struct hci_init_stage br_init2[] =3D {
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
