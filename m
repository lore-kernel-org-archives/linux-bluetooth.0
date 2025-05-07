Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BD1E3DDB
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650846; cv=none; b=idl6baWxfW7ariWjmMnIClC1/wL2X//dmzTuLNaYbpJBkgc0RxzMy17A0CU2OXsTu/2O69EjhCXSgkzg54C0cR/afmkDg9WjeFGDdNcaFM7hdPYgzrl/aWsls9V+5BTtvQ3L1uMv2kDjm0BxmW8xblJLSKBFxsd224pXM/pvUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650846; c=relaxed/simple;
	bh=wfK/qH+2mkfOoy8499ymzLTxNmXmi3tlWCdibyd4Kdk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mdRgQ77D99B9i68YIwqC8Lwboct+ghQQkyXd22/1y59yI1Kx0B35rttKcSX1fKlCeVjCZUg08Q0q6nBnI6BySXGJpy/GDHoWljJPXMTAPzi3iNZvzw9zuo+bIZxYXGufULnbYVRmUGtDyc9UfhQ5L2ttNavbsRXRwwDua/P6hzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WYaqPx+Y; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WYaqPx+Y"
Received: from github.com (hubbernetes-node-bc9b7c8.ac4-iad.github.net [10.52.132.39])
	by smtp.github.com (Postfix) with ESMTPA id 17EA270028E
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746650844;
	bh=RF2V2uP1TJdUeYukPdcytjIxmNDJSD3YMBw70E8bmu0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WYaqPx+YlqVWAovGI3nky5ct1YTBw6h3kf4dcGFCYZ58IIFxppCLFeYHMhTFBanAk
	 sYQEpk5wxB/7UfXy2rOx2TtndUVXOVkXbdydB67T1BLfypI5dCP5eJiBtWz+n4VxKf
	 s9JO1CKHTKmeyCliz68qgPQ80hkUIfTbDPSApIJI=
Date: Wed, 07 May 2025 13:47:24 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/960647/000000-786b11@github.com>
Subject: [bluez/bluez] 786b11: avdtp: Fix setting in_use flag for local seps
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

  Branch: refs/heads/960647
  Home:   https://github.com/bluez/bluez
  Commit: 786b11d384db0e8bfe8e96d2a5bf01411ff4557c
      https://github.com/bluez/bluez/commit/786b11d384db0e8bfe8e96d2a5bf01411ff4557c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-07 (Wed, 07 May 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avdtp.c
    M profiles/audio/avdtp.h

  Log Message:
  -----------
  avdtp: Fix setting in_use flag for local seps

This removes the assumption that only 1 stream can be configured per
local sep which prevents multipoint setups where different devices can
be using the same local endpoint.

Fixes: https://github.com/bluez/bluez/issues/1037
Fixes: https://github.com/bluez/bluez/issues/1064



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
