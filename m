Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980481A9F90
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771604428; cv=none; b=iNmuHRKsOrglkScX+RApIudTM87EJRqXR4jpeL7JqV2PYJhQrboCUMwNCtQUbAPNq7padDj+QVvAcfsZPvJMgM6PGZhxbWSIxszRP+JwaFddqU9MTOpYQJClQXaK/yKbBkO+wmNz7a9ecfsLBQbIcIX2kRqW/r8dXPod8Eg0H20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771604428; c=relaxed/simple;
	bh=yXRwUHekmKzZrVxTQIzdLheaQQav4niTVQ9Ppac9mEA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jkn+kex0aXpCkN2iMbloBRfDtQLlC5LWGx/faxulznG604qaa4PeujTKGck8bMVArpFaXs66wUcbVvLDyeFkZIxucrIcBdMiFibXoNXPWdkKOHHT/Bjlnxz9FgSnJ4iITDmVxSX/fiic6F/UV6fgRzWT1wPjHYYe6wn9oBRd3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DtuMPmKE; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DtuMPmKE"
Received: from github.com (hubbernetes-node-e4c9d5a.ac4-iad.github.net [10.52.155.46])
	by smtp.github.com (Postfix) with ESMTPA id A7AC864139E
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 08:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771604426;
	bh=PyiHs1kA5/Bd7+Osf2MmAMpsS//IZLzcMUA4z3X4AUI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DtuMPmKENho0pttDkBZk89nAx3a5ajco41SIgcRJ/c/Vy1FPhed1ASUt+mAZtFyUZ
	 rR4KnTrcbaZyvwE1UV0x4j5xfLGqDOGspzN+xNqd551t7x72QXWc1iDbhMdKQzMQPv
	 nENM9uWsBuzRk2Qx6y8Z2MLq4/DMqvbU853XRQEM=
Date: Fri, 20 Feb 2026 08:20:26 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055952/000000-d954f7@github.com>
Subject: [bluez/bluez] d954f7: shared/bap: Fix endpoint configuration
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

  Branch: refs/heads/1055952
  Home:   https://github.com/bluez/bluez
  Commit: d954f76b75ba5bd99f31b9574c6e14e3ecff62a0
      https://github.com/bluez/bluez/commit/d954f76b75ba5bd99f31b9574c6e1=
4e3ecff62a0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-20 (Fri, 20 Feb 2026)

  Changed paths:
    M profiles/audio/media.c
    M src/shared/bap.c
    M src/shared/bap.h
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Fix endpoint configuration

When a first local endpoint is created after connection to a remote
device this doesn't trigger the SelectProperties request because
bt_bap_bac ops are not yet set when bt_bap_select() is called.
Creating a second local endpoint allows to trigger SelectProperties
request for the first endpoint.

This commit fixes this behavior by setting the ops during bt_bap_pac
creation.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
