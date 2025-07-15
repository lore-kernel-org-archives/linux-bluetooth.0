Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109E2E88AC
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587505; cv=none; b=Z3f7McQPcO1gQtfLEMrLZOj1aHX31mimcxejH70oVnsoiHR0VFIqqdwZhOYdVNTdm7bapeY5qHICf3HwpzdDZD/JjCfE8KkFmEE3iyQ+UPRuusfFBTxFNWRAEVi4djpSX78gSRr/UM1Dbxm72lDSE7MfgZHIu+IQc0ZLooPX09w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587505; c=relaxed/simple;
	bh=/n/OJD5XYQq13tEvCdx8Phoxi90wWszgcbuOpuywo9o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mCf02STwiIzYwQgXR9pllm9jSjP4gdHU4TUY4qT9OUkcMZlrmF3nQsqV0V0Lg3wdpPxKxN4bIuizrftxctJQkYizqb4X+Hvu5z/aYMADGZqxNyFJ7uDUMti320zKlnM+0U5QwRr0kAg0H90GZz9jx7rvAnlA6K/SW5KBq5UDly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dQ/7Jw+5; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dQ/7Jw+5"
Received: from github.com (hubbernetes-node-2e44776.va3-iad.github.net [10.48.207.58])
	by smtp.github.com (Postfix) with ESMTPA id A40884E11E3
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752587503;
	bh=n01yRXz0sZTXE9Mw4RMpyjt5PQv1Kwd4XHLSzTzRhkY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dQ/7Jw+5+Ni+w8OzvYzHKDrGInx6T+gvwER0t0MzkJKy13dhD7YJomRQfutoFCDHV
	 UkbBCZ9i6KDALSvNm9DeGWIj7VMCs8fkQNq/vggph59rEEwJ8rmWu44GOViuA2hc6J
	 LlPBm884q1Y6gZCnYhzHRMoQiqxAkNfeSlpzS580=
Date: Tue, 15 Jul 2025 06:51:43 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982542/000000-35838b@github.com>
Subject: [bluez/bluez] 35838b: tester.config: Add missing drivers
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

  Branch: refs/heads/982542
  Home:   https://github.com/bluez/bluez
  Commit: 35838b7d2061ef7e0e531e637fe5df6609296df5
      https://github.com/bluez/bluez/commit/35838b7d2061ef7e0e531e637fe5df6609296df5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M doc/tester.config

  Log Message:
  -----------
  tester.config: Add missing drivers

This adds missing config options to enable all drivers which is required
in order to catch build problem with github CI workflow.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
