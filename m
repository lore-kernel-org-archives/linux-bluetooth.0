Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822D470125;
	Mon, 17 Aug 2026 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996017; cv=none; b=SYfuZOX9I0qvqQjdEqWUiNx01PJ3yswnMbnL0mWY1tiCXIwhuE1M+NCsQvHUxVpchgZVVQUa8pUb6XMtsVOwhc4bVtLf30HhoAZO/psydCkmD4fZa8uzcpRrM3oWQNzwxQ06DuYRThG7mkFziiaO9dAYRPjVUvSgLYOC8WFbJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996017; c=relaxed/simple;
	bh=pRXq4uqLwzIuYq2KvrvP8OkgYJmCZtLc9BkOzaqciCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o0mMVhTogV6XW0RCcvtxeBH1DBRN0AjysoAg559YGTQLNfBOefc+OB2prMyOzE9ovpyqULVoCVri4cw/OdJJ85SGQtDPSnFokS9nBizSEBQA5jlCJi5KnQVkrHQWpv8aZfQaUDyLcJOtoWOHwOOZ8qdnBX+KbDrAYq/QQQMZUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7oqdZ8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7oqdZ8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99F71F000E9;
	Mon, 17 Aug 2026 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996016;
	bh=rGl7wdqC72A2lpeYT9Lw86izhEPsQo8VKH2ZHiOpzuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e7oqdZ8hhRl92lb+gvZJLEeFo8IRqCvHlAdIXvGNSWE88lXOQHmiTJHBeHS554B2o
	 tJhzV4LFRNAK4fuRNtuCIam0xJWVZOAWAFmnnqP3Esrh5pUyeRehITyNXq3kji5x3L
	 c3jiOqFmvXxCVFYpRKx1dgbrQcGacLH/OddE6hdUEN8cQ6+A+J5+T30ZhIPUg1WMk+
	 t2xcg0gi4u59QrfUpv+Whre95LVNT0hROjooTzFgOfAEkSC7eNpK4HnCOn//CsgE0I
	 QLTqkd/+TDRoucg+I23+aj58fd9On/SXJJQm0TiiSwTW0ClB9eTOsFxW16+TkJjZ3o
	 DGLITT0YOLdqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568363926262;
	Mon, 17 Aug 2026 19:46:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] Bluetooth: hci_sync: add conditional locking
 annotations
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178699596788.1691257.11633718585143607081.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:46:07 +0000
References: 
 <1ceaa25d70f068adfe2c40290a629b73c382ec59.1786870726.git.pav@iki.fi>
In-Reply-To: 
 <1ceaa25d70f068adfe2c40290a629b73c382ec59.1786870726.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, nicoyip.dev@gmail.com, linux-kernel@vger.kernel.org,
 nathan@kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 16 Aug 2026 11:59:01 +0300 you wrote:
> Add context analysis annotations to functions doing conditional locking,
> to suppress analysis warnings.
> 
> Fixes: a3ad01d51d4b ("Bluetooth: hci_sync: Fix advertising data UAFs")
> Tested-by: Nathan Chancellor <nathan@kernel.org> # build
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: hci_sync: add conditional locking annotations
    https://git.kernel.org/bluetooth/bluetooth-next/c/26cf20d065b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


