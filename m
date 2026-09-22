Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606D755292C
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089287; cv=none; b=sSsUWk72Wcf2xzN/KdWX8w3zQ8/BGwJcUBpup5SXA3QgmNpkz5F8np8pumpk+eX1WjSs+Fp4dE66z/sjPpPDbA07/jPi1HU9dynvTorcJSI4w3IdvupGRHXzhfHixh0KUPnaAxzd4hcygH1R82AHwDeiaXer0EtFuJA1CH60NmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089287; c=relaxed/simple;
	bh=YKCAhqudMCMfXwyfyLtouwCDR5zpWZvHJ3pBxLDcDuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pMQXCO0DEP2xeQ1z6M0NX0eECo+z3GM79GMkxlk2mFCOnsVRodOzrTPjIk1RcLzOqM2+apIRshb/Kv4bIYcB6Zlb9JZa0bvq6Wdcx1XjejEksLZhSmZ/a9PJX4DcWrq4b5/Y4l7Bw0eUwa/Bv8NceBwODoeFWRqBYioBJ8iX798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4nHpSzZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4nHpSzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1701F000FF;
	Tue, 22 Sep 2026 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089286;
	bh=x42p5uV605QBbk8AeZnhcLf7dMAHVOREIfb0NGhPu3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X4nHpSzZc2IVU+jYHMb6pfzSti6zcyU5x2ERQRT5wxkCnCCGWXqaaVpncgjqCmyiT
	 ugSWBxKlpYoHWnkBET14QDo174joIQnKhmaooB49LbgeJBrA7fBmYsa60EqNksSYtU
	 XXqX/TEba0T8ooIQ7sC//JnPCP7vlwtHSz1vTvMQlqo0QzInL7Kid3lEuk1Wm/ijyK
	 GD99CuVS6M4wchSJmSFDg0DCaEZYKeZn2KVVdScB8aV94wCSC7wYbGCVegPuAK1wyX
	 oL4SRG1JMwsL7BlEmkuzZNIv10s2Nyxyqtd85I2N9iE2raj/JMUhgWBH0ZeOc2jvtk
	 VZmEgpGYeg7Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 567BF3811A4B;
	Tue, 22 Sep 2026 15:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/6] Add true wireless BAP broadcast tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179008921688.4126096.7132229331196034449.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 15:00:16 +0000
References: <20260921210123.3690449-1-luiz.dentz@gmail.com>
In-Reply-To: <20260921210123.3690449-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 21 Sep 2026 17:01:17 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds functional tests for broadcast setups where the left and the
> right side are separate devices, as in a pair of earbuds, which so far
> were only covered with a single sink taking both channels.
> 
> The source broadcasts one BIS per channel, and each side registers a
> single location, so each of them only gets a transport for the BIS
> carrying its own channel: the sides are told apart by the BIS index of
> the transport path.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/6] doc: describe the true wireless broadcast test cases
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=086a30e3cf47
  - [BlueZ,v1,2/6] doc: describe the true wireless broadcast assistant test case
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4c8102eecc20
  - [BlueZ,v1,3/6] test: functional: add the true wireless broadcast tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=547afc7ef35c
  - [BlueZ,v1,4/6] bass: keep the push target per MediaAssistant object
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bb59c19e299f
  - [BlueZ,v1,5/6] client: connect a device that is already paired
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e691da62c62f
  - [BlueZ,v1,6/6] test: functional: add the true wireless broadcast assistant test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=98d6d1350a6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


