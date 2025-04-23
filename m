Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A261289351
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745435065; cv=none; b=U8G79P570W3k8h7GsbeeEo+5HxxPcgnJW+D0jvsnnl2c7JE0TzgziFt6FwG1bc/TFxilZ6nsPhcT9ydPGj70OiD/6yiW70QxoKIGH/yT5Tn9RfnSFHJjxYuToZreExKpDMFczyyJSGWvuJLFMkgBu7LqsfpBa8CFKD0CyRJ5U5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745435065; c=relaxed/simple;
	bh=J7/38fqP5r2XahpKJaou5SzW1WHeJY+uOdudl7Psc+w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BFG3t67xa+VoYkqgDrxbPvMAaMn67hAc+C/R/O7hXstjwWTN/H5eOjhVKkqoMc5BoFFUuue2QKnv5a/abSdwX+6U2XOQOHm+XfWgCnkDZHMLw6aZCDx5ico+WYfekEb84rGsek/fDI25CU0oz1z5lmvdqHzUQwRiGXEPvyQdks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OGKvy7x6; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OGKvy7x6"
Received: from github.com (hubbernetes-node-2e2a1fd.ac4-iad.github.net [10.52.149.42])
	by smtp.github.com (Postfix) with ESMTPA id EDA2364071C
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745435063;
	bh=fLYKteujoX1qwBwviMXzPUDp+5aGnyem48rirz7zs7U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OGKvy7x6c42bgzdIG/sEFzGQZKpQAzXgnU4/uZqoFvbjS4a4JV9v9Q2SD5j1+21hy
	 qH2+h3ji62kXDC2F2PKyJkIzDlIUUPc+18h7S/h7Go3XRPOhzs786GW1ibUyiwno5V
	 3Un4P7pi9JlVRxmTTxEDIg+cx5o2+VvwiMwF5NVU=
Date: Wed, 23 Apr 2025 12:04:22 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/46e6a3-3e9827@github.com>
Subject: [bluez/bluez] 3e9827: workflows/sync: Add Cleanup PR and Sync
 Workflow
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
  Commit: 3e9827d3a67254deeb82d0b11bd5cd63f5499ff5
      https://github.com/bluez/bluez/commit/3e9827d3a67254deeb82d0b11bd5cd63f5499ff5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-23 (Wed, 23 Apr 2025)

  Changed paths:
    M .github/workflows/sync.yml

  Log Message:
  -----------
  workflows/sync: Add Cleanup PR and Sync Workflow

This adds the missing tasks of Cleanup PR and Sync Workflow which are
required in order to properly handle the PRs.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
