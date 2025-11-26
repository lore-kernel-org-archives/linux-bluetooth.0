Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988530EF81
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 05:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764134471; cv=none; b=D8QaJ6KsRq/3G03bG1kIRnd7iNGAFfjsdi7X30PKTe5xkpM2irG7uWbgV3ckhfFQVwthcXuiFe74n4GE/i/XK+ULMZJWwwemMf5vQNJJ2xnQ1QJeUwj8cyQYJa0igre8SJlDRfUGn2EK787/6p6tFEmVQkF4lMm9NgAtlCWhiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764134471; c=relaxed/simple;
	bh=KTxAVHGT5WMy8TosYlEBTzZWCKvULMHuyrRa8WO6Zco=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kqnz5jO3ZhAOVYfhJrVCHgBztIt6X9Xpjsl4itN5vk4F2kYvjDAaC0duxEek9Gx6C3YrQsn9T/lLABc53tYmkg7xERE/v2fivt+A2ncNfZaAc2kd6O/3ic6w4vsQBImEb+9f5t+/dGLLoFtjx6GC7DFoQHLEtZjRIGfvWQj0o0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aED8ca+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aED8ca+1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35646C113D0;
	Wed, 26 Nov 2025 05:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764134471;
	bh=KTxAVHGT5WMy8TosYlEBTzZWCKvULMHuyrRa8WO6Zco=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aED8ca+1qrPyKJ2RURxkyBi5e+O/suBW0ng19MRY3EKwt8/YUvbEYXEo2e0KcwIxa
	 R96kOyG9okyRFZxikGq60ZKPwox4d39swkuxeotK7/bx8/ZUgpmxLuzZPJvuaavVqq
	 9pLsr96UYvR7WXWXmJmAzpi5iXds6H9kJbY9AZewLGEa3S5tZBMnPPSjSU6vQxmM+f
	 1RDOQvJRshZv5Nhzy/Nx2r926htZeXbWKsGPVLU8M6QEL6ni6DTmZra4ZS0fYM9932
	 Bli2TV0b+pSkM/sNV54ZusbiRm1vG92NASCRmxcH066ye1vkYmj6guiWOqCCzYkidU
	 zkOFkxGTsuuWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214F7D0EE29;
	Wed, 26 Nov 2025 05:21:11 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Subject: [PATCH bluez v6 0/3] Add implementation of bearer
 connect/disconnect
Date: Wed, 26 Nov 2025 13:21:07 +0800
Message-Id: <20251126-bearer-impl-v6-0-e93fd41f10b6@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOOJmkC/23OwW6DMAwG4Fepcl4mnMSQ9LT3qHYItmkjQanCi
 rZVvPsiTrDWN9v6fvuhJslJJnU8PFSWOU1pvJamfjsousTrWXTi0itTGYRSupWYJes03HqNXSM
 21NC4GFURtyxd+l7TTqrt7/KrPsv4kqavMf+sN2ZYly/jZtCgOwfoEZwz4D/i0I/nRO80DmvSb
 Lba7rUpmqx4g0R1gy+03Wq/17Zojkzs24oa5GftNtr8+9wV3aIBF7jjEOtnjVuNe4260iRAgpE
 hcNjrZVn+AGPPMXinAQAA
X-Change-ID: 20251111-bearer-impl-5f7e396174aa
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764134468; l=2543;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=KTxAVHGT5WMy8TosYlEBTzZWCKvULMHuyrRa8WO6Zco=;
 b=k9QxY4J3ySQqd7rk691xHq0hajpt4MafjxcuHNMhRhAQcfHKYVtmHQhZTA84+nvIxoLyP92+O
 Aq3ubALuNQbBgkq6nur/bIwk0M/lwJeRZ2oKDi/2bKrho87hm5uieTb
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: Ye He <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

Signed-off-by: Ye He <ye.he@amlogic.com>
---
Changes in v6:
- Fix coding style warnings.
- Link to v5: https://patch.msgid.link/20251125-bearer-impl-v5-0-ce1ce5ad19d9@amlogic.com

Changes in v5:
- Split adding bearer field to btd_profile into a standalone patch.
- Link to v4: https://patch.msgid.link/20251121-bearer-impl-v4-1-b52149dfd9a6@amlogic.com

Changes in v4:
- Add a bearer field to btd_profile to indicate which bearer type the profile
- belongs to, thus we can distinct the services per bearer.
- Link to v3: https://patch.msgid.link/20251118-bearer-impl-v3-1-dadcd8b0c75d@amlogic.com

Changes in v3:
- Move the modification logic from the device to bearer, and add
- some helper functions to the device.
- Link to v2: https://patch.msgid.link/20251113-bearer-impl-v2-1-c3e825cc6758@amlogic.com

Changes in v2:
- Fix build error & warning.
- Link to v1: https://patch.msgid.link/20251111-bearer-impl-v1-1-f41585144218@amlogic.com

---
Ye He (3):
      profiles: Add bearer field to btd_profile
      bearer: Implement Connect/Disconnect methods
      client: Add shell cmd for bearer connect/disconnect

 client/bluetoothctl.rst          |  34 ++++++++
 client/main.c                    | 141 +++++++++++++++++++++++++++++++++
 profiles/audio/a2dp.c            |   5 +-
 profiles/audio/asha.c            |   1 +
 profiles/audio/avrcp.c           |   2 +
 profiles/audio/bap.c             |   2 +
 profiles/audio/bass.c            |   1 +
 profiles/audio/ccp.c             |   1 +
 profiles/audio/csip.c            |   2 +
 profiles/audio/mcp.c             |   1 +
 profiles/audio/micp.c            |   1 +
 profiles/audio/vcp.c             |   1 +
 profiles/battery/battery.c       |   1 +
 profiles/deviceinfo/deviceinfo.c |   1 +
 profiles/gap/gas.c               |   1 +
 profiles/health/hdp_manager.c    |   2 +
 profiles/input/hog.c             |   1 +
 profiles/input/manager.c         |   1 +
 profiles/midi/midi.c             |   1 +
 profiles/network/manager.c       |   3 +
 profiles/scanparam/scan.c        |   1 +
 src/bearer.c                     | 167 ++++++++++++++++++++++++++++++++++++++-
 src/device.c                     | 129 +++++++++++++++++++++++++-----
 src/device.h                     |  17 ++++
 src/profile.h                    |  10 +++
 25 files changed, 503 insertions(+), 24 deletions(-)
---
base-commit: 5e41d1e1d361e7288964e4c2c5ed90736025662f
change-id: 20251111-bearer-impl-5f7e396174aa

Best regards,
-- 
Ye He <ye.he@amlogic.com>


