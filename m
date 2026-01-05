Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4813FEE
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642060; cv=none; b=DEdPU+Pd1K3uAXiM4a92oldUh3U/CSY4pOGdnAfhsjAXoxA+0sp3r48V4+gBbyEp3kS7md/ogAKrjNXBHyRPFPF5JcxxsepouSL42TC+vluV3y8WVELm+R8WKXDcrC5Q0Ka+uAdg/EUL1o75B5Dq/lTLCC6a1Owjo6CGPZiF3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642060; c=relaxed/simple;
	bh=2WQogkOZytk5hQjPHl5YrKgKAY0z60xe+lQiiunDPZE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gcS8fY3WVM7mkKdv26tbcLTvR9eYg3BbAVrH/JMwiUkILqjRlbiB10j7Yi1cKdVQyjbnLi3AvGJR/EGFNp6DDHenSbsIZX8bwNQouDp55zVPMqlzejypD5BgkynClOBaVvmHGrLVgIlxrTj5U9n08nHeTUoRqR4AuLGYBMzcmqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Zd4kMoQ9; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Zd4kMoQ9"
Received: from github.com (hubbernetes-node-117a8f8.ash1-iad.github.net [10.56.209.94])
	by smtp.github.com (Postfix) with ESMTPA id 6D49792078C
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 11:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767642058;
	bh=xhRxJ6ipo8WYHapJD+g0XUFR2s3d7Ap7D9mHN+ckpe8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Zd4kMoQ9O2jASqmpDHRc5fWkBxAvK2jGJQmbjx6lDmZvz+68qMFsFoeJPtLnh4YSw
	 sWmKu4YaxBtJgRnQpZm3hw8Pl3tnbIVVcC5Zl0NtPAFFfC/3m2NSu0vnOXZGqxPn/y
	 DoFrK6U512jeDFlP7dzhV8w7x8IAUlxk3lFdTwj0=
Date: Mon, 05 Jan 2026 11:40:58 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f30307-c8fb53@github.com>
Subject: [bluez/bluez] c8fb53: bap: remove setup from bcast_snks when freed
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
  Commit: c8fb53f49cc691145c4b6447ab4eaf67ad3515b3
      https://github.com/bluez/bluez/commit/c8fb53f49cc691145c4b6447ab4eaf67ad3515b3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-05 (Mon, 05 Jan 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: remove setup from bcast_snks when freed

create_stream_for_bis() adds setups to data->bcast_snks, but they are
not removed from there in setup_free() which may cause double free in
bap_data_free().

Fix by removing setups from data->bcast_snks when freed.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
