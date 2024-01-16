Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621F1C6A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425625; cv=none; b=AZbOsiLNEQoFLoKiH9TAayeFtoQqjeOSU8PzXNn2RacjP4NM7JVCJUieiF72YPNzgh1ts/nOjeBfTi7DTGk2nBw1VPIdYv+OAUqjRtbKPOEI/SGrBEqD8yj4gaoNREIut8G24hGdkLSGE+WIoii8uKPPDsu2gBr7tgGz9ArjJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425625; c=relaxed/simple;
	bh=v2ZGgtcq2WMExr/XEI4a9kBERNn52izAR6t2QNMiN+0=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vEywAMnWn1Y6zabhm+FzVMRhKowCv7f4ZbibTglMZ89cUD6HA0+/9lwvl8cdAKfJUuIDnKQjy1bgquinnaxDRft9OaOtMv5u2ppEHDCh1hKFtaau4jJrG0gcEoo5H2S6IcAv7hIFByBK0XlwCgJHgOxmK/WTe6lCr1ojf1jiCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV7Gxt9n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV7Gxt9n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15988C433C7;
	Tue, 16 Jan 2024 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705425625;
	bh=v2ZGgtcq2WMExr/XEI4a9kBERNn52izAR6t2QNMiN+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PV7Gxt9nEK/Aqx5iyjoqqu7VPytJZM9ltUwrQ2w4xnfwYijV6C5u2rWgBH+AEdiQI
	 E3xQwI8fp/lM0OBE4SUaCk5wjoysxjEN2Mtr8Rzt7L+lnjO/qtQhX6B1ql93fVQLre
	 H5fj0RKTwy18KPC5NsoRsrqxcFAfuKHjNgGeAW5yDTYtMlVb2Uh5LyEa5RWrer5EiF
	 9UhJpHFQ7W2KTyRJSnxF48m7UYMEgzftD76xvZOLCfQkd7GkNVD746CFn5kvuG9RET
	 Z6EQDkD+Xhc3gn91LwxMKO1ZnDjQje4hSAt6+BHEN58CfhG3vzHeexFdNFCk889JMI
	 c0LySvLOpfubQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED975D8C987;
	Tue, 16 Jan 2024 17:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Add code to support dynamically generated BASE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170542562496.8089.4325846636458566898.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 17:20:24 +0000
References: <20240114224104.37716-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240114224104.37716-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Jan 2024 00:41:02 +0200 you wrote:
> Added code that will be used to generate the BASE dynamically in Bluez.
> This code will help when will remove the base_lc3_16_2_1 from player.c
> so we can use the preset from the endpoint.config command.
> 
> Added fix for ScanBuild error: Dereference of null pointer
> 
> Silviu Florian Barbulescu (2):
>   shared/bap: Fix ScanBuild error: Dereference of null pointer
>   shared/bap: Add code to support dynamically generated BASE from
>     presets
> 
> [...]

Here is the summary with links:
  - [v3,1/2] shared/bap: Fix dereference of null pointer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a3e935f3f65
  - [v3,2/2] shared/bap: Code for dynamically generated BASE
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


