Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79C35B136
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722430; cv=none; b=PoUiyQqCfGjLt3Qo6D3Cr38YSmYs1t2NcDLEbFE02RXdHfijLlpKXN25WoOQG7tYQMz5CSMP2KShkQRbsTRA0NFdHWRLszP0pfx7Y3/WVEmIkaisHSsduCL+hLyphlLV5tpKfh4lsmJ9CdqG1hF9rv/lxHjMo+AJUaggVIdIGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722430; c=relaxed/simple;
	bh=Jn8r8lzkXA4KLGb1c6z6MwmSs4EwJXZzUkpTZ7sAnmg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IgKlNhi6yzsTPK/0ceh+hCcYuRdbWj8bLyYDbanS+dp7E9bOGfJcOpMUsENKpfUZ+iA9YeL9ylMMuJlrPQ7v4TVMA4Ymvbj4z20VCPh+BcpD9u3YjM7IgRUYhBjQXE8kGabaIRYLUHKz0X4p/agk5vUnaOOfwJQcz+B+VQaRYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwR0o08Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwR0o08Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD00AC19425;
	Mon, 20 Apr 2026 22:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722429;
	bh=Jn8r8lzkXA4KLGb1c6z6MwmSs4EwJXZzUkpTZ7sAnmg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HwR0o08YSs4K2amsX8TqHGeSixFHbAcFr8G0ZrZNNf/DUX0fmOWEelrrnP42Oj++b
	 EehO9MVlNozxgzRwhSEF9hlR6aC76D4pbdhZQV4cexoDQid5OY/ucpZHAq91+IAbb0
	 GZHtULuEn3xCddBCEmYewX5DW2H2qN8w+5fx5honJhaH1qw6znL/hcXscnJTQMFalv
	 20hsRwfqFqgrTvsxujKufa2PmZT6b6QWQ+rtohKHyXrdcYyLIuXkVvHqK681F4BUuj
	 JHB/oTvzyFd2CkrXlQZDmB37ZBtVqbl4MesGjsaabr1dKOnlx8A5txmBASOokz7cmh
	 LKUYk5D5q5WTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD2D3930022;
	Mon, 20 Apr 2026 21:59:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: SCO: hold sk properly in sco_conn_ready
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177672239380.1802062.13554005681833243008.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 21:59:53 +0000
References: 
 <023e04a49d2002882eb5ea6bf27d1169261db875.1776525817.git.pav@iki.fi>
In-Reply-To: 
 <023e04a49d2002882eb5ea6bf27d1169261db875.1776525817.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 18 Apr 2026 18:41:12 +0300 you wrote:
> sk deref in sco_conn_ready must be done either under conn->lock, or
> holding a refcount, to avoid concurrent close. conn->sk and parent sk is
> currently accessed without either, and without checking parent->sk_state:
> 
>     [Task 1]            [Task 2]
>                         sco_sock_release
>     sco_conn_ready
>       sk = conn->sk
>                           lock_sock(sk)
>                             conn->sk = NULL
>       lock_sock(sk)
>                           release_sock(sk)
>                           sco_sock_kill(sk)
>        UAF on sk deref
> 
> [...]

Here is the summary with links:
  - Bluetooth: SCO: hold sk properly in sco_conn_ready
    https://git.kernel.org/bluetooth/bluetooth-next/c/fa7a2842af06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


