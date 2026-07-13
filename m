Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACA635B136
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973439; cv=none; b=MKLvUntn6/US8hpGK/+67mMUrxxN6m6xav9zpdg6Icn7qSvAFpsvAk0FpME2viv2Ex7hsNmCaIRnGUwE5TtIEMqdlzcwkODT9JMBYpiGMEnIuhMQttS5Wq3exWBB/Bwavodn+o/rTe10oU+1+6pDpslNzwk1LUUwR4BE/39ujZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973439; c=relaxed/simple;
	bh=VIZoUSMEVmwD1hMOX5asq5VYbybXa+nTTArcLqm7l1U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CdGEKLWGhqxZ3y4Dft1Fmp73TsNYP76l1AOuTp84EpsHrk55gc3/pr4mcw5jJmEhzaPvDcMNSNY7rJ82VMwO/1ydcc82j8pbFEyufPT90VopBV6IQqyp/15noJMSTV6NViu+ni9ZAKTCe79SwbKtUHMUZFyfTLphc0snGpfPjCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPTGJze+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPTGJze+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3CE1F000E9;
	Mon, 13 Jul 2026 20:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783973437;
	bh=krX4chLEO/71a3wInX4EM9iO7NJLLoyguDIiRflPW7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cPTGJze+Hxr4+6WJLDses0Y2YsXb5nCGqKkTthKhhwMNLNgRsMc8LsdcANLzjQA7B
	 NK3ddxMeKv5WbysGTbc5cQk3uG0XJUPquQm/X4WPWe9+ziEW6pP0DknFc+ihQUSCqt
	 FQAVsoWxNGyF6QPH004kPzEUsmnYRceqszjtPm70dLdsSm5K+DnBw36DYiN5fKRx9M
	 kWNr7RMXrfzsfXfMjKDrrHXWim7eQpb9BGZ6WM54UTj6kUAyq5nWL8J1ZH0pSD2reG
	 RawLH2RMrmD5r9P0dzIf8u73d7y1zd0opiRaoOEc+/CMy+F6kE4DENsOd6Z8RgouA/
	 82b0SZ5Teym7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569033924F90;
	Mon, 13 Jul 2026 20:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/4] tools/sco-tester: fix missing clear of io_id in
 callbacks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178397341288.2830302.4192601082706158750.git-patchwork-notify@kernel.org>
Date: Mon, 13 Jul 2026 20:10:12 +0000
References: 
 <acc2842d415b9bef95e60243695463fa7953bf71.1783950503.git.pav@iki.fi>
In-Reply-To: 
 <acc2842d415b9bef95e60243695463fa7953bf71.1783950503.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Jul 2026 16:50:23 +0300 you wrote:
> Fixes issues
> 
> GLib-CRITICAL **: Source ID 126 was not found when attempting to remove it
> ---
>  tools/sco-tester.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [BlueZ,1/4] tools/sco-tester: fix missing clear of io_id in callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0f2f53fd04d4
  - [BlueZ,2/4] tools/6lowpan-tester: fix race in Client Connect - Disable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9353c0ea9f6c
  - [BlueZ,3/4] tools/6lowpan-tester: add test for VHCI teardown without disable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ba08e0f6be0f
  - [BlueZ,4/4] tools/l2cap-tester: fix Set PHY test spurious failures
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1cfe2d8b2cbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


