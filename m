Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51636D510
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764665300; cv=none; b=bzrZpv8H4czVgVZsTXt36OIpClyBxVjQ3FK2u6N26WBXx+GS52ufEp9QsL2n3Vg6WL2jdcNC8qUHrDaXtcny2FBZ2y2qHNLjodpjFvtR2ft7GK888Qk3SM38NYvN9OkV/PXkiZCTZ5zdoMYoSO8XniZx92Q/arDFzTpbNrU6oP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764665300; c=relaxed/simple;
	bh=aGki3mOBGsrmupFMSwoia2BMpsqKUmXoOQzn7FOinV8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aFWH2dKFrBHZ1zJ7jSbKJ8a+Nuz18kavBclHC4injye7dwYKVbw/zYbQNSoSVmHBdVn9ILnhBcYqMAuXTGYuef/zsDC56baq5CrUtmUsIpd8jxYQqM/qfh2xZDVFVbzp5FFr4VqB+Kx1CifKFG5bs6MwDjyFmDQcGkSBr0QIu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MhG/dyUX; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MhG/dyUX"
Received: from github.com (hubbernetes-node-8e41b32.ash1-iad.github.net [10.56.194.54])
	by smtp.github.com (Postfix) with ESMTPA id ADFE71411AF
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 00:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764665298;
	bh=TcWL70PtpvG/SWl2nuqa1mcKCl2vuCAw9pWQ3OKrpss=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MhG/dyUXbySCAW5phZSwSzUSGEa9DePZIjSgl+XEZ1+BFZu8+Gez9pDgJDoAei9R0
	 BIZirxGGjuieRo0Q3uR+C4QAfci6VDgFGcrUzXGJck6jrIXbVT4XWN43YimLLiBYmA
	 FzhiX24t/5tRytqugF0dxBoejn6qDiB/Eoilm4AM=
Date: Tue, 02 Dec 2025 00:48:18 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1029637/000000-7cb5bc@github.com>
Subject: [bluez/bluez] de2783: profiles: Add bearer field to btd_profile
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

  Branch: refs/heads/1029637
  Home:   https://github.com/bluez/bluez
  Commit: de2783ea97d16cb25317447fa525a4ae2fd04ae9
      https://github.com/bluez/bluez/commit/de2783ea97d16cb25317447fa525a4ae2fd04ae9
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-12-02 (Tue, 02 Dec 2025)

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


  Commit: 56b338c451d0c92cc3210db766c1dec48e061222
      https://github.com/bluez/bluez/commit/56b338c451d0c92cc3210db766c1dec48e061222
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-12-02 (Tue, 02 Dec 2025)

  Changed paths:
    M src/bearer.c
    M src/bearer.h
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  bearer: Implement Connect/Disconnect methods

This patch provides implementations for the Connect and Disconnect
methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
interfaces.

Signed-off-by: Ye He <ye.he@amlogic.com>


  Commit: 7cb5bc03163bceaff7e55009b9523d9e50e3246f
      https://github.com/bluez/bluez/commit/7cb5bc03163bceaff7e55009b9523d9e50e3246f
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-12-02 (Tue, 02 Dec 2025)

  Changed paths:
    A client/bluetoothctl-bredr.rst
    A client/bluetoothctl-le.rst
    M client/bluetoothctl.rst
    M client/main.c

  Log Message:
  -----------
  client: Add shell cmd for bearer connect/disconnect

This patch adds shell command for bearer connect/disconnect.

Signed-off-by: Ye He <ye.he@amlogic.com>


Compare: https://github.com/bluez/bluez/compare/de2783ea97d1%5E...7cb5bc03163b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
