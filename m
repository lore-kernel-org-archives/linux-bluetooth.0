Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073F383980
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611040; cv=none; b=bY39BjFhSZz15CKHvyZrdCNl4BDDbtlKaT5EUestXHyxSMIYOQgRI8BxkK17ZadCbhsHYiN8R2/L3TX32MeCMe12eT5PngxAtBuL3oZOdFx8RKl/jjM+GDlhdfB3U3HLteRC8VnNczCuWw1f3PITpBwsWRvkediLBylUo4banp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611040; c=relaxed/simple;
	bh=6h4r+P1ocKCuq0hSIvuGO4IvQB+ye1Ii02hiCozqA3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tm3ROiDua9EX4QDZ3RFXTFkMwh7/yJNuQPowmT7i6cjliOFxdvuhM4G8F1x0MGik77wIMDC4xUPEf6+ziwqTekAECR9fkaNJnpsGbiy+ZqeoXmrdIHdSzyAbQnsq4WuIvcmYbaH7usCSTB2H1Eanjp5TrErdHkFaBwPKnxpzNMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkfEjxAH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkfEjxAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D183E1F000E9;
	Thu,  9 Jul 2026 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611037;
	bh=edJQpdspia7OA+SGn74aMNfE/ZLxDaaADjZjXIlpHHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IkfEjxAHrCWnZK/4jbniBkFyQR4VON3f8N7dWtjybdyROgGAqIor+b0q14NTdeaBG
	 cb+HFYOfwl5F7ocBQgWLCS2COdWKyJvjWhQGFpo/sDB7of4klzYA1aeOsvpcHlur97
	 bCUtjZixx0yAxU5DGelv4tAmfI0jbKzQuVD0++xSLjfOaMuZaNg45SnXlNutfRlH1U
	 4Du68Uj5Sz5gUZPBfzyyy/+pVh2QgEW9Z3zlhXuo9kJNvcD68qVJfjifj52dLSaAhL
	 fGceuypxNdfKoRgq8dywdfL71Iy38ISKaRAdF4uZuzQuuO5nYTRBz1Icln1poLebbq
	 ll6Hj1ORJ+zBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AED39250E0;
	Thu,  9 Jul 2026 15:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] gobex: Fix use-after-free when cancelling SRM PUT
 transfer
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178361101613.3546291.5670165280886865738.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 15:30:16 +0000
References: <20260707063543.80320-1-rahul.samana@oss.qualcomm.com>
In-Reply-To: <20260707063543.80320-1-rahul.samana@oss.qualcomm.com>
To: Rahul Samana <rahul.samana@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Jul 2026 12:05:43 +0530 you wrote:
> In SRM mode put_get_data() queues the next packet during encoding of
> the current one, so transfer->req_id and pending_req->id can diverge.
> When g_obex_cancel_transfer() cancels the queued packet from tx_queue,
> cancel_complete() frees the transfer while pending_req still holds a
> callback pointing to it. Its G_OBEX_DEFAULT_TIMEOUT (10s) then fires
> on freed memory causing a SIGSEGV.
> 
> [...]

Here is the summary with links:
  - [v1] gobex: Fix use-after-free when cancelling SRM PUT transfer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9e9f0a370c59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


