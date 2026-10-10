Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851E533D6
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645637; cv=none; b=uyWMofRq9AqBD//80LPH6QcBHOEwt2/TrUDVDSKTvoFccjdnLeUYuJYMrAp3fG7UofL6nctlWogSJFFO/qexEEDn9xLpzB+rOqKxWFk7mZ2aC9Rts8+fRB4mIid8cZCoPuh0yFErfFa1/289GNh1+tiPmEBxaCuG/wwnPq7gmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645637; c=relaxed/simple;
	bh=f+t8zvhtPN0E6tgneIPnsDBjd/nZkrjSA6iX0MTlbr0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eYrJ+b+DVMlHEFCNn+5MoYtOzrLTF8HIorh3QKk2IMqx2iubQjx4/f2IELiWBC0byFvnzSk+lnk7YqTxVTdAAB7StHzr+xZUFWVV1ysJGVcFvf6hUG00zWkW7qgqeXkBTgBAibuBobqowxuAsgg6zkH+lH7+3g8Ntt+aB2dD0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=ElgHtsLN; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ElgHtsLN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791645635;
	bh=FxD1UgqEp197SO/uBRB09MV0BbHv1swqFqdQUmCPoDU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ElgHtsLN4vZdQMV5ljbKKZNijdj+HKNwnU94oQQ+vebEoXkqpd1D8oXVrxqefW6nV
	 xkviQSrV0qbvuQ0YLAy1xUaAb13lhw2Sa7mwUx4uw5cR8grZAQqU4m8fWAS9gUrg3g
	 iLwy5PuvydD44eRrAVwYlz01G42WkXvOsNgGmpzGG8vVQotnndLY9IIT0ZfjNmGtL1
	 QzfZ0VR9pfNk/eilFgIMAiGvFFpD5QJqGlkoECj0pdeXWj83FinDXazOJ7Uzn3K1t1
	 pOpWfs93DQ7FTQ/6KtzBfUYzvLR7vMi41wT0XEhvPqXY+eNZ1O37nqaBACaaCqGvqG
	 e5NMOdHPK4u7Q==
Received: from github.com (hubbernetes-node-eacbc53.ash1-iad.github.net [10.59.88.30])
	by smtp.github.com (Postfix) with ESMTPA id B60BD840259
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 08:20:35 -0700 (PDT)
Date: Sat, 10 Oct 2026 08:20:35 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182943/000000-dd49fc@github.com>
Subject: [bluez/bluez] dd49fc: unit: test-rap: disable optimization to speed
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

  Branch: refs/heads/1182943
  Home:   https://github.com/bluez/bluez
  Commit: dd49fc17c7497f5218ccf36f02e5e2d9911c7a96
      https://github.com/bluez/bluez/commit/dd49fc17c7497f5218ccf36f02e5e2d9911c7a96
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-10-10 (Sat, 10 Oct 2026)

  Changed paths:
    M unit/test-rap.c

  Log Message:
  -----------
  unit: test-rap: disable optimization to speed up compilation

Compilation of this file with optimization takes 4 minutes with ASAN.
Disable optimization to reduce to 2 sec.

autoconf puts global -O2 in CFLAGS that cannot be overridden eg. with
unit_test_bap_CFLAGS. Use pragma instead.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
