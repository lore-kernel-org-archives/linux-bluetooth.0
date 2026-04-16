Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312F2BEFFD
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354754; cv=none; b=Iu9PfpggXumHH5DpG7JLPXUaapwFay7VKrTvOiDlP5dktO85MuDQqFQShpI1g/dSXpRxp9dAWqg/XxOvCT6cQtFUEVtBLNCqYiEv7930sRElvI1uKYe77uG9b0aMaZf0bXJDonmNmnJZzXGXVcHeY6enhhRQWhB+XFVM/1arRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354754; c=relaxed/simple;
	bh=6lYjNIzd8svZan2PtJCyvisM5GcMNkt7b1xd5ywY3jQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Nyq9lPon2dE3YPlcxiSa5TMhsNYhJzht9EoUQ4RDsQOhsiGfeAvB22TplM1R7z7bivaEa31F4BmSjGJrUsuphPTbDWFBHsVxSuJ/IXggU+prwsonovbsA+IwfHBA0D/fsoe+dvFF9sMUaBVIMiVTAy+M7OSK9nKhodGycuBwxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=l+21e+fl; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="l+21e+fl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776354752;
	bh=/oFkJl6nwZ/IJDmLWPL+elo6xnGtQUwvseIzNI48YCU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=l+21e+flYrZcBVRim2pYOorie5qHFhunjai8ADizYPBgEPf7mdSpO+RUzl/3tgdce
	 va3vQJpzrmY2tqN9Qd8TRBMCHeVKVc9Jko87MYoAjCLjjoGDtwvAeXHE2SlF/lxPHB
	 zOrPGKTopxRqNzAWnHNCN7jRBPkiLj1A0a9M/CPM=
Received: from github.com (hubbernetes-node-2786849.ac4-iad.github.net [10.52.223.44])
	by smtp.github.com (Postfix) with ESMTPA id A21457410AA
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 08:52:32 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:52:32 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082082/000000-a1228c@github.com>
Subject: [bluez/bluez] c2049b: shared: Remove glib dependency from
 src/shared/ad.c
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

  Branch: refs/heads/1082082
  Home:   https://github.com/bluez/bluez
  Commit: c2049bc5cee4f468436a01a51967a03ef503514a
      https://github.com/bluez/bluez/commit/c2049bc5cee4f468436a01a51967a03ef503514a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M plugins/neard.c
    M src/adapter.c
    M src/device.c
    M src/device.h
    M src/eir.c
    M src/eir.h
    M unit/test-eir.c

  Log Message:
  -----------
  shared: Remove glib dependency from src/shared/ad.c

src/shared/ad.c includes src/eir.h, which uses glib, which means that
the non-glib shared library can't be used without linking to glib.

Use our own queue implementation to remove the glib linked-list usage.


  Commit: 508d84052e856bb7a59261112015e16b80bce3d7
      https://github.com/bluez/bluez/commit/508d84052e856bb7a59261112015e16b80bce3d7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M src/shared/queue.h

  Log Message:
  -----------
  shared/queue: Fix warning when compiling ad.c

Both ad.c and eir.h include queue.h as both use the struct declared in
this header. Quiet the warnings with a stanza that means it will be
ignored second time around.


  Commit: a1228c04ede7ddf6f2ce1c07fea03804270fdba7
      https://github.com/bluez/bluez/commit/a1228c04ede7ddf6f2ce1c07fea03804270fdba7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M src/shared/csip.c
    M src/shared/rap.c

  Log Message:
  -----------
  shared: Remove unneeded glib includes

glib was included, but no glib functions or data types were being used,
so remove those includes.


Compare: https://github.com/bluez/bluez/compare/c2049bc5cee4%5E...a1228c04ede7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
