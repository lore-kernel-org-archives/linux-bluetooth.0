Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569658B6AA
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065680; cv=none; b=BZhWONWiL/DBvhco85PN/4Y4fKda0f3/E1mCKT4OhLe3dwJMjTPtys4uvM8BcjAkf0KWfvnAtp+XuWu26BbMpSuBazRmzjey/rE8sdI7C7sVo/UxQE1ENsGR23NNqKt8q+DCbfUlXMrdmyRyFlaLhmAkpMts3YwcixbJKsElOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065680; c=relaxed/simple;
	bh=ccUAmGDnWw4jH7NMJ1IhU3EOVglR5yWPmJpx4lZB0+M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gQAl0GvfKSfFLCRnVSZYwhNOGeWxHrkaAjtJGrhLBCNUL+Qs9BAdFsAHh91sAbkuag9KB27GkNoHld3ZX4cbcN2S4A7hEfmLnxVEaU+Eb7ihJ6DXt42R4PJAGQ35up1DLfQP0Awy/JpIF4LsWxwWfksk1w9ZeM/ZobAjw5pKI+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSq58Ohr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSq58Ohr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD771F000FF;
	Thu, 10 Sep 2026 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789065676;
	bh=kaw378ovjiPMyXlG7J3yrAYHC23mBQ0EBGVw/FiY4XM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NSq58Ohr9951hBSurgTnaU3G+QnXbxb8Dd7S5Y99rXRnbidL9SZqNlL58Fz15wUOO
	 ggMyBjtC84nOYfcZH9BzC/C+U82b2GKp/r9fPLifNBtRMaQwn8TJN30V8k5O5aWqxX
	 hE18byAwuqGRZXotShyU84yn4OU0yOlc44aAXBwaG157yJ66WSYh4S2orKPbHIQx/N
	 cq16Nid0/RG1PtvNNMDUL6btACfuoiiGSjdfOlQ3chFLORR9aNmApYDl7bigvFuqez
	 KRfIE8eX2CWGIlycNKBO2h0lf189IGsApoepeJZDNopU8kuCc7auv0jMPK3fLbw/m3
	 HyuI5pAe63Apg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CB7380CEC6;
	Thu, 10 Sep 2026 18:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] monitor: clamp max_len in print_packet
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178906561337.2027917.4685625875514348005.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 18:40:13 +0000
References: <20260814230419.2042327-1-chad@allthenticate.com>
In-Reply-To: <20260814230419.2042327-1-chad@allthenticate.com>
To: Chad Spensky <chad@allthenticate.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Aug 2026 18:04:19 -0500 you wrote:
> print_packet() derives the snprintf() bound for the packet text from the
> terminal width and never bounds it against the space left in line[]:
> 
> 	char line[LINE_MAX], ts_str[96], pid_str[140];
> 	int col = num_columns();
> 	...
> 	int max_len = col - len - extra_len - ts_len - 3;
> 
> [...]

Here is the summary with links:
  - monitor: clamp max_len in print_packet
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dca0f10fd560

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


