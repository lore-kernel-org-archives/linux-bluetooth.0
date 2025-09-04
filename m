Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50402F3C1E
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002218; cv=none; b=W4LfJN/Rx4Fw8oqViPXmqi7Q40gWneRisdolAINpxPT0VaaEJoc8cONJftuzwXfwsvRuVM+UqjOPHIxMhJmpehJuv98WKGQKNO5EhP4uigJkcvYZ8FwZfNffpAw3Vhzgc4R4MUeKVxlxTZHr9Doe4yA8QWx7OkXzY/QlCDwbp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002218; c=relaxed/simple;
	bh=SXvRO5+fxAaVr7sKKAF1aFP07gWH54LH0vNABlxg2Qc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RiJEUn2X/168M1pyu3WrPSclgjkT1HmT1Cfv4SPx0e9xjhLQQ3W8DklcJJdww/zDf865diiTQLdKxV9h9ZQOVBe+8VYHYy8F0AcPiSx9g9ir1HZv4y9VAIeCK/uS5QcaMRdvAl+0s6baa+3dByxwi8QhS9kAIM+oa4Zcco4qdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/WyTufp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/WyTufp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97100C4CEF0;
	Thu,  4 Sep 2025 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757002218;
	bh=SXvRO5+fxAaVr7sKKAF1aFP07gWH54LH0vNABlxg2Qc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f/WyTufpGMUzCx0s2U+8YYnNL2BbF0+82FN+Ivcm10rMhBa2H+QOiroXrQcZFzgIO
	 c+QZzgAmx+cj9RXpJzVBJXerW3uh8gMOlsVKPB0Rz46eiVBla3um+XqenKyoF3Q33/
	 92dry9X3Wtuy61H93JgS+XZABh90GRI2A4XyMI435OtQmjuvi3u9Ke2c2vX+D6Xdr2
	 XfCLBtJFhQ7awmBEgobF4cPiso7aOFs1U+8geCKkoiMzKdTTxeqc588zN/rykaAY47
	 dItxF3OuYLoWhtO7eosDfMgaSyp3B1PO4Ba3iQlq61XTns7xkM/t70NA/tQ0VHVOAV
	 h+obE9gHh+IEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0D8383BF69;
	Thu,  4 Sep 2025 16:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] unit/test-hfp: Re-order TS tests in
 alphabetical
 order
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175700222323.1866840.2683469427185858883.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 16:10:23 +0000
References: <20250901154903.187038-1-frederic.danis@collabora.com>
In-Reply-To: <20250901154903.187038-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  1 Sep 2025 17:49:01 +0200 you wrote:
> This will simplify when looking for a test.
> ---
>  unit/test-hfp.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

Here is the summary with links:
  - [BlueZ,1/3] unit/test-hfp: Re-order TS tests in alphabetical order
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c779eb8183a7
  - [BlueZ,2/3] shared/hfp: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bef16e9c4d8d
  - [BlueZ,3/3] unit/test-hfp: Play PDUs up to the last one for HF tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f9a98ff26e50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


