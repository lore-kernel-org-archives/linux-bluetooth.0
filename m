Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CE2BE046
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964196; cv=none; b=lNIEGeMfXDpkMLXH8SXnOdFHRuHr5HEJIfOaxLq01IgwR6psxIB7qumsbGmMYpfDPugKDUezzEBDcnWhjP8kq7z38Jwo+OMJ/YtRGF1PuGi6tdfM+IZ88TyGkO8d3urALChtdQV1fxnBl5sUgeBoH0Gnqs54PbBaaEbMAMprLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964196; c=relaxed/simple;
	bh=IWGPG8qiXQJAb9Z6pYsQVf0V8RRJMEYW7KInOU334Sk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UVV1T2D8HqlnKY4JDtyR2RO96eMES5B/ZT6BWJBM9RZ9gdwo8cEnwDx/fmUbIZzjwwlb3gcczOnbh2YQ0JvBuvjLAGHkqmx9i/H6xMOb3ZEUmeiAnpvXE9s2LHqoRXnbsOX1S2olH7PBJiJkAG9ZEGTW7b5/HbIQ5m4T7LY9JxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a2TcwoJJ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a2TcwoJJ"
Received: from github.com (hubbernetes-node-39ad0ba.ac4-iad.github.net [10.52.142.28])
	by smtp.github.com (Postfix) with ESMTPA id 0178C7004E2
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751964194;
	bh=GjH8ue8PtSls4joyqfJuLaxJokN4ZHdFC3U5nQg5lhg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a2TcwoJJmHh+qhs7M7dH/iXEdfDUlx2+v5wcQk9LKwzH9LAHSEZoksWPbbXgjJ3nG
	 6zGa+KbOB4S97ucQmVzQuDc2u0yp70SPepr4Rs3h7BmwIfiIuOQQwO4pgnoBmsg1Zt
	 mFY37lsFZVWtmLiH0hYB4VwxyjCdMu7s1Vs5M4Zk=
Date: Tue, 08 Jul 2025 01:43:13 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979955/000000-060ed0@github.com>
Subject: [bluez/bluez] 6eff2b: doc: Fix extra word in doc string
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

  Branch: refs/heads/979955
  Home:   https://github.com/bluez/bluez
  Commit: 6eff2b32273ac4dc3a9a117aca5a620c40760626
      https://github.com/bluez/bluez/commit/6eff2b32273ac4dc3a9a117aca5a620c40760626
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M doc/mesh-api.txt

  Log Message:
  -----------
  doc: Fix extra word in doc string


  Commit: 060ed0f185492c2404c99acab4883f127205d98a
      https://github.com/bluez/bluez/commit/060ed0f185492c2404c99acab4883f127205d98a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/midi/midi.c

  Log Message:
  -----------
  midi: Fix debug string


Compare: https://github.com/bluez/bluez/compare/6eff2b32273a%5E...060ed0f18549

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
