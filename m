Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B433FE15
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147631; cv=none; b=puqTnIWjVvjxEO39setH/rYv2UDfCoiBFaS0m89UfiBKK6GgA4TMUnWjP1JwrOTPcKqt+1gfyZcU72DdfHb0Zduru/y/0o+frIigWGBTkZi9g5fKrWKla5e1HIh/eMmTCcugdwKYHQ44RoQd72gXVc/p1kjWUhG0VouUpDylXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147631; c=relaxed/simple;
	bh=szbThxw3na3G4VHrBEGMIioRaIqlDWmTFncZbZXf3+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mZMsqEWsuqis5/CtAE1U5gakOuLUCoQz18Hw3Nu6NujPzdNIia3mXKIowwQbkmsJeqCQjAos7g6is7aSvYeUUQ7cKzivQ8rUu4IQQ+iuG5Z8jLdzZVb5Tf3RkKhZaIccICh0mShfrCvIicfot9LhIZVRFiEI9TDn7e7IwBy98jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7bjL+6V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7bjL+6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A821F000E9;
	Mon, 22 Jun 2026 17:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147630;
	bh=GFT8d/eQKlL2N1uN/YZ7HXJQCYCU709CaBUVwlLDLlI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=C7bjL+6VjZOHBBmvDRNVWLuWDEPkpkwCFJGxSfg26vizuEjdr65gYKykqcrQ/71aF
	 Vp+mnlAcIU1GGLrUjCBsehW7P7wiA3E4YjUAaItygMUsWwUoGkFPveM4y8EXk/+vYF
	 L9RF0atIIFm6XQkDlTODTmX2HAbAnFntk5rcF3k6jaTbkfRGj1JPb7E/vwBoNE+5kH
	 OzC4BnLs1k6pb5SqAJ3yoGxVuY5jMnChFD1OAiy0sjQXW1k6K2KcOwXmlzYZ9IIL8n
	 q/B18Vk8qeyyPH40Ks2zFNFDLLMj/xksXKh3DXxgEyWaLdHrfmQcdTCUVh8svw8wlq
	 WuGXaQeRRghxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197AF3930917;
	Mon, 22 Jun 2026 17:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] Bluetooth: enable context analysis
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178214762073.1322955.15712319484363446864.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 17:00:20 +0000
References: <cover.1781432726.git.pav@iki.fi>
In-Reply-To: <cover.1781432726.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 14 Jun 2026 13:27:01 +0300 you wrote:
> v2:
> - Add annotations to RFCOMM
> - Enable analysis also for BNEP, RFCOMM, HIDP
> 
> ***
> 
> Set up compiler context analysis that generate compiler warnings on
> problems that Clang -Wthread-safety can detect:
> 
> [...]

Here is the summary with links:
  - [v2,1/5] Bluetooth: af_bluetooth: Add minimal context analysis annotations
    https://git.kernel.org/bluetooth/bluetooth-next/c/077b1a4fdaa3
  - [v2,2/5] Bluetooth: hci_core: Add minimal context analysis annotations
    https://git.kernel.org/bluetooth/bluetooth-next/c/2f798c97b743
  - [v2,3/5] Bluetooth: L2CAP: Add minimal context analysis annotations
    https://git.kernel.org/bluetooth/bluetooth-next/c/a9cdc2959c77
  - [v2,4/5] Bluetooth: RFCOMM: Add minimal context analysis annotations
    https://git.kernel.org/bluetooth/bluetooth-next/c/14cb114880c7
  - [v2,5/5] Bluetooth: enable context analysis
    https://git.kernel.org/bluetooth/bluetooth-next/c/9218167503ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


