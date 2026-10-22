Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683855;
	b=UCUYobuajg+16ZkDW45eExcXQ5cxAHs9l3Y4BSvy9H0wOyRIFr5JBmV//fhbrzQwsq65
	 GT1dXqwJYeDVWcRjJT4V3l5DIplDptqAgnzm2DoV8C2c/h5tXuwDKqZ/ru5rDJntlqkpO
	 yNqwUHlVVazbv26/6WVuhlcx9QBrNZH38uIOFvWYKIeamBjqkUfbkqL8vXtmw3dD9P8PK
	 iUOAF+Y1Hi64WbpaB41DFL2Nd65cjgRgLEJLZOngRClqXfvwmQ7cjAz7cnKQFIyypi2t+
	 W2xtfa/M4tG2lIsh/NFCm6kdmFfEtLPdLmr+BIPRtDYyCzSZZm8asApeToDc5ogwRZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683855;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=18DkUEOk53azBQVDImiEA9Prf/53zbNW1Dm8/6ddOzA=;
	b=2iD+lXwy91txd/GeNCngDrmxiQnGDi4s/x+De4OxNvY+3ASoPYp+KWextxYKhl2HFELO
	 EOKA29MMrdFYDHkNeYGmanXSCgQlzLOHU8KjYSkpCM4vc8ARPN3Wg56DJLbV1uwH9tODK
	 siTXV4UhzQt8ruqnxQ3ih6P0ecvitrLarooDtKzVlRKoCte++4xXPgXRdXx90YzdWu5Fx
	 B9JnYmDtUU0oUOz6ra0clD6dKJz47K18TnxTkYJnHB2cpFDE4N3DyVc+xvm5oT6+RvykZ
	 FASYrBkipH40S1PWa/fevafuQ0f8ZIa3O4lVIhl5ZoIiyOLzXWzVFFTnjcNGetfZGug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOJvQ7Wd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94AB606A31F;
	Thu, 22 Oct 2026 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOJvQ7Wd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E191F01825;
	Thu, 22 Oct 2026 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792683854;
	bh=18DkUEOk53azBQVDImiEA9Prf/53zbNW1Dm8/6ddOzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DOJvQ7Wd67T7Wbw6YSuFgeKACthsYJONEbGREJQQyCyvl5yETlM7WmdIpENevhU+b
	 gxr+hXrsm3HV6DQafWeQy0J9Wd3jEO3FJHmIQoOCxaq0MlVZeJ3efXXnu/gnd1AClG
	 slizibdef5QBm06ddSK9XH7cvLLf/1Q/LHacGmm+AUE30D5M9C9RPvxp73r/AbGYd4
	 euWc2mtRsZslWmPvmSY07ZgCT74WnPZMPIsvCfZxeDWFwA0CIeYcWNv/H1DFdP4tI+
	 seiSZ3Qc6MzrPjIYQa90vHJVCVY0899UOQ0uIIenoDUxQG7c/d4SvQMmVBvpBU7U8m
	 JLptH6/Nt1AYw==
Date: Thu, 22 Oct 2026 08:44:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] Bluetooth: btusb: disable by default Qualcomm
 multi-subsystem
Message-ID: <20261022084413.5d14dee6@kernel.org>
In-Reply-To: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
References: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 17:38:06 +0200 Paolo Abeni wrote:
> New knobs should default to 'n'. The mentioned one depends on
> BT_HCIBTUSB, but the latter is enabled on most systems.

FTR added by commit:

3669487308f8 (Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072, 2026-09-13)

 drivers/bluetooth/Kconfig      |   14 +
 drivers/bluetooth/Makefile     |    1 +
 drivers/bluetooth/btusb_qcom.h |   99 +
 drivers/bluetooth/btusb_main.c |  121 ++
 drivers/bluetooth/btusb_qcom.c | 4557 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 4792 insertions(+)

so this is clearly gating new code, by Linus law the Kconfig should
default to disabled.

Acked-by: Jakub Kicinski <kuba@kernel.org>
