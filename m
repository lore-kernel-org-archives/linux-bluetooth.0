Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793367615;
	b=mbGzOWTFc1vY7S4OjMfYENBeGmE+RJR7ozK7q2pcjMqxlN6z3GjVj3yoyKTZo7eqHq1J
	 LUF5wyym5vfdGt58Vv3AuU96htNcVKA8xSpO1wLqQZkG0WMqz7kMTWDbA8e7p4O6tqiqS
	 nAGFro2F9moXBMHH1/ix204R1mJ6+TeOtPV/JY419eZGpvcwVy0BiyBQVzumo8RFXNbYB
	 0iQFdhrA5RdZPztY/6MFEbxRyS/W1YXu8AdUwh5oVr4JuTubg1IbSST3u2ao+2gFcTWxy
	 x+fP393O+DW8v1J0A8tDSEp0xLThZDD3b8Xivt3PkyFIEPeeoGwB87iQulapnpL8X0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367615;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=vH9f/OAgXyWxwWWm/WtCN677Dj3sXewYTSKHDJSzgHA=;
	b=upvBs2ncwx2jUDjec+bJsPJjmy54yskzThnE20vpm3ODVQgOCQ0mEE5EE4/KA0iy19FD
	 Zv5VYiPXVE1x0f5N4p2PruQJ2rwW+gJ2rJa/YRa3IyziDOABEj109+ViQ9jAAhQNV+cnK
	 Kn/Fm9wgBv+TRt7F35/G7phgJ6OdYfGMPrCLc8nmTO3FN76xh+lZ+7Sgy4YreePL9UVL+
	 aNU5UnTNUAEqSHWA1ObcBJkrczLE6+pp2Sox7oHkccRKt6r8GGKdsUfHrnEejgUKptzEM
	 R5uJi1VFxQCXLDsWpD5lsniPMBjrLgs2oc2k1fl0cjnrYUbw3cZdUf5edC0MtwlRe9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSpwjTXT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5567606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSpwjTXT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A18B1F000C1;
	Fri, 30 Oct 2026 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793367614;
	bh=vH9f/OAgXyWxwWWm/WtCN677Dj3sXewYTSKHDJSzgHA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GSpwjTXTChmm7Ztf4XyiTS/4MWCu8HQtC+2JNfGjZxjWnrK0C1nN2OI5p+sLK3O13
	 j6KU0NPs+pWHRUwg2iFpYNZRFrpW3KQpADZDpYNH++sY3SIAFXKOFoVLLpAafTFFME
	 p6nsgIfZ2IBCeXuGsUMCciwRfo1oaigoyFvw62+v4xjdn34dL8jOdOssSI8W5KdawV
	 /nvfDlA0wpIlLM4Fu2PpQwyZNRE/kLv/DZ97EHpVMbqtOgoJ7LdZFSG/+XSYmoE0El
	 76xp6WqhcgAKRM0ObUsO5z9Wxou5/INn1QsPacSn0geSy57FZO7g+iDj+XO+HPeD4F
	 Cpd0R5w0vT5gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401093800462;
	Fri, 30 Oct 2026 13:40:14 +0000 (UTC)
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
Subject: Re: [PATCH v1 1/7] Bluetooth: btintel_pcie: Add LOG_MASK parsing from
 debug INI
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179336761305.1081341.11036197403999043554.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 13:40:13 +0000
References: <20261029095344.3989729-1-kiran.k@intel.com>
In-Reply-To: <20261029095344.3989729-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Oct 2026 15:23:38 +0530 you wrote:
> Read an optional LOG_MASK entry from ibt_bt_dbg_cfg.ini and store it in
> a new log_mask field so that diagnostic logging can be selected per
> device without rebuilding the driver. The mask defaults to 0 and an
> invalid or missing entry leaves it unchanged. Preserve existing DBG_PATH
> and ENABLE_INI handling.
> 
> Individual logging categories are introduced by follow-up patches.
> 
> [...]

Here is the summary with links:
  - [v1,1/7] Bluetooth: btintel_pcie: Add LOG_MASK parsing from debug INI
    https://git.kernel.org/bluetooth/bluetooth-next/c/f3676663412f
  - [v1,2/7] Bluetooth: btintel_pcie: Add TX/RX packet dumps under LOG_MASK
    https://git.kernel.org/bluetooth/bluetooth-next/c/cf4421062795
  - [v1,3/7] Bluetooth: btintel_pcie: Add alive interrupt logging under LOG_MASK
    https://git.kernel.org/bluetooth/bluetooth-next/c/4a8be4ecf7b3
  - [v1,4/7] Bluetooth: btintel_pcie: Add Sx transition logging under LOG_MASK
    https://git.kernel.org/bluetooth/bluetooth-next/c/2a125bd559db
  - [v1,5/7] Bluetooth: btintel_pcie: Add MAC access logging under LOG_MASK
    https://git.kernel.org/bluetooth/bluetooth-next/c/20ac6f245ca3
  - [v1,6/7] Bluetooth: btintel_pcie: Add target memory read logging under LOG_MASK
    https://git.kernel.org/bluetooth/bluetooth-next/c/9d05e0a3685d
  - [v1,7/7] Bluetooth: btintel_pcie: Gate mailbox logging behind LOG_MASK
    https://git.kernel.org/bluetooth/bluetooth-next/c/0e8c6f65e567

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


