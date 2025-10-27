Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F22D8773
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573039; cv=none; b=pmeS16ePFCm6ngB0pIL4pPZOPkFykfp2dZ7yc019+UpNMCAFoF08Vchjxj6vnt8ZVIRf7q9fsma4S8A4+9ClyAQKPbmMQr7zEk/vbGHmeJAOANOFSt6dJR9h6mnZCB8NgTO2KUDs7LnFVT91INeCwz1RwJLREYrqgQ2GDMcuacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573039; c=relaxed/simple;
	bh=1Ml0zmeHc1+nOwPVjHXXbSqaKb1t5DabE3tliKVixZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kUV3n9HsagR+X38KZZZjb8EwlViwqhsuEd5OVLsrH3vLvPJ56eVYIPADWgviQxrLIsFnwUy2qW35ZpFDqdv2uHofv9nAP2HhAkz2EZYO3YPLTXMvBS4ttV9QDY5vEmHv3gMoLk0EXQf+7mRvqOzywkmE7uNdTSkLjB9qe0pIZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5TwBTqa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5TwBTqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D34C4CEF1;
	Mon, 27 Oct 2025 13:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573038;
	bh=1Ml0zmeHc1+nOwPVjHXXbSqaKb1t5DabE3tliKVixZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G5TwBTqaiV2HdqHfvGDMQApUhU6+6NIdmD+w8HGbZLOf5TO80klHfJu88rociG9Lb
	 +n427f9qRByrIKW+Oks30muW0qOAPKT/dQEZfEg7318JMZNc/m+jtB8jJ/SWBiU7kn
	 /NT1bY4wRBReYskpmgE99UPy8/BAHdLUT+0sM+mIPqIFpfYynd0Wf6a4/bNEk38xMy
	 6PeWpWMHg352pIaJU+x5pWlJnM83aaRFZGG2goWZ1TjlQFY0l13Jnt7k36B2kQZxWi
	 u2jPEJzYrRDhyep9vgS2i2VYMDHXfSA1DM8pSPNgwBcf665mX3kukj/AO1QXP8OG/L
	 14NmywfzLxFng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C1A380CEF8;
	Mon, 27 Oct 2025 13:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 01/13] bass: Only attach client if initiator
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176157301724.1378834.7090095864019432589.git-patchwork-notify@kernel.org>
Date: Mon, 27 Oct 2025 13:50:17 +0000
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Oct 2025 17:00:07 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes calling to bt_bass_attach conditional to being the initiator
> of the connection, otherwise both device may act as both roles which is
> not recommended.
> ---
>  profiles/audio/bass.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1,01/13] bass: Only attach client if initiator
    (no matching commit)
  - [BlueZ,v1,02/13] device: Add initial support for setting DEVICE_FLAG_PAST
    (no matching commit)
  - [BlueZ,v1,03/13] bass: Add support for setting DEVICE_FLAG_PAST
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a5ceeb414c86
  - [BlueZ,v1,04/13] MediaAssistant: Add Device option to Push
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1452790f1489
  - [BlueZ,v1,05/13] shared/bap: Add bt_bap_get_db
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3c67d49258ca
  - [BlueZ,v1,06/13] shared/bap: Fix no calling attach callback on bt_bap_attach_broadcast
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=603ffaf50af1
  - [BlueZ,v1,07/13] shared/bap: Fix bt_bap_stream_io_get_qos for broadcast streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c560149e1afb
  - [BlueZ,v1,08/13] gatt-database: Add btd_gatt_database_get and btd_gatt_database_get_adapter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bde3c34fd7ef
  - [BlueZ,v1,09/13] bass: Implement Device option for Push
    (no matching commit)
  - [BlueZ,v1,10/13] client/assistant: Handle assistant.push to own broadcasts
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=667db9a82a3f
  - [BlueZ,v1,11/13] client/assistant: Detect if object already contains a valid BCode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fdf49338d97d
  - [BlueZ,v1,12/13] client: Add script that setup a broadcast source with 2 BIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e52f05e1d664
  - [BlueZ,v1,13/13] client: Add script for testing Broadcast Delegator
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f80a2a57c910

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


