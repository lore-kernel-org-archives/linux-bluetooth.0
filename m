Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA914908AE
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728057; cv=none; b=cfNWVpCoZNgXj2GxSgzjIxwOml4u6usW51G5e4wCp4219lJN6j4pa4pzgWphMnZCHEToa0Z0ufUdC0KXHs9y/mY4x9nGqMfOEiikU5nBksu2P0FApciq3THWfTsS0T5LjIbIsgwxYxmnJMKjtsp/sf4FV7EMA83QNpPWUsFTgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728057; c=relaxed/simple;
	bh=V1Wz5uuSQNMfTuWbMQcihgqclNLQwTeCkS0mcWxzszI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KpdAYYpRLO8Ugc88NfYOECbDOiOQ6tpC17I7sGHOxTnJrhNBgc2PdDMIhXuFKTOO6WcQSKFuv2um2e21mtBzBEH+M89Lp/aeABITjybwEvX7XSjChiRwmK6QyydA6TbAzP47DjkUqoh43cW9HjIc4vccdibF6rcYKBw4XbLL4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l78Q3I5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l78Q3I5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EA11F000E9;
	Fri, 14 Aug 2026 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786728055;
	bh=QY99cnve4uQBj2TLZoIGAk+Avv2+soCaDXIvUYCxVHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l78Q3I5aJcPwdyJEtsQy5PgaFnUX3cAnudAD4azvHnqdXV9F8Hm4v6866AWwPAYNn
	 MhD7Dy3hpgR1Jl3e2LBkcw/qzA49CAfmZH2njmD5WRK3f8dHs/e7NFlCsIQaVNKlDR
	 QeqJSwP/T8whZN0T65btMlxracqY9zFRiUVCvJj1i67XnnfEI7K2MVLQAGjINd2S3l
	 88yVQdKw80miwPPFfap5vrNC6dnCqxubPb4w7MpreutIHPDRsKb666LdAO9oZVOMBu
	 nhpwvqNtIw+DAOD7hGoHt6dDJvI7WhiK2uS2ZTGxRevhHS5PwAkFeaEZfGVzOHZ89P
	 cyUZAHE1eoaNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197023924457;
	Fri, 14 Aug 2026 17:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ,
 v4] avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178672800963.3885098.13548471500210922609.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 17:20:09 +0000
References: <20260814140155.3155081-1-hadess@hadess.net>
In-Reply-To: <20260814140155.3155081-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, shahbazovelman97@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Aug 2026 16:01:18 +0200 you wrote:
> If the "Displayable Name Length" is much longer than the size of the PDU
> packet we receive, then we might try to memcpy() past the end of the PDU
> packet.
> 
> Be careful about clamping the name copying to the smallest of:
> - length specified in the PDU
> - left-over packet after the length field
> - size of the string we'll copy it into
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4] avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bd8989620ed6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


