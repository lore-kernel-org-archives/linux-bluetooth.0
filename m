Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D31E492D
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449627; cv=none; b=HYT9GFLRQl17Lfpf1iBxbX0vvf0etWUlaIVjMEPEfsq2mvsTIzBtF10A7TvMISWUr6TFzLAjqRcXCEh2wVzXbR66/VRGLyieX3Lt+tGSvJtjKj0Cs+Fr32P84BSpgDs2xbxnkUnROkDT6aAM+zjhaWLsKKjD59/kyvNN4aSxXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449627; c=relaxed/simple;
	bh=WZUj0M1TXLV+7M22Z9f4qlvkvUCvIUx42S0QbGRBs2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HUAwOPqcGkBxa+bxPU+1VPs+5pelpfdnWGADGTR2Y1ORQ+eXvKKpyCi3jBAdCWZU0DqWPxT4prvJypWa85hA05n92YA2jf4aR9yBqN0/O9LoHxJpix0U/muyiV9YhGviwo5ldrz7uJWVVnGntsgD0YrZqwkMusQ510pWWnJZqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXrdP1A/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXrdP1A/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C3D1F000E9;
	Tue,  7 Jul 2026 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783449626;
	bh=QDOFeFO7gXw8Gb+4eS1UBZeIm3tZ6tdvIRmF75fFy9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AXrdP1A/9bC95xF7GeEFnqUKk+C2Zp0MnanrZe3mXcKcLlSdpMTcszmrpmYL4GzHO
	 IaSfaCl/6/FiaM94J1B49vhw8ZYhmL+9uClWyx2VdjhT0bxozH/XR23GXShodPEGBB
	 1Da9V1Qo/2/PsSsMxV4locVbppdnz4dZEJVorhC/EdPoODvgBFiMG8QkRn9z7lsBbI
	 eajfrQ6huF2L3nr/ldkvTVHd/Jh5XNb+cvBxO/vFPSOxZJ/NDqE5ImWmvCma4JLTXr
	 YbHY6INjHvuvTo7mnPYa0WBHbalmrz+g3AwqkwTnSd9PGafeTYelVig0Uf7KK0a4UE
	 ej2S9ub2QVEnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1978739253F9;
	Tue,  7 Jul 2026 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] l2test: Fix calling getsockopt(BT_PHY)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178344960564.2123016.4432962508787679619.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 18:40:05 +0000
References: <20260707145536.874859-1-luiz.dentz@gmail.com>
In-Reply-To: <20260707145536.874859-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Jul 2026 10:55:36 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> getsockopt(BT_PHY) expectes a 32 bits argument not a
> sizeof(struct sockaddr_l2).
> ---
>  tools/l2test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v2] l2test: Fix calling getsockopt(BT_PHY)
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b84aa8949210

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


