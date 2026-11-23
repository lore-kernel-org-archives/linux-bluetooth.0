Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448307;
	b=b2/itlHra2EVfRELpGP44uO4XOi0vLnK1o9DStC7U6SNEdaJYJTPUzbJO7xK/WIxHwRt
	 m4qPNUs0jxKBCXWyUdCYa9G2qzVIDbsIg0F4nyLEfV3Zn9ln6c3/AsKUKP9pVYLmW4zRP
	 TtL3RUr4CWctxJmFimzLJPz4fKcQqsyHP6YGiCO/7oAX5w3H9hBCRkDg+xmUfCieRBaOb
	 z+O84x/GWIDJdaRzWWwl1JcfCf6pvom8mX5n4TvmquHfuAc3e4dYyCTxX5Z8saqUHwBvw
	 p4uAsOB5C0KwhzhB5DPxhY3+scwXPa8i4Y3hPVFcOsttawhFn8Cim8DZRo3xYxrr7AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448307;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mvP4StCLFnrfhMTTzT3GA6loA7QXzjD1GihUYmhhsZA=;
	b=cDWkMkt5zXVDH6VJUFopfbmeC7wrbGDTmm5xsZh2AxzaFpJT9NlIAcI/wFhPDdcAYvJF
	 9qC9ff1WUP/xT7bayKGWbwPPkgGZDjhGJjxP1Jd6CN7ZxV+IhUvVKZO97C4YYkiFqEzTF
	 XstExbwK9SV5gRE6IR3XGCYs+PTJnS8KsZsArcXCDPJZfL5ccTwzT4fQHYKqDV8jGyH2i
	 5pbkeMsgNPR6OqkmRDuXGPyO4D06DSoITGc5sqOFoODInqInURjaYWOSgqR3MtxzcERJq
	 b4wnMIbT3f9Bd4VgQTbd1ozHz/zlwLaGjiTdITwCikL3yzPyz+vhGSm1CuuQlsuxYOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEljJ3pP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B0F8B606A31A;
	Mon, 23 Nov 2026 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEljJ3pP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C8E7F1F000CA;
	Mon, 23 Nov 2026 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448307;
	bh=mvP4StCLFnrfhMTTzT3GA6loA7QXzjD1GihUYmhhsZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eEljJ3pPav7hXov+sLp0SFXn365X/pJXTV06KSqROoCnCZPHwqOfPBe+eDtQynMl5
	 0nYQkEOLF3f5IwxzQ7+cHv9oxCVarHi3GRhVSNlKI49Ax25ZhVWAyKweRegfTLlU3a
	 h2HzhagJyUX3eg8dAfpDZIM4iCEYV4w8UQPsp28RADBmBYxn7bNeP5Voi0V8wlQ2in
	 0T2fqIlLmmBMloo6Ybvljsa5njKGFzj/6qALAVsCJyEsEL0ekW2ZEuDkOfe/Al0Wrw
	 IeMVoCJmdP5tUMZMkQJhUqdnPv364Pwtso5NM6pBLflh0/SmJPnoP/GfjLcuA62NEC
	 nDpK6VnJI3PNA==
Date: Mon, 23 Nov 2026 16:38:23 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Michael McAllister <me@michaelmcallister.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_bgodavar@quicinc.com, lumag@kernel.org, mka@chromium.org, 
	markus.probst@posteo.de, shuai.zhang@oss.qualcomm.com, enderaoelyther@gmail.com
Subject: Re: [PATCH v3 0/5] Bluetooth: qca: Power off WCN3950
Message-ID: <hvwqozj3r7n7igxw5qogu7xxya4fkhqanb334sroj37ufzdizu@qarvtlkkulmj>
References: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>

On Mon, Nov 16, 2026 at 04:26:21PM +0000, Michael McAllister wrote:
> Hi Zhao, thanks for the review. I've split the serdev unregister fix into
> its own patch as requested.
> 
> The final code is unchanged from v2, which I tested on my Moto G10. I've
> also build-tested the standalone fix and rerun the regression tests.
> 
> Thanks,
> Michael
> 
> Changes in v3:
> - Split the generic unregister fix out as patch 1, with a stable Cc.
> - Keep the port-state-dependent TX flush with the QCA power-off change.
> - No changes to the final source tree.
> 
> Patch 1 applies independently. The remaining series keeps the separate
> Marvell port-lifetime fix as a prerequisite, as in v2.

Then send patch 1 separately. As it is, this series doesn't apply on top
of linux-next.

Bart
