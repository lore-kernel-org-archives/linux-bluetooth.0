Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26271EF36C
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Nov 2025 03:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763953384; cv=none; b=vD2iJPoZDIA3yd8e9TBln9huVkO3eETghA6Pdqb6TD1+2Xjv1maDyvXaeV1S3X/14OlT8MmtEFzRsfmR6kTX5gcx+h7pfUNCahXXEKq5MfC3j72ufEz+qwVC+CYAa7ldOU07PxxGKp4fuiVfufpm3WDV4dxrjYlDVy7MbOd35DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763953384; c=relaxed/simple;
	bh=CKleJVHFfhI6aU/GfuLM3SufXzEF2NgJdEYadHpzvZY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HxWPF+Yzi2pfI9sMSKvAAAQ+UD36XWihJDOhg0s9Ua+BIqRKMyatdjKwy9+b8IVw0ELR3dGHNvtJn7tJR7zVVRV3OB5f5/zy4EqUXNup8jzvC1jWMKsP8YTP+fv2xcUxY8yiiIrjgEWy/y+Np+6deaOqsx6vwthkWpUEzeqftMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=N7IHKkMR; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="N7IHKkMR"
Received: from github.com (hubbernetes-node-50b24c1.ash1-iad.github.net [10.56.186.33])
	by smtp.github.com (Postfix) with ESMTPA id E62289210B0
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 19:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763953381;
	bh=z9argk4WgCgRZKVT8Vans+oE6VhxFkg60cCOl6zlhKE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N7IHKkMROXA69OyTK0Dt6ZjLAAIgo+XjL+MQiOpwBt+5xnj6HwSAbzXx1Me/vlzHb
	 92+R+ykJiWKv7NfmghNjxhz2TdQfjUZR/XFkrGuJ7MKH08/3gaGTgJ0H5M984SqLfB
	 Q8Y/vmsNHPlYgc5ZQpaebVw//4tmfxLbbO3mK6rE=
Date: Sun, 23 Nov 2025 19:03:01 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026777/000000-402371@github.com>
Subject: [bluez/bluez] 402371: profiles: Add bearer field to btd_profile
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

  Branch: refs/heads/1026777
  Home:   https://github.com/bluez/bluez
  Commit: 402371fb8c3e81bc117db9bcb0758a8446e04900
      https://github.com/bluez/bluez/commit/402371fb8c3e81bc117db9bcb0758a8446e04900
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-24 (Mon, 24 Nov 2025)

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



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
