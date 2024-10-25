Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92508169AC5;
	Fri, 25 Oct 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870833; cv=none; b=fxzxK4HPToL/Xv6zrNkSsf+tDg7HymE6AYDoVEiVGgzWVnaRIzoh1VAkztPE4u5hz9IfO9dWXP3y+wuO6nYBSzlwfU3pbU/ZSIEMU5+bjWoO9aHXpqq8+JVIlVYJWhAOWur17DpYrKfM/jhKKasOZzabDD0NxAKIIxpLTX0LaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870833; c=relaxed/simple;
	bh=HjI+JzV1raC5Lry0ocWZJu5wPZ0AXj80BC5ZRUwkceQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P+XhBI5lZo49/fFJT6o36G+m5FF4uf9f6ctS2Bg0F9S6r9bR41SIgnYk64B/qPQFHhSzv4CHep+4N3FFYZWzCri6JpSGTkxcwLz/qnKMkA+dgpfiejMI3TTWmHA6BwVUkRh9CBPlSHVl9KcM769kgDB1WhCFpOt/ef2sAdWawjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhrBtg9d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhrBtg9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BE5C4CEE3;
	Fri, 25 Oct 2024 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729870833;
	bh=HjI+JzV1raC5Lry0ocWZJu5wPZ0AXj80BC5ZRUwkceQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AhrBtg9dB9G5+Gh1+IXkMUzfoOKn72ZkvP0CJFM7Zeh4NZuf2Xr8fVdY0jHwrZpUP
	 QTN53zG7olTM/TWI+2c7slNZKfpyYHLmfR9/nYHjDivCtsdQYYfp5GSHq5t+F/0Are
	 tUcHSTm5UF1pSJ6LZWlpresgXMl5xRBiI2HWnCdvKQIVcvewWafTzWSW4k9h2w5ikn
	 63TaHHpN10TOZ8Du/KC48slqia4/cAL6EoEg4co7DXQz73ySSlUVE8FmymOseMtNJH
	 P0it9VpcelpkMx5+Q2TgOuVrhgp5ZftXjxNSxK4FUSNeU5/j+g44S6BagWcFHBRwY0
	 bc2Uz1kffTA/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C773809A8A;
	Fri, 25 Oct 2024 15:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btmtk: adjust the position to init iso data
 anchor
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172987083975.2948690.13538212857409218005.git-patchwork-notify@kernel.org>
Date: Fri, 25 Oct 2024 15:40:39 +0000
References: <20241025060717.24222-1-chris.lu@mediatek.com>
In-Reply-To: <20241025060717.24222-1-chris.lu@mediatek.com>
To: =?utf-8?b?Q2hyaXMgTHUgKOmZuOeomuazkykgPGNocmlzLmx1QG1lZGlhdGVrLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Oct 2024 14:07:17 +0800 you wrote:
> MediaTek iso data anchor init should be moved to where MediaTek
> claims iso data interface.
> If there is an unexpected BT usb disconnect during setup flow,
> it will cause a NULL pointer crash issue when releasing iso
> anchor since the anchor wasn't been init yet. Adjust the position
> to do iso data anchor init.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btmtk: adjust the position to init iso data anchor
    https://git.kernel.org/bluetooth/bluetooth-next/c/2422d0e13858

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


