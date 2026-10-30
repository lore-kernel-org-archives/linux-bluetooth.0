Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360455;
	b=qvOUzKGy16OqtJpxcjGruavXbW3IAfudM0OhiXIrN5/pd4LydJqUEQrR8gFHLvKV8h+/
	 6DKljqXo6+6OZ5RZ1RXz9//5vmEEWq+Z+ubI4JEOc8/L5WeSXjQl2XRHdYuN+TbL+o7fZ
	 dpkZK2tazuOffXQ8POvmQwE69rn09t2MfLiV1KtMYQWydvHZc+m/MwwlWyc3j1CEUeDPv
	 YIvnTY//Zh+5rj5p/BNkIE+RLtUSZ12DsDIINbKf5wmhsbkuTYF9yDLn6V2xl1x3imlyA
	 XhpmjA22XoYPOEun0lMvyJ6NCDAPiUzKKQmj25o7LhUfOVa0tjCOaJ61rGwSrM45mFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360455;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=1CrdMhtr9XtYi8Kjb68AsuSjBPC8FcvJG5QbjpiJl0o=;
	b=qXVbJPQgMm8u8Y/Ohu7w/YuMMeM/l2dJkoaMi0Y3hU3EPiRA9neb8v/SZk+eoogCA4Xw
	 lgQB00xqAgtV/pjwllHHir2EMlo9BG4YjmjNAlxDKEqVJxr++kJadyxzHJUKR9Ms8c2gF
	 +J+wWpSymvRRlmyaVijWTbHoje0siYMPDMwxIAsTK2HSn5KpBPrnvZUgzrDBaSicdA/EL
	 xIdwjRsVXml8T/ZGfZ9+tNghW23hvCnFv3Sv/CiNZCnopmts2E5dpuRXZxJ3kf4Fg2et5
	 VhAJliZeG/S6Xo9vJ9rcmQDKuhkcwZ9AyLEfIKOT4cyTswmxt5cL19g0TomhVqOsW0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fyw5Rl1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDCB606A31F;
	Fri, 30 Oct 2026 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fyw5Rl1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E561F0093A;
	Fri, 30 Oct 2026 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793360455;
	bh=1CrdMhtr9XtYi8Kjb68AsuSjBPC8FcvJG5QbjpiJl0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fyw5Rl1w5pJVTmbyrpVTQd58oKUZqEvR7qT2p21cWMF8DB6mDJfPmnblVTHq3bvrn
	 qVu0gHCNmhdihjXKQ+/E5V1x0SksRhuBuaP5M6XjNeR2j59cqA98YorUAQaqQqt5RE
	 Nq2GUjRkNvTzATqP2ufOIJdh2LAqncjv+JHlSm6LkzE+DEfuwags+M/FWrIULIcLFX
	 sC7Y0PHq0tb+K9RSdgvCmrXxpEXAghZ4hEy+ihFgrYpiOSYEAQbibIJcRlLTCrKERx
	 PuPAGsLtLFSm4FOfUwYp1JBIGFQWXV5lystWac0yplKccz49jS1BD7Zhka2DuQa+Vl
	 vD5W+5rj6g/Rg==
Date: Fri, 30 Oct 2026 12:40:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: christian.koever-draxl@student.uibk.ac.at
Cc: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian Stefan =?utf-8?B?S8O2dsOpci1EcmF4bA==?= <ckoever@outlook.de>
Subject: Re: [PATCH 6/7] dt-bindings: net: bluetooth: amlogic,w155s2-bt: add
 amlogic,shared-antenna
Message-ID: <20261030-ambitious-muskox-of-jest-e4bd6c@quoll>
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192338.209574-7-christian.koever-draxl@student.uibk.ac.at>
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
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261025192338.209574-7-christian.koever-draxl@student.uibk.ac.at>

On Sun, Oct 25, 2026 at 08:23:37PM +0100, christian.koever-draxl@student.ui=
bk.ac.at wrote:
> From: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
>=20
> Some boards wire Bluetooth and Wi-Fi of the combo chip to a single
> antenna. The Bluetooth RF has to be configured for that, which the
> driver currently only does for the W265S2-class coexistence parts.
> Add a property for boards to describe it.
>=20
> Signed-off-by: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
> ---
>  .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml           | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

