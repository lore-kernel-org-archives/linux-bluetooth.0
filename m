Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C06F30C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179238; cv=none; b=sXt0lQhS5dT/02FISvsW8cN0WMuTQsX2lRNkOcFFck4wmGDBCpulwXYCzdM4wyaPLBuBGzlTcDMPesFK1A5yQ+3p3kf8hW1UkhJo7mh08gHpxtIrPBGee8AiGPWKGQqnz6ymxZK5etw/wvDsDGUVZWhv0ZtZJ0Wmzgw7iVS8ihU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179238; c=relaxed/simple;
	bh=2+KgKXfJ4Tlw5PO47nmNqitU20/W53sOQzq0HeOsAP0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GwTlgMFN1VmPjG9gcmHT+O6FFajay5rGeXtBmRjq5LM2SrQXJoZ6ZFhl/4hFDw9NOpQja04CWEhsf16PoaHGL8vDM9147shLP6WOJq97mm5tcra4delxA5cenhLz7y1qAtyS0EEHajpIPbAiPDkhrZ4g384cl24Arnuio6/adQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gs6o45Cd; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gs6o45Cd"
Received: from github.com (hubbernetes-node-2de13cf.ac4-iad.github.net [10.52.208.82])
	by smtp.github.com (Postfix) with ESMTPA id 42DE65E03CB
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 14:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1733179236;
	bh=VArEgRsHhgeQa9akdqGjeLFiJ2VPHqM46jd23e4uNgU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gs6o45CdrXtbeejEsN4QKnS70ttmuCqw7Xem76k5cQEyPTe7RtzJtPm/RJW8ivAqb
	 v0F3a6u+pJlwmjOgV88ScWyD9ohqGZHKp61hjwRfGVo6GOAPah65fmow6cKKJRN/8e
	 DyKPKPI+Zr3Bv4zMKW2Ywi4VL8yCpSIqJj2/Vp1E=
Date: Mon, 02 Dec 2024 14:40:36 -0800
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/252883-756d69@github.com>
Subject: [bluez/bluez] 7d84f8: btdev: Unlink local BIS before removing
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
  Commit: 7d84f84cf41c0dd8e74849e3310f1fa028979526
      https://github.com/bluez/bluez/commit/7d84f84cf41c0dd8e74849e3310f1fa028979526
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-12-02 (Mon, 02 Dec 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Unlink local BIS before removing

This unlinks the local BISes from the remote ones before removing them
in the handler for the LE BIG Terminate Sync command, because, otherwise,
the remote BISes will also be removed.


  Commit: 756d69fd3db8c84b88073c1467ba6b282ab5dbdd
      https://github.com/bluez/bluez/commit/756d69fd3db8c84b88073c1467ba6b282ab5dbdd
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-12-02 (Mon, 02 Dec 2024)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test for ISO Broadcaster Receiver Defer Reconnect

This adds a test for a Broadcast Receiver terminating BIG sync and
re-establishing it, while keeping PA sync alive:

ISO Broadcaster Receiver Defer Reconnect - Success


Compare: https://github.com/bluez/bluez/compare/252883241228...756d69fd3db8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
