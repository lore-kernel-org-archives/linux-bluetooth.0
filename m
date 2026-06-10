Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00B3F888F
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106019; cv=none; b=G9LbMMZnbNkdLFXXAGmcDCnwS0IqaWrJH84r1X+kduiUu5F13xsaZU3wwXaOx//7pidYbr2poAPdi8YWZopT+eLvLZoEL9uMwd/Pg8U7NGSAm2SmEv+qZIH0YYCjoakNYWTyaW+jW9J/PS/Fuj6mDJI9lckC7BvtyfFlC6Q7Rfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106019; c=relaxed/simple;
	bh=AX48HuIINsWgQOJ0iisBKQVrHuwgrcLPFYpoxthcqHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qJPfuwfckkiq7uQ3/TKpgFbqReT2qNqdkrRR19Ydnbgs7ScD38T57koEn2/Fk148c1uGIid4sVtAEqWGfFDc6EAgQ2oZRbFx3fgJizkG5L8v0nEury1tdLmtQ/DCPmFeAk0J7hH8cq/fRyElvgxTY6YA/LyNUWa1XjP7jjIdhmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXGBsj3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXGBsj3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AF11F00899;
	Wed, 10 Jun 2026 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106018;
	bh=sWZkeUDTICOpgLS4n7n3m1DNkfGAqozd1Oj0ljK2Hvw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oXGBsj3Fdo3p2V1GD6nF1cPJfWp2bsW96tOB7sS8h1s2e1oNCyilTnspoL9LomnVG
	 XlhuxyQL+0hkL+LvVqs9fQqEaNhLzvn5Mo1hj9/WxzCHPaCQza6yih6SX+p5boaqHw
	 XbXFS3RLsofQjaxlO6J16wBnpq1vdpXsdjHZMXdQg10WUECxZegvPI8w1NpjntsADy
	 UFlLHM5C/vXUOSrNCfdrHd1E4X/1NM2s5u1CC2AzbyRFxMkCKvBeETUU+9XBRAOBAk
	 1OFmOWPDx0wHdyrlF7bOf1cgUYMpjwXQWLIcFJkC7trRmDKw8F4kYNCMZXMyUsVDiM
	 80vy/zC8jxrFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5685D3930D7A;
	Wed, 10 Jun 2026 15:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] Bluetooth: hci_codec: validate capability record
 length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178110601591.3101197.7289209154305799030.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:40:15 +0000
References: 
 <4927cae4fe043f3e2aa80f4ee6bed05e4fb5a6d4.1779633761.git.xuyq21@lenovo.com>
In-Reply-To: 
 <4927cae4fe043f3e2aa80f4ee6bed05e4fb5a6d4.1779633761.git.xuyq21@lenovo.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, kiran.k@intel.com, chethan.tumkur.narayan@intel.com,
 ravishankar.srivatsa@intel.com, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, xuyq21@lenovo.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 29 May 2026 21:12:25 +0800 you wrote:
> From: Yuqi Xu <xuyq21@lenovo.com>
> 
> hci_read_codec_capabilities() validates each capability entry before
> adding its serialized size to len and advancing the skb.
> 
> The current check only compares skb->len against caps->len, even
> though the code consumes the length byte and the payload. Validate
> the full record size so the cached capability length matches the
> bytes available in the command response.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: hci_codec: validate capability record length
    https://git.kernel.org/bluetooth/bluetooth-next/c/246dc2ed724b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


