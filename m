Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F72AD2C
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794166; cv=none; b=fJPmSPHIM02H+iyBwyDBpO8co/gn09xyUyBrMNu+rwp1mxc/bNGSS50bQZsskLV6qmAUx4lRfj+w2uM2zbf7wnNFiBb/EAc04CALSj6r2mrYhVYyQ0rIJ84wKaGPeZSi3T/nzBnvm8on5XQEpJV//uwPiC58ziM3KTlQRUDk6F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794166; c=relaxed/simple;
	bh=t5KmKYpm6R3/TNAvGykxUmqjcMXcGwVm0n1U7XZQd8U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uoPH3sTxTCcsdEcMuXlhwvgKZV04DbPezS+vEPm4X7eCmwmoSSLRd22mHqxdVvY5vru27Ld2i+a/2LfD+ueyzIYold4BjboNq0lo58LShGutAX9i56NaaMqO4Q+SeYSDShAod/L0jy0/Aj9ylTh6Rw/yauRS+JUaNfi5Wv1LJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Sg4PxEHe; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Sg4PxEHe"
Received: from github.com (hubbernetes-node-c2d1116.ash1-iad.github.net [10.56.14.93])
	by smtp.github.com (Postfix) with ESMTPA id EE8196010D3
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 12:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764794162;
	bh=dRSO8P43G6/yqqvkN/w0MMr4dHe6mAs2WplhaAFwq18=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Sg4PxEHeb0IOsSnczjbcPMq7qiddp9V9M0VNnDbexWfK6wmSJ0K4sDqdaMHM81lT3
	 3XlQURBy2FGLXXRg0b/tO+S1ij39KW8wmHjKJVce/PHsU1SE5tTjA6p1X9neF4CZ8Z
	 qLKTKPlJuKJ+IBXzOod/75UY1uQOP7WQwbIizDRQ=
Date: Wed, 03 Dec 2025 12:36:01 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9a97ad-143037@github.com>
Subject: [bluez/bluez] 930df1: profiles: Add bearer field to btd_profile
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 930df108f30115f60807e79a6e7ce6618646cc38
      https://github.com/bluez/bluez/commit/930df108f30115f60807e79a6e7ce6618646cc38
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-12-03 (Wed, 03 Dec 2025)

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


  Commit: 4e21ebcaa5d0d34f937052f153a73c8fba2ccd27
      https://github.com/bluez/bluez/commit/4e21ebcaa5d0d34f937052f153a73c8fba2ccd27
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-12-03 (Wed, 03 Dec 2025)

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


  Commit: 143037cfe607689103ab75c76dd34326787e7110
      https://github.com/bluez/bluez/commit/143037cfe607689103ab75c76dd34326787e7110
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-12-03 (Wed, 03 Dec 2025)

  Changed paths:
    A client/bluetoothctl-bredr.rst
    A client/bluetoothctl-le.rst
    M client/bluetoothctl.rst
    M client/main.c

  Log Message:
  -----------
  client: Add shell cmd for bearer connect/disconnect

This patch adds shell command for bearer connect/disconnect.


Compare: https://github.com/bluez/bluez/compare/9a97ad574642...143037cfe607

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
