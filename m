Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D57126BF1
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763928932; cv=none; b=YcjM6KUn9j+8BUVVfyfUQS9c1Zfvb+135B9HTz1iNTFmE4Px5yNHDoiVSjXocXlmDLXFMowQp6kNYEaPvaUN6BiVjW32yrTtbvaCTSBEu159Sf0zZ4yts+ji4zaOoM4NDGVbjY/ovbVwQSMgVAf4ryZBqVwSOfMr01fsj/Ws7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763928932; c=relaxed/simple;
	bh=vde394PtuUV07je4pTZ7S597QufUI2bKll69tR+2miM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WDKbggCWrTuGbPxi+tBq6fSQwDxGjja/2GLLLyxBTP/iOMEQK7zhT9ZozfAEg+gJY00HN0dRQD6E+UNj4xUqD5tlf/yc+QbHUnrpJaIaL1rfDAo0yZA04+CmX3W7cLN9oN3LlNr6H2989XWJDe1nf/6Zr6XJvO9s85jkIpMPbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KCWNrEAg; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KCWNrEAg"
Received: from github.com (hubbernetes-node-0b6c14a.ac4-iad.github.net [10.52.169.43])
	by smtp.github.com (Postfix) with ESMTPA id ABF464010A9
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 12:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763928929;
	bh=W/sPxjpk6EuDXOnVga4grkDgfU0NfvYg8vI0uNkXrpk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KCWNrEAgmNECqJUk3uTeQ2ksDIv9MzBFCgLkce75RLHcaf3U8yuwG8CJI8phNtxko
	 njxZ56eAjViOK5/eQ4R+un1Foc3xp74KBbBYLHdPccnl1HN7Hrp9zuLH1Y3fH7e2yi
	 tGoLvHr9mwc6x0k+KuS3dRg5AAX/Qkwiis+DlyGU=
Date: Sun, 23 Nov 2025 12:15:29 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026741/000000-3c3893@github.com>
Subject: [bluez/bluez] 3c3893: sco-tester: add timeout / close during
 connection ...
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

  Branch: refs/heads/1026741
  Home:   https://github.com/bluez/bluez
  Commit: 3c3893b1f9a27d13ce47acf90a85a1863d466837
      https://github.com/bluez/bluez/commit/3c3893b1f9a27d13ce47acf90a85a1863d466837
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-23 (Sun, 23 Nov 2025)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: add timeout / close during connection tests

Add tests:

eSCO CVSD - Timeout
eSCO CVSD - Close



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
