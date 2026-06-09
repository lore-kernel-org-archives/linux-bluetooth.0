Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0E368D45
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030144; cv=none; b=fLNFUqcpCGu/bn20TgFyLrgluNQJXC2WeN0L7YTmio3epALiU/iQsR9BlAVi2EHOU4Ddfq6ytcnFpYvWzdh3bNCZx282WHSmBPZBzRauIgO5oIJcW9Kd/Ns+9s121z7JGmGkCdWumP9ry/IguB0BNCi+XAyWum/NbXlRplLXLVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030144; c=relaxed/simple;
	bh=8XP732e4bFb53vaCzb2R0WdjH5zOPkdSUWe7FHXzEfQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dBQQ1j81iTFL1zWNizAePVWtWgzXVVBp1mh5Ie608i90+g+z5wv9JRim/eVIIrQUE0/T6fjjU5qtaSMVhgou5B3N78DnmC4TunxXbAnImBhptDVwnkvLvnu6mZhu29cU1BRsymvpyqPAVaUhl6U72W87uOMGn2Pjczq7sSZVRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YFZRf3Yu; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YFZRf3Yu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781030142;
	bh=MTBdiRvZEfa5QVuQectwLvW9/bQqu5zmKLerMr72d1s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YFZRf3Yu8eWnSgXOCJP6rKQcMB3ld94O/1a5q66gNlBDD0pHVx8rLOqbU5jPWHgYN
	 KgfO4WjjCNtyr8QAXiumP6Z1kZ5vifR8E1GCKqOgq6jnyPNOchmJtaGeZyMABKdVyN
	 GiEC5J94YOn4bilI9akSEIgJ9p6dReUb6Zwp2G3Q=
Received: from github.com (hubbernetes-node-3babc38.va3-iad.github.net [10.48.205.51])
	by smtp.github.com (Postfix) with ESMTPA id 4CAA128109C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 11:35:42 -0700 (PDT)
Date: Tue, 09 Jun 2026 11:35:42 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108772/000000-45183e@github.com>
Subject: [bluez/bluez] 45183e: shared/vcp: Fix duplicate VCS registration in
 bt_v...
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

  Branch: refs/heads/1108772
  Home:   https://github.com/bluez/bluez
  Commit: 45183e49cd6de5e6ded958abce96a1889144d2fb
      https://github.com/bluez/bluez/commit/45183e49cd6de5e6ded958abce96a1889144d2fb
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: Fix duplicate VCS registration in bt_vcp_add_db

bt_vcp_add_db() called vcp_db_new() unconditionally, registering a
second VCS instance when bt_vcp_new() (e.g. a remote client session)
had already created a vdb for the same gatt_db. Guard the db as
bt_tmap_add_db()/bt_gmap_add_db() do, since VCS permits only one
instance per device.

Fixes PTS test VCS/SR/SGGIT/SER/BV-01-C.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
