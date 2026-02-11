Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323FC2EA151;
	Wed, 11 Feb 2026 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770838811; cv=none; b=cNsjuXhciwfB09xA4y2Xyy80B/mNBPF/XmV11DXZan80oZfWYpF76uhBoKF0yjrj3X6DJlLZpEOeiXpiGRS0tk+Q+If0Mt1dsX5Qrv+S2U+8X0gmMihl/ErGfJsOTPI/3KabG+kMd+7LYKroLhPnQgoTei5i08VbxcoXvEszYUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770838811; c=relaxed/simple;
	bh=pW6agFvFBsR3iZkfVOxXUj+mmNx/Qb1njeVmRcE3KOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KEc2hhL4OO40qPvr+yN/IcfpAozjxw2SNZqXR6jHTmXVxGqRfKNa9R++oLKujFaF/fDM/LATgqkv8aj+KudcmRRtHqW+nx5qCgLANUQtmn7zMDCwk+BsoIgzQB/JLZqvknleKoFpl8bU2KE+dGQHPZngbccPX6FxP2S3ou8MueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h51bmuTB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h51bmuTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD58C4CEF7;
	Wed, 11 Feb 2026 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770838810;
	bh=pW6agFvFBsR3iZkfVOxXUj+mmNx/Qb1njeVmRcE3KOw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h51bmuTBZx8atIlixmyh3ldYIZU3sjN6lV819BgEJJfCIfw7p9RNj+aVPVXHh+Mc0
	 qZsKSVCVldxAPiSrVafey60loZa+YVIyYmMlnQ5BCrlkeO6Za1NUEY4lL3HYc1p6sG
	 p2NcOTaOz4HIK8S8AiHfylpC5IDoRaLqsvksWFcv8gIGe/JXriA88u2JXhietIekV7
	 AcdZXylUrO6CO32jApcbEhD38oIaFztf8vynA+W1OiD06PUhbGqQ7Oh7Gi2W7Je9m5
	 d9ZDalh5Ux9dFTNol1LWbfI6r9Ew3WvkT2m71QAhO1TC/vwbVFVa6oqvav8UDt+FNm
	 h568ayE37PoKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C232239EF964;
	Wed, 11 Feb 2026 19:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btbcm: remove done label in btbcm_patchram
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177083880533.688115.14177184498868298088.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 19:40:05 +0000
References: <20260203071048.1624461-1-jindongyang@kylinos.cn>
In-Reply-To: <20260203071048.1624461-1-jindongyang@kylinos.cn>
To: Dongyang Jin <jindongyang@kylinos.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Feb 2026 15:10:48 +0800 you wrote:
> There is no point in having the label since all it does is return the
> value in the 'err' variable. Instead make every goto return directly
> and remove the label.
> 
> Signed-off-by: Dongyang Jin <jindongyang@kylinos.cn>
> ---
>  drivers/bluetooth/btbcm.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Here is the summary with links:
  - Bluetooth: btbcm: remove done label in btbcm_patchram
    https://git.kernel.org/bluetooth/bluetooth-next/c/7351872d71d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


