Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57222882B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242033; cv=pass; b=igjFKPQKpXLV4AmPsZYryBXDEruyo4Z38lnyRMq5GNn5EexOpUs6yY034ck8V5uoHe/8roxn2UPX4AokUMwjJr67skCXApJ+5PPR0DSVv+TC/9S5fHRmPsVxGFf7Q9Wq0n2XA3YqNk7ht87WuzMRcaJ2Zds+DNZIdWA6FvyRR/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242033; c=relaxed/simple;
	bh=MKqUYHXri7eOmSVpbrzMZCHqpFLprpK/d5rLOuXD3DU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uaHGtE59F5VxBh/fZVN2586U5GeV07LowRpqM5lWmbXYfmysRXGX53HBOAj0k18oHzu+qYKhy+OGrbLUgEuymOcTawi3+ws5yI1ocaGy3yycAbDlLNVFqhjXEoxYEpUJ1h22PARFU119nD+JUMasJRcLqS+o+ey1f6XM3+eo2Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=BpcRsM2U; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="BpcRsM2U"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bdtTr71W8z49PwQ;
	Fri, 11 Jul 2025 16:53:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752242017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5LPHAKIF1tV5o8kBsMVOfBJkPNzHWr+ULh9VPINME+A=;
	b=BpcRsM2U4e7wtVElRRislVJJKqcdH5m8DSHzEvV2qULEHYYat4EvwBRq8EfBHPnu9jGx9A
	Sf5i0NQgUmBFvifcSgzEOKO/R5efXgFE9DDEzhH02PagqMltYkM4WDUAwcnlNmEx1ROjeD
	xelwH0YTe/FPnkLGdi/eAMh3vP/aMku5no5o/uTMDNf36ZUlRuqUsWXL/FD8Qx9bzqAiEv
	aTIRzZaPqZ7FqRHcAMU9HI63HdWMBX8BDCwO8Zmwe1pkQXSTRrPbXJF5qvSrhlSx3yIue5
	QkwPVBpVHebj2b5aTyqtuA2GLzsQ9xWK4mfkbO5vTsUcFX7FuYMRvb3WEeCPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752242017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5LPHAKIF1tV5o8kBsMVOfBJkPNzHWr+ULh9VPINME+A=;
	b=hKAtok/n9spSUNVeUNoglRWw2OKxtmaSPXvu1ZosAeGThHQyBqBRUEhGccdxtW0N581BW9
	iILMAcEDzlbiVN8SHVJEWLXzTj8dk0Z83MLwYJN1ZcRtJm5mEFIsnt5ajDMztVZGwSA+YL
	o25qXHiwWcQFYk8DYeM/KrRxxOQvKV0zR0DNw4usD0JVsEuHqz2V+RIHDxzbr58xXkLapV
	+NQcxLESuK5WTK10ancCRjCWGig0RzSSHmRq2QeCeBihohct1I7beO3xQW/k1p2Ture5jh
	qHTWzpPB8L23CJ/TcVpmNYGyjjqsX4eOxL1YJe6XvHvMelnw4dDOyAUbTRzz/w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752242017; a=rsa-sha256;
	cv=none;
	b=HLuUqTkohKumPn3XKtzxYSqz51NXmGzAIIxpl48VJ8FQpbU3dQvFQZGZQOjKD3T0SGIbWF
	J3boMRzfrz//y1n0sZqsGzwYEeLY931NyQB01b9oUqYJhAs/1niSE8lsqTg2Nky4/k+ss1
	EY2PQUjBxVrwmRpIs+xmr+SQ2IZ76i8vLr4KLj437+Gzk5Y6OoE1AKMgUUOirbXDBtZyu1
	d0TtjmidkKBeJRz52rEWJ6DOLrGNkF4nOJSCEu8UYbOUaH1WL1qSIG2m1MYolR+Ipns4LR
	vKHPUpwlQ3cGfkWDHbTAQaWbSUm+bdaVicYw+w7Vk1ZK263SpGPSXAAs4oTaLw==
Message-ID: <1241dea72ce758a6f5eccd73cefca8df802916b7.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix L2CAP MTU negotiation
From: Pauli Virtanen <pav@iki.fi>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@collabora.com>, 
	linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Jul 2025 16:53:35 +0300
In-Reply-To: <20250612075034.190194-1-frederic.danis@collabora.com>
References: <20250612075034.190194-1-frederic.danis@collabora.com>
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
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2025-06-12 kello 09:50 +0200, Fr=C3=A9d=C3=A9ric Danis kirjoitti:
> OBEX download from iPhone is currently slow due to small packet size
> used to transfer data which doesn't follow the MTU negotiated during
> L2CAP connection, i.e. 672 bytes instead of 32767:

There are some reports that appear to indicate this commit causes
regressions for A2DP:

https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/14=
9#note_285698

https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4793#note_3001287


>=20
>   < ACL Data TX: Handle 11 flags 0x00 dlen 12
>       L2CAP: Connection Request (0x02) ident 18 len 4
>         PSM: 4103 (0x1007)
>         Source CID: 72
>   > ACL Data RX: Handle 11 flags 0x02 dlen 16
>       L2CAP: Connection Response (0x03) ident 18 len 8
>         Destination CID: 14608
>         Source CID: 72
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
>   < ACL Data TX: Handle 11 flags 0x00 dlen 27
>       L2CAP: Configure Request (0x04) ident 20 len 19
>         Destination CID: 14608
>         Flags: 0x0000
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 32767
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 63
>           Max transmit: 3
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>   > ACL Data RX: Handle 11 flags 0x02 dlen 26
>       L2CAP: Configure Request (0x04) ident 72 len 18
>         Destination CID: 72
>         Flags: 0x0000
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 32
>           Max transmit: 255
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 65527
>         Option: Frame Check Sequence (0x05) [mandatory]
>           FCS: 16-bit FCS (0x01)
>   < ACL Data TX: Handle 11 flags 0x00 dlen 29
>       L2CAP: Configure Response (0x05) ident 72 len 21
>         Source CID: 14608
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 672
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 32
>           Max transmit: 255
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>   > ACL Data RX: Handle 11 flags 0x02 dlen 32
>       L2CAP: Configure Response (0x05) ident 20 len 24
>         Source CID: 72
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 32767
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 63
>           Max transmit: 3
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>         Option: Frame Check Sequence (0x05) [mandatory]
>           FCS: 16-bit FCS (0x01)
>   ...
>   > ACL Data RX: Handle 11 flags 0x02 dlen 680
>       Channel: 72 len 676 ctrl 0x0202 [PSM 4103 mode Enhanced Retransmiss=
ion (0x03)] {chan 8}
>       I-frame: Unsegmented TxSeq 1 ReqSeq 2
>   < ACL Data TX: Handle 11 flags 0x00 dlen 13
>       Channel: 14608 len 9 ctrl 0x0204 [PSM 4103 mode Enhanced Retransmis=
sion (0x03)] {chan 8}
>       I-frame: Unsegmented TxSeq 2 ReqSeq 2
>   > ACL Data RX: Handle 11 flags 0x02 dlen 680
>       Channel: 72 len 676 ctrl 0x0304 [PSM 4103 mode Enhanced Retransmiss=
ion (0x03)] {chan 8}
>       I-frame: Unsegmented TxSeq 2 ReqSeq 3
>=20
> The MTUs are negotiated for each direction. In this traces 32767 for
> iPhone->localhost and no MTU for localhost->iPhone, which based on
> '4.4 L2CAP_CONFIGURATION_REQ' (Core specification v5.4, Vol. 3, Part
> A):
>=20
>   The only parameters that should be included in the
>   L2CAP_CONFIGURATION_REQ packet are those that require different
>   values than the default or previously agreed values.
>   ...
>   Any missing configuration parameters are assumed to have their
>   most recently explicitly or implicitly accepted values.
>=20
> and '5.1 Maximum transmission unit (MTU)':
>=20
>   If the remote device sends a positive L2CAP_CONFIGURATION_RSP
>   packet it should include the actual MTU to be used on this channel
>   for traffic flowing into the local device.
>   ...
>   The default value is 672 octets.
>=20
> is set by BlueZ to 672 bytes.
>=20
> It seems that the iPhone used the lowest negotiated value to transfer
> data to the localhost instead of the negotiated one for the incoming
> direction.
>=20
> This could be fixed by using the MTU negotiated for the other
> direction, if exists, in the L2CAP_CONFIGURATION_RSP.
> This allows to use segmented packets as in the following traces:
>=20
>   < ACL Data TX: Handle 11 flags 0x00 dlen 12
>         L2CAP: Connection Request (0x02) ident 22 len 4
>           PSM: 4103 (0x1007)
>           Source CID: 72
>   < ACL Data TX: Handle 11 flags 0x00 dlen 27
>         L2CAP: Configure Request (0x04) ident 24 len 19
>           Destination CID: 2832
>           Flags: 0x0000
>           Option: Maximum Transmission Unit (0x01) [mandatory]
>             MTU: 32767
>           Option: Retransmission and Flow Control (0x04) [mandatory]
>             Mode: Enhanced Retransmission (0x03)
>             TX window size: 63
>             Max transmit: 3
>             Retransmission timeout: 2000
>             Monitor timeout: 12000
>             Maximum PDU size: 1009
>   > ACL Data RX: Handle 11 flags 0x02 dlen 26
>         L2CAP: Configure Request (0x04) ident 15 len 18
>           Destination CID: 72
>           Flags: 0x0000
>           Option: Retransmission and Flow Control (0x04) [mandatory]
>             Mode: Enhanced Retransmission (0x03)
>             TX window size: 32
>             Max transmit: 255
>             Retransmission timeout: 0
>             Monitor timeout: 0
>             Maximum PDU size: 65527
>           Option: Frame Check Sequence (0x05) [mandatory]
>             FCS: 16-bit FCS (0x01)
>   < ACL Data TX: Handle 11 flags 0x00 dlen 29
>         L2CAP: Configure Response (0x05) ident 15 len 21
>           Source CID: 2832
>           Flags: 0x0000
>           Result: Success (0x0000)
>           Option: Maximum Transmission Unit (0x01) [mandatory]
>             MTU: 32767
>           Option: Retransmission and Flow Control (0x04) [mandatory]
>             Mode: Enhanced Retransmission (0x03)
>             TX window size: 32
>             Max transmit: 255
>             Retransmission timeout: 2000
>             Monitor timeout: 12000
>             Maximum PDU size: 1009
>   > ACL Data RX: Handle 11 flags 0x02 dlen 32
>         L2CAP: Configure Response (0x05) ident 24 len 24
>           Source CID: 72
>           Flags: 0x0000
>           Result: Success (0x0000)
>           Option: Maximum Transmission Unit (0x01) [mandatory]
>             MTU: 32767
>           Option: Retransmission and Flow Control (0x04) [mandatory]
>             Mode: Enhanced Retransmission (0x03)
>             TX window size: 63
>             Max transmit: 3
>             Retransmission timeout: 2000
>             Monitor timeout: 12000
>             Maximum PDU size: 1009
>           Option: Frame Check Sequence (0x05) [mandatory]
>             FCS: 16-bit FCS (0x01)
>   ...
>   > ACL Data RX: Handle 11 flags 0x02 dlen 1009
>         Channel: 72 len 1005 ctrl 0x4202 [PSM 4103 mode Enhanced Retransm=
ission (0x03)] {chan 8}
>         I-frame: Start (len 21884) TxSeq 1 ReqSeq 2
>   > ACL Data RX: Handle 11 flags 0x02 dlen 1009
>         Channel: 72 len 1005 ctrl 0xc204 [PSM 4103 mode Enhanced Retransm=
ission (0x03)] {chan 8}
>         I-frame: Continuation TxSeq 2 ReqSeq 2
>=20
> This has been tested with kernel 5.4 and BlueZ 5.77.
>=20
> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> ---
>  net/bluetooth/l2cap_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index a5bde5db58ef..40daa38276f3 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3415,7 +3415,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *=
chan, void *data, size_t data
>  	struct l2cap_conf_rfc rfc =3D { .mode =3D L2CAP_MODE_BASIC };
>  	struct l2cap_conf_efs efs;
>  	u8 remote_efs =3D 0;
> -	u16 mtu =3D L2CAP_DEFAULT_MTU;
> +	u16 mtu =3D 0;
>  	u16 result =3D L2CAP_CONF_SUCCESS;
>  	u16 size;
> =20
> @@ -3520,6 +3520,13 @@ static int l2cap_parse_conf_req(struct l2cap_chan =
*chan, void *data, size_t data
>  		/* Configure output options and let the other side know
>  		 * which ones we don't like. */
> =20
> +		/* If MTU is not provided in configure request, use the most recently
> +		 * explicitly or implicitly accepted value for the other direction,
> +		 * or the default value.
> +		 */
> +		if (mtu =3D=3D 0)
> +			mtu =3D chan->imtu ? chan->imtu : L2CAP_DEFAULT_MTU;
> +
>  		if (mtu < L2CAP_DEFAULT_MIN_MTU)
>  			result =3D L2CAP_CONF_UNACCEPT;
>  		else {

--=20
Pauli Virtanen
