Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C62F3C22
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596605; cv=none; b=qKGzMNlww7r1TH1eveqQZknElv4ei+0cKnMNYZYctSiCfHhfZhYif6Y7OopwGGNZyKLPeeyJsJNXleMFoSm7syXRxmIFWo0I4R3KB5Oe0Ssvb1z8GZQeBPWSyhIjI20pW8QpApSMj1IpW9250BRdQ1ze3+V+c74qAi6/Te0V4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596605; c=relaxed/simple;
	bh=haUfWvvgIffiuJmuH/dy2bPMHbcTtAorsp45Dmbil7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WxaCVoFffXCvG1IpIKjF3xmhiHXeglzHzPud2wqmcKY1tiSixqlSn+sWMYCaKmOo5N26LVkFtc+ipaOg4YleNDqfMcEDeGD71b7WXMtCa3S4JudHQo4kAfMxCon4kOemUP+XQBrYZhCEbGOUPIl2/qj3Ceuq/peByCy/cLErVf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShzTdld1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShzTdld1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2151F00893;
	Thu,  4 Jun 2026 18:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780596604;
	bh=Oa2zofoYQ0Tx88VSEUZFZZfUPgDfTAUZ/VCVPBWFUpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ShzTdld1cm400gbBmp26uvUFuFwhHbbUsFC/D+B39StP4Sh1BDu0GTFmLH5rW4iFe
	 hyyor65Fp1uzK4ec0mADPqxD60sb7OBxUY2X9YF0WZPL5W7aH96kTJqe98mgBe5B1V
	 BciC7r+mA1pk74NWvJF3AtkJW9mJ0E/qZPq+lIQIsUBI0+QzkGtp6mwLRCukq24rSv
	 CDHS24A+3VgUiFOSo7tc6NU6W7la76P825ixhOa3i5jSv9Lk4MmXEdIgJK0MIjfrpk
	 WKMtHfOELtRoxP1F6CvXMDCsrXF88/RQ482ihb7X/FnugGIAJVHrEkkob1BsAC4TW7
	 VsMJOJrOup+iQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987A3930A14;
	Thu,  4 Jun 2026 18:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch] support libical 4.0
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178059660488.2966613.150489617181400746.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 18:10:04 +0000
References: <1445e90e.ded.19e159db7d2.Coremail.fundawang@yeah.net>
In-Reply-To: <1445e90e.ded.19e159db7d2.Coremail.fundawang@yeah.net>
To: Funda Wang <fundawang@yeah.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 May 2026 13:58:38 +0800 (CST) you wrote:
> Hello,
> 
> Since libical 4.0 [1], pkgconfig files of libical have been splitted into several files according to libraries. The libical pkgconfig check need to be tweaked to check libicalvcal. Patch attached.
> 
> Thanks.
> 
> [1]: https://github.com/libical/libical/pull/988
> From e5128e1124efa814d8c65b4797025b1a15c6b250 Mon Sep 17 00:00:00 2001
> From: Funda Wang <fundawang@yeah.net>
> Date: Mon, 11 May 2026 12:37:35 +0800
> Subject: [PATCH] support libical 4.0
> 
> [...]

Here is the summary with links:
  - support libical 4.0
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e60d07255327

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


