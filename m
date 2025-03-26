Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D71F418F
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001799; cv=none; b=oCmsqa7csHKQGqK9vcJwr+nXxHytmahAE5Uw/rkPIyofDtl4okxhSso+Su7hw09g2qm6IJWdyz4il2txEMZ0HGBYWwiU1/wg67ExO1U+N/WjKQemrlqObvqNKf8Vj1yTA03roGD5Ed1MHRyJTcqD4UwICnmlsRETJwy/1RuqnTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001799; c=relaxed/simple;
	bh=K0LIrpdM8HZ7jN97XT/yKVBmbTJ9JiFJrxi3ub0uQhA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g16TBMwz935XZqv9LLXfRoDrUTxBEhD/V6UYz4xe/sIhXPGUM6bBOBy/b7wXG+C7G7j+btoGe1rnbEM6u9s1ZvIPD3XMDbPQkYEg1EnPgst2sEHRIuo/ykAuGceGe5IfslLlP/BsHVoXt09F7y3kuJka0j2F2eoHmyq3/SDknGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2LJBtw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2LJBtw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE371C4CEE8;
	Wed, 26 Mar 2025 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001799;
	bh=K0LIrpdM8HZ7jN97XT/yKVBmbTJ9JiFJrxi3ub0uQhA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G2LJBtw5Pbd8pxMGx1PPsL3tV+57GAjgWJoFg8yMA7dDp8HqOXnn6ybGrwFR2oX/s
	 fsSL+boddKhSNwVoYzNP0xhIoYlPbkJTyBzMTtp3LQvXFX5BGh4BkOVSziX/DCNFnX
	 SZ9i1IKMkzL0ymtl8/5qOsxEA7lsX15EDnPF1cRTEu9IWhw67PStW16ZZSfyjOMaKk
	 EEGPOksc2VxO7HoueJLHYgfEP4obrj4QlNihEZ9LgfHAsery5WwS6cesaYWlYVskav
	 qZR1wVNjBZAqtOIxFCUwv3ijKyJMDg7mJR6sdIUA8O1jbVhWrEG1y8eawDrFrQYaOE
	 friY6WzD2eWoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 725F23810901;
	Wed, 26 Mar 2025 15:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] bass: Add support for selecting multiple transports
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174300183499.1347744.15959214911229703681.git-patchwork-notify@kernel.org>
Date: Wed, 26 Mar 2025 15:10:34 +0000
References: <20250325155211.18111-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20250325155211.18111-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 25 Mar 2025 17:52:10 +0200 you wrote:
> This adds support for the BAP Scan Delegator to select multiple transports
> added by a Broadcast Assistant and to acquire them one by one to receive
> the streams.
> 
> This provides a fix for https://github.com/bluez/bluez/issues/1139
> 
> Iulia Tanasescu (1):
>   bass: Add support for selecting multiple transports
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] bass: Add support for selecting multiple transports
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=de22ef2bac4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


