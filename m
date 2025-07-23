Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7821D3F5
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296605; cv=none; b=Ur+U2mK/qxerg6q+RrIDjrU0ajgUNC5Fdnt9MyXKP5VaQXrTGuwzDX2618gQjzkV0TK3SP5vfRLwJ1HSSu/DJodHQcyH+YiSKeeSHsCKvt7ApJWXRpT/ne8sDRa9fSSe6pTA/GUi1gf5OKQhispBsuceMIpBU6Cj0saFEhk9YNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296605; c=relaxed/simple;
	bh=+4qXGaq+5NC3GZrBWRkUYbWrQSMpVeb8Eq6oUaKh/4E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tkysd8mKN0KcX7BgChGYjeey1PEHKG1L2DKp6sKXHvHuuhIK+/bRBWZhHR4VPlAhzOJnZprQXiJlPEE7igN3fWy8wd6GLvYrplBSF+l97bMfSlZtKhE4wukCepQcrNa7I6JLorsRjW0T7rhBtR3yx2O1Yy4E3b/Ltz60G/8elUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cSzMQWao; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cSzMQWao"
Received: from github.com (hubbernetes-node-deea9a8.va3-iad.github.net [10.48.167.51])
	by smtp.github.com (Postfix) with ESMTPA id CECCB4E53DD
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753296602;
	bh=mL/WfmhJ63SpYwtOgAhbTU+XbAQ+MtWsbGhPRjVsE8w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cSzMQWaosjBdZB1eTmZGXDjYW/aPf8i0fla43FzxkW9WnfQOjwg3VQVz/+VuMZj++
	 qJqmFoCwMVq2LNHBvhzYE/B0QiySWcu9UYgc/NY+DuWH8sub2JEjzk4rN9JmBocGzB
	 Gk3Eps16DR/TpquY7AZNrhAloS8XyaU7iQqX1d1E=
Date: Wed, 23 Jul 2025 11:50:02 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/985227/000000-765a05@github.com>
Subject: [bluez/bluez] b793ab: bthost: fragment when sending ISO packets
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

  Branch: refs/heads/985227
  Home:   https://github.com/bluez/bluez
  Commit: b793abf0afa527c148557f6a962102afbdd20a0d
      https://github.com/bluez/bluez/commit/b793abf0afa527c148557f6a962102afbdd20a0d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-23 (Wed, 23 Jul 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M emulator/hciemu.c

  Log Message:
  -----------
  bthost: fragment when sending ISO packets

Support fragmentation to controller MTU when sending ISO packets.
By default, fragment when exceeding btdev iso_mtu.


  Commit: 765a05f8b639e076949908e5ca8e3919b56d8bb3
      https://github.com/bluez/bluez/commit/765a05f8b639e076949908e5ca8e3919b56d8bb3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-23 (Wed, 23 Jul 2025)

  Changed paths:
    M tools/iso-tester.c
    M tools/tester.h

  Log Message:
  -----------
  iso-tester: add tests for hardware RX timestamps

Add tests for HW RX timestamping.  Also add test that sends large
packets to test ISO fragmentation.

Add tests:

ISO Receive - HW Timestamping
ISO Receive Fragmented - Success
ISO Receive Fragmented - HW Timestamping


Compare: https://github.com/bluez/bluez/compare/b793abf0afa5%5E...765a05f8b639

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
