Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635316C878
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378164; cv=none; b=i70KIT29ywFdCTAKucxVKhH+c+VA1ED7rhRUENdxkwWwZiA/xB74j2eoHyxHMHG+iaaYxY4Pc0mCEBsg+B9vG7BGeU7ErCqoJ9U1NaPFLcKdr0+WtC3UJE1/abEFr1dBHOXJdNnjLW1UJWSmBBoSDWhnB+LhiI8HspsFN3k7HBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378164; c=relaxed/simple;
	bh=YJpvtPacwc+mymxQKpfFqe3MCTol7ptFBv2dgH8Duyk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hm1ntFd3kr5tbGvCop+ZS1+urE03EhHcLKI7NjIWcg9+qdZDt11Crs/+Dqm+yuaH21va2afrKmEpXshMRe/xrZc1L4RsKCwY1OVEgifQ0gUta8N391Xw17tNq6jVLvKSmxOVpa8Q2vp6UZQW8DpDY67fw7RxZle8zojn19sKYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VXYwrsOm; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VXYwrsOm"
Received: from github.com (hubbernetes-node-b4e53f7.ac4-iad.github.net [10.52.201.36])
	by smtp.github.com (Postfix) with ESMTPA id DB301641113
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1718378161;
	bh=d2Q1cr5Z463VZw4aCHReZwZrlYOxrQyozsh/x4Wqqmw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VXYwrsOmbRMBJjbucD2iRqJLV9IMcaafDOjZnbUPUN6B9oq9H/ENYndNZ/lT/o+sa
	 UmyU9B1ST/JH5KaPmQti2M4pebiXBg02IPmLPKrznpgHekFrKUr9gvG7gizrdeN5Z5
	 T7WgyQQtpe3GVtn/m87F817TaYDEcw4dQ96nhNHY=
Date: Fri, 14 Jun 2024 08:16:01 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0b0237-48b7f7@github.com>
Subject: [bluez/bluez] 48b7f7: device: Fix marking device as temporary
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
  Commit: 48b7f7e5fe53b434f388a8b85cc0996853b3567c
      https://github.com/bluez/bluez/commit/48b7f7e5fe53b434f388a8b85cc0996853b3567c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-14 (Fri, 14 Jun 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix marking device as temporary

If bonding has failed but there are other bearers connected don't mark
the device as temporary.

Fixes: https://github.com/bluez/bluez/issues/856



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
