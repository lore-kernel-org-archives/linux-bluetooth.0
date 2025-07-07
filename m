Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A578C9C
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918365; cv=none; b=u3eWzgHJ+UrvEX9TRSF6FcnqFQgQhi4uPN8NvywfR3xi0hq1t3kKBjqMGs6tDxOjuUtKzscCxT2Y8nR8o05Om/M75/MIkpTC4jgTkCmRhzUWWEsKo4ZaDUvURBOVvIqGkOa1HnYBKXKLyEZUm1bygVyqxcyDte7pS9bpDN5ktQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918365; c=relaxed/simple;
	bh=Z9rVz22SncHeFRmJbMKs45YDJVNcXG++gkxGzWKeaBY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=r3ZjH7DyZcXf8o1NjO8Ckl2s9x2wSRVaWjTEKQE2hD2//u2f97jByPtJD47fLq4ghxWMwWbnlRsTrl7JMtBg6zg4acRZTtX0vRTP9EV6lz2tegkOvH4JuyUNH0UZNyVSJY3PggA2eXFkutpzQCDtqzHsksVREtojOKGmQXKBhgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TKlwop1l; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TKlwop1l"
Received: from github.com (hubbernetes-node-e8326b5.va3-iad.github.net [10.48.183.30])
	by smtp.github.com (Postfix) with ESMTPA id 12F884E079A
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751918363;
	bh=w4amxG8WqgxRgdoYGVAN4+URBTeNlyP1O8Tle6r1vMA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TKlwop1lWU1s9fqhhJM7zoeeq8+DxonTcImQOWz4EBCGbBHl9QRXTmkCGSZohWP4o
	 NLxOY0H1GS75xFh7qOnalxOkbuGokK5quZ1+eg4Ma19SxSe/KOQRT0sA4cijtQikOT
	 k5GwJQaK3J1C0HwhYB+E48UTbNYURd9qWyjuutn4=
Date: Mon, 07 Jul 2025 12:59:23 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979806/000000-de485c@github.com>
Subject: [bluez/bluez] de485c: doc: Add org.bluez.Device.LE and
 org.bluez.Device....
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

  Branch: refs/heads/979806
  Home:   https://github.com/bluez/bluez
  Commit: de485c135ef9dbdd4cceeec599fa24db62f87627
      https://github.com/bluez/bluez/commit/de485c135ef9dbdd4cceeec599fa24db62f87627
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Device.BREDR.rst
    A doc/org.bluez.Device.LE.rst

  Log Message:
  -----------
  doc: Add org.bluez.Device.LE and org.bluez.Device.BREDR

This adds bearer specific interfaces so they can properly be operated
separately.

Fixes: https://github.com/bluez/bluez/issues/1350



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
