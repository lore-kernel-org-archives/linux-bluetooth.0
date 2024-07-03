Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66511EB27
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017634; cv=none; b=P3mRyRYo8no5DWf+vbXpk6QmPoXPlBJPZeF3U53FeG9B5F3TxSrR4LSRFlgXKmwXGmbEy0Z4etwuZ9O5h69yrOVZpAnm9788JFv1/yVsDfL+K56bHkoZ2ZAhXcWNLkz2acOr2yY29wB8cE7JTlPaSzZFrcgiWPftWY7zQwg7fZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017634; c=relaxed/simple;
	bh=+r8GFmTzmRpOBDO7lXBLx0vpn/YGJQzMF2/ApR3TSg0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j+PGk/auqjV0vt77t9exNre1fjFtHgxxuqphwurLJN5wGH+I8pvS8M293s/VxoN/AT6HewImctYAI9rxlvRUHhpkCdUPCt3ee3rdxZqlV5l/08kf05fdUf9sm8Z+f1rZLlptY16rVeLecM88kMWHP7yqHL9koNAEb/0XD39x6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdnJLKAl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdnJLKAl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EB74C32781;
	Wed,  3 Jul 2024 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720017633;
	bh=+r8GFmTzmRpOBDO7lXBLx0vpn/YGJQzMF2/ApR3TSg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sdnJLKAlLXSX+hOMIP0L260vQyJFhdyw+xhRs8Nnn/cDSXacvMGg3ip+aJksIB4/g
	 sZjT44dfKnWx+AIYnPPgeyxgB8DeQEj9uDvCvgXBG9nWqpFYimMn20IeIenkBFdBM5
	 3LdEdz9FpO79+jnRwADSk+WCvv/X4xgY4xDKHIT2CfOolJT4ftJ+EmsLR/l9t3E5I1
	 /nxs2DNYBYU1NJS5RONoMWZ9xa9Jre4XqypeiDgnC9TOCqkHEKztp7TfwXPiAIe3GP
	 hDDpW1Aw9o2R5UYCEYZlVYAzZ+tp6sFBrYnf2Sk6WYLesJ7PELGBPYrIN76J+Jbp5Y
	 vTF/slU5wfK2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77D90C43612;
	Wed,  3 Jul 2024 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ resend 0/9] Fix a number of static analysis issues #4
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172001763348.31919.15641608591729534283.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 14:40:33 +0000
References: <20240702142436.833138-1-hadess@hadess.net>
In-Reply-To: <20240702142436.833138-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Jul 2024 16:23:32 +0200 you wrote:
> "main: Simplify parse_config_string()" is a repeat. If you don't want
> the patch, please let me know and I'll carry it downstream.
> 
> More fixes incoming, please review carefully, thanks!
> 
> Re-sent with the correct prefix
> 
> [...]

Here is the summary with links:
  - [BlueZ,resend,1/9] main: Simplify parse_config_string()
    (no matching commit)
  - [BlueZ,resend,2/9] avdtp: Fix manipulating struct as an array
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7c896d7b73cb
  - [BlueZ,resend,3/9] mesh: Avoid accessing array out-of-bounds
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3f1b3c624a96
  - [BlueZ,resend,4/9] obexd: Fix possible memleak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=99750d2acd9d
  - [BlueZ,resend,5/9] obexd: Fix memory leak in entry struct
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4b3fe69df7c7
  - [BlueZ,resend,6/9] obexd: Fix leak in backup_object struct
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5475aba84edc
  - [BlueZ,resend,7/9] health/mcap: Fix memory leak in mcl struct
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d79e429a9fc3
  - [BlueZ,resend,8/9] sdp: Fix memory leak in sdp_data_alloc*()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5dcc52a486f2
  - [BlueZ,resend,9/9] sdp: Check memory allocation in sdp_copy_seq()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1707a8362230

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


