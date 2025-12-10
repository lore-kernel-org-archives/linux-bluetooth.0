Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E259302773
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765402695; cv=none; b=Qy2pcWbyp7wvA93uidje1Ip3JJ4/k/xfi83vDanD6Rqu/nk66JCFag8B8HBLyV34ppLilPEMTxEGXNYWK5EBctmdE8pE4vVGnP8Vf9R+8EGFomf52y4lrY3nMO7KyYX9nkFu46PpsVyaLxMFC3FIujkN2BuLQi5kjdYLaoWw8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765402695; c=relaxed/simple;
	bh=OBbvt7y3DtTH9uTC/R3oIiGWoZmk2ZuV6BDu7Y+q8pg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ePQPTU1aO1ww5b4qJsKPXrTuwR5RPJTjonABE3zM9tHfJE+W0AoeqqXw5vHT/JQcgpG+0ieaiS7k8wJsX7gLhd9w/T7NPQNgqqyvMcxTIvA0a8IyEeFRoSnq9oQj09N+33JxRrS2+fRjX9Djb1cetu3mqykR7v+sSrRqpfsmc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T1EnJFaa; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T1EnJFaa"
Received: from github.com (hubbernetes-node-2835a54.va3-iad.github.net [10.48.200.31])
	by smtp.github.com (Postfix) with ESMTPA id 5D37E4E08B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 13:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765402693;
	bh=fjhdw3Q6cjp6v9GFDSyiBAhc8kW1h7+e2P+2eTHSMTQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T1EnJFaadBwAioRxmnrlRbMbKRxBPliVOCSpVqIZzfD7Qe1/+Suc6U5bUpHK7QQp8
	 rMbd4Plcb6nWAX9ryrpA4wL3gOwvs9ABbLf+mDEUV0HgQ9QU+Jc9ZO4PPwyy2Rx4si
	 qd3CPmEQ8bvkqhtELg8/YG64iz4XmB1PW7GQcxhA=
Date: Wed, 10 Dec 2025 13:38:13 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/359390-fa6f1e@github.com>
Subject: [bluez/bluez] fa6f1e: unit: reduce macro expansion volume
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
  Commit: fa6f1e942cee11765b12c572086c4034f3173e0a
      https://github.com/bluez/bluez/commit/fa6f1e942cee11765b12c572086c4034f3173e0a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-10 (Wed, 10 Dec 2025)

  Changed paths:
    M unit/test-bap.c
    M unit/test-bass.c
    M unit/test-gmap.c
    M unit/test-micp.c
    M unit/test-tmap.c
    M unit/test-vcp.c

  Log Message:
  -----------
  unit: reduce macro expansion volume

define_test() in some of unit tests expands the long command sequences
three times.

Make it expand only once.

This reduces preprocessor output e.g. for test-bap.c from 23 Mb to 5 Mb,
for faster compilation.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
