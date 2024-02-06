Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016511C283
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258632; cv=none; b=I52j6L/Cos2oGxQW3ysnYtHZ7pCygDI3DQ5Hm6UdeGgImZsRN44vy7owPKImVNGHfXCfz6BRB156cJQaQajlcTJ9e4EGcbfgyAuXgNutFanmAPZkK7gKmlRDY06H6o2UwIw7d+nLgvudNzVwNjwCqUXSCeKZzV7KeF7Hhw2nhYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258632; c=relaxed/simple;
	bh=0RgeApuAKR7KdS/4hClGeiH6fuWdT2qB37LKtezLX+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PLeCYPLXCAFUDv9aq7alwcyWzi1Yu56Jczcj1ZU8e4bAQ/U4WJe53JcRVUM43cl7ARsenafjvbLhwnWTCgz2hqKTonpChDN/1p8LTwY6mjST3/HKMaFPOjBTaDsOE/mSBSzhREeFeoY3BFjIFlSx53oVV2bmGJeOwjeG+XypAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/zZ1ogr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/zZ1ogr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F2ABC43390;
	Tue,  6 Feb 2024 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707258631;
	bh=0RgeApuAKR7KdS/4hClGeiH6fuWdT2qB37LKtezLX+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b/zZ1ogrXoi015aV4mU6mzztjeepaYLCfkttjTsS4nh3/aDYo0Gi29B/YoSnHZQOM
	 LJFJ2iQzc6QOvKPOjN+iB00buAZdhtmei7qTXEFklnANUENStYan1NrcJ3nqGMqIji
	 VOgp6uoJd7SCWMGaC6ezcP12dQbN+0JAW4Y8ZNuRn4ZnHqaCqUFk7rh0Tt1CZ3eV0I
	 hmFJcxXE/UhnbDuJ8W5O1qThGx2yVDz5P6CgO487eQLUYIZ3FY/CSkaVEqOs1lNMqr
	 HPsrWvDck/FGRWiJ40+CSTtWOTO/NGe2Sngd62VyLDp5XY/5RqpiNbQLjJIc4qfj9q
	 /uvAbAOiN9/PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D1D4E2F31F;
	Tue,  6 Feb 2024 22:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/4] Adjust tests for sequential conn establishing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170725863144.29070.6388777695583932801.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 22:30:31 +0000
References: <20240206112253.76446-1-verdre@v0yd.nl>
In-Reply-To: <20240206112253.76446-1-verdre@v0yd.nl>
To: =?utf-8?q?Jonas_Dre=C3=9Fler_=3Cverdre=40v0yd=2Enl=3E?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Feb 2024 12:22:49 +0100 you wrote:
> We're going to change the logic to establish connections to ACL
> devices in the kernel so that they only happen sequentially,
> similar to what we're already doing for "LE Create Connection".
> 
> This needs a change in mgmt-tester, and while at it, let's also
> introduce a test verifying the new behavior.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/4] mgmt-tester: Add a 0-entry to expect_hci_list lists
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=141513cd0229
  - [BlueZ,v2,2/4] mgmt-tester: Adjust a test for recent kernel changes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6a264df7200b
  - [BlueZ,v2,3/4] emulator/btdev: Send page timeout after 5.12 secs delay
    (no matching commit)
  - [BlueZ,v2,4/4] mgmt-tester: Add a test for connecting sequentially
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


