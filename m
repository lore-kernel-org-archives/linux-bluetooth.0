Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBD4E06FC
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617888; cv=none; b=f35IXkMFNoZ+NHFdBVwA6URfYp1AOxv1zE6t02C4sJKzfTSsF3YC+AGovZp+fo4YgPChe8CJg7vDxkRmcI76+QQDa2zjLkBqGm2g+z5SpWh58hP/z3M0hxyXcuvbE+fGGXjxRGtxf6k8j5E+7AbcUOfasb05BE0vkkIlYkOK0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617888; c=relaxed/simple;
	bh=0QcDDm4h6EZrIyfTY4UEuTJqy+oqjWSC+ZkrLzur5e8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BiSuvvxtT/6PIb3iGSO9HMGAa0ZbmUFJ7xOvrZMGgc5Wp/wIb1U9XaL+RcjnMpdpxknhgpsptK5XXScbX8cmQFonz7Fe32Gk9A3RaLPs6TPpLSiIKVrj0XkVQ4e3XLcvw+E4JlScPgRuYDKd+Xbjv9Df+3hTaDEsllhjs//BZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zov4ia+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zov4ia+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70E61F000FF;
	Mon, 28 Sep 2026 17:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617886;
	bh=VawJvaiuwX2CVVxxs+F/JV15sELt44H3xtyNh6rTWRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zov4ia+zqK8DFyCXPr125UfbWDXY5yRSSx+6rsJzji6zlD27SMkricjwdr2SxJDSg
	 8vyxOFGRcyliRAfwIMiiETwSEde9Uzv0w63HIRJPncYe4wf28pqJ4Ps/kL+oow0hzs
	 Tr+7w7sKLEYOdOn+03/g1lThEXl7EOFB7jE1GcKdxa5nqH3cNn5+PD0nQwhsfB7nMG
	 LmuIsWvpkQCHU9wUFPPqwbqslZnMk8h092aw59fHbQKTSz6IrU7M5WJn+blcIBi+8m
	 tWCIt6oWskHJlI9ZA0rpiIVZpMmq/qJKJhOUPomwtLNB7FJa96UiRuwjhuWttjIut5
	 6MkL+lc3euWcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9380F3924A77;
	Mon, 28 Sep 2026 17:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared: mainloop: Skip removed mainloop events
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061781113.50268.815655039941498260.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 17:50:11 +0000
References: 
 <fc1baff935104e08b170f528477e31bfedc57c7c.1790531371.git.pav@iki.fi>
In-Reply-To: 
 <fc1baff935104e08b170f528477e31bfedc57c7c.1790531371.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 27 Sep 2026 20:49:49 +0300 you wrote:
> mainloop_remove_fd() on an fd that occurs in the same epoll_wait batch
> as the current callback, causes ASan crash.
> 
> Several callsites do this, crash is sporadic since it requires suitable
> timing.
> 
> Fix by adding registration ID in each event and dispatching only if that
> registration is still active.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] shared: mainloop: Skip removed mainloop events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2ef55e49f2b
  - [BlueZ,2/2] unit: test-mainloop: add basic mainloop test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=45c3b69db034

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


