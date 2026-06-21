Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915653C07A
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782052659; cv=none; b=cVkgY8oOOSqDsJw7JeKwn+zzmSO7s+CqsJw4eR2KszIkpzVlrhsVp1G+EJVPTGCQfafQewUgHykKI/AnYXGYEUlXRh3iOGQkQ9XXvzms/+Ec8pHzoknwNdGDw/eojj04hyqmi46+fGm5Wm54pQYFg9lCzHAaIxJvawiGQvlwOhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782052659; c=relaxed/simple;
	bh=6k9Qg3SndkyNFUp6f7waH8tnlUX322gY5oKDZp9Bbnk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sUKTG3Fi8Qugv0IQFFZ/6pUYGsSAKj0RfTX2wtPC18jUj1vvx3BAByZQL5ZJk+sg4ZwaysHp91vLU8eAMpvSpoZCR/ZjU07M4AAIwo80MpSx4XxXQ/T3vWYUhEgwkh6DlXqcQeWXHT4U1FUkxRpoZYkN5Mftbnni1rQxT8qa4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eUzjm+ve; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eUzjm+ve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782052657;
	bh=oSIzVVU9UYJALkbksKfzNugb8eVZwOaF63xyzKar8UU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eUzjm+veOZb1H+Vpi+mZhoxB5Q10pCSw2agoCLqfsYCBd0E25GZTJBjwvXyfbiKPO
	 we83GfG8hGV52NXY+KF293/+wXXta7lEe2rHgrBIF5NytWZht+SNbLucpulu3Q6mVw
	 i8ptgBRbyT65d8YIWjgKWuRD8I593vuMIo2t1eXs=
Received: from github.com (hubbernetes-node-fc8dbb3.va3-iad.github.net [10.48.177.36])
	by smtp.github.com (Postfix) with ESMTPA id EB69C28049D
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 07:37:37 -0700 (PDT)
Date: Sun, 21 Jun 2026 07:37:37 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114334/000000-d6996f@github.com>
Subject: [bluez/bluez] d6996f: unit: test-bap: disable optimization to speed
 up c...
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

  Branch: refs/heads/1114334
  Home:   https://github.com/bluez/bluez
  Commit: d6996fb9bdcdf329c692eed1461e7515fcd5e05d
      https://github.com/bluez/bluez/commit/d6996fb9bdcdf329c692eed1461e7515fcd5e05d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-21 (Sun, 21 Jun 2026)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  unit: test-bap: disable optimization to speed up compilation

Compilation of this file with optimization takes 12 min with ASAN, 1 min
without.  This is too long, and the -O2 doesn't serve purpose for unit
tests.

Disable optimization to reduce to 30 sec with ASAN (5 sec without).

autoconf puts global -O2 in CFLAGS that cannot be overridden eg. with
unit_test_bap_CFLAGS. Use pragma instead.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
