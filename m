Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26574175A8F
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246278; cv=pass; b=ZSGoIeQSkwcO+pDr6hg8+Er5O98aUbL36zrx12uF4/avdBiD0HzwF9/KgKSi00FSr6iswNVMxSL4cO+wCSxC7n4FW6vZ6zTiR4kySl3QnzdTrhf02is5N8LLCk04S8f+SVprdKjgB3lTBssXOjabCZhOHOxxeOhq3ivhWI/T+co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246278; c=relaxed/simple;
	bh=NG1O3B+wuRA4vyQPtJB5G4kHP/9zQUoaYrndhE5bGNM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a3nYbxFQGJF4PhcO9KqN4x5vb7qMQ/JkwIsZYsBAsHMHoy/FzCNp39GAFpIc6vj45UUNSMkt4WImLLqK1Gv96JYnPMOYINTEcsHtB6b18CpgK7TOm3qpYfMiW1eP3sDKgzky2yRLPZ45FiiPgMO2+HCOQlv/B63bsRc983JkdGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=IqmSfdIR; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="IqmSfdIR"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fWGKh4zXHz49Px6;
	Wed, 11 Mar 2026 18:24:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1773246265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOzRcbvj1YIv7v0fU8ybxcTG8gURhLcunvlwB4geBHQ=;
	b=IqmSfdIR9du3ql2w4YApEGnB61U4vBZwgiiXfc8zpLH5gMbmWQ3Iur5dgSPgwpiYz6TR8H
	6PavK2MctrOJVG9+hzs6Fx1JUsnGdhAH0I1FpHMaXjpwr3UMVD7J1LUFy52iDbisfzb4Vg
	M4u2Ax3uCxJm0CIITfhT+6A8qKXvGKJ6s3RISRHlNiOR8M/ZYWDYmnXxVrc2CuTw98Uw1F
	4pk74x+4cRix4++hU3t+dTLvTvCL3F+8lquPXoBUEyfe7SV1+SYt5PMXElMUu58Zg5kaKr
	Tr4PGz2zU+bsZeao4xwReCFUh6l8J58hWcdoOv7gjf/jHPL0qsRbYcYxqamwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1773246265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOzRcbvj1YIv7v0fU8ybxcTG8gURhLcunvlwB4geBHQ=;
	b=GTTTMf86WtvO+gbKIgL2v3UA5O3p3YfTzyYwC8JUUDToCTjvBW8XTuZLIigFpaGWsue/eC
	u0x1Lige0ehXuXFzPiYfn1f4bk5GLm4f0o05s/Q810CbBQ8G32NtGngW3s0jCSSIJwPQT/
	12AFIlbFq3l05bKKmOJda9drl2VRjvDugoaP0Vt8J17SQ3UX++W6ktKnr1gmNf/oe5ACYX
	Q9pQbPJ8YjDPKV53k86f+gdO5tE+71Y6LSFvQ7+5Q+z3ACkX4SHe9AQ7ZeGd4WG8fIf3Ss
	GKm6Ge+VRkH6FhzU4+B6R3yET9tveWDTsBXC8WdzICcxO4bMthh/xb7/3NwhLw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1773246265;
	b=ltzAkYHS6oqf5afYWpJCf+I19AciVvz9xtSbDuuGn++ShtIKfoLyRcugPhkEaiqTEiPgtE
	OIGCBchl5NCBlyIZ7GwBgC/Zkdx/e+0Xvk3OWsBkSet0bhbCngbNAcHtXkgndABU1y1Blb
	lSBR+g+ovfq3Pd73tkuJ1UAGStlW2R+Eo4ISMVJxHBRp31kEfdX2mgFW17pB72jyX9wEM0
	IT3Xwk71D55+Q2h5MdWqmLB1+ISMLOCgRdInEoCuC2Qi8O+zL2Fp2l8V4BASKvON+SScNt
	MDonNfKmAW9tH1M5LR/+RK0ku4kWNfM2O+Wqm6Ow0/03DhRqIiwZWFrWbx6hZg==
Message-ID: <6b523ff37391a685be2fc08ee88e1fbde3a2142b.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: ISO: add timestamp for outgoing HCI ISO
 packet
From: Pauli Virtanen <pav@iki.fi>
To: "tailu.shi" <tailu.shi@samsung.com>, Marcel Holtmann
 <marcel@holtmann.org>,  Luiz Augusto von Dentz	 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 11 Mar 2026 18:24:23 +0200
In-Reply-To: <20260311081401.3832000-1-tailu.shi@samsung.com>
References: 
	<CGME20260311081515epcas5p44f035a61a5c6738cd6017d961bf68326@epcas5p4.samsung.com>
	 <20260311081401.3832000-1-tailu.shi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2026-03-11 kello 16:14 +0800, tailu.shi kirjoitti:
> The Bluetooth Core Specification defines the 'Time_Stamp' field of
> an HCI ISO packet as optional. However, it's mandatory to include
> the 'Time_Stamp' field when using HCI ISO packets per section 3.3
> 'HCI Feature Support Requirement' of TMAP specification.
> https://www.bluetooth.com/specifications/specs/html/?src=3DTMAP_v1.0.1/ou=
t/en/index-en.html#UUID-68138fa8-fd1f-1a1b-e552-ddcd8fede9ec
>=20
> To comply with TMAP, introduce a new socket option BT_PKT_ISO_TIMESTAMP
> that allows user application (e.g. PipeWire) to attach timestamp to the
> data it sends to the ISO socket within BT_SCM_PKT_ISO_TIMESTAMP CMSG.
>=20
> When the option is enabled, the kernel extracts the timestamp and copies
> it into the 'Time_Stamp' field of the outgoing HCI ISO packet.
>=20
> This also gives the controller the reference timing information
> required for ISO stream synchronization.

These timestamps are in controller clock domain, so generic host like
Linux appears to need to perform clock synchronization via
HCI_OP_LE_READ_ISO_TX_SYNC to be able to provide timestamps.=C2=A0

I had in the works a not fully finished patch series adding the same
thing + LE Read ISO TX Sync + tests. I sent these now to the list in
their current state, maybe they are useful if you are working on this

https://lore.kernel.org/linux-bluetooth/cover.1773245666.git.pav@iki.fi/T/

https://lore.kernel.org/linux-bluetooth/cover.1773245672.git.pav@iki.fi/T/

The tests pass, but not really tested to satisfaction on real
controllers.

From what I saw, it seems several controllers like Intel AX210 and some
Realtek ones don't implement LE Read ISO TX Sync correctly (returns 0
timestamp), so in those cases it AFAICS it's not possible to provide
host timestamps.

Getting the clock sync via LE Read ISO TX Sync to work properly across
controllers is maybe not so easy, as it appears the Core Specification
is somewhat unclear how it should work.

> A corresponding userspace change is required for full functionality.
> A reference implementation is available in PipeWire:
> https://gitlab.freedesktop.org/shitailu/pipewire/-/commit/5b3bd74e15febb9=
74c8737a64f31fd17e18cd11b

This sends timestamps in host clock domain and has no clock sync, but I
guess this is just for testing.

> Signed-off-by: tailu.shi <tailu.shi@samsung.com>
> ---
>  include/net/bluetooth/bluetooth.h |  5 ++++
>  include/net/bluetooth/hci_core.h  |  1 +
>  net/bluetooth/hci_core.c          |  2 +-
>  net/bluetooth/iso.c               | 49 +++++++++++++++++++++++++++----
>  4 files changed, 50 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 69eed69f7f26..f88c83d21c5e 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -259,6 +259,10 @@ struct bt_codecs {
> =20
>  #define BT_SCM_PKT_SEQNUM	0x05
> =20
> +#define BT_PKT_ISO_TIMESTAMP     23
> +
> +#define BT_SCM_PKT_ISO_TIMESTAMP 0x06
> +
>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
>  __printf(1, 2)
> @@ -409,6 +413,7 @@ enum {
>  	BT_SK_SUSPEND,
>  	BT_SK_PKT_STATUS,
>  	BT_SK_PKT_SEQNUM,
> +	BT_SK_PKT_ISO_TIMESTAMP,
>  };
> =20
>  struct bt_sock_list {
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index a7bffb908c1e..e39d192f8ef6 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -740,6 +740,7 @@ struct hci_conn {
>  	struct bt_iso_qos iso_qos;
>  	__u8		num_bis;
>  	__u8		bis[HCI_MAX_ISO_BIS];
> +	bool		iso_pkt_ts;
> =20
>  	unsigned long	flags;
> =20
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 31308c1de4ec..4264c0229dfb 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3335,7 +3335,7 @@ static void hci_queue_iso(struct hci_conn *conn, st=
ruct sk_buff_head *queue,
> =20
>  	list =3D skb_shinfo(skb)->frag_list;
> =20
> -	flags =3D hci_iso_flags_pack(list ? ISO_START : ISO_SINGLE, 0x00);
> +	flags =3D hci_iso_flags_pack(list ? ISO_START : ISO_SINGLE, conn->iso_p=
kt_ts ? 0x01 : 0x00);
>  	hci_add_iso_hdr(skb, conn->handle, flags);
> =20
>  	if (!list) {
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index be145e2736b7..dd4d198bab4c 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -73,6 +73,9 @@ struct iso_pinfo {
>  	__u8			base_len;
>  	__u8			base[BASE_MAX_LENGTH];
>  	struct iso_conn		*conn;
> +	bool			ts_flag;
> +	__u32			ts;

I think these are not needed, they can be passed as arguments to
iso_send_frame().

Adding them to iso_pinfo() probably causes a data race if two processes
sendmsg() at the same time.

> +
>  };
> =20
>  static struct bt_iso_qos default_qos;
> @@ -542,6 +545,7 @@ static int iso_send_frame(struct sock *sk, struct sk_=
buff *skb,
>  	struct iso_conn *conn =3D iso_pi(sk)->conn;
>  	struct bt_iso_qos *qos =3D iso_sock_get_qos(sk);
>  	struct hci_iso_data_hdr *hdr;
> +	struct hci_iso_ts_data_hdr *hdr_ts;
>  	int len =3D 0;
> =20
>  	BT_DBG("sk %p len %d", sk, skb->len);
> @@ -552,13 +556,20 @@ static int iso_send_frame(struct sock *sk, struct s=
k_buff *skb,
>  	len =3D skb->len;
> =20
>  	/* Push ISO data header */
> -	hdr =3D skb_push(skb, HCI_ISO_DATA_HDR_SIZE);
> -	hdr->sn =3D cpu_to_le16(conn->tx_sn++);
> -	hdr->slen =3D cpu_to_le16(hci_iso_data_len_pack(len,
> -						      HCI_ISO_STATUS_VALID));
> +	if (iso_pi(sk)->ts_flag) {
> +		hdr_ts =3D skb_push(skb, HCI_ISO_TS_DATA_HDR_SIZE);
> +		hdr_ts->ts =3D cpu_to_le32(iso_pi(sk)->ts);
> +		hdr_ts->sn =3D cpu_to_le16(conn->tx_sn++);
> +		hdr_ts->slen =3D cpu_to_le16(hci_iso_data_len_pack(len, HCI_ISO_STATUS=
_VALID));
> +	} else {
> +		hdr =3D skb_push(skb, HCI_ISO_DATA_HDR_SIZE);
> +		hdr->sn =3D cpu_to_le16(conn->tx_sn++);
> +		hdr->slen =3D cpu_to_le16(hci_iso_data_len_pack(len, HCI_ISO_STATUS_VA=
LID));
> +	}
> =20
>  	if (sk->sk_state =3D=3D BT_CONNECTED) {
>  		hci_setup_tx_timestamp(skb, 1, sockc);
> +		conn->hcon->iso_pkt_ts =3D iso_pi(sk)->ts_flag;
>  		hci_send_iso(conn->hcon, skb);
>  	} else {
>  		len =3D -ENOTCONN;
> @@ -1471,7 +1482,8 @@ static int iso_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
>  	struct sock *sk =3D sock->sk;
>  	struct sk_buff *skb, **frag;
>  	struct sockcm_cookie sockc;
> -	size_t mtu;
> +	struct cmsghdr *cm;
> +	size_t mtu, hlen;
>  	int err;
> =20
>  	BT_DBG("sock %p, sk %p", sock, sk);
> @@ -1485,10 +1497,23 @@ static int iso_sock_sendmsg(struct socket *sock, =
struct msghdr *msg,
> =20
>  	hci_sockcm_init(&sockc, sk);
> =20
> +	iso_pi(sk)->ts_flag =3D false;
>  	if (msg->msg_controllen) {
>  		err =3D sock_cmsg_send(sk, msg, &sockc);
>  		if (err)
>  			return err;
> +
> +		for (cm =3D CMSG_FIRSTHDR(msg); cm; cm =3D CMSG_NXTHDR(msg, cm)) {
> +			if (cm->cmsg_level !=3D SOL_BLUETOOTH)
> +				continue;
> +			if (test_bit(BT_SK_PKT_ISO_TIMESTAMP, &bt_sk(sk)->flags) &&
> +			    cm->cmsg_type =3D=3D BT_SCM_PKT_ISO_TIMESTAMP &&
> +			    cm->cmsg_len =3D=3D CMSG_LEN(sizeof(u32))) {
> +				iso_pi(sk)->ts_flag =3D true;
> +				iso_pi(sk)->ts =3D *(u32 *)CMSG_DATA(cm);
> +				break;
> +			}
> +		}

I would put this in a separate function.

>  	}
> =20
>  	lock_sock(sk);
> @@ -1502,7 +1527,8 @@ static int iso_sock_sendmsg(struct socket *sock, st=
ruct msghdr *msg,
> =20
>  	release_sock(sk);
> =20
> -	skb =3D bt_skb_sendmsg(sk, msg, len, mtu, HCI_ISO_DATA_HDR_SIZE, 0);
> +	hlen =3D iso_pi(sk)->ts_flag ? HCI_ISO_TS_DATA_HDR_SIZE : HCI_ISO_DATA_=
HDR_SIZE;
> +	skb =3D bt_skb_sendmsg(sk, msg, len, mtu, hlen, 0);
>  	if (IS_ERR(skb))
>  		return PTR_ERR(skb);
> =20
> @@ -1840,6 +1866,17 @@ static int iso_sock_setsockopt(struct socket *sock=
, int level, int optname,
> =20
>  		break;
> =20
> +	case BT_PKT_ISO_TIMESTAMP:
> +		err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
> +		if (err)
> +			break;
> +
> +		if (opt)
> +			set_bit(BT_SK_PKT_ISO_TIMESTAMP, &bt_sk(sk)->flags);
> +		else
> +			clear_bit(BT_SK_PKT_ISO_TIMESTAMP, &bt_sk(sk)->flags);
> +		break;
> +
>  	default:
>  		err =3D -ENOPROTOOPT;
>  		break;

--=20
Pauli Virtanen
