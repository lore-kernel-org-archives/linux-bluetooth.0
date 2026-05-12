Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F63EDE5E
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613666; cv=none; b=j2KcTVVpJtYGMEtXEF6/+zFWVAZMstHSZMc1/L6VrlQduCuYb2kcVD2wd/xsF0niLzzs9xrWS1z/0kpY0hWgQO0ArO4J+uhm2rd4jPlVGneD50wOrxWqRhrA3yq6VB+4LvnxEjeoVBpZPf0mU/bdnT7sfeLzpxEV8oD2qHCsx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613666; c=relaxed/simple;
	bh=2xWlbyyFIMfltEBEByZ7xowpu/C9d20FUxITMtGHOxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aQN+fJYV/21nVdgkUsPfBQA5HNRMbKbR61PGM8Xw42gTNEElc1mioxTbIqcj4P1rzxg+fLgHb9hFZRJkz57V8jLxdLfc+1HnR28ChTPecckSoO8AEy6MSfvSrTJ6xUXVH6dW1H/03pNqDCkDFidW2IeCXUhgS2cSmnWQ0/4yL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANVCDzgN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANVCDzgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5AEC2BCB0;
	Tue, 12 May 2026 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778613665;
	bh=2xWlbyyFIMfltEBEByZ7xowpu/C9d20FUxITMtGHOxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ANVCDzgNUPTN8i8ugDxPziYKX/EKj2uSJK5KoM3+7TpQ1GvdWUnbBs4dKkZPeEGb0
	 WvwHvGAPb1APSSa3klTbsNzlA/Qttuf7jVhwj4KyLVvNinnL3UyIluf0sPBUVx/fCH
	 BO3v0wcCHrE9cpgDN/c9mKlRMuS3JPMtnoIH2jsxLvY77RjnyhK2YHOo2QcoHsgn/q
	 qEbhAYiWFKOoofFe/yrVvT93qqbpAWSY+fdC/Ozpxp41/jEoC2LU9z9BFLJejNsxzx
	 Bn2mMFOysRhqqkk8hbdL8+ybh4wOt8ae1//bnq7yM0DqFd2D64y1yLiC2O3vL2Fd+o
	 E9UhlYq5yGtxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BE53811A59;
	Tue, 12 May 2026 19:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ v3 0/6] Add helper for "cleanup" variable attribute
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177861361154.3045511.1045324340041670862.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 19:20:11 +0000
References: <20260511132131.1283892-1-hadess@hadess.net>
In-Reply-To: <20260511132131.1283892-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 May 2026 15:18:03 +0200 you wrote:
> As discussed in:
> https://lore.kernel.org/linux-bluetooth/ed949f2550f79a4bef19bd482bf8b069ad5b7e0c.camel@hadess.net/
> 
> Implement a cleanup helper.
> 
> The MIN/MAX fix is here because it touches the same hunk in src/main.c
> as the other patches. Feel free to pick it up straight away while the
> rest is discussed.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/6] all: Remove more unneeded MIN/MAX macro definition
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ca2b39b0c08e
  - [BlueZ,v3,2/6] shared/util: Add helper for "cleanup" variable attribute
    (no matching commit)
  - [BlueZ,v3,3/6] doc: Recommend using _cleanup_ and friends
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9ba6c13df5fb
  - [BlueZ,v3,4/6] main: Use _cleanup_() to simplify configuration parsing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=140e3569295c
  - [BlueZ,v3,5/6] client: Use _cleanup_fd_ to simplify urandom access
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e33f5027b898
  - [BlueZ,v3,6/6] btattach: Use _cleanup_fd_ to simplify error paths
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=02aa9a8cfe6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


