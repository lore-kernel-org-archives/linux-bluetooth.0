Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982FD37CD33
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689885; cv=none; b=SXO3K0lblqldgG17EcDb0EitngbWcsE4Njm7a8/bfZVsRLQmByuJcJI5tEpYS2ESGOiXgnxBigl1i3EKCiJQ0OtcN/M328ioxDhgs8tryvy5LeZZdFJ81jr5nQpP6NFk5bTyFyLbCYBT/dBjhOQ/HYe7WboRZoiYnD8h7nBU//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689885; c=relaxed/simple;
	bh=YI7CQSLbPTYKFZrtcSbuSf30TRuTPa2utFJLT+eACFQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VBW4xG/H5A1/APUTc3iA0TXhTxgQ0WcTUTm8C6VeUuVViflKcJFQzdJz/gKvt7W5x+Ey8zAkHhCC09pmR28Yq2vWc1h4R8RdnwgeoOGlrLgCutyjSObsNNvBQTJAaQEVzY0+RnUWY/iWLZFPJ1819Rw4nvvj+zHdAXZNrWEyvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=MSRHDVF1; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="MSRHDVF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790689881;
	bh=AZ/gG3dNaEyvKmo33qR9COqvs68vBeXxMVssrFVqzjU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MSRHDVF17Kbe3poRTDgOVs4Lra1WKYK/qXTpk2RvnIh9/le7LY2BbNF04Gae3cB5C
	 mm9CmWg+XUp9IqidJsz8fJ53LXYrQESCMlYzoMAyWryv4u7sFr/PeMdUwpsCbToFp5
	 A5yPW6TZno5QAePRvvH0TAmpNuhj0daHo1IrMmE7AAVLpT75UBooVImosTZgMfT1fl
	 iTrqzLDVqhq4ejVdSCcKz8qJNz7A7ou5mb4zsOg6xHiM3+38qB53AKVS1oM01AZVyL
	 vpuTpeZUQVTvGQStCVoqncVQCHaGr9AhXsf5nPDu/gpT4hydCwwXALEdHCUKlNItfa
	 pfvAnJLy+oNBg==
Received: from github.com (hubbernetes-node-4959980.ash1-iad.github.net [10.56.178.20])
	by smtp.github.com (Postfix) with ESMTPA id 986BE8411A1
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:51:21 -0700 (PDT)
Date: Tue, 29 Sep 2026 06:51:21 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1176102/000000-9f1247@github.com>
Subject: [bluez/bluez] 9f1247: avrcp: Poll GetPlayStatus when position changed
 ev...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1176102
  Home:   https://github.com/bluez/bluez
  Commit: 9f124774f2f6bec24d8640221ac0168c44a33a11
      https://github.com/bluez/bluez/commit/9f124774f2f6bec24d8640221ac01=
68c44a33a11
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Poll GetPlayStatus when position changed event unsupported

Some remote targets do not support the AVRCP_EVENT_PLAYBACK_POS_CHANGED
notification, meaning bluetoothd never learns about track position
updates for such devices.

When this event is not present in the capabilities reported by the
remote, fall back to polling AVRCP_GET_PLAY_STATUS once a second so
the media player position stays in sync. Polling is only kept running
while playback is actively progressing (playing) and is stopped
otherwise, and is torn down on session destruction.

Assisted-by: Copilot CLI:claude-sonnet-5



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
