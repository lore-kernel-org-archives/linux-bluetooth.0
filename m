Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D0D346792
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704212; cv=none; b=C6Xk806jenWKgXeLPngBjm8ZEj+9VbgafA5W1MZozu4QWtoymOHD32xFeqLwX1tyO8DiWFEah9gELWuo4Hygk1pLgVUTIFQpoMa/3oUyuXCYYB+v5KuRLJclQj+Foiq0o8QmiizHoENpA6MWc6XnAlnbJIEi+jrOqVcH1MWzG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704212; c=relaxed/simple;
	bh=n66D/MNNFEBL3GF/+dZjE/xAaesgZpTG3yhJVq9iN4g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oT+b8goeWaBO8KgRGZYfVbe4Ox+23lRDhxQ/Qtv7cOghfmhkMAJjMOCTYU0ygG3Ri88pZlmd8TVlQr+jWgG4DlFoNbEDjlwS8kanpfDBYKdVK1qyKCM4PIl/D+bcYhzO88J7m638ONxZx6r4xJl028SWpEsGWlmKbiIomSpf/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFi2bMSa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFi2bMSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCE7C4CEF7;
	Thu, 29 Jan 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704211;
	bh=n66D/MNNFEBL3GF/+dZjE/xAaesgZpTG3yhJVq9iN4g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WFi2bMSao2v1qbr0gGrQVTyORXyvSbp+Dq5WEka2pY8oaidpb0kPrifBWoEfO2L5V
	 e2/9Rqu1nE4q7U/+2UlfM3LMACUoa0AG1csXwPDxDP8oLS/k0SYlhyhXUgtIaI/izc
	 LN5WLsH1rsWa7J9TRZooUbKUHmovQ1eqhv68FxEMC68rwLWd/8rdQzKaAnQWSf5zu1
	 eiQfPqNeviKY/R60YGLMy7fW6ILOSCLgRs9EJGYLkXK8yru4ua3LkyVIQspo+uWQRX
	 bCcQcyMOI7JGJebDSM3fQp7b41tUQWhHDn8E/xhQ+KrmuPKpoWhFN6HO2BzlWmG5ZF
	 4k76GV+i3w/dQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8CA7380CECB;
	Thu, 29 Jan 2026 16:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] media: Fix G.722 @ 16 kHz codec ID value reported by
 transport
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176970420460.2563498.7347833153547034544.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 16:30:04 +0000
References: <20260128103809.2679085-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20260128103809.2679085-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Jan 2026 11:38:09 +0100 you wrote:
> The G.722 @ 16 kHz codec ID is 0x01, not 0x02. The 0x02 value comes from
> the ASHA ReadOnlyProperties GATT characteristic which is a bitmask with
> bits corresponding to codec IDs - setting bit 1 gives bitmask value 0x02.
> ---
>  profiles/audio/media.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - media: Fix G.722 @ 16 kHz codec ID value reported by transport
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ebb33150ba76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


