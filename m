Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F421C9F2
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495894; cv=none; b=S9+MLymgakREa6QDvDealXrylkY/iZSBKvrbP0MbyHDIrwEqL0V+qDd6WODQUnbSStIfGTcjl3gs2+Q5HqjybcqQp0VJqxCDLy8rCNX6kKK2Tf7qflWF+ePg7vFJSxJvSUw+a3L74eUWWyYu82GpyWzzahKmi/Rrt6irwD+quEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495894; c=relaxed/simple;
	bh=8Ie4VebcFU2qysIsqPKyD3BdTXyrD1NOJfHY2PEU+jM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MEKGmzug0d+U9XGwr7TLsbDQkzak6FfH64wLJR0Z0jO76MnM6Z+I5d9BXuTsZmwNcjC1HM0vyoO4lTP2BnaEzGXBaoYCBEyRFBxeuotyTOafAW8nzC3FeSnLNR0T0PI60GWrYzGrRsXyrxhdONaol25gKEV+hsPDPbxDTBQaoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVaEEAKB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVaEEAKB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8DAC4CEEF;
	Mon,  9 Jun 2025 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749495894;
	bh=8Ie4VebcFU2qysIsqPKyD3BdTXyrD1NOJfHY2PEU+jM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oVaEEAKBJJMR1GXJVXPHmzqQsAmhJjv3RPyTK+Ae3oZrDQrz4Xysm82xod3150lB+
	 PN1487IPzuPaclUeEF77U0B5+guA8DHJDNmClFcQ0O+6Ez8swnnKqtas7cIb5oi76x
	 yBd3IWyBcEojwtJqn5rqjEy9GvXvLAlylzVtmMxArUwP0kGiE06ddC8JWyOdyhOKH2
	 VzC+jIIXevsso72l9wS0i9Y7CXxQR1N0AH0R69As0fENDhwYaGXVouFjjClQM4AHgU
	 P98o85cgi6uVq1LKBAQt0+NdeMFG8z3mO1l4ZfWfr3AP1iPanjBaKXvus3Ot3l2pkL
	 HOlcUSoReFi+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE683822D49;
	Mon,  9 Jun 2025 19:05:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] btvirt improvements for LE Audio
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174949592448.1356526.15327081211524527340.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jun 2025 19:05:24 +0000
References: <20250609143811.566331-1-d3dx12.xx@gmail.com>
In-Reply-To: <20250609143811.566331-1-d3dx12.xx@gmail.com>
To: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Jun 2025 16:38:07 +0200 you wrote:
> This patch series improves some bits around btvirt, its interfaces,
> advertising and isochronous channel handling.
> 
> These changes enable btvirt to be used for simulation testing of
> Zephyr Bluetooth stack implementation of BAP server for LE Audio.
> 
> Dmitrii Sharshakov (4):
>   btdev: implement extended advertising
>   btdev: fix LE Remove ISO Data Path command
>   emulator: add option to listen on TCP
>   emulator: server: handle ISO, use BR/EDR+LE 5.2 by default
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] btdev: implement extended advertising
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=964585e3b352
  - [BlueZ,2/4] btdev: fix LE Remove ISO Data Path command
    (no matching commit)
  - [BlueZ,3/4] emulator: add option to listen on TCP
    (no matching commit)
  - [BlueZ,4/4] emulator: server: handle ISO, use BR/EDR+LE 5.2 by default
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


