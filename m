Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939299;
	b=FcMbU9amMQ5kj83f14D+vu2GRQXlsNWjAbH61PGHrhZpAmUhXG/eNJ1w0w7GdYSOGLFO
	 cFbbwGEG8WU8mUWxmAFnqQVKo8JeIXcV/Mkvji9uNjDDvpR0rSvTarUr8xycGcuK52Ven
	 xIV+ODU2bJfs6idjfYLUvmwnkPwSUBv6LLZqflVAxE/C0BLXFmHwtlaogJ55PKaKbNTco
	 p1ZQaeqHbR8C2RwiOQtO188O+VGhhCia/l2qeqKuNGBobg0o3jCvPI1eW9B5C7Tll6nKg
	 tUpgZkJZczIKzH9beZbcz7jA5KZlSXJ8Diceikr6bjSg3IbFART9X/uOq0QB+9wgzmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939299;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=VUbLFpGC6oJfJwdNxVP8oejHx2h8X3UnbAiDfBqngiY=;
	b=NSIK/dbfAfocHZ1e/uqPQQoxyeeh0UrWErKxxEK4yoEx2C+x/eE5Gszl8CIlZ1vgcNcl
	 K6+mjoA9jfYeDForNNI1mPZPqYyDUmHzza2VeRo1nSOg8cGLpF+dYtazU0tgf+tSVACDn
	 2J1KDq0R0EtK+Lvb4R1vsT1O6MjZdiabHm7/66mWOTNuwTuVBpIjEoKUiYcn43fAbepi7
	 Cp+x5fZpueRKJ9K8mt/zPIRVaQVqRRrFl6IBLcQYi45+1o6wStw65Y2YN/lDliUfojsTh
	 iZRL8/CNjWFN7t6fVS5Wy5HUw19L3hpepHG61miG5SxKfYXFmxHdnqoiiUWVevDyC4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=W1+jZ6o9;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619E606A31B
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 04:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8619E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=W1+jZ6o9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793939294; x=1794198494;
	bh=VUbLFpGC6oJfJwdNxVP8oejHx2h8X3UnbAiDfBqngiY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W1+jZ6o9iwwDynJKl+Pwq/pWQcpkv2r6xPoEUXpwDKtLfE1q45Xgnuu6GDA2n2etu
	 wenxxjnkB6mu9IuL5wxMp3Cur18IhuHHDTGiFJ40wOAEaY24Lkx+2HHq0g/+OEUNAQ
	 eM3vDYGL0ukRtdv8cmW2cUOg8zFEvh0R8fpt4Cd7YTdrBl6kAiZlEwKiBYmiPhlAco
	 lr+TmPNEtGYyLos/amh05FQoEF0xOIiasmbQJ41iiRbeO+dZq0TSG/IDXRqCtu6qUd
	 /7rDW5eWjpnBmnfQmqtzxGPtKR3/bMjdIOjb7s3VulQhAl0E1JGC0YC/4vrT3AEc1J
	 Z4Q34MBBqm6Sg==
Date: Fri, 06 Nov 2026 04:28:09 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: Re: [PATCH 1/1] Bluetooth: reject invalid LE supervision timeout relationships
Message-ID: <O8KSCk4Dqp1dOjSn_XmazuZF_32_hNdKU_RUTXgga7xPpkYoXvQWc0uEEDHhp4y26pjYI3LCaYhCt0g5L_csS_uZitb6Uo9YpbBfcPOaqiM=@proton.me>
In-Reply-To: <20261106021809.631456-1-cochcoder@proton.me>
References: <20261013033118.501182-1-cochcoder@proton.me> <20261015043336.47734-1-cochcoder@proton.me> <20261015181041.42873-1-cochcoder@proton.me> <20261106021809.631456-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: b024a9441cc69009f4b236e9a45c0c29887769dd
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I sent a separate BlueZ fix for the timeout-wrapper use-after-free
reported by l2cap-tester:

[PATCH] shared/timeout: Keep callback data alive during removal
https://lore.kernel.org/linux-bluetooth/20261106042339.811655-1-cochcoder@p=
roton.me/



On Thursday, November 5th, 2026 at 9:18 PM, Kyle Pepper <cochcoder@proton.m=
e> wrote:

> The LE parameter validator calculates an unsigned maximum latency by
> subtracting one from a truncated quotient. If the quotient is zero,
> this wraps and accepts invalid parameters. Exact quotient boundaries
> also accept equality where the supervision timeout must be greater.
>=20
> Compare the products directly after checking the field bounds. The
> validated interval and latency limits keep the products within int.
> This enforces the strict timeout relationship without division or
> unsigned subtraction.
>=20
> Sashiko identified the underflow while reviewing the soft interval
> preference RFC. The bug is already present in its unpatched base; keep
> this common-validator fix independent of that preference policy.
>=20
> Assisted-by: LLM
>=20
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> Fix the pre-existing validator bug found during interval RFC review.
> AI review: https://sashiko.dev/#/patchset/20261015181041.42873-1-cochcode=
r%40proton.me
>=20
>  include/net/bluetooth/hci_core.h | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index e33b15808..97ba716c0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -2371,8 +2371,6 @@ static inline struct smp_irk *hci_get_irk(struct hc=
i_dev *hdev,
>  static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
>  =09=09=09=09=09u16 to_multiplier)
>  {
> -=09u16 max_latency;
> -
>  =09if (min > max) {
>  =09=09BT_WARN("min %d > max %d", min, max);
>  =09=09return -EINVAL;
> @@ -2398,19 +2396,14 @@ static inline int hci_check_conn_params(u16 min, =
u16 max, u16 latency,
>  =09=09return -EINVAL;
>  =09}
> =20
> -=09if (max >=3D to_multiplier * 8) {
> -=09=09BT_WARN("max %d >=3D to_multiplier %d * 8", max, to_multiplier);
> -=09=09return -EINVAL;
> -=09}
> -
> -=09max_latency =3D (to_multiplier * 4 / max) - 1;
>  =09if (latency > 499) {
>  =09=09BT_WARN("latency %d > 499", latency);
>  =09=09return -EINVAL;
>  =09}
> =20
> -=09if (latency > max_latency) {
> -=09=09BT_WARN("latency %d > max_latency %d", latency, max_latency);
> +=09if ((latency + 1) * max >=3D to_multiplier * 4) {
> +=09=09BT_WARN("latency %d, max %d and timeout %d are incompatible",
> +=09=09=09latency, max, to_multiplier);
>  =09=09return -EINVAL;
>  =09}
> =20
>=20
> base-commit: a063a00e6cd9e354aa6d67a154a0527951d7f881
> 
