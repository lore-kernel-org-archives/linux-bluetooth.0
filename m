Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B722AE7A
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764238468; cv=none; b=urYR8HrIEzd4LNFuB91F483361cbLJUPmAuYanzXGl8xDNmCnTFTkP2w2ElWRiZXvRgPsx9DQP/bKfVWnxfdv5dVNi35FG1Uy6Wl4aSRr1fPs/JJHd+bAvDQfROsiviHxiAudzdv0FgAwiQg49m85idUm8EhoIJDVLNq7x9hJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764238468; c=relaxed/simple;
	bh=8hUIZA4wLsg83z4CHIlJfLmeLoo+6eQwTxZU6Gzrskw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=N9IV3X/wr90Ig7hmOyCXzpJicX6nk0wHkgm5DzuJ3zigfHBwajdNm0InwPLy9NRCvNpU6r3Eq5ddyqxN423mgAaMxK6p54zrYgeZgldDtScl4vLrXbps0j/AYaBoZi993j6riw7jNz38pCt7us3Jm9O7m2uFZEHVvzMlVAqwdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lM8gqV7L; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lM8gqV7L"
Received: from github.com (hubbernetes-node-56060a6.ac4-iad.github.net [10.52.222.24])
	by smtp.github.com (Postfix) with ESMTPA id 099B320950
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 02:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764238466;
	bh=grV2oko2OlEjEIaPNSFW6sQwQvSx2iD+sCDQyAF1Jrs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lM8gqV7LFlnEcHfmmiaALyzO7/vth5UPEvme7bbDqqnJV6N4iit4GE0dCogb8xsXH
	 Mr7EdSliTPdF/b0c7hqXum16Tx6C6vcJQCuG08gtXY7q/EtkMc2d0E7Q4gxdCB4NTf
	 gFcyfoPlmpAETjmEohLFtBvwhSg/ZVAnnhuCU3YA=
Date: Thu, 27 Nov 2025 02:14:26 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1028205/000000-953f53@github.com>
Subject: [bluez/bluez] 4464cc: profiles: Add bearer field to btd_profile
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

  Branch: refs/heads/1028205
  Home:   https://github.com/bluez/bluez
  Commit: 4464cc80fd89e056b3d77443b6d9d229674c53db
      https://github.com/bluez/bluez/commit/4464cc80fd89e056b3d77443b6d9d229674c53db
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-27 (Thu, 27 Nov 2025)

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


  Commit: 39d7af05e58969829d43e053abaa3269d48ab46a
      https://github.com/bluez/bluez/commit/39d7af05e58969829d43e053abaa3269d48ab46a
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-27 (Thu, 27 Nov 2025)

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


  Commit: 953f533f93f61c094d49c98a4a05c07299adf6d7
      https://github.com/bluez/bluez/commit/953f533f93f61c094d49c98a4a05c07299adf6d7
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-27 (Thu, 27 Nov 2025)

  Changed paths:
    M client/bluetoothctl.rst
    M client/main.c

  Log Message:
  -----------
  client: Add shell cmd for bearer connect/disconnect

This patch adds shell command for bearer connect/disconnect.

Signed-off-by: Ye He <ye.he@amlogic.com>


Compare: https://github.com/bluez/bluez/compare/4464cc80fd89%5E...953f533f93f6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
