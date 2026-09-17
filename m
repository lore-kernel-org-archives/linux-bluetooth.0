Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CA352F29E
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666272; cv=none; b=Y9I8gIyO9LltbL/Eigt3VCupH2kyBRc1TrWc3fF6uh3Bwgrsr3ss4J+sK7tAed5Yx2Fc+f80Vun7CgZkhV3jjP4STvBtOx32LkCrNYPXFnyGVHEzPRctcBPA1f3dKat3Gg9LoBipny98Fvoh9GgMLz1jEg1trRjEWGjLjZK8n6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666272; c=relaxed/simple;
	bh=EhMLd+W0LPmCulzCAgjxYAowPiFzjvLR6qFtlM9SVa4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DGV/dG1MY9MrKh9Z6mdGZ5lq0B0lY3cdQW6qKt/eCyKMyiSx5rvOhZzmUmcOg407aeuT5/UUAu7dWm6PXh4YJyWPq86oIFNk4+pV86yew3jm6rC49e3eVHPCkCPnO0GhtLu4NNcYpbpnFCMREDYpJGuC8QT2mJMHOODr5B4rHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOUAWiis; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOUAWiis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1232B1F00898;
	Thu, 17 Sep 2026 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789666271;
	bh=IiR+htvtaFf4QhW3fSAbFvooy2LDP2QSA84s9D9S1KU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fOUAWiisqqywGSxKj60mWJZAU4lCP2mNLdRif1gqmnPVZIiwjWLlBl9Q+j1Vieai+
	 qrA0K388hN2c04zaLxo8sF1EbnKBoBtjIk5i5TnPCc+lvgrwf+QLl50hmN2+N9O2CB
	 88ScrmRfDpB8FE18ZhBTC9ABy20FY0UVPVdz0J/TSB1LBjJrtMsoJKSk++jEYvMGyw
	 crZT9b5Kdv3ly13WDuTRYNHutWPFpiiwMWVIEgmAlJ7PGe+8jQ2jkTeZO1Rnf0sSkT
	 Og0xWJEBNnnpLIIAMahkVcR5uH/ZMUwwImjEGC5zbpSs+EQA12akcTOQQ2lSZfe128
	 sO3fljnaIUaHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A51381197E;
	Thu, 17 Sep 2026 17:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/4] gatt-server: Check prepare write length
 before
 reallocating
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178966620463.3782583.6861381345742673420.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 17:30:04 +0000
References: <20260910184216.1601639-1-luiz.dentz@gmail.com>
In-Reply-To: <20260910184216.1601639-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Sep 2026 14:42:13 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> append_prep_data() grew the buffer and copied the new fragment into it
> before rejecting a total length above UINT16_MAX. On overflow the
> allocation had already been enlarged and written while prep_data->length
> was left at its previous value, desynchronising the buffer from its
> tracked size.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/4] gatt-server: Check prepare write length before reallocating
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=985ee7b3ab0e
  - [BlueZ,v1,2/4] adapter: Unify the A2DP admin allowlist UUID mapping
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0ccdf019681c
  - [BlueZ,v1,3/4] battery: Document the unknown sentinels and fix a stale name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ffbcf6f9d38
  - [BlueZ,v1,4/4] client/bluetoothctl: Declare the controller helper in its own header
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e5dc89d28253

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


