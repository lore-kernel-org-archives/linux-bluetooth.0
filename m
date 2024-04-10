Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F117BB1D
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768707; cv=none; b=ATLtLMZy4Kma/3IE9PsYDfh5rpvUsj5mSNa6wdkKD2AI4R+aBHDbaxQm3FfrsEp4BDOTWVb8rUb1qkCDa8tuC/gQ3u3VAStGvRncf8E+PU5OgmOy/zyuG+3ur80fV9uaBF171y4Xnkd1N/Fv/gWBj+Q5Cqdb5peGimJPUxEo2WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768707; c=relaxed/simple;
	bh=STx8GC3etp/3SWJ9+uE3+w8AxQcRkWw5QVT2wh1aHow=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GZLrcokCJ5M4apCc9YhqUhFP+G7d6tzFWn5qvQVW/J6pnI5FvBY7YcNa8Yso9G/L5F7G1FuQ9Sy4wO9uO06tFtOEZP506PmkjCGrxUIG35QKQtE+nOPw2A/CgeOVYTNtKQ3rDgvca6hpoIU51Q5h3S/pV9m2/uWM5q1gRcx0Rvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KGC/a5j8; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KGC/a5j8"
Received: from github.com (hubbernetes-node-1316d73.ash1-iad.github.net [10.56.152.33])
	by smtp.github.com (Postfix) with ESMTPA id B4C4A600757
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1712768704;
	bh=6s+LW3loIhUqzapOthkuyzAm5fRx+oOL86nzlSDCF3c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KGC/a5j8KNW9dv1ICcONmU0ZUtR0WoTCCmodX9/UW/ZK35gA1vw0f2YAsfyx1jYvL
	 YcFjOvymmA6e7w/32FcWiTXxTUrjthTqAnR22ZxOh/J9mPtHNQlkscmouYUK/JlYls
	 1SdgH9WgoETIJ8x/Qi3GiheI49Zy2AM1uKucZylA=
Date: Wed, 10 Apr 2024 10:05:04 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b163e2-fe71fa@github.com>
Subject: [bluez/bluez] 138e97: lib: add BT_POLL_ERRQUEUE socket option
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
  Commit: 138e97020d5fb2261ab2c4554dedf1f8216986d8
      https://github.com/bluez/bluez/commit/138e97020d5fb2261ab2c4554dedf1f8216986d8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-10 (Wed, 10 Apr 2024)

  Changed paths:
    M lib/bluetooth.h

  Log Message:
  -----------
  lib: add BT_POLL_ERRQUEUE socket option

Add new (experimental) socket option.


  Commit: e1c178f96a07fc43ad7523fdd4c93967843e4f60
      https://github.com/bluez/bluez/commit/e1c178f96a07fc43ad7523fdd4c93967843e4f60
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-10 (Wed, 10 Apr 2024)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  adapter: add support for setting POLL_ERRQUEUE experimental feature

Add support for setting an experimental feature UUID which enables the
use of the BT_POLL_ERRQUEUE socket option.

Change adapter initialization to read and set also INDEX_NONE features.
This may set them multiple times, but this is harmless and it is simpler
to use the same framework.


  Commit: c777c55ab662db4e9853bb08a6e1e6c77b319e09
      https://github.com/bluez/bluez/commit/c777c55ab662db4e9853bb08a6e1e6c77b319e09
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-10 (Wed, 10 Apr 2024)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: update for Poll Errqueue experimental fature

Update Read Exp Feature - Success (Index None) for new experimental
feature Poll Errqueue.


  Commit: 141f66411ca488e26bdd64e6f858ffa190395d23
      https://github.com/bluez/bluez/commit/141f66411ca488e26bdd64e6f858ffa190395d23
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-10 (Wed, 10 Apr 2024)

  Changed paths:
    M tools/iso-tester.c
    M tools/tester.h

  Log Message:
  -----------
  iso-tester: add test for BT_POLL_ERRQUEUE

Also test BT_POLL_ERRQUEUE is experimental feature.

Add test:

ISO Send - TX No Poll Timestamping


  Commit: fe71fa3dfe26e4d3fd7c5b83ff78035bf5e7a38f
      https://github.com/bluez/bluez/commit/fe71fa3dfe26e4d3fd7c5b83ff78035bf5e7a38f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-04-10 (Wed, 10 Apr 2024)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: add uuid for Poll Errqueue experimental feature

Add UUID for Poll Errqueue experimental feature to bt_uuidstr_to_str().


Compare: https://github.com/bluez/bluez/compare/b163e2bd0303...fe71fa3dfe26

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
