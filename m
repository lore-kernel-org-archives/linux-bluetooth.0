Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E333DECB
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715683; cv=none; b=pNfwYM+i6KqcCz2GosQ1VIpgob70jGuZc+yFUZQ2Or1wVhI9OinG5MYn+EogdNVoo+mfcmALOMWH0H/T5XjHFNuGkUGFECKl1jhOM87AFb3vn9nIRePoOVPGZYGwRJcr2PlOoqGRMSpvKomLmK0U7gH0FNEfbJHHKNnfh3V1wjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715683; c=relaxed/simple;
	bh=VoL3jhwGY5041C2FgslhIPv5xUb5T7yOFx1DsjjYj/c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YCFfqwiguFyloax2C+Efup7WhmP35zELf0qqqY5DWHjKZNQC65DM1dcMsbtil97ZjKBvG5h1gVIfXuXlIfBSbQwkhEwSBIStpRwKfC8KJniDpZIbyEF0z02dZ20YGXX7WM7nUpzai8KruNJX8QMNiINtYLDU501lvbOdVUI0LhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Eq196229; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Eq196229"
Received: from github.com (hubbernetes-node-b6f7ce6.ac4-iad.github.net [10.52.211.83])
	by smtp.github.com (Postfix) with ESMTPA id 56F744011AF
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 01:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763715681;
	bh=yae64t4AAi8ZAgx1EuOb1/xk6//IeQiEGSvg/MgCHoc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Eq196229Z7OyKtFDFv/Z3Vx1DFfbug+Ycch/Sh6kC7jKpT1+Fdd8UlZ3bMkf2xutJ
	 TMmYXxq5ePe1O7jRYyc+V2tObF6XoXpq/qvn+4eGp1o2zkUbJfF6EHQKU7aMDLrf+N
	 aBDKAmapd3rnyLRsyclRkMY3QPuBRg0E4HJB4x8Y=
Date: Fri, 21 Nov 2025 01:01:21 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026215/000000-347570@github.com>
Subject: [bluez/bluez] 347570: bearer: Implement Connect/Disconnect methods
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

  Branch: refs/heads/1026215
  Home:   https://github.com/bluez/bluez
  Commit: 34757009488458b20e44f7ae8b3515a770cc91d7
      https://github.com/bluez/bluez/commit/34757009488458b20e44f7ae8b3515a770cc91d7
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-21 (Fri, 21 Nov 2025)

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
    M profiles/health/hdp_manager.c
    M profiles/input/hog.c
    M profiles/input/manager.c
    M profiles/midi/midi.c
    M profiles/network/manager.c
    M profiles/scanparam/scan.c
    M src/bearer.c
    M src/device.c
    M src/device.h
    M src/profile.h

  Log Message:
  -----------
  bearer: Implement Connect/Disconnect methods

This patch provides implementations for the Connect and Disconnect
methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
interfaces.

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
