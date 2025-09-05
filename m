Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85FAB640
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082662; cv=none; b=uHXQoEFKx80NPQXVoX3tssOXkOcKUgOo1yzB0dkMin4lo5FqX8zT3+lqT8C0ae8FzqTl4bYv4p2USEoQF2Uh8zPfMr9rzmSlgLAKPqmn/IQENU1mQabXLhGdqanOCK2L7+ZaTExChL9T15EU7kdV5RgsZ6PPNkHqVcBS50iXtLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082662; c=relaxed/simple;
	bh=tl1JspAWiqkqrVNZ/etlns//5WNUrQ+S1GV6gq7NkUk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=m0X7ztLmflGqKfxPYvCza4M3gLxAx4wkW/vP9/zNTABCutoMj9y/rscqMI7c5o4NqBBjtJKLiLn5expP9W8zEogM7TV/s1p25iPlESAx5gAmh4rhruJRWD5ujnXTLUDIrsYiq46pSsph9tSqWqCqjQjjAJSPYOhNwuKK4jXn12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=g0eBQgsu; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="g0eBQgsu"
Received: from github.com (hubbernetes-node-03b79b8.ac4-iad.github.net [10.52.178.35])
	by smtp.github.com (Postfix) with ESMTPA id 88239700C70
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757082659;
	bh=maVvkyVavNq4iLx1sdvsqfG03lA3Br3hGWxR5tPZYmk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=g0eBQgsu05VioyWZ6LzzfhdTfsP01EMi4W8MELrMDu1DUPG3xUQMzDCEUIOUhJR0H
	 neyB8HzG1XQWiRpOh16ydda0+iV48V6yd+7/XVdSlQ0aqCRjJ+k1QgDTOTl4H10zAb
	 hHpSQywkdq+KRDP6q1DvlvilAtW+81ch/2Gy+qcU=
Date: Fri, 05 Sep 2025 07:30:59 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/999363/000000-3b8e21@github.com>
Subject: [bluez/bluez] 3b8e21: unit/test-hfp: Fix MINIMAL_SLC_SESSION
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

  Branch: refs/heads/999363
  Home:   https://github.com/bluez/bluez
  Commit: 3b8e2122fefef1dfe2e0af660e678638f72126da
      https://github.com/bluez/bluez/commit/3b8e2122fefef1dfe2e0af660e678=
638f72126da
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-05 (Fri, 05 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Fix MINIMAL_SLC_SESSION

Fix missing commas in +CIND reply.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
