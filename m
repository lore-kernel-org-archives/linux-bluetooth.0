Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723416;
	b=1Iqz4jbAS9gLvixpbvTA2RymLZXLtN+sPHCECzFK1V6Po2PR+xF0tD/N3grng9gQVEL9
	 UzwMzJDdieVdzIy2UgjvN62USimI12qJJGpGIe7kTrRgA3Jf/g7Vf1Pspx7wgTzMpVKS5
	 GK3Nfkuu7XFFrDwHhOjp7MZ5Y1jxRcRelNBgFpo0yigiimodIE6xdIkUO9XvWZlJ56fsg
	 beExd9bhAC/Vn3SCsRjjLRmp9XslKNvG3mgPh6ERXBBnqSork2PWOTxiV+F19nCeYVd+h
	 0JDNg8z0NJKnFAnAWxMdks8txOfOMiJB2jaSwi94aNIOANVN90cNo3Y1boCW5GnkUBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723416;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=woqvNn2OUTGbssJtkpyFtNtQUyry6NOQdgDtqjWMwak=;
	b=h8t7R4HSPKNxJHXWzGkJaKH46ueUXVRFXKi7mIKqEBjp3Mi4jsr/1TOUxr5oc+yAegAg
	 ggAKLVWO7/2+JBnLS1omJ/sEXm2BuNxQOH8EDFefR4rQnJiLDHfjC62/iDrbeTT1ZidG8
	 x8poOYfU1vdR6KbSrmNnUbBlIVYsfUE35sYLHqKYFeZ948avcFbnf7PqEb1PJeka7llYC
	 nPW5NTKDQiALrSdsndQx3Jk92NcYbQG9s4vtXnV2S6Vw4FcQ/DctBE8/1oHv30abmtbzL
	 CXyg+veWEXwQF9XnGx3fUJiqqFPmocS5/H339W6/0zHPLKH+5teXNobb91BCHewNg6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUlC9YgM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF15606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUlC9YgM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F20E1F000C1;
	Tue,  3 Nov 2026 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723416;
	bh=woqvNn2OUTGbssJtkpyFtNtQUyry6NOQdgDtqjWMwak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DUlC9YgM7+So+7meEieenLZa48J8dJ6upT8vkKp/qzr/bGBmEpsVKAC6ottiVMqkJ
	 8MUaJzbCyq7PN2vBcRJk50DnfVR7ZkxphZMYvs+q/WsoJzs0dbFeg2l0b1sUXbUT4M
	 aZt6F0IKkudPn3hE8YVXdxMQ/TKoWYjgCI20npBIsTwXU3pg6D5q3/RcUb9BkvdwOu
	 qrGxNvzY+3FJvgKGP+74o9KCbD/NHhvjRSae8ijVuYEqFjDMfsUaN77mGkOYz6pQUr
	 eYaN5Hw6hsajfiQv4w6PoeZ9/CfZ9dmaT3JVgNZ0HmbxZJDeFmuDOGGlbMA/ivCFCg
	 5SDLQazzUmsjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03113391AFF6;
	Tue,  3 Nov 2026 16:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] profiles/midi: Fix running status across
 channels
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179372341454.1736455.18207620929462425550.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 16:30:14 +0000
References: <20261102221223.16079-1-rasmusml0501@gmail.com>
In-Reply-To: <20261102221223.16079-1-rasmusml0501@gmail.com>
To: RasmusML <rasmusml0501@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, rasmusml@hotmail.dk

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  2 Nov 2026 23:12:22 +0100 you wrote:
> From: RasmusML <rasmusml@hotmail.dk>
> 
> When two MIDI messages of the same type but on different channels end
> up in the same BLE-MIDI packet, read_ev_others() writes the second
> status byte without the timestampLow byte that must precede every
> status byte. A receiver then reads that status byte as the timestamp
> and applies the following data bytes to the previous message's channel
> through running status, e.g.:
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] profiles/midi: Fix running status across channels
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=737e84da251a
  - [BlueZ,2/2] unit/test-midi: Add multi-channel writer test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae27e4a2baf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


