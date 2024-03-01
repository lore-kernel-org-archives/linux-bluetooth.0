Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13703AC34
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319634; cv=none; b=VXhV2yI/a/jt0AQRVwtSVbXjUhb3PJ0L3kc9+EiksCbmD9sfIS7VykfzlNMFBBYMsimIu9P8wsyisYquGbbYb1sCZ2pM6Y5R7GZl/zQYTlC16P7vnzASv0WTxUiXpcPi5ndFuyOaOHirntkeZeqy9x7lNvzjQFnykK2wI8MXv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319634; c=relaxed/simple;
	bh=WlpwXCcgC5GAuV4Pw06OPg3P39O9+pYJlOwlSVciRc0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ubHZNIpACVMAliMBJvErlToSSk9BsIX0gimoY7RXX+2413BIN1m8ZCY90Y3mBG4+vMExkkjZea/ES8jNqKVnn9Dl3pyXvxq0RUOyg3to5RtUs98Z0eCxSp9QBmSya5WWhrAoFjTidd69Bh+dsnOzV7cDcxi2+bLb0UoVPQknTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErchSM+V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErchSM+V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57B77C43399;
	Fri,  1 Mar 2024 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709319634;
	bh=WlpwXCcgC5GAuV4Pw06OPg3P39O9+pYJlOwlSVciRc0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ErchSM+VFBltnHmMRx60rUdMGtZq+0V2xe3TYH/m58r5KQanAKZD42drKVAe0d2aN
	 wqnJ/jI5UO0b2v5VZfx7CEkz6QZrx/HfViftr18oNF+A8KwtCrtGAx1gXvbOQaSkHK
	 PZqa5C+g3UdnLMk2H6Hmh8rUF+I/3x0MeYIJbTyWkS2rqbk1IYwQQUl4gDM+BCxWHm
	 BwPTuJpO0kHJd9Xf+BZTEFhRDuMp4i1cVlcFw6kKd8KZQaTve0EuWXIUsmKua8rNw4
	 REqwLUjZ474gO8DnUhMfidK75zVgotBkIm1zdLXyf+ZNznOffL2U+MWm/9hILnCVZc
	 hOpMeNXRBNrIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BCA5C595C4;
	Fri,  1 Mar 2024 19:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/4] Bluetooth: hci_core: Fix possible buffer overflow
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170931963423.12312.3754146571156211740.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 19:00:34 +0000
References: <20240228171838.2414532-1-luiz.dentz@gmail.com>
In-Reply-To: <20240228171838.2414532-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Feb 2024 12:18:35 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> struct hci_dev_info has a fixed size name[8] field so in the event that
> hdev->name is bigger than that strcpy would attempt to write past its
> size, so this fixes this problem by switching to use strscpy.
> 
> Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1,1/4] Bluetooth: hci_core: Fix possible buffer overflow
    https://git.kernel.org/bluetooth/bluetooth-next/c/c6febaabc470
  - [v1,2/4] Bluetooth: msft: Fix memory leak
    https://git.kernel.org/bluetooth/bluetooth-next/c/14cfaede6ad1
  - [v1,3/4] Bluetooth: btusb: Fix memory leak
    https://git.kernel.org/bluetooth/bluetooth-next/c/875829da81e8
  - [v1,4/4] Bluetooth: bnep: Fix out-of-bound access
    https://git.kernel.org/bluetooth/bluetooth-next/c/cfbc55231f8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


