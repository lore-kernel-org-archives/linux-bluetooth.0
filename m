Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794500647;
	b=qBQxaPnW2gqEAbyXEVR4Ot96U9UrS+wgpk+i8mHWuhh2EvRK3OGHFqZ7tKh4R/yW+Z/l
	 /8IVfHd4B0HGHw8QIrS87PNbzRx+rdNR4ESa9+vlUbYfyIfyfjnQNfgSFpc0C/M1rK803
	 x/vhAcfMBbJeHyotkz9MlcGTlHCV5T8hxqHArKxmG2h08YLg+FkqAIHPJSyIiAPbpJ0SO
	 Vsv1/kFb4wnvKf8ClcwZIKKkA/tFH4yHAJb+0zNf0iDCaLsc+rsHk+igc2uli19nDYdn8
	 pQthV50i5KACHND9T3UpuAQKJ8Gg8FjLXPxLJqjoVHK+fF3EopQ6T6myIeitTesrOtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500647;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=7YIsLdDIYlb9hijyx+OvAMP78co/SY2WJJhUxILAIhw=;
	b=2PzltjUCdbQauiJVh2p3jn1zkhdtjr86RzrPySCyqP6LkIdVLwdReXQiyZyQwfQlgKBG
	 zoL4OeBCE/Rt6SM+uXVH1+vcgCu2Ceqld6Z7NIQ/3AyJnTGWfCHUclVDOvTmAiNMRocuF
	 jKkk8HmIIy0Wnw1cx2QfqqKH7Q/Xu5smwi1ODLwj54x3NcTv5ihEbRdGUWpl7aQTvHWyd
	 WrWqGWSsgKPOZlAsmXkudg6LZR2SyCpOGx8M9zVqy8ca18kzwXsBZCa4yQ9HrcDl3O0LN
	 m/2W1B+GcL8rUFxkFTvbIcCSDszXtZZ+8O6AGX9UOojQaRVtBxFHlcEJTeXzc7cTUoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iki.fi;
	spf=pass smtp.mailfrom=iki.fi;
	dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=JADE5tIr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.185.170.37
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A8606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 16:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C15A8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=lahtoruutu header.b=JADE5tIr
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4jQQgf37tQz49PyD;
	Thu, 12 Nov 2026 18:23:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1794500639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7YIsLdDIYlb9hijyx+OvAMP78co/SY2WJJhUxILAIhw=;
	b=JADE5tIrZjfjigPk/uXXakxVILM5o6dk2XrPo8CGFqcTqXfnC/Si3ogyMsS6NdiYYEEtTg
	+JpiSed3Z2qVkuHWdSHp9QMOqkFnrBOMxvSlUzuap4zmLGs1nMQEpBWAhk9+xYkUiz1yOG
	Kgatfd2ewAj0YozN7u6SiVzjqqiXCC1ShM35d9VK3YmLNtRUw/Ow6yXQTGle38eB7wGJnB
	CD6MnsNdBmICAIUj2LUTEzulN994oHB+6PlypDgWOz7j9Is1BcLY7VK2HK2MaPlc5Xbvju
	RCMuF7/KFquV39aI2pfCMzw+AFQNR9rNVn/XeSx+mUpcjKpxxvsoxtSctjpZJA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1794500639;
	b=PjydofC3QP6UyMJxyra5vXqS+90HccOYGzIuuTLI3tmt2YyhnIql1Xs+lOITuiHdpTJoKQ
	5gatr96QJa2x4vKuRLfOyhg6omBL5NLplprNZEmm+L9hO1yD7sWmvSgP6+DKkmHHKuATa/
	HrGqmbQASS4RbD2qm8YvkihA2KJ8yJXsAyymSB8H5udT0QI9LbdbABgXChPd4xZI/kVvyT
	YAmVM4fSpYXUBmoIE7VFhXZHsYI8CC809AMamueZ26U4xzKli6C/jdAaS1SNCw5HUin0rn
	bandB7SlFlz92IGMH5St0TSiO/hcZ0Yd+D59t6SRGjwbCqLA7PL3pSLl6RDgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1794500639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7YIsLdDIYlb9hijyx+OvAMP78co/SY2WJJhUxILAIhw=;
	b=efWoL0woCTpL9u4tAfL2ydAAoIyGNIycyIbAFtX2Ppy0p/RQV9m3mtK/nTWOpxlUjCMc7P
	pBbwv5xRM0+7a9voWP9kbBl/MOMY/UPmbSptT07HbqXWirF1WzVBaa6/1DHsazwRyl4b66
	IjwEbHmbdij02yMHeWRXIomQR7yoQ+Ct1XZpP3q8bHiVZfnxKA51DF4zjgY/bN2l0X5SRx
	7z7jUqqXmA4DbiN6GxLxCF87jc3SYe+SXNmDbNqhCnnJT5XIQe3ZKnPTitYjFFvcAxZWWw
	gTeGom6YmEnMMkKq6HNQg1CTg6tRfHQZ2pDa14akiaWXxd2bdhwBH3Hp/609mA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <8d3eb065640c99cc0c2236426d0b35f9f5dc1099.camel@iki.fi>
Subject: Re: Add support for HDT and EKS
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Nov 2026 18:23:56 +0200
In-Reply-To: <CABBYNZ+dzizM9Lf1UfANaFSyiSkcOTjH6z1KRiGxKV+xvB+JfQ@mail.gmail.com>
References: <20261111200705.3802779-2-luiz.dentz@gmail.com>
	 <6af521d8.488c8742.26003.3592@mx.google.com>
	 <CABBYNZ+dzizM9Lf1UfANaFSyiSkcOTjH6z1KRiGxKV+xvB+JfQ@mail.gmail.com>
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
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Luiz,

to, 2026-11-12 kello 10:37 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Wed, Nov 11, 2026 at 9:18=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
> >=20
> > This is automated email and please do not reply to this email!
[clip]
> > FAIL functional.test_mpris_proxy::test_mpris_proxy_playback_control[le-=
vm2]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
> >     Remote traceback:
> >         Traceback (most recent call last):
> >           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv=
/../pytest_bluezenv/rpc.py", line 102, in server_stream
> >             result =3D method(*msg["a"], **msg["kw"])
> >           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv=
/../pytest_bluezenv/env.py", line 238, in wait_load
> >             raise RuntimeError("load failed")
> >         RuntimeError: load failed"
> > FAIL functional.test_mpris_proxy::test_mpris_proxy_track_control[le-vm2=
]: failed on setup with "pytest_bluezenv.rpc.RemoteError: load failed
> >     Remote traceback:
> >         Traceback (most recent call last):
> >           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv=
/../pytest_bluezenv/rpc.py", line 102, in server_stream
> >             result =3D method(*msg["a"], **msg["kw"])
> >           File "/usr/local/lib/python3.14/dist-packages/pytest_bluezenv=
/../pytest_bluezenv/env.py", line 238, in wait_load
> >             raise RuntimeError("load failed")
> >         RuntimeError: load failed"
>=20
> This looks like a recurring problem we are hitting at github, I tried
> investigating but it seems the controllers are not responding under
> pytest_bluezenv, have you made any recent changes? I hope we are not
> defaulting to UML mode since that is still experimental.

This appeared to be due to Github updating their ubuntu-latest runner
to 26.04 which breaks something in running Qemu in Docker.

This comes from bluez/.github/workflows/ci.yml --- other parts of the
CI are pinned to specific versions / images.

This should fix it: https://github.com/bluez/action-ci/pull/11

--=20
Pauli Virtanen
