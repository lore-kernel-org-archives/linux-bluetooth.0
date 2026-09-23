Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539F4349AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157702; cv=none; b=a5NCxtzHU9emq9UcLNXtC4kun4WLqy0QCwRaURz6BbILBZ212f70x8AZJcYAQMJM9fYvrJofzCYffLoWvDSu95wnXuuvgWA/G3Y7tL96fYo9L9TYt9bOroVADlvdobp4HYngkz4bCSIhidXAcxKU/0n+a4gL7BKZGl8ynAdd1X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157702; c=relaxed/simple;
	bh=G7Ryijx34U2SIMc6pLQC8OASoeBWCilQrSG9oaC6LPQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WUn2SjCOVs8fxO6JxpZRsH/n3m1ZR5pzE+OW5AjBo1npr84/YS9hLLtBjmbOOmbDROZBrRAS/adxr/yxJGrYaZ0oaJpK5B6JsS5kHZUrepJE/HmaHHfq+yl9dFVX1KXjF9F+C83+zvFHX7/OJJq2G5KtnHDtdPyvcRpXGyzqJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CCPX33KO; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CCPX33KO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790157699;
	bh=SLK6A7GZenotVBnxS2ZP+cEW3cW0Ey8TM+Rwcp1ieeo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CCPX33KOSd/OIHUFBzottd/2446xh1+EuRSGza71DR0MlUCaLJovInBWzOH35n4ml
	 FKFFX/ju+mlsNbSi8hP2ahRKv/gjsJ1+lEJOePVpUjgTP6LBfLmFMlrFL8ic4faGrS
	 r7nyzkUEoed5cwYixNRh+C3ciCq7zHciSSIIa2S8=
Received: from github.com (hubbernetes-node-a3ed61b.ash1-iad.github.net [10.56.203.108])
	by smtp.github.com (Postfix) with ESMTPA id AD1F8360712
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 03:01:39 -0700 (PDT)
Date: Wed, 23 Sep 2026 03:01:39 -0700
From: Pavel Bozhko <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1172081/000000-c0db83@github.com>
Subject: [bluez/bluez] c0db83: audio/avrcp: Add AvrcpVersion config option
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

  Branch: refs/heads/1172081
  Home:   https://github.com/bluez/bluez
  Commit: c0db8395102247c7d3a2550da9b53dfbaf19f0e1
      https://github.com/bluez/bluez/commit/c0db8395102247c7d3a2550da9b53dfbaf19f0e1
  Author: Pavel Bozhko <pvbozhko@salutedevices.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    M profiles/audio/avrcp.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  audio/avrcp: Add AvrcpVersion config option

Some devices advertise AVRCP 1.3 in SDP but still support absolute
volume (SetAbsoluteVolume and EVENT_VOLUME_CHANGED), which the
specification introduced in version 1.4.  Examples include certain
TVs such as LG webOS UM7450PLA and Xiaomi Mi TV 4A 43 when acting
as the audio source.

Add an AvrcpVersion option under [AVRCP] and apply it to the target
in target_init(), so the version check in avrcp_volume_supported()
can succeed for such peers.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
