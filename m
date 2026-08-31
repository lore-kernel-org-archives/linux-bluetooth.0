Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1236039446B
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209185; cv=none; b=W/dttzWYdnVHw2h7o/5copZ1JttLEZ1rz0O7SK25Srd/PwFOfXDynPLo8tj+10ebZ5aPU6gBQcg3ipZwOrzzHf+bbtMTSqCEtBO1tcur1k82snn4rXZyiG5PmxL7gv60TZ8G3RUkihCl8962jf44B3RQpyCzT1YRblZtpoZ90YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209185; c=relaxed/simple;
	bh=Py9+lSlh2n2jaPj1R24jwvldf/8kS9lNE5FYogDnj5Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sM+EsGkP/NeZRcQLj2KSBMHYMC9q8LnCa+7RNhF+8aqD6HuRYZEME0CQlXfkN9ReSWNzITmDZgQUaR32tHJ2t/ca5B5S9LtOhrHXHVHHbaQwMq1Y+28owjVIlDIdEWpsNoxVwIctJXL+7vUbIy31RVQghc8+G8lwSneUb77oKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JaN4yRLh; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JaN4yRLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788209182;
	bh=ZjJJZ+1eMHTcwAahHb8LaQsOmcX6DlprCy4m5IAqPnY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JaN4yRLhZn40OjIJ+oSGxOBbhdoYQMoLxo6ZcadR/N0b2mTpkJSFBMfXceGN2POkF
	 seDX5K1Pi0LRN3Xb7HFN1IaQKpdXkySxIGvcxIVh3WR00MINaupFdI253mVpzb7bZt
	 N3l5s6KA6pSPI0KSii4Sod0H5vQKw2iNrF0BwFhU=
Received: from github.com (hubbernetes-node-f8c7997.va3-iad.github.net [10.51.93.19])
	by smtp.github.com (Postfix) with ESMTPA id DA8DC3411EB
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 13:46:22 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:46:22 -0700
From: Jan-Michael Brummer <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1154605/000000-2b1fe5@github.com>
Subject: [bluez/bluez] 2b1fe5: Add cover art support
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

  Branch: refs/heads/1154605
  Home:   https://github.com/bluez/bluez
  Commit: 2b1fe5547b81dd77798dcd3c29b07c637bc4a979
      https://github.com/bluez/bluez/commit/2b1fe5547b81dd77798dcd3c29b07c637bc4a979
  Author: Jan-Michael Brummer <jan.brummer@tabos.org>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M Makefile.plugins
    M doc/org.bluez.Media.rst
    A profiles/audio/avrcp-bip.c
    A profiles/audio/avrcp-bip.h
    M profiles/audio/avrcp.c
    M profiles/audio/media.c
    M src/bluetooth.conf
    M tools/mpris-proxy.c

  Log Message:
  -----------
  Add cover art support

Add bluetooth cover art support based on the existing code.
Tested with VW head unit and Fairphone 5.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
