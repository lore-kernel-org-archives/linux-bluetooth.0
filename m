Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5425CC49
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775394; cv=none; b=gjx1T71DrJN/o6cJdryfFr3l1YAGY9G76MsAs3xJ7ff1VD54+fToT5qtmhSC/fb4/WaFmUdDHwnHoXCZq6SslDWhQRaExhdH9uqa90WsHFBhyxozfFRZ0w1o9R0Bul/Pc0s/jXlLQzgll4pcH6pHzNmAH1SpWdonHuDo0VD3irE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775394; c=relaxed/simple;
	bh=8/by4BZ2wl3EbOxrJxlZvEFqpSbbe3snfmjcJci7ZZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qLfeQPAezvQT6wLG8XusVa86O4KCoo8ExH8yE2fKbAKNsAj4ybm9HekdpmL6ZbYBau4cnpLqT3O052Yhs3Up0HGAks9jtOY9n70iyESL8Q+JCgQvwMlDMjdD480VXEV5j1JkCh+eXKaGVkolIe6E3FlCxt5RQvJUmwIiBalLmus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAoFHiAF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAoFHiAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E7FC4CEE9;
	Tue, 20 May 2025 21:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747775394;
	bh=8/by4BZ2wl3EbOxrJxlZvEFqpSbbe3snfmjcJci7ZZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hAoFHiAF+tTX5Q636V+CqQYzM9uzyjvH9467R7S2rdLIoGm9zHhCK1lAfPIidCzVe
	 2inubqefmyewETTD4r7oeiPiDGzZdXAk2kvdotUb/lpryEA+feQf9O/FZZyDD8Esed
	 MPIMhWMM85PCmTybWsdRLTeTY7Zfweq0URmEDycUjnLRdfsxn4oQwsnCn8T6ZcpvEs
	 kIM9nweEy4Wk9eGT3IhoNT8jabAaySeSrskni6B19QFdqoEJobnjnFQklyPmyQK2WR
	 mcmA/p3vS1qpPsNpV1ClV4ExdzDvOe1ULCMzmG12nxthTfyDySmt3npHcQKzp3I52+
	 7TvCV94k4YEdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34678380AA70;
	Tue, 20 May 2025 21:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] org.bluez.Device: Add last-used option to
 PreferredBearer
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174777543000.1463763.3509561458197622406.git-patchwork-notify@kernel.org>
Date: Tue, 20 May 2025 21:10:30 +0000
References: <20250516181731.1967217-1-luiz.dentz@gmail.com>
In-Reply-To: <20250516181731.1967217-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 May 2025 14:17:30 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds last-used option to PreferredBearer which when set would
> make Connect to use the last used bearer first.
> ---
>  doc/org.bluez.Device.rst | 8 ++++++--
>  doc/settings-storage.txt | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] org.bluez.Device: Add last-used option to PreferredBearer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=940717e9fad4
  - [BlueZ,v1,2/2] device: Implement PreferredBearer=last-used
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f39b3ec12e8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


