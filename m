Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7954F3932F1
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453902; cv=none; b=eKHMzZG7Y9jlITU08/fZD+S793+vVpUesCWn08sy8cm2kep0Fw714hrc57SFPdICtqr7Yj0/RMJ9pfHhAXOE9//ck7/Z9YMGws5plLXUTAsD4/HdhTrtlRQ4qo44h6yzJCIPKGDn3+/KnnKQqobwkHdann8pwTsEp9+csL9WjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453902; c=relaxed/simple;
	bh=wLUNdPbE7yPlrLJsyVSi4PFGNqTz7EA6pX/En320xSE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=soiHBVsXGqnk9xH891OJdFb3csBUL5N6mSLJ7782uhbJJfeMGWDDEDRzaVozB9JtyLYdGi4KvLc4MVZomy5j1mmQAMSiBGXKl9OuOB+stjBFgY2334/XAIlX6q683KsuwKujcaDDJ42BYZT4pLNih7Z9CwrLVrQ7MKpEnIT0NRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kVWOAuQg; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kVWOAuQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783453900;
	bh=me4dMGN0YJoXqcjBDWfeFGoTOPIoDMAcBtpKSCCPwhc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kVWOAuQgOg5Lvr06/wvylxajXfoRGp8TtyzinOG03hdmnm8Brm8q6ZzZQjLGWhSJF
	 wPUsgfcbqXWgwdCDixaGs804es3DmlA43TigmwqH3NUGzHMRTbEC8sx/ppLEC1zGxM
	 ymyh1P98SS0jm9UXyI54GIwSt5QdQldqg1NLyZ7c=
Received: from github.com (hubbernetes-node-c8253cd.va3-iad.github.net [10.48.175.43])
	by smtp.github.com (Postfix) with ESMTPA id B96EA280B6A
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 12:51:40 -0700 (PDT)
Date: Tue, 07 Jul 2026 12:51:40 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1123298/000000-5a8416@github.com>
Subject: [bluez/bluez] 5a8416: shared/bap: Use util_ltv_foreach to process
 metadata
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

  Branch: refs/heads/1123298
  Home:   https://github.com/bluez/bluez
  Commit: 5a8416f704d4a8000f493f5eed16148d62c845ab
      https://github.com/bluez/bluez/commit/5a8416f704d4a8000f493f5eed16148d62c845ab
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-07 (Tue, 07 Jul 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Use util_ltv_foreach to process metadata

This makes use of util_ltv_foreach to process the metadata entries
instead of attempting to iterate over the entries manually which
probably only works with the exact same order as used by PTS.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
