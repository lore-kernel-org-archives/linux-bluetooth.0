Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E10456DF8
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252561; cv=none; b=klYtyVcRnbNLZryh8ETyAuopoWo0QjIb8lzPpwrOYz0nrKVM3S/qnmpjXKbckQm5EpTeq7WPJlHiPaTzzUAwKlPqAalI2E7va0iu/X98qXXmdBTTG8d+M+oggof2BSkf8mGzr6H0T9T5QMvpSbxiE5nV5G2s5jZef7Cuarbw438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252561; c=relaxed/simple;
	bh=CfI0HR2uBLaXy2novjb55QdOpFIynrW1xqUqSQBhaSQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=k6I1Y/UX1UCi3oWCT73umSUYJwO8purxMb57KIezBMn5/ucfcLRGIoNAY17s4h50TM3lcq286OEraWc8e3mXC714XHfXsCiwrwSn/0ZQ10mNPiwkyZNBjDpti/uBaiYzkoILAEEukcPs+gaLL0gQgERG52cwCsD42IcPhRAIlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YafvISi7; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YafvISi7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785252559;
	bh=Ncf43dEEt3fXd6RbdpC1vi5zVOY9zBprKV/y4e49wdU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YafvISi73XZiNvcL3wGQkwYhD0uxzbx4fg4RSBrD/M2MYKNd4bggVaUwVdbypBmox
	 EDI20ozPCoEhXg5jy/WfiiTWxwdIi1ieT2bDSjY6fuT1IdGT72gmm5Dr4Nkmiqv0VE
	 4BbXlgF3C85V9jZ0QrV4cjZHCk8jH5wLxg2v4QsQ=
Received: from github.com (hubbernetes-node-3e29ba1.ac4-iad.github.net [10.52.134.16])
	by smtp.github.com (Postfix) with ESMTPA id 5FA4CA1308
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 08:29:19 -0700 (PDT)
Date: Tue, 28 Jul 2026 08:29:19 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/89d477-729f96@github.com>
Subject: [bluez/bluez] 322c39: bap: Start BIG sync after receiving BIGInfo
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
  Commit: 322c39a643232643ccd514a8f8dfc9683e3e3f1b
      https://github.com/bluez/bluez/commit/322c39a643232643ccd514a8f8dfc9683e3e3f1b
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2026-07-27 (Mon, 27 Jul 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Start BIG sync after receiving BIGInfo

The current implementation starts BIG sync before receiving a BIGInfo
report. According to the Bluetooth Core Specification, BIG sync should
only be initiated after BIGInfo has been received.

Starting BIG sync too early may cause unexpected controller behavior.

Trigger BIG sync from the BIGInfo callback, following the same approach
used by the short PA flow.

Fixes: https://github.com/bluez/bluez/issues/2345


  Commit: 729f96089cf66831d911385623ca932e0c245913
      https://github.com/bluez/bluez/commit/729f96089cf66831d911385623ca932e0c245913
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-07-27 (Mon, 27 Jul 2026)

  Changed paths:
    M .github/workflows/stale.yml

  Log Message:
  -----------
  github: Disable stale bot for triaged bugs

When the "bug" label is set on an issue, don't reap it with the stale
bot, as we've triaged the problem and seen a bug.


Compare: https://github.com/bluez/bluez/compare/89d477bb5494...729f96089cf6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
