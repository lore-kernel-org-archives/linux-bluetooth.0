Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACED38E8AD
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604059; cv=none; b=qy/rn4Ocb1zBeasc+rleJKnNLvJRdAXoLUr2hMi6ZReCcj3TtIevxPhteksXOupUV3ko96wG5eQdVuvXSEbFtR4p60lX+pRpxUtPR2Vx8qwN+zwv4ZzoSFcCXONSUdglSfZBeNeiQUY9GjPHVAphN4UpU9SXrvRqoDd5tlde4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604059; c=relaxed/simple;
	bh=RKUGo+NIwHdNSG0mKJ62VmtUKXbHlPorl2zPXZ6Txx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ikcmR92a3EMC7AJDYyiaC3DahohuUTmnRqhkMarNEPQDXdlvgh9O0ytEsqFdKkM7v1MVLPFwwajlRDoEx4FAeFHZtYxJrsjZM63p83LuRPw8BBL8q/ENH6ePvL2QT5CCifuVq3XuHdvsqr15ksNwajs/dTPBXpbtPItzmqXstio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeA0fZa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeA0fZa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653831F000E9;
	Mon, 24 Aug 2026 20:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787604058;
	bh=7ygpu5+8E8BzYXjgK1QZDiMf+t+PGcKWliY7joGjrss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AeA0fZa8uM8qvpIwM8QFeT+tnajmv4Q0UhUr6tnYXcY6kiM2Fp22HySCHbbOiV5Mk
	 DqN38E3PA513R04aMsVwG4k4bt4Q89rM0B7TfJkFnWRcwMhfZAUdXAZp/ms4+5S6nB
	 T3IuGVJjdTokgYdh4cEaCyFbH+kBtOdUqllRDnyqrrEooI2HH1pDouvKCXEg1Qw8HN
	 FDAdhHSmY5SlvWCUknyRjKjO9xExD3LgaxFnNa/f56QGAcJUIrA3Xw+J/A8n7bIw5i
	 YpOapQ1De/GMAqh/tXQnizjJizRLAWJxERIJbxedovNYBA7RmAw39L4tgtmQl8KAhj
	 Csot5W5UXVbZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198D93924A51;
	Mon, 24 Aug 2026 20:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] build: Ignore the test-sdp-xml binary
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178760400589.3109701.17824373756875955356.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 20:40:05 +0000
References: <20260821193120.1335629-1-george.kiagiadakis@collabora.com>
In-Reply-To: <20260821193120.1335629-1-george.kiagiadakis@collabora.com>
To: George Kiagiadakis <george.kiagiadakis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Aug 2026 22:31:20 +0300 you wrote:
> unit/test-sdp-xml has been built by make check ever since the test was
> added, but was never added to .gitignore, so it shows up as untracked.
> 
> Fixes: e55ff8818f72 ("unit: Add test for sdp_xml_parse_record()")
> 
> Assisted-by: Claude:claude-opus-5
> 
> [...]

Here is the summary with links:
  - [BlueZ] build: Ignore the test-sdp-xml binary
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3b3e0589b1bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


