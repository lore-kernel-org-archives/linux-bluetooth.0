Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A864A07
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778112134; cv=none; b=DvRhmK4bE91Ak4X0/uVELTLv74sT4ZfSJP6KRhPzFiL3t1Hs7qVthdXpJWBRNeSQ2/xV0h/jdGqlgGRzVrcA5CSPJUS+/cFmz3xDOm9MSP8162DTL8JDW25YGLOW9v/7fv0TlRt15fa3MPmRMxzuoQUd+9KhxQRLF88psNoFQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778112134; c=relaxed/simple;
	bh=CDHbjuB17iquk7KwJGyY+E4puH28GneeNaEW/dBtTs8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jq3/mjVPolfmF+vVOZhu75jyANyrvGSU/15XQkQgMKT3eofF8tZCfXgfGnYgmR4tT0CG2uyMPOCZDuBUEZzUMrJ1iw5Ao9ArQGLjG8ZWbQVwdP9IxPMlr256kQahW+dUlxeKF8nrQH51FKVoDU872QhB6D1A1IOfcDQ+bzka21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X+b9e9Tt; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X+b9e9Tt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778112131;
	bh=XpQl6VYj1eifX6aXuaqK0IkM2u2rkdJeQehP6VKN5bk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X+b9e9Ttrcf+EA1tmyortwoQTaRJ1CbFRzw4rDS7TnHOpN/9/eh6ElwEYnTQP8+oE
	 0IgKhKjn3SEWn8nX3aO86e/+KegAFCHmVMRywMu/9LIovBIWH0+pGAFKbsSeBR6gJ5
	 HJFODnZ3FE8SPn0KDYox+WXWaO/WXVvMrAgKBlNg=
Received: from github.com (hubbernetes-node-13e1d46.va3-iad.github.net [10.48.219.59])
	by smtp.github.com (Postfix) with ESMTPA id DDD4A340B6B
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 17:02:11 -0700 (PDT)
Date: Wed, 06 May 2026 17:02:11 -0700
From: qarnet <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090721/000000-67706c@github.com>
Subject: [bluez/bluez] 67706c: bap: Fix typo in QoS D-Bus dictionary entry
 names
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

  Branch: refs/heads/1090721
  Home:   https://github.com/bluez/bluez
  Commit: 67706c7563c90ddffb9b642f4a77143670b362c4
      https://github.com/bluez/bluez/commit/67706c7563c90ddffb9b642f4a77143670b362c4
  Author: Thomas Kirschner <thomaskirschner85@yahoo.de>
  Date:   2026-05-07 (Thu, 07 May 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix typo in QoS D-Bus dictionary entry names

MinimumDelay and PreferredMinimumDelay had wrong spelling, causing
them to be exposed incorrectly over D-Bus. Any client relying on
the correct spelling would fail to find these entries, breaking
LE Audio QoS negotiation.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
