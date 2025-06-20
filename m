Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7601928033D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411266; cv=none; b=oU/8xKo6kPMEwcKmtBi4OWvYT6UeyWQAblipM1VIqifPQTBmrUkCNpmL7SVv0vrjentDaJZqZlr1P/a3roUJsTNp2UxOZe+JV1OBROSV2RFXVZ9AVW9ICJ0vcR9wjhbGscnh2ZKKPZ0CkKKe5LpfYawiSrg9wWiZZELX3h6WX9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411266; c=relaxed/simple;
	bh=u7Ed4pZE0snwXaZjC0N0CMgO7zE25Kg8xnT7h4M0imI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Td1N98EY+szOIixc7XX4iMHhzxPwKhRWMhq9oJsU1hanPwwr6erOoXjDGQi+MUnJqM9XZ7OwEURdsEYQyhDRR8BZed8MX8lAhF2T52JCAyQTUyZ5vkJgbut0cPItMG5YotiHISecbbrYsrfKDVIX9LM2EwM1FekRsVyZkygpNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lrbALSBB; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lrbALSBB"
Received: from github.com (hubbernetes-node-a138743.va3-iad.github.net [10.48.149.33])
	by smtp.github.com (Postfix) with ESMTPA id 801248C039A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750411264;
	bh=QWW43yTKHy4t2cBWIDgPnT6q01Bi6JoSSHCG9XzxOOY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lrbALSBBru+Wlt5ey5HZmHwPQrKdq4eIxKB3Z6CqFbdSUCuNi7IbBxAL7B1nFa7G/
	 zvYsZO7hmyDUpcmZdaWMXNPXpOhNT9wAv+3ISUzpnqqKUKj+FrHnEDDhnWDa08YIhG
	 vyfIrblKEn7nP2/L1uftL1TihTGFSdFQ4v+0boXc=
Date: Fri, 20 Jun 2025 02:21:04 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974152/000000-70b054@github.com>
Subject: [bluez/bluez] 70b054: bap: don't pass in stream's own metadata to
 enable()
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

  Branch: refs/heads/974152
  Home:   https://github.com/bluez/bluez
  Commit: 70b0544f4f015b83fef9ffe53e078a53b6d145c5
      https://github.com/bluez/bluez/commit/70b0544f4f015b83fef9ffe53e078a53b6d145c5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  bap: don't pass in stream's own metadata to enable()

Stream owned metadata pointers may be invalidated in bt_bap_stream
operations.  Callers should make copies and not rely on details of their
invalidation semantics.

Fixes:

ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x7b86a76f5d18 thread T0
    #0 0x000000836745 in util_iov_dup src/shared/util.c:353
    #1 0x0000008ea96b in bap_stream_metadata src/shared/bap.c:1991
    #2 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072
    #3 0x0000009226e7 in bt_bap_stream_enable src/shared/bap.c:6392
    #4 0x00000044037d in transport_bap_resume profiles/audio/transport.c:1981
freed by thread T0 here:
    #0 0x7f66a92e5bcb in free.part.0 (/lib64/libasan.so.8+0xe5bcb)
    #1 0x000000837002 in util_iov_free src/shared/util.c:392
    #2 0x0000008ea94e in bap_stream_metadata src/shared/bap.c:1990
    #3 0x0000008ebfbe in bap_ucast_enable src/shared/bap.c:2072



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
