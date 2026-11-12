Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794464396;
	b=3dQmTVpOgLBjgEyDrK6nsYPS03CKKDySGbtV289vIpetoLyXuS50P+GjmvLG3RzrFGVk
	 EGQ/d9IMbZqN5ufrcknnza3IrBUjTrqTdHfCjewzDgRY0qt1ucKtoPlzfd9pVaw6veaof
	 KfSDEy/sxIno7Gh/KaCwhKf99wSIZhGJgH6006zruTIbejmq2WuqTESSGRbii1qcLK8Eo
	 odS7wogc/1ZIoFsRhwIbLnjBM+VQE1o9CniXghfBzwKGsAfXmupDCDLBYl7e2VUwXZHxZ
	 h041zL3ZiTqT7xgMc8/47t7Su+pqg6b1VXhb2bPh513QQZ620RZWxZ2CCh0wVBAvSXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464396;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=neSRzhF/d5DoRVpSm0zYWoFxhd17W2VLi2BCLsSsDLI=;
	b=vjpqzdlGwK6F8piRCwvku0xFKrSFlW57/BtwWjp3pzL01DmefE1arupgSenMs85AqHvQ
	 vhAPROqoZdwheT4s/eTqrN/ZheLwHP8Kfdh7bXQkFF8JaZEeFm6eVIrHLixGAlVptcEYe
	 UnVy7C/M3FkhiDa6UAwTnA2WVWDCP25Exl8Z0+1c4xNOVDYsyuw2QKO30VIkLzZq7k/b6
	 QjoEqGBl+tzsOH+FWxw5TMRKnIL7wKwEk816zKb3mTt6+wRsNGT073Zw8baFJMdUy90ZP
	 EWOc2GEuodXV5sXMax8vR/QD0WZf5yc1kb1C7uDpTjdCL6HuddnMPNJVkuiE9QmzQlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctjilLN4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEF606A323;
	Thu, 12 Nov 2026 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctjilLN4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1461F00A05;
	Thu, 12 Nov 2026 06:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794464396;
	bh=neSRzhF/d5DoRVpSm0zYWoFxhd17W2VLi2BCLsSsDLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ctjilLN4RNMv/a6ywxFLBBf5r6QEIHNLpp1KM7XvMCdUS1jm42Geh4MwWtCMcv0F/
	 Hld0s6yVuD8QDO5X9cVCd1Yd7jOOO09N8Aem4VLDmuJJijAPvcaNh79SwCdYJqBDKc
	 zlvG3sDlX3ERr3aI/a1q8x4jbCmf9Nm43ddHn5Wz4t3UN6qzNgJc4XzPNiZcx/BfEI
	 IxjaAJGV85Rp380DY67sc73p3ylzB1l7QSUFUnG1mP68pDzNAf/01z2jmbu7a7IKCs
	 e1N/HaqV9fPx3AixTRP55vuv0nNPzaidGDCCVCE256iFAeYZAI4rfKt7HD7UUMj+2C
	 Jt9iQV47EAXIA==
Date: Thu, 12 Nov 2026 06:19:51 +0000
From: Yixun Lan <dlan@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBNYWjDqQ==?= <frederic.mahe@cirad.fr>,
	marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, anarsoul@gmail.com,
	alistair@alistair23.me, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Bluetooth for the RTL8852BS on BPI-F3
Message-ID: <20261112061951-GKA62271@kernel.org>
References: <20261111094557.443481-1-frederic.mahe@cirad.fr>
 <179442601916.1604530.1705197925952408060.git-patchwork-notify@kernel.org>
 <DMSUPKS0VL8N.1RUUESQVU8FMF@linux.spacemit.com>
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
In-Reply-To: <DMSUPKS0VL8N.1RUUESQVU8FMF@linux.spacemit.com>

Hi Luiz, Troy,

On 01:45 Thu 12 Nov     , Troy Mitchell wrote:
> Hi Luiz,
> 
> On Wed, 11 Nov 2026 19:40:19 +0000, patchwork-bot+bluetooth@kernel.org wrote:
> > This series was applied to bluetooth/bluetooth-next.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> 
> [...]
> > Here is the summary with links:
> >   - [v2,1/2] dt-bindings: net: bluetooth: realtek: Add RTL8852BS
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/c21f8cff7503
> >   - [v2,2/2] riscv: dts: spacemit: enable Bluetooth on BPI-F3
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/df348a0d065c
> 
> SpacemiT DTS changes normally go through Yixun's tree to the SoC tree,
> and Yixun hasn't acked this one yet. The binding patch is fine in
> bluetooth-next.
> 
This do happen sometimes.. I agree with the split, or another solution -
I could also take patch 1/2 with bluethooth maintainer's Ack, either way
is fine by me

> Yixun, what do you think? Should Luiz drop the DTS patch and you pick it
> up?
> 
Ideally, the DT part patch [2/2] should go through SpacemiT's SoC tree,
which would avoid potential unnecessary conflicts.. besides, the DT maintainer
did complain about this thing before and request dts go through soc tree, see
https://lore.kernel.org/all/20260918-belligerent-succinct-kraken-7fa592@quoll/

-- 
Yixun Lan (dlan)
