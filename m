Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786550EBFB;
	Fri,  4 Sep 2026 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541038; cv=none; b=cmXbNjEgZdyX9HgLkY3+0B772Q0doTvo25ZegbVjhl66OwzP3Kc8vyLiDiV+b7/FZRIzsKimIL0UvRzNIC+RQryZQ4dAZGEQXt6ZcLzoTut+Lj9IV3J6c+rx0Ohn0oDNyGFowEvPHAwoG3wsGiVgwgpjCtqz6PUfG5wsZw8LEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541038; c=relaxed/simple;
	bh=FijBKzjRYiS01tb/TYXOmr5DddhEZGTDIgqCAm/6W8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jXOUthk7eSmndgESKkLf7h9LPCJFuT3fffDOCGnvVwBHm0z5DJmApQNYt9d2ic5HNY7FyPErL1Ydu7md8swqpx3oa8cXApUl4Er8b0sbVxQNikYF4IShbzQcho9p593JnXbcq3+FipoXpAg1aWxme8beyLeIcmLPu5GUIlDsFnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiPiIZEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiPiIZEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB571F00A3D;
	Fri,  4 Sep 2026 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541037;
	bh=Bu5KsArgp0kmBezMk9BFDJB0i52Mn7bOkddXZBFVeDg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XiPiIZEJB6mi+9kaNhqKgak78FL9cASQuSuUICabZgDC4itQXtbvsc4psz0T6oi6M
	 3o/1SHiH3HkwziHzg73mXJxJmOWx0dgGo8LPBC7/zxRga77ZEwVoWMnw0F2ht9AF0v
	 cadZxE3FsVbG3pEZuWl1jcWRYrQMrF4bKAOVVTDqWE4u18ZYF1aob3sE69MkrZhvGP
	 /uy15nUkFZQsFva/ZHPekdAtxhBByqWdNxOvrzZS6kW5FzEs5oKsMtngzaoTm+KSam
	 coAGWseK1QRQ3L4kqtd3nul4rhRFgTBrmimOlOCwhiCEN8KeKH8NRDfwg+2ENFLKkX
	 WzoNdy7BwwL2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197BD3924A50;
	Fri,  4 Sep 2026 16:56:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Add support for the Synaptics BCM4384 Bluetooth
 controller
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178854097763.344939.12946304327950941506.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 16:56:17 +0000
References: <20260818014948.996739-1-kaihsin.chung@synaptics.com>
In-Reply-To: <20260818014948.996739-1-kaihsin.chung@synaptics.com>
To: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linusw@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kaihsin.chung@synaptics.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Aug 2026 09:49:46 +0800 you wrote:
> The first patch adds the BCM4384 Device Tree compatible string.
> 
> The second patch adds the controller support to the Broadcom
> Bluetooth driver
> 
> Kaihsin Chung (2):
>   dt-bindings: net: bluetooth: add BCM4384
>   Bluetooth: btbcm: Add Synaptics 4384 chip support
> 
> [...]

Here is the summary with links:
  - [v2,1/2] dt-bindings: net: bluetooth: add BCM4384
    https://git.kernel.org/bluetooth/bluetooth-next/c/29d82dcf7273
  - [v2,2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
    https://git.kernel.org/bluetooth/bluetooth-next/c/9aa9447804c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


