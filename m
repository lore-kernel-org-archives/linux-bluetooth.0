Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35D2AD0C
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759348057; cv=none; b=BxqdnXGOIl6QrU8mg3/M56c/ZZWCIEYJ1HK8HRpaG5GwgrWn1uKk/EPClwhnc8T1wySl9zs/PoopJRVo8dKYldSy494Ce9jThDxehxwIkRFAsadW9WlRUrYd1kGJnh2XLDbjAjOT4DVEtP2YE20T0b/Ah9eYc/b2GSzC5pQaVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759348057; c=relaxed/simple;
	bh=YSb85E8GxI5QyLxXt3CA5rwyoqwg0pQBZsktpSrjxVI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=e2ykc+hzqKgmy3d88NCluMvi+LVvYl2AKZUp/PGX8MT1dGGVsG0Vidj4ef28Uw0RPd6bQ9XfC4pCyjhIGy7GIGak8xVnFPs47pq3ykHH+z4fOXjoPwz1dMJ7TRqkpe9gZHCPO3YYqXggTgN1GV/KF4fR+d88WP3YeNzBoZ5T9qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Y9vAgBtS; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Y9vAgBtS"
Received: from github.com (hubbernetes-node-b970631.ash1-iad.github.net [10.56.165.41])
	by smtp.github.com (Postfix) with ESMTPA id 6613D92110F
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759348055;
	bh=4UQxsZC/lq3vnHol3ZbEtHeIkGMGkLqQ8cbxbrfWE4A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Y9vAgBtSzW271DC1tjiAd7VPrTF9TwT7n65GjW7o6ArPCdiXMvP2QtWJpNUFGNgPv
	 oC6788Rx3j9zImr2FIJtahVKdtwDAGMlvYiwFxO4G/LlCytBTasBBIm3mR4ZEw/4ZT
	 3W6ihZHhF7MZ/JhOSnETNMbqtJS+O42Vxz1hoBYY=
Date: Wed, 01 Oct 2025 12:47:35 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1007812/000000-1fbdb2@github.com>
Subject: [bluez/bluez] 1fbdb2: lib: Fix headers that are used to interface
 with k...
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

  Branch: refs/heads/1007812
  Home:   https://github.com/bluez/bluez
  Commit: 1fbdb2a4b30ce4c34f5e63cf3bea1291fad01dd7
      https://github.com/bluez/bluez/commit/1fbdb2a4b30ce4c34f5e63cf3bea1291fad01dd7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-01 (Wed, 01 Oct 2025)

  Changed paths:
    M lib/bluetooth/bluetooth.h
    M lib/bluetooth/bnep.h
    M lib/bluetooth/cmtp.h
    M lib/bluetooth/hci.h
    M lib/bluetooth/hidp.h
    M lib/bluetooth/iso.h
    M lib/bluetooth/l2cap.h
    M lib/bluetooth/mgmt.h
    M lib/bluetooth/rfcomm.h
    M lib/bluetooth/sco.h

  Log Message:
  -----------
  lib: Fix headers that are used to interface with kernel syscalls

This fixes the headers that are used to interface with kernel syscalls
which seems to be broken for a very long time due bluetooth not having
proper uapi in the kernel and libbluetooth not licensing the headers
according to the same headers in the kernel.

Fixes: https://github.com/bluez/bluez/issues/989



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
