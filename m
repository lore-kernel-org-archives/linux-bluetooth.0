Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81082DF14B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534780; cv=none; b=UTszOrV5Az/Vwd5vVbcaN9Q+eQ59d2InmzIuJcgEcYb2tbN5gtFeSf/Yj5/+Tak6QbY0fUDGLWAJTQkBbwKQyWOrAnaou2R8tIbXtQEv4UZJyLYBio7pvoC47EYJZSiuqng4BagPI8Wrid0+ItdIq6BnzJV/k11CHqrVgXpVMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534780; c=relaxed/simple;
	bh=/QZqX3V00q0vl10yZu3RgtjjwNQ4oxBvQdezKYkRCdw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OGbG5deU/y72ECGYlxKc1uS0zxtWRHJ2z743PWJj+4MturrRZD/V8IFuLRutRuV9/PnhYnKtZ7PvcieoCo9aACD48Nllb8H/yv2/ikTlNNihD/iWi20+VEQTNk5mDDQjbyubCzl1MGSKqWZiRHSZFxrgR9Oy8gl5OgkGtMSO3lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kMQ/rzLP; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kMQ/rzLP"
Received: from github.com (hubbernetes-node-ccff0d4.ac4-iad.github.net [10.52.165.16])
	by smtp.github.com (Postfix) with ESMTPA id 21C5464071B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769534778;
	bh=URYLMLXCn1C9JtYIxQqJMcv6Gc59Ey8FF9BTeICBBwc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kMQ/rzLPzHIEqOE4LDF5pOsEKjWZWYc+tq/GVmFRHRs+y2SzFcp5om+c/YcGkoG5l
	 YVQaJ+L4puv56KkSTLmFmEvXenZo3CaEjmO/Nluxlr/L8OqeYA/2QWhdgZCNctv6uX
	 t3hZu+6JNTbQgh7VVqXg6tYThrtUorzoCD+nlTJo=
Date: Tue, 27 Jan 2026 09:26:18 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047693/000000-26cf2d@github.com>
Subject: [bluez/bluez] 26cf2d: doc/qualification: Add PICS and howto for the
 AVRC...
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

  Branch: refs/heads/1047693
  Home:   https://github.com/bluez/bluez
  Commit: 26cf2d013bea4912d0357517fd94402540888e8c
      https://github.com/bluez/bluez/commit/26cf2d013bea4912d0357517fd944=
02540888e8c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/avrcp-pics.rst
    A doc/qualification/avrcp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the AVRCP qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
