Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ADF17BD5
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713608605; cv=pass; b=CaB7KRu27nwnfDmwiLrHCWfeSDVB3HPjFVOcYYilnDeYgCfKBWULVssFWNSWYmmjRD9832tbUut/QTE18OODespj8hRZh/44C9P1WHylxdhcS0PJ0LmoMVHmMTa+QiW28lcMX3p5Jgx2iNmxTS7jKupfyWIb0W7ile7SJlkIlb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713608605; c=relaxed/simple;
	bh=RQHQP/ySt1OkyF7LsbSoBDwV/g7KprtKHZKfpkA67Fs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=N0L+YRoCh3lSICM+2uVxZ2i/5u0bkIhnkiUL5vPtzLfeoFaE2wox4XAO/1gzadUltDCxSlfsJdJOQdUkkdACZJc5miF5dBGutBKSqjO6MlSM+bXRg9Fb05FFYrk8xHUyi7dntcIukaQmHdJyOMFTMbEXyZxwRZpsR5G/7RZUIsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ORAAvuVv; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ORAAvuVv"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VM6zM3v5Cz49Q4N;
	Sat, 20 Apr 2024 13:23:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1713608592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=1dvx8sXvA76dhMZKRXwY9PPnxEFaGiaYhvrMpxwB0t4=;
	b=ORAAvuVvn9pWudYJ6G6/rGSDs8Atr4vg8IV7fYTYEK62jFwOx4sRG+uVBNk/bFX8+xtw6P
	TXyDCwod0wIqxvxzVrL+jGeLsVxSc5rcR+SwPtDbGFXdKqBHwugmfTs4hTtieeCBpPC0x4
	5P9OOY4KuxRGw4wzJUvJqGFImfKQ2cNXnsrpPP6veZUxa58gcHyq/O7PCYynRgiZh3VtzW
	SbwAT4KFfMu3nxDavyfyuWRylzFsjSxOrzIJ8sUF+Rx+vDtgaQHQGIPa6UNYnJoaFNz2WN
	iCZxyt+RBLPLRG8JwqJPhqfhMME4t68P5KGHFydOk36+wbpezFIHb6PAG7dfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1713608592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=1dvx8sXvA76dhMZKRXwY9PPnxEFaGiaYhvrMpxwB0t4=;
	b=ViEhMa38qQK0ZMyTfCMs3ZnsNKe5h+KiFWjaxrdc5yUz97KQ2fVq5GvzgbfQ5RURN+GtDl
	xh+RoD3cNuxQTeHqCN3FWEMNShAibYMXUgpRoiJdGtLpRZAWVHvY/Yk+YQDGQi/CfgGkdf
	ES0N+OMCXACbTj6DTIPz9U6T6Pz/9kGWJ0K3Ydzr/97VgO9kPvsSKzo87Tff33BURGOJmd
	qQNb9UZhuP7UYyyiSbuJIIN3Zvi5wp6cl92Ywbj2p7fR9ZvnRPmHVqVAhYEz9NFwwTIV41
	f0SAd+2ONUnFg3tsAUYSFGED//OFUXsVlLQbQrtemCqeXXgVtQ60bMnajLcdyQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1713608592; a=rsa-sha256;
	cv=none;
	b=HRvko6XRrpJUu8B1LmB7qoAivgVwn9jkcqGH5xd8ib2Lpzc7eqg1AApCAAHMTPnzHePqep
	COnRGZQRMlTMlcJtHOU/tZ04u518OoyiRNHSXUVR7WNVSPYxoI9NkJO6xTPJbz3Re+Irha
	USP0Lr5kmCH/ZSBPxFio05A2OghQcCstK88LpaFJco0VAEyyHrNhLbfYG9YccTCdhf/u71
	BVj1uCzvcfK+/xW3WNjFZhyX8EZTjazu+/GOcK/YTVaxnH0Sz3zwATTzUl/hr0Xbu3tles
	ICOxqXCeA8GEjBm62ifk06pL1q5crSjdrsFB1OM2Gcp30J2C6uOKEoW1bb9NSA==
Message-ID: <ac186b288055109c33c9e89b0ac71984d5ef9bf6.camel@iki.fi>
Subject: ISO flow control issues with Intel AX210 fw build 79483
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Kiran K <kiran.k@intel.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>
Date: Sat, 20 Apr 2024 13:23:07 +0300
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=mQINBGX+qmEBEACt7O4iYRbX80B2OV+LbX06Mj1Wd67SVWwq2sAlI+6fK1YWbFu5jOWFyShFCRGmwyzNvkVpK7cu/XOOhwt2URcy6DY3zhmd5gChz/t/NDHGBTezCh8rSO9DsIl1w9nNEbghUlcYmEvIhQjHH3vv2HCOKxSZES/6NXkskByXtkPVP8prHPNl1FHIO0JVVL7/psmWFP/eeB66eAcwIgdaUeWsA9+/AwcjqJV2pa1kblWjfZZw4TxrBgCB72dC7FAYs94ebUmNg3dyv8PQq63EnC8TAUTyph+McnQiCPz6chp7XHVQdeaxSfcCEsOJaHlS+CtdUHiGYxN4mewPm5JwM1C7PW6QBPIpx6XFvtvMfG+Ny+AZ/jZtXxHmrGEJ5sz5YfqucDV8bMcNgnbFzFWxvVklafpP80O/4VkEZ8Og09kvDBdB6MAhr71b3On+dE0S83rEiJs4v64/CG8FQ8B9K2p9HE55Iu3AyovR6jKajAi/iMKR/x4KoSq9Jgj9ZI3g86voWxM4735WC8h7vnhFSA8qKRhsbvlNlMplPjq0f9kVLg9cyNzRQBVrNcH6zGMhkMqbSvCTR5I1kY4SfU4fQqRF1Ai5f9Q9D8ExKb6fy7ct8aDUZ69Ms9N+XmqEL8C3+AAYod1XaXk9/hdTQ1Dhb51VPXAMWTICBdXi5z7be6KALQARAQABtCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaWtpLmZpPokCWgQTAQgARAIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBGrOSfUCZNEJOswAnOSaCbhLOrBPBQJl/qsDAhkBAAoJEOSaCbhLOrBPB/oP/1j6A7hlzheRhqcj+6sk+OgZZ+5eX7mBomyr76G+m/3RhPGlKbDxKTWtBZaIDKg2c0Q6yC1TegtxQ2EUD4kk7wKoHKj8dKbR29uS3OvURQR1g
	uCo2/5kzQQVxQwhIoMdHJYF0aYNQgdA+ZJL09lDz+JC89xvup3spxbKYc9Iq6vxVLbVbjF9Uv/ncAC4Bsg1MQoMowhKsxwN5VlUdjqPZ6uGebZyC+gX6YWUHpPWcHQ1TxCD8TtqTbFU3Ltd3AYl7d8ygMNBEe3T7DV2GjBI06Xqdhydhz2G5bWPM0JSodNDE/m6MrmoKSEG0xTNkH2w3TWWD4o1snte9406az0YOwkkxDq9LxEVoeg6POceQG9UdcsKiiAJQXu/I0iUprkybRUkUj+3oTJQECcdfL1QtkuJBh+IParSF14/jXojwnf7tE5rm7QvMWWSiSRewro1vaXjgGyhKNyJ+HCCgp5mw+ch7KaDHtg0fG48yJgKNpjkzGWfLQBNXqtd8VYn1mCM3YM7qdtf9bsgjQqpvFiAh7jYGrhYr7geRjary1hTc8WwrxAxaxGvo4xZ1XYps3uayy5dGHdiddk5KJ4iMTLSLH3Rucl19966COQeCwDvFMjkNZx5ExHshWCV5W7+xX/2nIkKUfwXRKfKdsVTL03FG0YvY/8A98EMbvlf4TnpyyaytBtQYXVsaSBWaXJ0YW5lbiA8cGF2QGlraS5maT6JAlcEEwEIAEEWIQRqzkn1AmTRCTrMAJzkmgm4SzqwTwUCZf6qYQIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCRDkmgm4SzqwTxYZD/9hfC+CaihOESMcTKHoK9JLkO34YC0t8u3JAyetIz3Z9ek42FU8fpf58vbpKUIR6POdiANmKLjeBlT0D3mHW2ta90O1s711NlA1yaaoUw7s4RJb09W2VotbG02pDu2qhupD1GNpufArm3mOcYDJt0Rhh9DkTR2WQ9SzfnfzapjxmRQtMzkrH0GWX5OPv368IzfbJS1fw79TXmRx/DqyHg+7/bvqeA3ZFCnuC/HQST72ncuQA9wFbrg3ZVOPAjqrjesEOFFL4R
	SaT0JasSXdcxCbAu9WNrHbtRZu2jo7n4UkQ7F133zKH4B0SD5IclLgK6Zc92gnHylGEPtOFpij/zCRdZw20VHxrPO4eI5Za4iRpnKhCbL85zHE0f8pDaBLD9L56UuTVdRvB6cKncL4T6JmTR6wbH+J+s4L3OLjsyx2LfEcVEh+xFsW87YQgVY7Mm1q+O94P2soUqjU3KslSxgbX5BghY2yDcDMNlfnZ3SdeRNbssgT28PAk5q9AmX/5YyNbexOCyYKZ9TLcAJJ1QLrHGoZaAIaR72K/kmVxy0oqdtAkvCQw4j2DCQDR0lQXsH2blWTSfNIdSZd4pMxXHFF5iQbh+uReDc8rISNOFMAZcIMd+9jRNCbyGcoFiLa52yNGOLo7Im+CIlmZEtbzyGkKh2h8XdrYhtDjw9LmrprPbkCDQRl/qphARAA1OQ/6lkiNSv4mZGepG6I6BrG4TUzzPd3kD6zA4iS65fbr/u62s4YnQdOkc3wooRXWUX2BwWLaZMk1LNwOIZRfppVt8OLVP2DCKcTdEB5W+3MQQ2twkYN1a8QWx8mnmnRJWKOUzQc+mJp/2xin3B3zgEjk94pMD8NrMTatJ3ZnN3I4aeFgxejd5yomIVAN4RAgXTxyZeF9m+ozzQOky5glA4UpXsidrnkoMnkPT/wQlumvOnroi1BuXiXng30cBkYMz/E2sWdX0NBlZBU5pv/FgK7sa7pLvu8mVBYcE00q4CHF7ENtD4MVfr5Bb6L4U6wppVZR0nzV33GAqW33hnyRTLKWNh3VPxQszxU3lG8JFODXFNLBGgrW6prDKGL/H3lvLGljZp0BoWelLhCxZcp2KUQIDI8YEKZ9gfupFvbzUC/N484ENsYnRSyr1zU2/DlE72CW4+OZ1hKMzeuy52zEgFsu1vHNgLeuNPz4gdl/h+nDKFXt5sPVkbeu3FT1q8DW041IYm/rPYGDCi+WkJ2gP4OilRj1pZkIDBXD6sF5Dybm8hXtMM
	HW7MpskCcEFlDoOjdZHUP1XMdTE1uqfk8QMdbCMHuCYAAYEC+0Bxk6DGo8IRuKFyf9ZCH/X8Sn76uawiSY2rrLB2qQ4LbckDVKwr3AGV1yACfcw6A6blI/wkAEQEAAYkCPAQYAQgAJhYhBGrOSfUCZNEJOswAnOSaCbhLOrBPBQJl/qphAhsMBQkSzAMAAAoJEOSaCbhLOrBPwm8QAKRGljnvoHBM3RRtA8LLewt2OpD73HdgBaGmgAwbjIl4zSAUj90jp9L2Df+kpL0MoeIgv/4Z1DzTJUm0YS1GyXfUiKQYV2zmRu5tiFJzjT+z5aEe+g+j/UionaMOEufOgkIHrdaQbE1qbV8KE7lvqy7ne4PfMFmx28gsFkJ9NUkDOj7epmilkOU96sWBi9SDmVW09f3WfkituEYGxoo4Ytvwvbj3Fwv32x0I+7s7mMjUrb/5/P+22KJLT9T0B1oDValnoN7W/mLgjzGH3x119iCuWr8q4HgwAxYXQy3D3rBKY/WGuecRxCJlmmUECi4Fm5Pl5+W3jUuUahLMAWDfvBaVapmYiX3c/oyaVV6/sbzGFzlkaPuhV91pVBLqCLcYXBbiybSP9F1xBWqOJABaAHRVEmA6DxCVnxphZ87BAL4HdZ1KIOahD6Heaz5RiABFFX6dg4siBILt4b2pjUzMLiTfiBbHuGcydkHSDWZAFLe1VJjTVRR1XY/L70sFUs9L9woo5LHtO16LVVfic7IUHBs25cI+/jhP0tJQU5SaT/52HyNoDmmDtaWkk3S6J8X+fUJjpIh5hY5P2D/YXA5NVkuXPLNFrtbqDLR6oou2jhJKkSQRpkdjoJmSiRbmqeToyUpMq75pkiPJQ7e4EL+PI/kVynsG6JohaedRxX6Gbivk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

The behavior of HCI ISO Data Packet flow control on Intel AX210 seems to
have changed between firmware versions 23.20.0.3 (fw build REL75234,
Jan 2024) and 23.40.0.2 (fw build REL79483, Mar 2024).

In practice, with this firmware version TWS playback with two CIS
essentially always loses one of the two streams, as kernel stops sending
further data to the controller for one of the two.

This does not occur with the earlier firmware version.

The new behavior looks as if the controller is failing to send Number of
Completed Packets events for some of the ISO data packets it actually
has processed (which would seem wrong, Core v5.4 Vol 4 Part E =C2=A74.1.1),
causing the kernel to stop queueing further data.

btsnoop log when streaming data to two CIS:
https://gitlab.freedesktop.org/pvir/repros/-/raw/main/2024-04-22_1.log?inli=
ne=3Dfalse

***

Looking at `btmon -r 2024-04-22_1.log` output:

Initially it looks fine:
```
< ISO Data TX: Handle 2305 flags 0x02 dlen 121           #1283 [hci1] 17.71=
6197
< ISO Data TX: Handle 2304 flags 0x02 dlen 121           #1284 [hci1] 17.71=
6214
> HCI Event: Number of Completed Packets (0x13) plen 9   #1285 [hci1] 17.71=
6529
        Num handles: 2
        Handle: 2304 Address: 28:3D:C2:4A:7E:DA (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #1280: len 121 (138 Kb/s)
        Latency: 7 msec (5-8 msec ~7 msec)
        Handle: 2305 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #1281: len 121 (138 Kb/s)
        Latency: 7 msec (5-8 msec ~7 msec)
```
After physically covering one of the receiver devices briefly, which appear=
s to
temporarily reduce the connection quality:
```
< ISO Data TX: Handle 2305 flags 0x02 dlen 121           #1430 [hci1] 18.08=
3668
< ISO Data TX: Handle 2304 flags 0x02 dlen 121           #1431 [hci1] 18.08=
3684
> HCI Event: Number of Completed Packets (0x13) plen 9   #1432 [hci1] 18.08=
3660
        Num handles: 2
        Handle: 2304 Address: 28:3D:C2:4A:7E:DA (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #1425: len 121 (69 Kb/s)
        Latency: 14 msec (5-15 msec ~15 msec)
        Handle: 2305 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #1427: len 121 (138 Kb/s)
        Latency: 7 msec (5-8 msec ~7 msec)
```
The latencies stay constant after this. In this situation when the two
CIS have different latency (as seen in btmon), in the earlier firmware
the CIS playback was desynchronized
(cf https://github.com/bluez/bluez/issues/515), but in this instance
they remain synchronized despite the latency difference in the NCP
events.

Note however that CIS desynchronization also still occurs with this
firmware revision, but we can no longer compensate for it on application
side, as the NCP events no longer correspond to this.

Disrupting connectivity again increases the NCP latency of handle 2304
further to 30ms (around #2630), and yet again (around #4487) to 50ms,
with the CIS playback remaining still in sync:
```
< ISO Data TX: Handle 2305 flags 0x02 dlen 121           #2639 [hci1] 21.10=
6203
< ISO Data TX: Handle 2304 flags 0x02 dlen 121           #2640 [hci1] 21.10=
6416
> HCI Event: Number of Completed Packets (0x13) plen 9   #2641 [hci1] 21.10=
6660
        Num handles: 2
        Handle: 2304 Address: 28:3D:C2:4A:7E:DA (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #2628: len 121 (32 Kb/s)
        Latency: 30 msec (5-30 msec ~30 msec)
        Handle: 2305 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #2636: len 121 (138 Kb/s)
        Latency: 7 msec (5-8 msec ~7 msec)
```
A fourth time results to packets for Handle 2304 no longer being
reported complete, and kernel stops scheduling more as it thinks there
are already several packets waiting in controller buffers:
```
< ISO Data TX: Handle 2304 flags 0x02 dlen 121           #6712 [hci1] 31.29=
8684
< ISO Data TX: Handle 2304 flags 0x02 dlen 121           #6713 [hci1] 31.29=
8693
> HCI Event: Number of Completed Packets (0x13) plen 5   #6714 [hci1] 31.30=
6659
        Num handles: 1
        Handle: 2304 Address: 28:3D:C2:4A:7E:DA (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #6695: len 121 (18 Kb/s)
        Latency: 52 msec (5-74 msec ~52 msec)
< ISO Data TX: Handle 2305 flags 0x02 dlen 121           #6715 [hci1] 31.30=
6713
> HCI Event: Number of Completed Packets (0x13) plen 5   #6716 [hci1] 31.31=
3659
        Num handles: 1
        Handle: 2305 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #6715: len 121 (161 Kb/s)
        Latency: 6 msec (4-8 msec ~7 msec)
< ISO Data TX: Handle 2305 flags 0x02 dlen 121           #6717 [hci1] 31.31=
3685
> HCI Event: Number of Completed Packets (0x13) plen 5   #6718 [hci1] 31.32=
1655
        Num handles: 1
        Handle: 2305 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #6717: len 121 (138 Kb/s)
        Latency: 7 msec (4-8 msec ~7 msec)
... (no further Number of Completed Packets for Handle 2304) ...
```
The connection is not disconnected, but kernel stops queueing more data
for Handle 2304 as there are no more NCP events e.g. packets #6712,
#6713 never get acknowledged.

In kernel logs in such situation:
```
[49492.883693] hci_rx_work:4101: hci1
[49492.883701] hci_rx_work:4145: hci1 Event packet
[49492.883708] hci_tx_work:3869: hci1 acl 4 sco 6 le 6 iso 1
[49492.883711] hci_sched_sco:3627: hci1
[49492.883712] hci_sched_esco:3650: hci1
[49492.883713] hci_sched_iso:3844: hci1
[49492.883715] hci_low_sent:3448: conn 0000000095db7cfc quote 1
[49492.883717] hci_sched_iso:3853: skb 00000000cc60fe22 len 125
[49492.883720] hci_send_frame:3040: hci1 type 5 len 125
[49492.883728] hci_sched_acl:3766: hci1
[49492.883729] hci_sched_le:3793: hci1
[49492.883731] hci_chan_sent:3487: hci1
[49492.890059] hci_send_iso:3365: hci1 len 121
[49492.890063] hci_queue_iso:3335: hci1 nonfrag skb 0000000084004c42 len 12=
5
[49492.890087] hci_tx_work:3869: hci1 acl 4 sco 6 le 6 iso 0
[49492.890090] hci_sched_sco:3627: hci1
[49492.890091] hci_sched_esco:3650: hci1
[49492.890091] hci_sched_iso:3844: hci1
[49492.890092] hci_sched_acl:3766: hci1
[49492.890093] hci_sched_le:3793: hci1
[49492.890094] hci_chan_sent:3487: hci1
[49492.890733] hci_rx_work:4101: hci1
[49492.890740] hci_rx_work:4145: hci1 Event packet
[49492.890747] hci_tx_work:3869: hci1 acl 4 sco 6 le 6 iso 1
[49492.890751] hci_sched_sco:3627: hci1
[49492.890753] hci_sched_esco:3650: hci1
[49492.890754] hci_sched_iso:3844: hci1
[49492.890756] hci_low_sent:3448: conn 0000000095db7cfc quote 1
[49492.890758] hci_sched_iso:3853: skb 000000002d6239ed len 125
[49492.890761] hci_send_frame:3040: hci1 type 5 len 125
[49492.890770] hci_sched_acl:3766: hci1
[49492.890771] hci_sched_le:3793: hci1
[49492.890772] hci_chan_sent:3487: hci1
```
So the kernel indeed thinks all ISO buffers are full, and only one of
the two connections is making progress.

When the application stops queuing more data and the last packet for
Handle 2305 is acknowledged, kernel starts queuing more packets for
Handle 2304 (due to hci_conn_low_sent scheduling logic). Each sent
packet now gets a NCP event immediately:
```
< ISO Data TX: Handle 2305 flags 0x02 dlen 121           #8105 [hci1] 36.51=
8739
> HCI Event: Number of Completed Packets (0x13) plen 5   #8106 [hci1] 36.52=
6665
        Num handles: 1
        Handle: 2305 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #8105: len 121 (138 Kb/s)
        Latency: 7 msec (4-8 msec ~7 msec)
< ISO Data TX: Handle 2304 flags 0x02 dlen 121           #8107 [hci1] 36.52=
6694
> HCI Event: Number of Completed Packets (0x13) plen 5   #8108 [hci1] 36.53=
3663
        Num handles: 1
        Handle: 2304 Address: 28:3D:C2:4A:7E:DA (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #6698: len 121 (0 Kb/s)
        Latency: 5271 msec (5-5271 msec ~2162 msec)
< ISO Data TX: Handle 2304 flags 0x02 dlen 121           #8109 [hci1] 36.53=
3697
> HCI Event: Number of Completed Packets (0x13) plen 5   #8110 [hci1] 36.54=
1651
        Num handles: 1
        Handle: 2304 Address: 28:3D:C2:4A:7E:DA (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #6701: len 121 (0 Kb/s)
        Latency: 5272 msec (5-5272 msec ~3717 msec)
...
< ISO Data TX: Handle 2304 flags 0x02 dlen 121           #8117 [hci1] 36.56=
3720
> HCI Event: Number of Completed Packets (0x13) plen 5   #8118 [hci1] 36.57=
1665
        Num handles: 1
        Handle: 2304 Address: 28:3D:C2:4A:7E:DA (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #6712: len 121 (0 Kb/s)
        Latency: 5272 msec (5-5272 msec ~4300 msec)
```
Note huge latency values: btmon and kernel are thinking these are the
packets queued to controller buffers long ago.

That these "delayed" NCP events come immediately after kernel sends
a new ISO data packet for the handle, and that there still remain
unacknowledged packets at the end, it looks as if each of these events
actually corresponds to the packet sent immediately before, and the
controller has failed to send NCP events for the earlier packets.

Similarly, as the CIS playback remained in sync despite "latency"
increase, one can suspect some packets were silently dropped, and
the NCP flow control accounting is off by some number of packets.

***

Also, in another btmon log under similar conditions, but without trying
to disrupt the connection, at the end of the transmission we see the
last ISO Data TX events:
```
bluetoothd[2231]: < ISO Data TX: Handle 2304 flags 0x02 dlen 121           =
    #6405 [hci1] 22.231296
bluetoothd[2231]: < ISO Data TX: Handle 2305 flags 0x02 dlen 121           =
    #6406 [hci1] 22.231317
...
bluetoothd[2231]: < ISO Data TX: Handle 2304 flags 0x02 dlen 121           =
    #6408 [hci1] 22.239306
bluetoothd[2231]: < ISO Data TX: Handle 2305 flags 0x02 dlen 121           =
    #6409 [hci1] 22.239315
...
bluetoothd[2231]: < ISO Data TX: Handle 2304 flags 0x02 dlen 121           =
    #6411 [hci1] 22.246330
bluetoothd[2231]: < ISO Data TX: Handle 2305 flags 0x02 dlen 121           =
    #6412 [hci1] 22.246351
...
bluetoothd[2231]: < ISO Data TX: Handle 2304 flags 0x02 dlen 121           =
    #6414 [hci1] 22.254364
bluetoothd[2231]: < ISO Data TX: Handle 2305 flags 0x02 dlen 121           =
    #6415 [hci1] 22.254375
> HCI Event: Number of Completed Packets (0x13) plen 9                     =
    #6416 [hci1] 22.261249
        Num handles: 2
        Handle: 2304 Address: 28:3D:C2:4A:7E:DA (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #6405: len 121 (33 Kb/s)
        Latency: 29 msec (2-59 msec ~29 msec)
        Handle: 2305 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,Lt=
d)
        Count: 1
        #6406: len 121 (33 Kb/s)
        Latency: 29 msec (2-44 msec ~29 msec)
bluetoothd[2231]: < ACL Data TX: Handle 2049 flags 0x00 dlen 10            =
    #6417 [hci1] 23.226334
      ATT: Write Command (0x52) len 5
        Handle: 0x0043 Type: ASE Control Point (0x2bc6)
          Data[3]: 050101
            Opcode: Disable (0x05)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x01
...
< HCI Command: Disconnect (0x01|0x0006) plen 3                             =
    #6422 [hci1] 23.307036
        Handle: 2304 Address: 28:3D:C2:4A:7E:DA (Samsung Electronics Co.,Lt=
d)
        Reason: Remote User Terminated Connection (0x13)
...
< HCI Command: Disconnect (0x01|0x0006) plen 3                             =
    #6438 [hci1] 23.374932
        Handle: 2305 Address: 28:3D:C2:4A:7D:2A (Samsung Electronics Co.,Lt=
d)
        Reason: Remote User Terminated Connection (0x13)
```
At the end of streaming, NCP events remain missing for 3 packets for
both CIS, despite there is one second delay between stopping sending
data and starting disconnect procedures.

----------

Firmware version info:
```
[   27.584475] Bluetooth: hci1: Device revision is 0
[   27.584479] Bluetooth: hci1: Secure boot is enabled
[   27.584481] Bluetooth: hci1: OTP lock is enabled
[   27.584482] Bluetooth: hci1: API lock is enabled
[   27.584483] Bluetooth: hci1: Debug lock is disabled
[   27.584484] Bluetooth: hci1: Minimum firmware build 1 week 10 2014
[   27.584486] Bluetooth: hci1: Bootloader timestamp 2019.40 buildtype 1 bu=
ild 38
[   27.584491] Bluetooth: hci1: No support for _PRR ACPI method
[   27.643226] Bluetooth: hci1: Found device firmware: intel/ibt-0041-0041.=
sfi
[   27.643280] Bluetooth: hci1: Boot Address: 0x100800
[   27.643282] Bluetooth: hci1: Firmware Version: 123-8.24
[   29.575500] Bluetooth: hci1: Waiting for firmware download to complete
[   29.575701] Bluetooth: hci1: Firmware loaded in 1887177 usecs
[   29.575747] Bluetooth: hci1: Waiting for device to boot
[   29.600715] Bluetooth: hci1: Device booted in 24401 usecs
[   29.600719] Bluetooth: hci1: Malformed MSFT vendor event: 0x02
[   29.601167] Bluetooth: hci1: Found Intel DDC parameters: intel/ibt-0041-=
0041.ddc
[   29.602729] Bluetooth: hci1: Applying Intel DDC parameters completed
[   29.605729] Bluetooth: hci1: Firmware timestamp 2024.8 buildtype 1 build=
 79483
[   29.605737] Bluetooth: hci1: Firmware SHA1: 0x7c7b67b9
```

--=20
Pauli Virtanen
