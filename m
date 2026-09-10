Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3A57D20A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069516; cv=none; b=nX+EVSZhBN2gCMlGh5EMeThYwMCaHzpItY0GxQRjdgy4ca5rFKQHro2XBq4r1ypBb6ogfSlQh/My6t/EM+HWWR0I7IY9tOQWUPFKfLB8JWTgsfak34JI2pzQ6p50aKVCGJQXWZSJ3URWayX35fljpwVSaGj7D4uhbIDRfDl8if0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069516; c=relaxed/simple;
	bh=pcl9co03PjPMPui11+PXxcAwjN8GuiAZbdRg6qUTlqw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uQ/4bjT/vr5O9vjn+1S376n91QSILLbzvsamqHRFMYsDyf1MMtya7hi7itVAw0QSUabaFcdcmOpqznRgnCjo6jpHK5DZOl8yZ0ag0msHn4QeW0fN4ffsSuhMksZQ+9PDUVn85i6B0OSeqFbhFu9J1kcVlRHaqqk2d5Pg0LoW6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZX801oGb; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZX801oGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789069514;
	bh=wl1P3In6S0lb/jvLrhZ6Pdd+OTtjJ6VYkbJRoZxd9Ks=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZX801oGbjZJoQl9S/Vw+afEhpopfHdthCATjs5FZiOkkIA21mO7gGXQXvOU87o0Ew
	 q6to/Pm4Mgu61BsTIw1J+I6QZ/ncskbTe02FmBnCTBohn9LntqBunMv02UJ7Bq1DnD
	 wtZodbwzy2pAzBM/rr/OPvEb2H/YqcHlPcyGtePw=
Received: from github.com (hubbernetes-node-4434f7c.ac4-iad.github.net [10.52.201.19])
	by smtp.github.com (Postfix) with ESMTPA id 7A3D9A0B8B
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:45:14 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:45:14 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/08efb9-fa1938@github.com>
Subject: [bluez/action-ci] fa1938: sync_patchwork: don't recreate a PR that
 was alrea...
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: fa19384d4c70f1cfd7e432aab9a2f731dadb7091
      https://github.com/bluez/action-ci/commit/fa19384d4c70f1cfd7e432aab9a2f731dadb7091
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M libs/githubtool.py
    M sync_patchwork.py

  Log Message:
  -----------
  sync_patchwork: don't recreate a PR that was already closed

The series to process are picked from the patchwork state, and the only
thing that kept a series from being processed again was an open pull
request with its id in the title. Closing a stale pull request removed
that marker, so the next run recreated the pull request, ran the CI again
and sent a second result summary to the same thread:

  #652 [PW_SID:1151528] ... created 2026-08-25, closed 2026-09-10 18:05
  #746 [PW_SID:1151528] ... created 2026-09-10 18:11

Look the closed pull requests up as well so a series is handled only once.
A resent series always gets a new series id from patchwork and is still
picked up.

The series id is now matched exactly too. The old substring match made,
for example, PW_SID:115152 match a pull request for PW_SID:1151528 and the
series was silently never tested.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
