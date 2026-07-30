Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07792449990
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427850; cv=none; b=Sf+Ttk13GEUt9HKIftCil+wPhvgG9zxvAXLk/2opE0Uz/RfDjJLQdzX7AugWtzGHvld50gJ0EmQaYKya66rPzX1G+uJA/4hPNaryO3mDZHH9FV3iX3he2Y2mAX/iMooEKeZm8Vq+Cq885Klhoz+lc5K04Fl56M7RnQhgRgiLDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427850; c=relaxed/simple;
	bh=g3sUrcKFsiYBLq7goYjsytd0yuf5N1UOOddaIJLcNgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sjryYr8WM3ORNaHWzdRY8ZMmnMSrjC8H8ROVRJMfE+GYL6OWoxwWrKIP6Ht4CMsYyJVqpULaOaXKZJGD654Bi+smtEeSDWgU0XW3u63jyxFaZqIE7ZchFbGuFqWtIwM3Fmaur9ECTsqytSQdeSh+LiAcpqaw/QP4NQXbzv9lzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ6xm+74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ6xm+74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2B11F00A3E;
	Thu, 30 Jul 2026 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785427848;
	bh=kOzZL33DsCBzp1liv3NYg56ZfsqaZ81sjIHeTeIuSmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MZ6xm+745pnf+c3AlCOxt/ERVIRqVSR+ezGoqvoXo8dMiGnaQr+LHEdqfYX417yNI
	 cf3x+bFBWdjZ/dvkwcQKwKBbD7PBzIUR2vQxwcAIYd30RdAdZf7VmDDRaVbCvejcux
	 e46ww6LjCje83RN2BZXhqDKhs8lHV/Y7fVH2jislVvBdyTAwPWqBTRFRH0DuCjpipe
	 qZ/V5baoIxgo653iQTFPcoAH6ErVR8FkWwR68iYR7KvMralHME9ArkmC+Zb1cGz+nz
	 PVInZl9jtKidmUO29kuMisnWwUTpl2wAkjpW5+rMcNpMEEXDgfCKXASYgTp7/TSPp8
	 Dv8WssxmJ3qlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9385938119E7;
	Thu, 30 Jul 2026 16:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 00/12] Add support for Shorter Connection
 Interval
 (SCI)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178542781213.4069407.17479725999715799508.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 16:10:12 +0000
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Jul 2026 15:12:13 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This series adds support for the Shorter Connection Interval (SCI) feature
> introduced in Bluetooth Core Specification 6.2 and used by HIDS 1.1 / HOGP
> v1.2.
> 
> SCI allows an LE ACL connection to use very short connection intervals (as
> low as 1.25 ms) combined with a subrating factor, so a device such as a HID
> peripheral can achieve low input latency while keeping power consumption
> manageable. The connection rate parameters (connection interval range,
> subrate factor range, peripheral latency, continuation number and
> supervision timeout) are negotiated with the LE Connection Rate Request
> procedure.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,01/12] input/hog-lib: Add discovery support for HIDS 1.1 SCI attributes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=92f6ea8766d0
  - [BlueZ,v1,02/12] emulator/btdev: Add emulation support for HIDS 1.1 SCI commands
    (no matching commit)
  - [BlueZ,v1,03/12] mgmt: Add Shorter Connection Interval setting and Load Connection Subrate
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=794eea615846
  - [BlueZ,v1,04/12] mgmt-tester: Add tests for SCI setting and Load Connection Subrate
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=46f08703a152
  - [BlueZ,v1,05/12] adapter: Add support for loading connection subrate parameters
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=071c21873dfa
  - [BlueZ,v1,06/12] monitor: Add decoding for Load Connection Subrate, SCI setting and event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=594eaab8e50e
  - [BlueZ,v1,07/12] doc: Document ConnectionSubrate storage format
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=062bf7b40f9f
  - [BlueZ,v1,08/12] client/mgmt: Add conn-subrate command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=db7e82d95f31
  - [BlueZ,v1,09/12] mgmt-tester: Add HIDS recommended SCI parameter tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=912238948422
  - [BlueZ,v1,10/12] l2cap-tester: Add SCI mode tests for LE client connections
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c76fbeb918d3
  - [BlueZ,v1,11/12] emulator/bthost: Add LE Connection Rate Request support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3aefec4b4151
  - [BlueZ,v1,12/12] l2cap-tester: Add SCI mode tests for LE server connections
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e45128f029ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


