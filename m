Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7E2EAB61
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806039; cv=none; b=ow4Ww7FcnA/VPbiFFd1gLwV5CH87/6rvp9W+zNX8k6xgwTHIDmu69vJq3xO5XbA9FEwTUkpdxsnVo2CygHv4P1qOthxheUf2FHhHupbSj9xaF4ZP8tyHjrC2lMBnt9tVq2cP936d/9eSiKeYOQodbvNp4PYrCvLLFDTaI97f7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806039; c=relaxed/simple;
	bh=xPPEFrNQsa2MkPZOuhAWqffqzfauIFtpd/puAtOUU9Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wsu29Ohm5imwPsLq2Y1jVnYI6chqHNq6WrkdWfrozBQL4TXz/smN5oI6cOzECY8LBP80XdAnjMCkgc1wYuF1jaaz1rAVA2h/btKi5G9ARW+6+nmkO85L5IoUwfEXp3NsOuTL7gs9wlI69irww67GMu9DebME26zahdY3MeH6pwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhg+up/c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhg+up/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B7CC113D0;
	Mon, 10 Nov 2025 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762806039;
	bh=xPPEFrNQsa2MkPZOuhAWqffqzfauIFtpd/puAtOUU9Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fhg+up/cST6rXMHbI2fcsMOWOjrolzjaejz2ISewVe2ysSln8uGkIJqS8BANp8zLn
	 GXIrS7Ig3vj/i35f4O7SFpkODQAy63xVC8kcMVItVhetWXM8oTsznN5CyXVq21G3Fc
	 kegh1i34ze1p/67LXdEElemxr7hUyqpl0DgRBgykBlYVS65n5OVTVGT6tVTH4W0Y85
	 YkckK9lf89s+zMkwWE8EhTa2tCcY40UaSeRXYEgCvSx858AQ7RPzskghBoX0BZM3PG
	 nMo+tCT0oTeKn+6pDS3eM53JO0Ur9FWVJhjfpbk7JH1VI3E5SzafUNx3Yo2gCTUH+k
	 wH8UkeesCbhXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BD0380CEF8;
	Mon, 10 Nov 2025 20:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] github/issue_template: Add basic issue template
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176280601024.2762084.9094566839804478626.git-patchwork-notify@kernel.org>
Date: Mon, 10 Nov 2025 20:20:10 +0000
References: 
 <4ae9101b9ad8a521af68b0eede9ed33e752de65a.1762450967.git.pav@iki.fi>
In-Reply-To: 
 <4ae9101b9ad8a521af68b0eede9ed33e752de65a.1762450967.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  6 Nov 2025 19:44:28 +0200 you wrote:
> Add issue template that instructs to use btmon and indicate software
> versions.
> ---
>  .github/ISSUE_TEMPLATE/issue.md | 41 +++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 .github/ISSUE_TEMPLATE/issue.md

Here is the summary with links:
  - [BlueZ] github/issue_template: Add basic issue template
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d7693dc3b4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


