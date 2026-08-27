Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904341D21A
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850662; cv=none; b=ra0dP2v8NZOSbkoKokOnQUYlZmwpxrYsSTWAjiIQ+xcJXUPHlysFOYkcFJZPNcw08ANK+xFwYjm6m626aScTW/kHkcNozon0dDLrl7Er431OuCW5i+iqC/3Rb2C2u3AzXqC5sf7lBSKtpsbehPVLhpH7SP/+D9Q9Exk7DtMSob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850662; c=relaxed/simple;
	bh=kENJQ4m4lw26U3GOdXVwfeSE18v19rcARWbloG/Jorc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dOBYss6Y4R7CupbDeYSwNerJ8+UrHsVvf7DkoPlvfWc4UGRhOWQpgtmAG2u7E1LDpL85a5jzSx3V58DRuvkqgaOh+D1lgJKIlMDeaep8kxkWnLKjGlPeECHWXToZrWzPNpunjHIdHIv/FrEkxbjOw9sX6+RHzYfdBbE60D/Ra4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8ym8X8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8ym8X8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B691F000E9;
	Thu, 27 Aug 2026 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787850661;
	bh=SuKUHPqNInYR5aFye+y2nraM2ElIITAJ+0lbzMgznq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=g8ym8X8M7pWs79kKT8P0PJ+KouXYCDD1MNyZtsmCkE1rmYR+tOch3XPMmP71lTWHB
	 GGTT5fYrqR4OUdXMb5oV7HBYbBORZkbE8TGHlX5xxBzN11WNZSk+7nPbllRxqHND0k
	 iMYHdeeHHicvcH9lquITiJkgDLSBdqO4U98a9AtTAOEHAqtC03FO+SjsSddD+TnIy/
	 Ob1z4gpgRR6t0AGgS2T1vDmJ+YIQmAaXIWHOUiNHBTmfguy6yNy6ktrzvPmBGxhafA
	 A/3tQyrqb+n6F0uDwPPEXeeL3YIJlQ2UJsaHJU/OJZrQsPNrPwh8OhAheovkc5tgP2
	 YxZzrL043OrnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09573809A89;
	Thu, 27 Aug 2026 17:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bap: Fix stack buffer overflow in BlueZ LE Audio BASE
 parser
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178785060639.1754949.17611133756001684186.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 17:10:06 +0000
References: <20260827145807.1568199-1-hadess@hadess.net>
In-Reply-To: <20260827145807.1568199-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Aug 2026 16:58:00 +0200 you wrote:
> A stack buffer overflow (CWE-121) in bap_sink_match_allocation() in
> src/shared/bap.c allows an attacker within BLE range to write ~195
> attacker-controlled bytes past a 4-byte stack buffer in bluetoothd
> with no pairing, no connection, and no user interaction. The BAP
> profile auto-syncs to any device advertising the BCAAS UUID.
> 
> bap_sink_match_allocation() copies the value of an
> Audio_Channel_Allocation LTV (type 0x03) into a 4-byte uint32_t stack
> local using the LTV's attacker-controlled length byte as the memcpy
> size, with no upper bound check:
> 	// src/shared/bap.c:7767
> 	memcpy(&location32, v, l);  // l attacker-controlled, no upper bound
> 
> [...]

Here is the summary with links:
  - bap: Fix stack buffer overflow in BlueZ LE Audio BASE parser
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=627f9fae7895

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


