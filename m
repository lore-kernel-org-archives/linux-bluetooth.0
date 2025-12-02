Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5C3054F2
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764664816; cv=none; b=sGfCquTWAg7R4q8a81BXaFE74M8hHaSMPIx6CGm10REMKQICSO0o4Ler4voTcWscVI7UZLpN0mzNTC51X7Z1hZuGQbrwPN/3ujMm5kk7va9UehVMIR1m5vZhMOU71Y0fDQhvkE7RZ928rsp1oeTZ9i/q3Ls4JRfAJuam5rWEWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764664816; c=relaxed/simple;
	bh=5DOMLs5m9IU4l0tQJo8D27YDqRllNYTeV81UHwnWLDQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nxY2KrlC75Ehp1eUljgYOGx+G6u3H3X5PnrpRF7DH3rXxEnCLPbdr+LeGUvuD8m5gKlebT3FWl1paZhBxkX/pNlHggvewDg9W6VcQvOoyN259F4lctKdxr7ihuf1u+I0Y4mekf0NLwu8wVNR1ZD80Em+nCpinzLLQocKFHkOigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txTTPFsb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txTTPFsb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BC54C4CEF1;
	Tue,  2 Dec 2025 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764664816;
	bh=5DOMLs5m9IU4l0tQJo8D27YDqRllNYTeV81UHwnWLDQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=txTTPFsbzZHBlXD98OLMR1JxexYLYoaxmxPTFS2KhsLP99qVDqahbmgF8mtot/qR/
	 wfS13iPgXl2mFfG5wKjZjt9+on8fSV5I2UNvoS+EQQaY7iFYdsaUl4n2aYksnL0Jww
	 gBf3h6JHNGnjYyBWzlgkvuz271DW0sDISl6C/TR44P5b9UmPAybFQNG0Wzv7L/gsvv
	 Am4be5TGR0lAzE8FYPVBnrjxgSminhWlvKn9Owq19cfNggzHAQSOC9atFPx6neQH6u
	 fuMhLVoxPeKRo9zEwkyDM9fyXM73hFlqQmjeD8qC40e+BW7NZI5M12bD16t4crIW8b
	 g/NQ2R2BwupKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F1D116F6;
	Tue,  2 Dec 2025 08:40:16 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Subject: [PATCH bluez v9 0/3] Add implementation of bearer
 connect/disconnect
Date: Tue, 02 Dec 2025 16:40:10 +0800
Message-Id: <20251202-bearer-impl-v9-0-21602a82ad7c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOqlLmkC/23PzW6DMAwH8Fepcl4mHOJ89LT3mHbIh9NGglLBh
 rZVvPsiLgsF32zr93fyYBONmSZ2Pj3YSHOe8nArjX05sXB1twvxHEvPRCMQSnFPbqSR5/7ecUy
 aWqtAS+dYEfeRUv5e096Z777ol32U8TVPn8P4s96YYV0exs3AgScJaBCkFGDeXN8Nlxxew9CvS
 bOodbvVoujQkhEYgtJ4oNtam61ui44uhmh8EzTGvZaVFk8vl0V7FCBtTNE6tddYa9xq5A0PBIH
 QRbDR7rWqtdpqVTTZNkUJCRp/cFvXWm+1Lto69I2Sylgr9tr8a9E8/dsUnayUXiWbynarl2X5A
 3/qdJZhAgAA
X-Change-ID: 20251111-bearer-impl-5f7e396174aa
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764664813; l=3166;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=5DOMLs5m9IU4l0tQJo8D27YDqRllNYTeV81UHwnWLDQ=;
 b=uT7Zcotg155wcBXPjHhG5Jf6vGNzlM0SQ1haBMdfWS0fuoBD2l1KNsTaQcbnV49JbEeoKc929
 kflGJrz6vufAc6PGnCRAM3CWK2k0pW8KLjygfE5GSLIdjUJR7aSe6wr
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: Ye He <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

Signed-off-by: Ye He <ye.he@amlogic.com>
---
Changes in v9:
- Send D-Bus reply when bearer.connect() fails. 
- Link to v8: https://patch.msgid.link/20251201-bearer-impl-v8-0-f944b6f9f201@amlogic.com

Changes in v8:
- Add le & bredr as sub-menus.
- Link to v7: https://patch.msgid.link/20251127-bearer-impl-v7-0-9a5b06468992@amlogic.com

Changes in v7:
- Specify the bearer type explicitly in the shell command, instead of passing
- it as a parameter.
- Link to v6: https://patch.msgid.link/20251126-bearer-impl-v6-0-e93fd41f10b6@amlogic.com

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

 client/bluetoothctl-bredr.rst    |  70 +++++++++
 client/bluetoothctl-le.rst       |  71 +++++++++
 client/bluetoothctl.rst          |  10 ++
 client/main.c                    | 324 +++++++++++++++++++++++++++++++++++++++
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
 src/bearer.c                     | 178 ++++++++++++++++++++-
 src/bearer.h                     |   2 +-
 src/device.c                     | 153 +++++++++++++++---
 src/device.h                     |  17 ++
 src/profile.h                    |  10 ++
 28 files changed, 836 insertions(+), 28 deletions(-)
---
base-commit: 5e41d1e1d361e7288964e4c2c5ed90736025662f
change-id: 20251111-bearer-impl-5f7e396174aa

Best regards,
-- 
Ye He <ye.he@amlogic.com>


