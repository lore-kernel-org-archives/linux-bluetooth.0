Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F63164D3
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216606; cv=none; b=HSOWL7SoF0NS2PYsQjUXbh4MCyavT72EpW1dtRtxX8VLlTgHAjYpNPqHYoum4HNun06O/Gj+QIl2RWzx0/X+7Ihcsjhnb8xS+A4W5lKspO0ZXi5WDsZT8Qz2sYYcX2VO1aGNk/ahXMOhPGKIgcujVM7jNrPkrSgAc45Xa8R9pe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216606; c=relaxed/simple;
	bh=D3elzevIvIjl0y3WBoJax0OPja20CsaDRn3SNjLLiZA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PvP3WGRiv+xcEV60ukJ9S2xT9DomsDCASZApxKPu92Kiz8mQ8qZ59Qv9CqFhAlD7yxEISW5iVW2YWP1I0rT3lNWltyveRcXz7Lk2Df3HW0YAtukLDsEVZhAB/SlPJIBCCmKIQ4v9LMLERqw25G2ToUK2Rnb9CGm16OWBotWw5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jqxH16DO; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jqxH16DO"
Received: from github.com (hubbernetes-node-e88b482.va3-iad.github.net [10.48.132.35])
	by smtp.github.com (Postfix) with ESMTPA id EA4238C03B7
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758216604;
	bh=8HZkwVm/JtX0u27MFKlWJDEEd5o6nfl05Y7bDGUCVaU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jqxH16DOMSK/etGgUpPVEV28paUPD/L5H1Ct5li3d/57L2i7/3RyKTjcQQXtAhUjr
	 tYYwFlcSHpcxbSkp3tVBB0N/QSsWdhsD/mm/NKlrrbUVK3PQkrjV2Cg6E4GV3W9yZB
	 ke6CtKnQXBmCv4PruGavJxtN9O+VwKCtaEssBkHM=
Date: Thu, 18 Sep 2025 10:30:03 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1003939/000000-166210@github.com>
Subject: [bluez/bluez] 166210: media: fix pac_config_cb() error code return
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

  Branch: refs/heads/1003939
  Home:   https://github.com/bluez/bluez
  Commit: 166210e8bcb7245ef65c3a4f7d17737d9997c292
      https://github.com/bluez/bluez/commit/166210e8bcb7245ef65c3a4f7d17737d9997c292
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-09-18 (Thu, 18 Sep 2025)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: fix pac_config_cb() error code return

Fixes: a887b1a1b91f ("audio: Add support for specific error codes for A2DP configuration")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
