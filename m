Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2961917F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697679; cv=none; b=V7EEQy6yMZT944InPBhyoP1El5KuelMgM1f2wH3G+nD/OJkanj6JrB/YgDIUv9NM6ZT9XHvu6dVkrL0fgT+wdexhTgfeXOgPrLqx5eXl7Zxorn9ewICzHXZNDVOErfWm5l6d7vB+aw7L6Me/mdfTab25PYGPOS+PCixFJH00450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697679; c=relaxed/simple;
	bh=MDWipffC2VS9+vGo4GWRzvLcKKEhoLA4LqCZ7+GWcj8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kIncbmwKWYGQaWOW72NUjFauAqmTx4q0CdObAs6Z/pgkQ6u10nz5F2kz8+v7qW8BgnhoTEdkIPT5pKQ0BdZz2O68aVbrhS9U5RyRDb9HvE+GBlhvLTH8T1hrEfH2AcwxfqRj5+MbEzglV62rvR8i9BKk/urFGMsKEBGv+Ro16fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZlonZGgX; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZlonZGgX"
Received: from github.com (hubbernetes-node-82d639a.ash1-iad.github.net [10.56.192.49])
	by smtp.github.com (Postfix) with ESMTPA id A59FC141073
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755697676;
	bh=sN4H1YdWP0VZmfZGZ77XsxFfgpvYM48/rVXTTdBanKU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZlonZGgXGqbMyDNklNCQAoF2A1APYsoY+9K6fVt1A/Fn2OBWAUnqtaxtXqrI+7YTV
	 AfU5/DjPhWUDGVZkYsBhoXmhQDT0bspifxZsr+hy6s0s8TPzDyQrKGp4MDNGlYgfmv
	 bHEy2nfVcF75okKSRdufZnbWQegAUSyQkk04CSnY=
Date: Wed, 20 Aug 2025 06:47:56 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/993518/000000-0fff08@github.com>
Subject: [bluez/bluez] c11c05: shared/hfp: Add HF SLC connection function
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/993518
  Home:   https://github.com/bluez/bluez
  Commit: c11c0555997b834e5eedef4bf78378acbe254f62
      https://github.com/bluez/bluez/commit/c11c0555997b834e5eedef4bf7837=
8acbe254f62
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add HF SLC connection function

This implements the minimal SLC connection exchange, i.e. AT+BRSF,
AT+CIND=3D?, AT+CIND? and AT+CMER=3D3,0,0,1 requested to complete the
Service Level Connection Establishment.


  Commit: 619e7f78a20fbb3e515e3f294abc65c86892384e
      https://github.com/bluez/bluez/commit/619e7f78a20fbb3e515e3f294abc6=
5c86892384e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add SLC connection test

This adds minimal packet exchange to test the SLC establishment.


  Commit: 6e269585d1da171aea02ff442a8be91d579373f5
      https://github.com/bluez/bluez/commit/6e269585d1da171aea02ff442a8be=
91d579373f5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M src/shared/hfp.c

  Log Message:
  -----------
  shared/hfp: Add +CIEV event support

Register +CIEV handler on SLC completion to call the update_indicator
call back on unsolicited events.


  Commit: 0fff08f962ffcd04bd6044ffa476b9867c229580
      https://github.com/bluez/bluez/commit/0fff08f962ffcd04bd6044ffa476b=
9867c229580
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add indicators tests for HF

This adds the following tests:
- /HFP/HF/TRS/BV-01-C
  Verify that  the HF accepts the registration status indication.
- /HFP/HF/PSI/BV-01-C
  Verify that the HF successfully receives the signal strength status of
  the AG.
- /HFP/HF/PSI/BV-02-C
  Verify that the HF successfully receives the roaming status of the AG.
- /HFP/HF/PSI/BV-03-C
  Verify that the HF successfully receives the battery level status of
  the AG.


Compare: https://github.com/bluez/bluez/compare/c11c0555997b%5E...0fff08f=
962ff

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
