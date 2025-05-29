Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9122DA0F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537645; cv=none; b=dpRtWSVaKcE84gB6ekTSKzK+vflWFjFjCTl9miwQ5fmmAkPHA+duo0eOYBEI+A8epEL/qjlVHgWmGGiNkWNwESb962GtPcImeIf8Jfk4XTemYpr4t1VgKudQiOr4jG/v+nxPUEBR1eQdcDrqLwMC3xkNIETJpC5adEgXFUXbLY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537645; c=relaxed/simple;
	bh=C1K7iyxXaHjKvBl2SJWfDoCrRlClfHjHmU35F5L5yxc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tcx2LMXKpFGAwiT5nr6RhuoZmBlO9Ia9lk2gA3XdJDHTgi4Xia+Nig566va/ZAeql78GkfXjKWzDaerTIgb+VMGmHsxdGrOtXEqtTzCYa5/YNma02mYUhlPUJJiVKUwz5ikax27yOkn0vk3MKJXkyEcpYqyDK+UtSIaXt4RVee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YNTk34hu; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YNTk34hu"
Received: from github.com (hubbernetes-node-9ec63ab.ac4-iad.github.net [10.52.152.34])
	by smtp.github.com (Postfix) with ESMTPA id 3914B21084
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748537643;
	bh=yjDLPlVe+nIacmlTUUzbWmsHKZfZyrEMoI5LVdKJH88=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YNTk34hu89etFMUJNTwhNtMzenFG8xKmCG38N9ODluMPXSxrSgKCdOWTjPgMzfZxw
	 iAd5kDpapm81BwaPFnfIhCS/mKb/xBZgtzFBlHEInqPyNq+W+7/PBebxkpdYG4thnC
	 XJRxqjeWX6ygwXHPk69AAugRipe7VhCcb9JtgTIQ=
Date: Thu, 29 May 2025 09:54:03 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/967384/000000-d12f4a@github.com>
Subject: [bluez/bluez] d12f4a: bass: Fix not using SID from BT_BASS_ADD_SRC
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

  Branch: refs/heads/967384
  Home:   https://github.com/bluez/bluez
  Commit: d12f4ab5e5a65624a1927ac4da0c95fad31980eb
      https://github.com/bluez/bluez/commit/d12f4ab5e5a65624a1927ac4da0c95fad31980eb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-29 (Thu, 29 May 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix not using SID from BT_BASS_ADD_SRC

BT_BASS_ADD_SRC command does actually have the SID of the broadcast
source which must be set otherwise the kernel would assume it to be
0x00 which may not always be the case.

Fixes: https://github.com/bluez/bluez/issues/1282



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
