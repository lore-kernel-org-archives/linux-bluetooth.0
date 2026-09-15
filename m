Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7CC3F44CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505473; cv=none; b=Nshoj7nUhGyIeAs00RtZo18SJsaJzZ6DZmsdGF7mgCs/M0kUyUKO+IfWRwSmCrOFgJpOaxVcVhbjUc2J3TVbl8f1k+YWYwhfwC9Yz4mxUb221uWic56TgrkbsqmHCgOwQfSDbxpCC1RjnLyrtFMIAHZBT9ShryaBfFfmYf+sqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505473; c=relaxed/simple;
	bh=YXasDVmQPbFf83RQGPrIWJ07CLrQailSXcevL0SRQ6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ociNUq9aNQiQklPURLxI1QAZi4EbjSIhnvpJIr/jjtljfsCO1Yfee5dEmkD88uekZeO4TuVboZkvv3IK8DdFw2uQy85IZlHyTmn5vJ/9yBqPpG+OJ/iiLaUoz3R37OvrkJgMBccaXMK65X6WwwtSG8OLViyxHOLBR8ODFD7zVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXnDBtYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXnDBtYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279A41F000FF;
	Tue, 15 Sep 2026 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789505470;
	bh=qwg3/koiuZI6xfB8OjAoQiuNa6kSCX9t9Vcxn3Zsskg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XXnDBtYL9S7YLYfvtcoNfEERKuvziiISGumw+JvJkF9ty+7OlIMlMYl2us8kAmydC
	 oT8d2UvjvDcAx9+mN84OcvIQ5gSHaMu0cijV17UeO6MMde/ZTZ0lZDECgy6+SNc68/
	 UlPdjAiMxGXoFIdKKxjR/PMUSIBH+y+x5M3U44xq99SIy4yXAKhY+ip60w0+lYEl7U
	 jy0kfcaoCw0byMElq4uM/ec3ajEZejxTNScpe/i9JDY+SSPn9ctTMlQfrrgmpA8Fbr
	 U5J3i8hVJgYM6a2x2yoi8n+K7mKZkv6ukHMvI4AN2TGPA6tzAmut2i6uLWVWVnlGV4
	 9aFCU4IHIIVxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0995392705F;
	Tue, 15 Sep 2026 20:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] test: functional: add mpris-proxy end-to-end
 tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178950540463.2270046.15143718818647294828.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 20:50:04 +0000
References: <cover.1789430529.git.pav@iki.fi>
In-Reply-To: <cover.1789430529.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 03:07:17 +0300 you wrote:
> Add tests for:
> 
> MPRIS -> local player -> AVRCP / MCP -> remote player -> MPRIS
> 
> Connection and basic operations are tested on smoketest level.
> 
> The code is LLM-assisted, with manual design and details input. I
> reviewed and tested the result.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] test: functional: add mpris-proxy BR/EDR test cases
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3e7fb4ac2e28
  - [BlueZ,2/3] test: functional: deduce pairing bearer in shared fixtures
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=acab65d06795
  - [BlueZ,3/3] test: functional: run mpris-proxy tests over LE via MCP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e2ec6827f7be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


