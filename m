Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504021;
	b=xjVwZT95vwZ+RwNsNQzyhvYNGgDaAvkb3uIoAN+nnENtC8RpRIQj6Xz02ohzZZvDPctQ
	 jrmgCi/h8HQ3yADIIQMcIlWJsOyDL+p2At36H0XX8BIsHROWZ7Twb8MN2eEcaNnHamdwK
	 hCB321XySb7OERGIlH4d5ZBQ0IEAblvkvIxEwT9m67ZhoiPWoZrJ+/MNBpL4slh7daj1d
	 zpylA0LDzriWeFx/g9yPjiTRDYgqo6CfSZKDuwV9w/rual4c76lc5oksN96eWUqVmFME+
	 exuCmN3iYluN7sGcqHTxrxqeD4Qbm0rL8W1ulgqqGc5fXu/QcPv48OqFBhpBwkJKcfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504021;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=VWWjwPtx4nEiCoxZ5P++z0k6zN7IndGSuoFAkNJEX0Q=;
	b=iodckReMGu4tVEMMo4CwOZsWaGNBcjsJ/GYkAmBba9Hn1QgTgcp7JHibuTqpg40KE0Op
	 NtdXLRjparYpbU2eowx7K36DGzcbx2Ck8SWmBQi1Mdus1l8IeleJ4SPCjI5a4p+4l7FtF
	 OLlLDFdJTfjoWblbxyEElB+5Zg6EGxAL1EZllhk3N1Aqc2cilcc+MzzThzZmg9DDB+nVt
	 0rGWmwtYGyDpEjpkUz70zcOgBsYaJuyx6E2RXA+Gmqu7VXZ5PEgThPzZthcXymDHOe0n0
	 T0/Jl1LXKMgrVR88+1EziR9z1RXnkfJC2eVF2lEgxf5UyytzNcSt8wUFpaPat4T7bPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZR7nzPWn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2409606A333
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZR7nzPWn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4326C1F000C5;
	Thu, 12 Nov 2026 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504021;
	bh=VWWjwPtx4nEiCoxZ5P++z0k6zN7IndGSuoFAkNJEX0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZR7nzPWn8lfNbY+TbDVt9/xVRi5HUR9gKRh3sPa4myiOJpaWHYN5C24NKsOjVwT+Y
	 hFOsXrJ+0BkRzFGu3+egDoeiQW+god3AoLnThKeBygN/QRsGN+nwLQz0UemfWpsrG/
	 Qdr37KYC9jQTiOq84tVF4m6kWakEputjXfyw58QmW/dJKgBIuv74frNfePTJDAd7L9
	 TVGJlAbwAZtzvt5o5xMsnIytKL6xEbpre5bp20/meVyWcoJUR5Vj46x2GqEcs3eywJ
	 DUVWmNWrMqZorywjlRSyQadmyNeAemyfnC6G7+GXXMq+fM/FNYvPrXWbrfvDOCRQjU
	 +4mBGeIg9eo0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A357380AA78;
	Thu, 12 Nov 2026 17:20:21 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v10 00/11] Add support for HDT and EKS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179450401977.546493.15267669702851311269.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 17:20:19 +0000
References: <20261111200705.3802779-1-luiz.dentz@gmail.com>
In-Reply-To: <20261111200705.3802779-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:06:53 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for the LE High Data Throughput (HDT) PHY and the
> Encryption Key Schedule (EKS) introduced in Bluetooth Core 7.0:
> definitions, btmon HCI and LL decoding, btdev/bthost emulation, GATT
> MIC length permissions, main.conf options, tests in l2cap-tester,
> iso-tester and mgmt-tester, and l2test options.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v10,01/11] monitor: Use __packed in bt.h and its users
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d32a2145a267
  - [BlueZ,v10,02/11] lib: Add HDT definitions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a92c05ae8e5b
  - [BlueZ,v10,03/11] doc/iso-protocol: Document BT_ISO_QOS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5f9c7e98842a
  - [BlueZ,v10,04/11] monitor: Add HCI decoding for HDT
    (no matching commit)
  - [BlueZ,v10,05/11] monitor: Add LL decoding for HDT
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=444ba153b4e4
  - [BlueZ,v10,06/11] emulator: Add HDT support to btdev
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a7f03764fa5f
  - [BlueZ,v10,07/11] emulator: Add HDT support to bthost
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a7d89aa0ef58
  - [BlueZ,v10,08/11] shared/gatt: Add MIC length permission checks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=962ea78ef6ab
  - [BlueZ,v10,09/11] main.conf: Add HDT configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=26f84a524adb
  - [BlueZ,v10,10/11] l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a44cdc6c278c
  - [BlueZ,v10,11/11] l2test: Add HDT options
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


