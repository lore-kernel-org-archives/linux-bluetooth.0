Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B38175A8D
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153152; cv=none; b=Fmo5hoHmJ7oUCT1hiH0gdyk/SBbJURLtHxMKPuHaGPtm24xf0DVNhCZvbFXAMewPPDnANpgN+/iMqKggTZaj9ZIKbZrgdMRckve9K15qO+F/Sz9xn+zTghRGxdwzUy+Ctcn2Pcj1OG/x4BlF6dt3GZCVjnA/95M0S4WHart/pxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153152; c=relaxed/simple;
	bh=5FZAtCjjwQgesmLX99ho2JpF20kOnX0wsVvSnQFbgZY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MIJM7es+ie/yXQX3yYu7ZEt0rGm3YyIsrVuHoqq0lyugQ+ocvGQ5HtEva6B4Eoc/GSWxGkvq6hnEhSbdrI9eSDqapGhbiLU2pg4TOMiEUqddz6SPIuIFIDz84jbypsszYSrZwDSQ442zKZ0GlSrupkKWaoh3JAG4yW6DpvmDigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LgssapXc; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LgssapXc"
Received: from github.com (hubbernetes-node-3517ba6.ash1-iad.github.net [10.56.76.26])
	by smtp.github.com (Postfix) with ESMTPA id 02CB6C1B41
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775153151;
	bh=B2S3gpHusSD/VxuDvCQr+BgY4uSK0SzPO74aTPzv+DQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LgssapXcQHxGxtQxAxflEvxvNkajLgg3f3+kSPF85wRu1f+EUzz5xTy0+kzFbMWZi
	 SPsOqzDykvD+VsH+C+nQyLCQuFOMGwD3dLWWLxut0jw7+ye1B/LgFp6XCjfPM+FLGS
	 Hv0koTPPR/gt5wmdfI4JzgJBvEp3BQGSdO+x6qi0=
Date: Thu, 02 Apr 2026 11:05:51 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0fd01e-1ce7cf@github.com>
Subject: [bluez/bluez] 1ce7cf: doc: add btmon-mgmt.rst
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
  Commit: 1ce7cfcd0f6ca87d4280a6e0c14b7d2c16778457
      https://github.com/bluez/bluez/commit/1ce7cfcd0f6ca87d4280a6e0c14b7d2c16778457
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-01 (Wed, 01 Apr 2026)

  Changed paths:
    M Makefile.am
    A doc/btmon-mgmt.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc: add btmon-mgmt.rst

Add a new btmon sub-document doc/btmon-mgmt.rst describing Management
(MGMT) protocol flows as seen in btmon output; include it from
doc/btmon.rst and list it in EXTRA_DIST in Makefile.am.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
