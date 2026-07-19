Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C913A258;
	Sun, 19 Jul 2026 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466936; cv=none; b=YR8D6I2GmsNPt4pjwfN+OGuMaoHqrcp21xpKYG7nKekRkMAjmWsi4iDFL1taNC2tqzcFEZkSCnqpdhss/jI21dU2oKWfXAqPkdGOTIztl4iPgoL7pjQt7qghkHkOgrCbpQkARJcoL2freyMMDjxWNeiJxTU3fxzhi6Tw0g4O9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466936; c=relaxed/simple;
	bh=lxCy6+4tgaC+do2rvc0+7V+EUsdw6w7kQ3US3qb8wy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2b7ctT7XdU89L19a/VI3m5E2EWvvZvdKuyygoNuZDeFtqKvHSKUr2Ki5n2RtxqvUZPTrwcAjOXfdGKS+GjbbnSEefB0hKv2GG975oPpUqYjxQZMvy+Oa7ytmLEnue4RSVXH6GGEDDb7pZxDX6ytD8RH/cZzx6CItHJdVHa8+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgmli8w0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgmli8w0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE74E1F000E9;
	Sun, 19 Jul 2026 13:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784466935;
	bh=lxCy6+4tgaC+do2rvc0+7V+EUsdw6w7kQ3US3qb8wy0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bgmli8w0LfTMb84cf4Usv1oyZxqOEFetk7IgX+b/lMYq21NtFhpZJJAz7Oyifh3wy
	 XPjiqrsUORQ9CKSnMkJJ6VVcg1hY4etT8P4vrZqviYWXehBYjvNZHb9WZA5kQemigU
	 Y+1+AdeWWdLeiOR3EUZ5LUH+XAkYmwJc39uRNQDs/NU7fy05f5ZvMgW+Bb+wzo0ATO
	 pQNdOzvTI11eegJuSAbbFJ5Ijlov59D/p8OgdpG25uXwjVZbU1XSuqYNUTTcBE8C1f
	 g9dx0eQdmTn28gJR8uzEA/JeaATKUdjkkpifuH7o92ZNG+lcnwr9M59Fx3ENq7EaOX
	 g/1MXbTONiJmA==
Message-ID: <e48a3602-0871-4675-a80c-154d58ce7243@kernel.org>
Date: Sun, 19 Jul 2026 15:15:31 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] Bluetooth: hci_bcm4377: Use named initializers for
 pci_device_id array
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Janne Grunau <j@jannau.net>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Neal Gompa <neal@gompa.dev>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260718172513.986134-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260718172513.986134-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/18/26 19:25, Uwe Kleine-König (The Capable Hub) wrote:
> Initializing a struct using list initializers is hard to read, compared
> to that using named initializers is more ideomatic. Convert the macro
> used to assign values in the driver's pci_device_id array accordingly.
>
> This change doesn't introduce any changes to the compiled array on an
> x86 and an arm64 build.
>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---

Acked-by: Sven Peter <sven@kernel.org>


Best,


Sven
