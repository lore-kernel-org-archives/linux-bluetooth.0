Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9513AA2D
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055154; cv=none; b=EfBzWYoSswl6LQqYVbdDObghIBwjdbJpad5fyO/cyzYzcg20ES/dg+NiuvUu0MmS47DnfTs5iz8vlrCGj2fGj7OKVtX5hv/5wEy34vpXq40dk9gygqmBsqPqH0QDozsGxVfMZCH/ILd8jJNWgb5J23dNBgevXk8RJXAG56e08vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055154; c=relaxed/simple;
	bh=Xx9WR607aCMDhcxEdQJhAozjn6EDGcsVVXriKq6WceA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=b616VWErGR/gRqp5y2SMHRpOVDiScBBnZNWTk111q89S3upDO156pjjTlLeswqwLDyzUSumBIVCfmJvX0HuPV2acK/gL0zLqo46c/e0+WcdUvLxehCkz9KLwAYTrzv/W2u8HrTl158KV5F046glWPcBhv4KppP1iv0KdNmCzi8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E27yLV5I; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E27yLV5I"
Received: from github.com (hubbernetes-node-a8406d9.ac4-iad.github.net [10.52.210.59])
	by smtp.github.com (Postfix) with ESMTPA id 7357220954
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Nov 2025 23:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764055152;
	bh=6VTOK4GocIM76Ae4t3q4A6bFspcOPSgqGuBBR9KHQMI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E27yLV5IZ92o7s+GQGNjxo7dYoORPxfvM9gLzzxHucZ9YcxrqD8E9wCovoN6j38Tr
	 0SoNuibb0XJFMAFgE98wPZfTP0uqxCvRwKkpbJ+chqhxrOUtyOqbg/IQ3K99PbF3Gm
	 6XtepIUT/IWGsKvJU+ogah2tGaY9G4y3UeRYs4GQ=
Date: Mon, 24 Nov 2025 23:19:12 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1027210/000000-71160c@github.com>
Subject: [bluez/bluez] 29dcff: profiles: Add bearer field to btd_profile
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1027210
  Home:   https://github.com/bluez/bluez
  Commit: 29dcfff9551bd248fb6b59c7a2c2e810b5763924
      https://github.com/bluez/bluez/commit/29dcfff9551bd248fb6b59c7a2c2e810b5763924
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-25 (Tue, 25 Nov 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/asha.c
    M profiles/audio/avrcp.c
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M profiles/audio/ccp.c
    M profiles/audio/csip.c
    M profiles/audio/mcp.c
    M profiles/audio/micp.c
    M profiles/audio/vcp.c
    M profiles/battery/battery.c
    M profiles/deviceinfo/deviceinfo.c
    M profiles/gap/gas.c
    M profiles/health/hdp_manager.c
    M profiles/input/hog.c
    M profiles/input/manager.c
    M profiles/midi/midi.c
    M profiles/network/manager.c
    M profiles/scanparam/scan.c
    M src/profile.h

  Log Message:
  -----------
  profiles: Add bearer field to btd_profile

Add bearer filed into btd_profile to indicates which bearer
type this profile belongs to. Thus we can distinct the services
per bearer.

Signed-off-by: Ye He <ye.he@amlogic.com>


  Commit: c3e8a526367a4f3d06b94d224d5d0a0de11ba1b2
      https://github.com/bluez/bluez/commit/c3e8a526367a4f3d06b94d224d5d0a0de11ba1b2
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-25 (Tue, 25 Nov 2025)

  Changed paths:
    M src/bearer.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  bearer: Implement Connect/Disconnect methods

This patch provides implementations for the Connect and Disconnect
methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
interfaces.

Signed-off-by: Ye He <ye.he@amlogic.com>


  Commit: 71160c46b41e31b3b4e1c1a0f6d4e539fd8b83e2
      https://github.com/bluez/bluez/commit/71160c46b41e31b3b4e1c1a0f6d4e539fd8b83e2
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-25 (Tue, 25 Nov 2025)

  Changed paths:
    M client/bluetoothctl.rst
    M client/main.c

  Log Message:
  -----------
  client: Add shell cmd for bearer connect/disconnect

This patch adds shell command for bearer connect/disconnect.

Signed-off-by: Ye He <ye.he@amlogic.com>


Compare: https://github.com/bluez/bluez/compare/29dcfff9551b%5E...71160c46b41e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
