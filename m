Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851426;
	b=apacvhaLfqZ8q2XoDut0/TWzxYBbgEngHtS4XqelIpWRQ2WW56bi9y6fHh2WRq1qJv1K
	 +1uP05hnAUe/SdW0UimurhK7oEEd1CRPMIqMfIFBrYCx80NNCW5cu/bJi/xj6Tvj5ES18
	 /HNyyJ6EcZdOUPqSPh+svDuwNoguq0bLq41s4T4cG2noeqArhWxR5L4bHKLy42JyRuKq2
	 02r+FkeuYgqN0/YsbBh4ZKh9doWNIViosX1IfGvW23iaLM6x9PPCOamg07VaDku4SrfeJ
	 r1q8FvS3l8g4vTIqmUoe16Tl+ObAFln26xNZK4hmZ0qkebyN+vtcahsAuuC5snwuXZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851426;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=45ZQzrCgcYw6uEYFuV8Qoz9Hz8SJI38vD21bDkrs13g=;
	b=rYuu5xaeBVJTWKRNaHPD83HwLYG09WhJ/a/TdWIsZC70ckvpor5SoEuYh265URJr1G9h
	 7d0UD8201Yv3b0Bq3NyGjZyT9/PnRXLyrN7vSzuHHWev7pzU47ZPr2Ov5Yiav+WO/7682
	 2qQa2+craZTQaEa9sgYY2+lUQF0O1ZcdeVHyom5rnYxVwKGQI1MO+xTZhAay+Y/Wlet/7
	 4Q+gRNGEnImA2651zkviz+jda9d+OEN3p0FGqIjPjFrdZAaodYd2oEmYKNzkNnhT4vIJv
	 RZ5YHJroaZZW9vJjILVzZXAc8aZXcvdlMagwwz+GbG5IxOhyK9Zg2KZLtzj573Vi2ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIcwdxXy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3D606A323
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIcwdxXy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BD91F000C9;
	Mon, 16 Nov 2026 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851426;
	bh=45ZQzrCgcYw6uEYFuV8Qoz9Hz8SJI38vD21bDkrs13g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CIcwdxXycTcVbFL1/gj2L9AnZDPoQm/n4WmqeazD4eqjZKb8IBefI2P+toVC4rFpT
	 5jAqT2Ln5imMfSibht+QAXsvGsl2Z5L/5NLaaXPzAre5vHGZTkqg+us2jV8KHSJ2si
	 zyf71tNaDyT7igwO1kH2Kqwif2NByvECcIEbW0tnDoCH1YQndpdZsb19fNIEQbom3T
	 w2xwHXxWWk14qDIzSw7ZPAVwYSrMJqSY6z2SlW0pUUlCZR/4svvjpt8Xfltnf7Pwnh
	 SXTaPYvK+xkd8H7OUty2RCt0THndzUTI8ngOv73/hz4c2gXn2MId/phtLH6jVrbK7y
	 qcwRbnCJ/l6FQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F13CB391AFAF;
	Mon, 16 Nov 2026 17:50:25 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 4/8] transport: Don't hand the owner over while
 releasing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485142452.3796096.17811546275183515310.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:24 +0000
References: 
 <07eac67b88248b126fcec9d784db800a69ac3e0c.1794428234.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <07eac67b88248b126fcec9d784db800a69ac3e0c.1794428234.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:37:38 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> As a server, handing the owner over to a link still streaming also
> happened when the audio server released the transport. Release sets the
> transport to suspending before disabling its ASE, and disabling a Sink
> ASE reaches the handover synchronously, before the request of Release
> is installed. The handover cleared the owner of the transport, so the
> removal of the owner by Release did nothing, and the link, which kept
> the owner, was left owned and never moved to idle:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,4/8] transport: Don't hand the owner over while releasing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=578b16afd93c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


