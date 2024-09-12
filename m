Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A1A1B9B33
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158793; cv=none; b=jjCgQQere1/fK/63qkMiPyrZFeTsozJzWggFVEHpQFiUER14j6Smhnc4hGdVyX5DmyT9S2IVgc/2xdVLQ03Ezft3t8JLun7NrGScstyhfMfC1X1T08Fw8kKYLRoo6PouAagCDg32b+pp65HkhUrl4xRpczS/CYtcPBQHGo0Y+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158793; c=relaxed/simple;
	bh=4HugHkccPZlNbvrXyvTzKGBaRMK6q2+dk4qQa5Z7WZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ndC4O9DC4pUEOgN8Z3dNlZBkXqmUTK1MbSY1+M91j+YH7P8E0hkns3ZGUBbvF8GcIaffz2FZ1V6XWECzJ+L8dQGivKNTeBYLD+XxBER56oARMf3Tbe879+1iGdHPoPgIPNGw3LPO9UQK3R4DgjLl/gngHWbT6fZ6Bi1lqpxwEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpW2spFb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpW2spFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E02EC4CEC3;
	Thu, 12 Sep 2024 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726158792;
	bh=4HugHkccPZlNbvrXyvTzKGBaRMK6q2+dk4qQa5Z7WZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jpW2spFbfkwjPkEEKY6odbJclEXl1bazfNBSh/LwxOTICsxNZUDjTnxO/R3GxGdtL
	 w86x9uEN/wjN06vBClfbZfYmw6t1m2u2VeRyfCy0gwVQRcbPzQ/WkdBhDx0zW5lJAY
	 Lp+bXWwCSplKcFrbTVuajd/TZ4gPkprCGjKH6qdRs38zg2wLgU3r4O+6KLXY9xRAjE
	 mBTeEWwuhd3bRiaeA0+p6712oRax0D1ahzO5YjrJvBreeWoR031cDqwKCjUZzZVwBf
	 Ap4NOJo4t88XFRsaktz8lfk0QCYFZ3F/Vw2jU0g54Z+WYn7f62Mf5RDWErqUB63QLg
	 2eoOpSVJpE8Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB02C3822D1B;
	Thu, 12 Sep 2024 16:33:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btusb: Add 2 USB HW IDs for MT7925 (0xe118/e)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172615879350.1648954.2614457145292861267.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 16:33:13 +0000
References: <SN6PR01MB5070DA7BB9E7C6FA574D1E4CA5912@SN6PR01MB5070.prod.exchangelabs.com>
In-Reply-To: <SN6PR01MB5070DA7BB9E7C6FA574D1E4CA5912@SN6PR01MB5070.prod.exchangelabs.com>
To: Michael Burch <me@michaelburch.net>
Cc: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com,
 pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 1 Sep 2024 04:28:47 +0000 you wrote:
> Add 2 USB HW IDs for MT7925 (0xe118/e) to ensure proper recognition.
> These HW IDs are extracted from Windows driver inf file https://dlcdnets.asus.com/pub/ASUS/nb/Image/Driver/Bluetooth/39389/Bluetooth_DCH_MediaTek_B_V1.1037.0.433Sub2_39389.exe?model=H7606WV
> 
> Patch has been tested successfully on an Asus ProArt P16 model H7606WV. Controller is recognized devices pair successfully.
> 
> Signed-off-by: Michael Burch <me@michaelburch.net>
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btusb: Add 2 USB HW IDs for MT7925 (0xe118/e)
    https://git.kernel.org/bluetooth/bluetooth-next/c/39e4bfb46674

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


