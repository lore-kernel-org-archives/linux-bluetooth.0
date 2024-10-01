Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46CA18754F
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Oct 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812231; cv=none; b=CAExoXjc2hvX8aeOEhoc9M3A8YDqwaIHtm6RvXRgiPdgyzIlm2MiwLymU5Cj3STaAHacOJFkg2JRSCQjts6j+2P7sh1/PwGaCG4IBPuvfu0HfQJ5urGDFpBHHVP3C8uODEGi6ZUbDqAaVyJtDBKl2+LXC/Mls3bQIlFUTaLAOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812231; c=relaxed/simple;
	bh=PZnt4R3kY0NjQxcuRv0ReJ2AZbyAEK2at8ry7YW1CHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BmwsfWByGl8btTPPSusv2/DekMZYAZ8J2/I/VoIyyrDxHI9GYpjVp2eBGF4Y4ZujvuIe+vXdtJ1GLFb1kUP9WAtDsVNkMizJpo3HzNAgMm6a7ts1lktt9aPN84tXtC74Iho3X+1Dt9eyqDnAuuvSdn0u2kKY0bTT7lozCswnVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKxngj7n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKxngj7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C350C4CECD;
	Tue,  1 Oct 2024 19:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727812231;
	bh=PZnt4R3kY0NjQxcuRv0ReJ2AZbyAEK2at8ry7YW1CHw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AKxngj7no9pJUaiWpmw60HQulItBw3B2RZiQwIxfzPe7JEikKZkPnP2uEG+Dv/XCP
	 XUd5seFZkRMAxTb8Wz7hPMnbCgm7VYVOA8ROHQFS2d7EmF+sg6aTyTHE2PMDnNaF9s
	 /vwvk4laDe879ZfTo+3Ax0+mGO1rk8rcymju4E5rGIJW8PgutlC6P1jeXDTblnCzSg
	 wF5jcJ9P6hDSe1nhDRDmxD/wNvKr2Lxe2mQjTClOftkWUh0OEVK4+eIXKWRxiYndtT
	 7NJqWq/iwOSNrzpDbHykuVW+TiufwGGWjrOJk5EqnMelsANYIrvB6gq719KKKIDejT
	 sEd8IF+rh7lxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCF3380DBF7;
	Tue,  1 Oct 2024 19:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_conn: Use disable_delayed_work_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172781223449.541677.16988892055290436799.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 19:50:34 +0000
References: <20241001165055.3111289-1-luiz.dentz@gmail.com>
In-Reply-To: <20241001165055.3111289-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Oct 2024 12:50:55 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes use of disable_delayed_work_sync instead
> cancel_delayed_work_sync as it not only cancel the ongoing work but also
> disables new submit which is disarable since the object holding the work
> is about to be freed.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_conn: Use disable_delayed_work_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/6774cca543da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


