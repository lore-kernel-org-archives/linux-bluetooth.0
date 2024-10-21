Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F519923C
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545365; cv=none; b=XlSHUUOOIJkqGmzHFQA6L/B1W2mch1wJS4/Jn+XLILCsCl0QK0lRaw8OwzkED7C5wjo2QWjeoYAJfxearkmQ0Qdpg5B/luQFqLfibRQ6Kgfs6LRefi0qbprD93BbORlVnqy/q54Xzw+vXn9UV6PcH3CZuRG1/9e4dqKmojCsUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545365; c=relaxed/simple;
	bh=EIZOtP3cI32i09LoVcrr0AacGq/+vDWZuhkQ2UKHIbM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jD2RHBvSu2mS+Cw5VJ/aTXMJiPCAm2PYFrdpdt8W1n1bNizMMYRzJKwYc5aSIhlqtwQU63VW44gowdmGuGeCI0FPwXjJm4k+YM73rOfWCb0wmrk3FOjGvs7Miw/UmHIjFBMnzj+MYal1PuN8DcGZ9UU1sbGT6C81YiuBmRTe+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TLLh6Ag0; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TLLh6Ag0"
Received: from github.com (hubbernetes-node-a9ec292.ash1-iad.github.net [10.56.173.19])
	by smtp.github.com (Postfix) with ESMTPA id 6C83F6C105F
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 14:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1729545363;
	bh=ChV6l+KHnzpUdTG7zfYZ5nrAaLTpw8EOzeGUXqgCXy8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TLLh6Ag0oFu7tpsMaG54kZ8AbNT6yil8Mn9IfOyh1bEXq+hEPLLdnKkutohJ0fuie
	 h4tdR4WPzA5oZ4mMSIUteow0hYsCplMFD981caasOXHZ7pBVLM2zTuPNNPVTjDbX6O
	 pvcLhxReEafRycSlbqP2+R3Sw+CsPx/qvldCft8o=
Date: Mon, 21 Oct 2024 14:16:03 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8baabd-29174d@github.com>
Subject: [bluez/bluez] 29174d: build: Fix make distcheck
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
  Commit: 29174df0042ac1438ad7d00e6111c74031f1ac29
      https://github.com/bluez/bluez/commit/29174df0042ac1438ad7d00e6111c74031f1ac29
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-10-21 (Mon, 21 Oct 2024)

  Changed paths:
    M Makefile.am
    M doc/mgmt-api.txt
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  build: Fix make distcheck

This fixes the following error:

make[2]: *** No rule to make target 'doct/hci.7', needed by 'distdir-am'.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
