Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7635B653
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815561; cv=none; b=EQkRMiRVTHzjoOJUO03tMZiS4yZYn09RMR4ZhBt+/Yusdf7P9qsZIGIggdEhtd5yCR3dLhnT+guSdAEdP4rtTWRls39K+w3AxsI0QJH8hfJ/whsOiRAkYQoUw7w3OKYOMcWu66qr2gkmcRQGKLjyFfQcKi5vltshj8gxPrI7Qco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815561; c=relaxed/simple;
	bh=8lO6VPVoCFMmpHk4+iomPQtcmTrEzhbDQnapsIdNPpE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PyW8lETNYg/Zmhe8ILWmP5Yyid8MpT4RAIiAnaSm40r3FHpYEJgqV/E9I/hf5qVrO1XecinBCWKZIT0MdGrRICjUw0hihamPo9EPCqnYVzRlii+Fs5ghmcSnLOKutTQDSS93TNRQ0XEDx1j7vjWp86QzCGjCjwn8iQ/4zZAeiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YxKkn1wB; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YxKkn1wB"
Received: from github.com (hubbernetes-node-997b209.ash1-iad.github.net [10.56.173.22])
	by smtp.github.com (Postfix) with ESMTPA id E628C1406BF
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775815558;
	bh=kMPYP+6bO3KoVeSqe3+dA2xZnkAL4NLKb7CzYCDaT5s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YxKkn1wBbP42HttQD4UVkmv/jLTEsv8cImYVP7xw+UX9ZBLIRwN8Bo7tC4NRVRvcG
	 G1bgzYU8cnF/02aO11MXyMdfxsl/NNLx1wlMpE/S/94jDo8Tw2bWkLNm64AyZTB5G/
	 kh+6wK3TaW53WcJhI0MlvqhO9sa4ESC25fjcE89Q=
Date: Fri, 10 Apr 2026 03:05:58 -0700
From: caitao123456789 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1079646/000000-b32f3e@github.com>
Subject: [bluez/bluez] b32f3e: src/device: Add ConnectedUUIDs property
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

  Branch: refs/heads/1079646
  Home:   https://github.com/bluez/bluez
  Commit: b32f3ea8e6f88b8477270ffbbe9e1dceed223316
      https://github.com/bluez/bluez/commit/b32f3ea8e6f88b8477270ffbbe9e1dceed223316
  Author: caitao <caitao@kylinos.cn>
  Date:   2026-04-10 (Fri, 10 Apr 2026)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c

  Log Message:
  -----------
  src/device: Add ConnectedUUIDs property

Add a new D-Bus property "ConnectedUUIDs" (array of strings, read-only)
to the org.bluez.Device interface. This property tracks the UUIDs of
profiles that are currently connected on the device.

The property is updated dynamically when a service state changes to
CONNECTED or DISCONNECTED.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
