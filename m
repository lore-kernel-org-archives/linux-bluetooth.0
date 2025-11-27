Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF76311969
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764237271; cv=none; b=ZXElKgMrosuYh3xbegkL23MzJnF/lfgvUhsQMnodpRQEWmYIc9bRGSOCjeGnjYIaJ/+ZaJ7EmyrQJ8S2vhCPJ6t96JLuVjgjjDmAhlUwbNNOggB0QxDeZkIf/RdsIh0Vp0nP5RRI/WPpD4mYNPmgXJ/NPsh1b/QDRPy29pSpZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764237271; c=relaxed/simple;
	bh=ZMD94GQEyv3mTsdXIjTzJjdi1u3L5yfS5qx/81nIeRg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZgSHbQiYswUsNrbRF2091p5CVo7Qp4qrEoeNV/Ao+UIUY7rnm7GGWA2udjxMIZithS6DdKs5eAsHYsvkFmitVPYA9y533tCJk9aa7hJp02dgzS9rsE+j4o7IH5838mhWSo//rJY49t97NuH3MaKnPopn5jHJdLybYFokxgG5QuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFUncxji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFUncxji"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ACB3C4CEF8;
	Thu, 27 Nov 2025 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764237270;
	bh=ZMD94GQEyv3mTsdXIjTzJjdi1u3L5yfS5qx/81nIeRg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IFUncxjiziErMt7okNIWIczn/zs9e0UVO+0Tw8WvmGv9c5F4KT13cj6JzDJBpBOpm
	 hlIlpFxIDv8mbPEI1DKyWZ6qee1kL0NaiL0wppzQOC4IsCwgmyA/xFzEQCaeiZ+ijc
	 IBJGkyyLkP9lYlPxCm6udU1u8oFyVtfbXe5J81R7UTexYuHKD7ZoXiIWTbtWuZpBOV
	 8QUybwZjs9iBH2YCLfITSRInNcdl6PoY71Xr3I+gBLZfjW9LksXfilofjFUvXLpLl8
	 cEVcvRbFpE2yFc5Zk6Wcuwkoawh12cNsNMACF7IZ9tddGExFqOggVKpbRV8xr6tKAR
	 9IlpGFnNoPvCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE70D11183;
	Thu, 27 Nov 2025 09:54:30 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Subject: [PATCH bluez v7 0/3] Add implementation of bearer
 connect/disconnect
Date: Thu, 27 Nov 2025 17:54:20 +0800
Message-Id: <20251127-bearer-impl-v7-0-9a5b06468992@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMwfKGkC/23OzW7DIAwH8FepOI8pBgxhp73HtAMfpkVKmops0
 bYq7z6UE2nqm239/vadzVQyzeztdGeFljzn6Vob83Ji4eKuZ+I51p6JTiDU4p5cocLzeBs4JkP
 SajDKOVbFrVDKP1vaB/PDN/2xzzq+5PlrKr/bjQW25dO4BTjwpAB7BKUE9O9uHKZzDq9hGrekR
 bRa7rWoOkjqBYagDT7RstX9Xsuqo4sh9r4LBuNRq0aLh89V1R4FKBtTtE4fNbYa9xp5xwNBIHQ
 RbLRHrVut91pXTVamqCBB5x9ur+v6D1jj2E/lAQAA
X-Change-ID: 20251111-bearer-impl-5f7e396174aa
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764237268; l=2759;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=ZMD94GQEyv3mTsdXIjTzJjdi1u3L5yfS5qx/81nIeRg=;
 b=fpRTNw1Bh5qzBU+luK5wygSf25BlJB8VqAON/Ok327AC+/XONB4y79usB2vKaYo0ickuIntCT
 EhQakxDESUrCFBIOlT79jaOLtFTbFneuuljngdK7RlzZuEebbby/vnj
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: Ye He <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

Signed-off-by: Ye He <ye.he@amlogic.com>
---
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

 client/bluetoothctl.rst          |  49 ++++++++++++
 client/main.c                    | 152 +++++++++++++++++++++++++++++++++++
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
 25 files changed, 529 insertions(+), 24 deletions(-)
---
base-commit: 5e41d1e1d361e7288964e4c2c5ed90736025662f
change-id: 20251111-bearer-impl-5f7e396174aa

Best regards,
-- 
Ye He <ye.he@amlogic.com>


