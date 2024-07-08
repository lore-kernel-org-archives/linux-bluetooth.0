Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464A14900C
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473634; cv=none; b=mJT/VcODWYtVECETYzlOdiGbfgf725rsazodEaWJIbSFqKtM3ccAS8p1j/d8lBLx9EAfN79Acm5BcDSvlRlDeosTnimzPB2FZc4bxNbYE3Fp3jZ0IIFd1yX+YFDkb4Q3Ir3bWHhAbfFTzZbyPibRyDLf/Ym/6ziOyuDCVgnVSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473634; c=relaxed/simple;
	bh=Vh8lYlDbD7vZITX3Oh8S/kotnWzLtWt8jjWW3czmptM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AlS2+VZwA6f3HfXDaS+eh43PVusGYZ4lMadLezoOZRXVhUL3TOqDAT1bEbBibNPTVnd7O7ICTQ2EuYdZDaHO1i0etlcJa2+eSlrBCUilyVewcVwNpbtZH5FURc3nDHE9fE1LmX7OrXCA3tEqPgh7s27Vc7SFV6yW1u0f9J4//Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz10IH52; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz10IH52"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8952AC4AF0D;
	Mon,  8 Jul 2024 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720473633;
	bh=Vh8lYlDbD7vZITX3Oh8S/kotnWzLtWt8jjWW3czmptM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zz10IH52zdhx3iZZWe/UmFW61G6OIVev7vhvAh7L5s9uR74OwCZ/znUUPY2DMbpr2
	 HCoD8JoYi4AQ4VNjDkqSThus5tYg++/UZBXLh6wYeHVuZwbT8KNfkCvT45VbI2trnK
	 QppPfT0oMWxDi3vpvd3O4TBxmPX3iRGfoTxg0Ur1Cza8CZvO/xCtSSOwgE0dUzzh6n
	 K6Ur6gq2xs9NAz83c37foMKYjLnhuxUDvL6rpQmTrj9dEaPyTpd5+dB91EopTDmaY7
	 eiD9E57lnGpYWng2vf4T8w87ADUh7eJki4X/TGcY3B7XOlP9vY24dwO0+/Clozi2KS
	 G1z0W6a5dnKkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A2B2DF3714;
	Mon,  8 Jul 2024 21:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel: Add support for BlazarU core
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172047363349.9973.18099512977219955945.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 21:20:33 +0000
References: <20240705102923.3512817-1-kiran.k@intel.com>
In-Reply-To: <20240705102923.3512817-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Jul 2024 15:59:22 +0530 you wrote:
> Add support for BlazarU core (CNVi).
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [v1,1/2] Bluetooth: btintel: Add support for BlazarU core
    https://git.kernel.org/bluetooth/bluetooth-next/c/1126250fa38b
  - [v1,2/2] Bluetooth: btintel: Add support for Whale Peak2
    https://git.kernel.org/bluetooth/bluetooth-next/c/41473738be53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


