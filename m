Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFF94FC8DE
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841820; cv=none; b=letOvuwh52DGE1shjNYkcVyXH818nTfOexAeW/VBExOS/jOEVRUF27Jrls+EQPur+PQ3X8AL8NBsphnbOc6eqDJNuXshXQcH+p8rGIwdRbQGB3WQbHvymdobG86nI6gldswVlCuyj7X8F5NyV/a7jvAFJwgsMQ2tUdFM8ow3pL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841820; c=relaxed/simple;
	bh=OG1QrdzLzUcy/wrqr+MtipxYY0PWTZwtDK0CLBCxvek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lBsMn6MkB0wR90JTfJpRbiA1h8trhsJoWdcfsiGaAVY5oYNXiv0XpHrpMDrtFTrg84vyZDqiDFs/3h/bL+yNXAZglqd8XG6CQhRgZPp4vF5jeYbPSPen6QqO49bL187QRj39HuviQtEAefuE1W8T0RHyuPi9k3n7XiYtD89KdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhq3K5MR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhq3K5MR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9E21F008A1;
	Mon, 12 Oct 2026 21:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791841812;
	bh=1eI6aTk6mYuVXpApg720KKGxh/60KVPXc5MZAP6Lgmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nhq3K5MRSpSS+Ab9J5foIk1ENRe3h2C97obJ8WRm2cE/sOOafQDAxfKBMFe1lI0ot
	 Olncd2cgKrIKTyeELqNnIHThn5RcBA4lccguR4gSIdEaY3zot2N6NvqmV204qlCFUZ
	 OSzT1KLgtsLCdnKORfOjEg4kA7AgUTGT1jLXZ2tnco3PHkj0l4r56+h0HsbfkGL8ei
	 utNqD2k/eqjaU8oLC7bjCev0V8qjs7w+z4oILqRJGKEM7gO2SW5lWqfRTmtMQKhY9E
	 cyuMVmjt9Bw9mGdh26qvi4o8sw5JXvH7TdVVkmSOpjPtVwgII0O2WphjO7uyMbT7qU
	 8+D34zIM7IIxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44FF39253C8;
	Mon, 12 Oct 2026 21:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/rap: Track RAS CCC state per connection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179184181126.4115061.339294852166421514.git-patchwork-notify@kernel.org>
Date: Mon, 12 Oct 2026 21:50:11 +0000
References: <20261009173341.1143848-1-luiz.dentz@gmail.com>
In-Reply-To: <20261009173341.1143848-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 Oct 2026 13:33:41 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The Real-time, On-demand, Ranging Data Ready and Ranging Data Overwritten
> CCC values were stored on the RAS service shared by all connections, while
> ranging data is sent on the ATT channel of the connection that produced
> it. One central's subscription could therefore decide whether, and with
> which transport, another central was sent ranging data, and the Real-time
> vs On-demand exclusivity check rejected a central because of another
> central's configuration.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/rap: Track RAS CCC state per connection
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=da2406695f70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


