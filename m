Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114207;
	b=FLN+jtniGJxol7z0Ro31I5Ubu4Std6Kqp3FCKebFh6P6VKkTaZOvz3KW+IYuN1eotNcf
	 ZjXgdNz7jtJJ7oHAuyt6O+mGr0clf7Wk7h1LRRECkakY/+mU0Ziw65SKvF85S9ezyEphU
	 ttwk2X1qcnBtSmeg+/w/nYBESSz4PeFlsOacqrJYzLSrFUx67vGbtm7epCJbAQO1ZXPS2
	 mnT/J0PCsRNCXZO80Ha6GLcy0poa4r5DPkEnU77UXu7ugogFduPYsmUfErTQmFNzv3QWG
	 CBSHmaB/pdk14fSdx+t/2izoI4uCaLUFnKlGzODCGa2wmXXH5OFYm3TbaKq0Bx+puJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+vL07Mw4L870AZhbuC96q2Ea+ft5Y3xw8+XbWh0Cc9o=;
	b=lYPy3SuU9eaG4MFyZVNshpbjUkZPNgTdAsNKDzjB1OSYTDLTjJe7C13UJ8QYwVgfRgx2
	 Bt+/z+UTSoEBoMf6jxTYH0W5X+Qv2grA8m8syP714lKb2tfT16e5A4flgzVBSDJcJVQSa
	 KSOMlyYxoI4bPt5873rrMwPBjnTNvlDCiXjd1vP6Ru8pcHPbOeepIxrqsgz/ZiMe/JipN
	 aRlmWv0Eu5uQC1zTOVti/+7M+D87z4zfaMC0wEHnA1A2F744niyVqUgCyVbjZiXdg7qr5
	 3gSxX4AgCai738xguEk98NkYJ7cKp7ewU+X3B6vpySJRAdA+x4fNU0cG9gVgoKf+Kwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxHuDhZf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2631606A333;
	Thu, 19 Nov 2026 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxHuDhZf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463681F000C5;
	Thu, 19 Nov 2026 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114207;
	bh=+vL07Mw4L870AZhbuC96q2Ea+ft5Y3xw8+XbWh0Cc9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bxHuDhZffgDVz9+uAm60IPADCxQUWm+BOhlwLp+AXFDbaWL9iHKdyOcvU0HMP35O9
	 N5s/8zMlrOeNqR+8eq0DCulj68B2UOkhYGc0CCYQEYZLSlDxE7TsrWvY6N4Cjbu+d/
	 oDb+ca6bm0yN4ONjgEpx3lkJWDAXSTr1w+IFLKntGEnk7lhqdFIgWq/5oExx0GI9Ca
	 yqsOIJmMB8tQITPuXIvO8NAlDKSef7PjH47y2LoEmlW+9JHjOF0RgzSCuPT69Y3tVF
	 cNqoEZpjO7IoYkJCaFA1MWvo+EucUtgYMTl7ZoijAXCM04UPKe4ralorAIGrpynYHE
	 xhWsosNSGDEyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3503808210;
	Thu, 19 Nov 2026 18:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: btrtl: Don't return NULL from
 btrtl_initialize()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179511420603.3743161.9291199653240239049.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 18:50:06 +0000
References: <20261115195313.20809-1-arturfaleiros1254@gmail.com>
In-Reply-To: <20261115195313.20809-1-arturfaleiros1254@gmail.com>
To: Artur <arturfaleiros1254@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, max.chou@realtek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 15 Nov 2026 19:53:11 +0000 you wrote:
> btrtl_initialize() has two error paths that jump to err_free while
> 'ret' is still 0, so the function returns ERR_PTR(0), which is NULL.
> Both callers only check the result with IS_ERR() and then dereference
> the pointer.
> 
> Patch 1 fixes the path taken when reading the RTL_SEC_PROJ register
> fails. It can be hit by a controller that times out or answers the
> vendor command with an error during setup.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btrtl: Return an error when reading the key id fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/c3cdaaa5cb5b
  - [2/2] Bluetooth: btrtl: Set an error code when skb allocation fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/fc4527d1e1b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


