Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386442E9EA2
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069589; cv=none; b=LDZzdOzo90BDy5FSp+XAXOXNhwlmDXCB9Bg9ZBy4C92IE2Md6sTLLN4IXNbuHphJvXpep1Rtb3Z4aA/AQUAuE9PEUTOqcFFP5rBjLnmTjngarY1o18I3EkV27CV4VOM7Fhqn8dkzsoQVoQDfYlHMSs8FUIXjF143j5M33ejPeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069589; c=relaxed/simple;
	bh=IhCdy+RMzeXh1M+nnbI0cWLUGN8N0hHEw2/OCJdYaEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XE3uNJ0NJkn48xQOuKwim4oBTqiBdZ5tjfWwRQ78ICtnXvQJ2U9qf53Q9213vfxtqUxO3XIgoym5mJBc/6kUcdniFfobHGr8x0caoVbmVNF91Lrvg/JmxPpGrdiLFAyH08zp6AREVkPo0p+vlN0n/oAipawtDXkLnLsU8g9W2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD5cZpJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD5cZpJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C07C4CEEF;
	Wed,  9 Jul 2025 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069588;
	bh=IhCdy+RMzeXh1M+nnbI0cWLUGN8N0hHEw2/OCJdYaEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bD5cZpJVpLsptp/Ljnau/5F/MsbyNYvU+odXh1SnKFJOmG3YV/DqY3jLK+rtk9TgV
	 JFU98g4xf10uADQSTUEDDT4ReWD2WtrVXxEJ3piD9DXhn5iaDdSkTm88On1mh85U65
	 D/WShMBxFSDDx2lWFmz11gsxFltu2Y1FsgerMFvSPKw0dHPonRkBurY0GPI52PqelV
	 XGK9LyhGnotV+rRb0mnyqNY+dJzuO5h87o7JSw43qxZVJgHIqosjf49hrGCYN+AGSX
	 v3bEsvVHDGkTKmzfF3ngtt7FKc7/cyZEFnfI9xUEwGJaScbzDkWM/L43VWq0QAVj75
	 Vs0+5oMdrlvPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E99380DBEE;
	Wed,  9 Jul 2025 14:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/4] Fix bugs found by static analysis
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175206961124.733062.14757629538867632536.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 14:00:11 +0000
References: <20250709133622.2819849-1-i.iskakov@omp.ru>
In-Reply-To: <20250709133622.2819849-1-i.iskakov@omp.ru>
To: Ismagil Iskakov <i.iskakov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 9 Jul 2025 16:36:18 +0300 you wrote:
> btio: fix range validation of security level
> Expression is used as an index for accessing
> an array's element in function 'l2cap_set_lm'.
> This expression can have value 4, which is out
> of range, as indicated by a preceding
> conditional expression.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/4] btio: fix range validation of security level
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=80a6b91d758a
  - [BlueZ,v4,2/4] profiles/audio: add nullity checks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=77932f2dac1a
  - [BlueZ,v4,3/4] src/shared: add nullity checks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9432bfe81afd
  - [BlueZ,v4,4/4] obexd/client: fix err condition causing memleak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=09212f9d110e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


