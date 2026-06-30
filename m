Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B447AF6D
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851584; cv=none; b=nIQ0qSDdmi02kEIjriSY+G+sTl+uyF8YamxrNsoYZ6t5cznZ8YVNcxOGAuCNUL2Nu2JmJaOpmUP79dYG1edGwRBWa6hs92YuwrSmiGa6+hGsur6qWOar/Luq5WmRC3UQnqZjHufAOeDOqSm15nPp8g7NLg3YRHi+q1+ceYr9zDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851584; c=relaxed/simple;
	bh=bQlMREzrgjvHygNIGQGQR5+hDwDmLifvnWLm8Au6tfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XXWqA5xZvokcsb+J6OSiU9qnZYFPucwGGNfMXzlTcLbP/ZnyycQcrQweJor94rJhA28SVlBESX9Y8hvvm/yYu/8DPcHTCzcdwVNhHQ0KGwRBmKhVYiJy8PlNfcAA9I2rIX+jCDdWTGHUZv+9bgu+uBV1JR7LwvUR1JaqgcLx+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH3JERAj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH3JERAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704A71F000E9;
	Tue, 30 Jun 2026 20:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851583;
	bh=6sRNc4Juh/LNPLCtvvIq/h+VfVy9P08z+eWv9+Hgw1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DH3JERAjz5/LM5gkZwS5PQ4NZ0zkgddfv68P/rcvHtXNiqzRg33yKfAC2On9udZas
	 LOZA8cRDy6Pu8/5PYfJFJJSfAzIa8RDYKIza336bKydwy/zcBpcVNPyqx88SafwhC8
	 l6dciq95CnXVWsZSY/FbiS8HiP4pSxFdclevM4dXecy9HImlECg8u2GMigGxjpMMcF
	 1aD/La/8jBBpwFg5ZXvUOm3yYEUQdduCiffja9hYkoWYTNPyk2Njou4NHAcXgklYlW
	 BTn6KhGi5edDwB3JY3I7yirofHTs81Qx33TMRM44chPpSOHZkUPDq4p0ldHl07kYp+
	 FqVLVMRrugMSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A25393A951;
	Tue, 30 Jun 2026 20:32:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] profiles/midi: Fix zero timestampHigh
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178285156713.267316.12619611811577977707.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:47 +0000
References: <20260627224444.531788-1-matthew@matthew-cash.com>
In-Reply-To: <20260627224444.531788-1-matthew@matthew-cash.com>
To: Matthew Cash <matthew@matthew-cash.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 27 Jun 2026 15:44:44 -0700 you wrote:
> BLE-MIDI timestampHigh can legitimately be zero. The MIDI parser used
> timestamp_high == 0 to decide whether it had already consumed the packet
> header, so packets starting with 0x80 0x80 caused the next running-status
> payload byte to be consumed as another timestamp header.
> 
> Track whether timestampHigh has been read separately from its value so
> packed MIDI events with zero timestampHigh are parsed correctly.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] profiles/midi: Fix zero timestampHigh
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=220f102c8db9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


