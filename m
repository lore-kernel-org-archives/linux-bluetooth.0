Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1CA3B530F
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220043; cv=none; b=OepxZU6YHsyEwlKXhdPpU5MPZaELwLe3UJa69Pnr8+HJSDPnYJxGSq3s6xa3A8sJEDZuwpiiztFpcG3+4Zok3fX8NXgA/omkhLGP3fWBxxZwzrJT8PpaV4hHmtH30stYDvTqVvKvwc63OOJJmfi3l0IVfL7chWWA/CALzjSOKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220043; c=relaxed/simple;
	bh=m2gJdwt5Mg8WqYkjKuNOiwyoHun4coMyFVG7MRwXSnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jYVuS2Coan4LkwRKz8/HLAuQ7Bka8PzSwGo4twmppudC/tRBtAZVC0Bd6mY5cLc8QzJsQTgWvpZQ1ZMtYX+skO7UAkfmhVgutqbxdjXJyelzoKWEonOLaZzZf7urpD7HbG4bb3qv2rQ7GGeChRW2fYtiCuf+JJj+vWy53ByRT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8H5/Q2y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8H5/Q2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFA11F000E9;
	Thu, 16 Jul 2026 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220034;
	bh=HEUp80+blhfMOzHg6uQf9E5htKWuKlc4KZtn/b1yBLM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f8H5/Q2y9pnxtAHpAIWIumST3i9rn7xmD/SB+zDnbD+0HuHq6HimmlpB1WRY2QI4i
	 chXQfTVCiFIeyehFxJ3Vk/RR22uBPLA3QqD3sKN445Yq1BDlouMSmqmgfwrmFudbmN
	 Cy0NKGq7FLyg18W+igYDF52hD0Kpb+xbOW3elN+aUpzw8cm4xJcw4ZS6MCeCZQLfD+
	 s03t58kLPOSgX/ROWFkO9cQXHwubPj9D+ta3xpwVnX+2n5xenWF7kf4zm4KoFi/MkM
	 DggFvM4KWUMiNAGhpCi593ZGJn1f5Nbqc0zPtTZ8KddbqqOddttxwablNR8USbfHbq
	 Ms20uoG6aWmiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569833809A29;
	Thu, 16 Jul 2026 16:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/4] Add Channel Sounding Dbus support and
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178422000684.1338131.4594006652273177415.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jul 2026 16:40:06 +0000
References: <20260712121743.2842547-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260712121743.2842547-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 12 Jul 2026 17:47:39 +0530 you wrote:
> This series adds user-facing control and configuration support for
> Bluetooth LE Channel Sounding (CS) through a new DBus interface and
> bluetoothctl integration.
> 
> The RAP profile is extended to expose an
> org.bluez.ChannelSounding1 interface, allowing external applications
> to configure default Channel Sounding settings and start or stop
> measurement procedures. CS configuration, frequency, and default
> settings are moved from hardcoded values into shared parameter
> structures and accessor APIs, enabling runtime configuration from the
> DBus layer.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/4] rap: Add Channel Sounding parameter types and APIs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=befde3661e03
  - [BlueZ,v3,2/4] src: Register GATT profiles for Channel Sounding reflector
    (no matching commit)
  - [BlueZ,v3,3/4] profiles: Add D-Bus Channel Sounding control APIs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=66d986081360
  - [BlueZ,v3,4/4] client: Add Channel Sounding shell submenu
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=79d1a58208e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


