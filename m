Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6AE486E7D
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864646; cv=none; b=OwE3V3gKCLfaZRx2KOb9KapkB5i/wGrmKz3qihF+wjVjiMrg/ub3q/uQAIkvrurkD+fFj5Ktatjehwp/ES7NOoZWQlZamIbNasPnXg98+kELM6P+o/Mh5XSJzeiR4ocS3dGalOTbETOZyUcDg6tX7cgZSbwG4WFC0qO5PRvw8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864646; c=relaxed/simple;
	bh=/UkJ5y3ku+5FUjIb1WsG3Eg716dSHP25KdIszQyzuL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P0Mv7HAcHa1w2d2MCH9MLmbkI0ayZbqMGkBo++WSaFYn+bQjVB8hn5AQi/Wypfim663eNMADWPjPUfZakj0bVnqPAxS2awrg0rOQ6g7BDmXDI/ctaseJzLmAWA+DdiiKw343b7FG1jyhY5QhC8F+TjvfbdpcMy6DPANpsC5fehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBmJmEIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBmJmEIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26961F00A3A;
	Tue,  4 Aug 2026 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785864644;
	bh=d0GvOfBycdBnAfLyTjna5yoaiVRQFb2E33hJvyc3Lv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WBmJmEIK2tlK+RgDbKpHBDmBJbqDAwQ90/PaW4ocbd+6QGWw4c4LC75dNSS5zxHb0
	 p4ShzixGObA/U6Q94l7HnISHtKRjk4fyYEqGRUWa9tGGWAThvI/QRgu1zAzjJVxuRK
	 NFlVJUsvnauCQFkinjcuPon/POSKR/gaCD71l9mteddl41f6QTny5aKXaBr6wT8h/L
	 IgbqP+zryLCOP0851zXPFR7jbgzzpKLcRqbrMt5+C7W68V9v2MC1XWlLqxF1UsuQ8A
	 FGv9S3heLdn8tQoqxzAQ1MDYCozPjfdaZ1eHCOWYN9P20zS4ACppTGvQRquTn+WpG4
	 XknzGVOXQ7ByA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9390B392626C;
	Tue,  4 Aug 2026 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Decode Intel DDC LE extended features
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178586460514.3699428.9244650513396028338.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 17:30:05 +0000
References: <20260730175135.2865308-1-luiz.dentz@gmail.com>
In-Reply-To: <20260730175135.2865308-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Jul 2026 13:51:35 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The Intel DDC Config Write command (0x3f|0x008b) can carry identifier
> 0x031f which holds the 248 octet LE extended features array, using the
> same layout as LE Read All Local Features: page 0 is 8 octets followed
> by 10 pages of 24 octets each.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] monitor: Decode Intel DDC LE extended features
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e0d2a5bfe162

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


