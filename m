Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0F25740
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235230; cv=none; b=oa5Y379+pyXULtCyiG7flc/qjFLfehBJklgtRMAzEDxaa2rknIelRyUCCgD10hKE+rY5EFQlec2TfM/g8/qVrGsvjkXMkj4nap2MlY8Ef3kZwnkPD9vnETH8Uee127n3kwhOsKSMaPtvqpWG1Xn2BJW8GAuXoh0KnLgOVzIm0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235230; c=relaxed/simple;
	bh=KhzR33bW+/9A0YPeziguQ574FjIx245YFk7GT9BNrX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sCeqjKZOmaWzHrSV3BYgmXTc7rtnMFOTJZ+YLlJUc6Y9P1/KnOQ9+4gg/mTPHs0Td54ukIEvBJ1sedhwW4ov7EXselhJrwmi3IvlzGwTPmd78gjrIS6ZupmEzbM0OBY2m3/AYzy1cdpeMnORLYt8FzY/N1YnOsVxJgdG7rHb6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiR33eTq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiR33eTq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38FB3C32789;
	Mon, 20 May 2024 20:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716235230;
	bh=KhzR33bW+/9A0YPeziguQ574FjIx245YFk7GT9BNrX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KiR33eTqUjpeht3uceqZhoPvI95ka3h3wKCcjqfysY2DxnlYqkMpKsLdbrLL+XAxp
	 KC5zJ1o6mXdLUij2HVc+V6Hlav2JioMtG44KzKJeNBF8h891YO5uyXoWdPiPnsJfw6
	 G/HFRPp4jo+sVtMqDPGjz23vNOpztl9LbYwMxdA/s3Ktixc71VIbrliG9+RyTBKBrw
	 eaqnwJSq2W+NcreS4c4YsAHe1E3RyM0DnxdgDg1e/dz4pFPBfq3Use5Pn251RpSpgY
	 W6CR4bxAHjJNv/N8Mqu55cZe1FRfsfQQvgE8QvSXgmzRFDLuAwMjXtzxO2ZJeqhj3t
	 ejag5rYTaQg1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29381C43332;
	Mon, 20 May 2024 20:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] test-bap: Add Broadcast Sink STR one BIS tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171623523016.22228.16109778712209594638.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 20:00:30 +0000
References: <20240520102014.24236-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240520102014.24236-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 May 2024 13:20:13 +0300 you wrote:
> This patch adds BAP unit tests for Broadcast Sink Streaming with one
> BIS (4.14.2 Broadcast Audio Stream with One BIS - Sink - page 189).
> 
> Iulia Tanasescu (1):
>   test-bap: Add Broadcast Sink STR one BIS tests
> 
>  unit/test-bap.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 209 insertions(+)
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] test-bap: Add Broadcast Sink STR one BIS tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a2438e46f812

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


