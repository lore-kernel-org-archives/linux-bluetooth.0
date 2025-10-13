Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29E4C81
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371224; cv=none; b=RaGloHjU2WQlXx/gNkqZcqgSXahy9TWcKi5tQmYNddU+6QWZq2utU5n6aLsn/xXrKvpPb3eML9Ij0CFUjH0cqea75cP9ZkEnvgymiaPe3BiGf8iyA9FpC705zs3vZHgUzDAaNk6SrQURMPYo9mfIHIu4RBwlllT41sHqMTZLQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371224; c=relaxed/simple;
	bh=oEb9T+YIs+1pl1PjUvudIloeH+wO36Z+eaixm4rkykI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HVIqBqHN5OqwjbALZ8bdhUG2XMwSKtG7NqpK1ETEwV1HO17smlV3EmwRf9R47eib9Laknk8QJaqQ5sLPGviB46caR73RwhyZJVNpUPyu5MPQ1Z1gAWAh2eZV7lbxLtmvY/7ISJPEcCErMf12469cBIIS7jgjfNxmGO0cLSUlb+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6/o0vNn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6/o0vNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6CCC4CEE7;
	Mon, 13 Oct 2025 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760371224;
	bh=oEb9T+YIs+1pl1PjUvudIloeH+wO36Z+eaixm4rkykI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U6/o0vNnDY73hascl+C4tSB3o/p0U3FlA10khAz0zsQVN60SZ3hr0XgGJaxBw6TWn
	 UCyH0kFu6Jo6jxFai4s5JbyZO4UimgUnjduLeWg5JoyJK5l/MYLfVrsvg/QaTN3TwG
	 CLvRSavD9eORhJjKCcGAUbWRAXtMqODkxLA+1/1vPuB360Cr98UgBa7O3EGWWLchG1
	 eWeKkX8r3ZVLL/A/YB5GkMUdKEa4Kj4RSnuMcXjZEFyuR+BBSX+AyKH1JLsgWVhJ4I
	 LsXRcBud22L34bCL1yVcrgdIBX0GgdFlahRU/XLWLkbzNn3LE+PqYph9p6E8myDk2I
	 6gQsum6zc1Mvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71644380A953;
	Mon, 13 Oct 2025 16:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/6] shared/hfp: Add dial support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176037120999.3108925.5624337133911962094.git-patchwork-notify@kernel.org>
Date: Mon, 13 Oct 2025 16:00:09 +0000
References: <20251009195842.776231-1-frederic.danis@collabora.com>
In-Reply-To: <20251009195842.776231-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  9 Oct 2025 21:58:37 +0200 you wrote:
> If no number, NULL or empry string, is passed to hfp_hf_dial() this
> will try to call the last dialed phone number using AT+BLDN.
> 
> If the phone number starts with '>' and is followed by a number nnn…,
> up to 10 digits, it will call the phone number in memory entry nnn….
> 
> Else it will performed a voice call to the number provided.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/6] shared/hfp: Add dial support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=217bd72c128a
  - [BlueZ,v2,2/6] unit/test-hfp: Add dial tests for HF
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c285274d1708
  - [BlueZ,v2,3/6] shared/hfp: Add in-band ring tone setting support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ff984192b452
  - [BlueZ,v2,4/6] unit/test-hfp: Add Answer Incoming Call with In-Band Ring tests for HF
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fc3aa8a9fd4d
  - [BlueZ,v2,5/6] unit/test-hfp: Add incoming call prior to connection test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=78c723b4d568
  - [BlueZ,v2,6/6] unit/test-hfp: Add incoming call interrupted test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d01da89d6a1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


