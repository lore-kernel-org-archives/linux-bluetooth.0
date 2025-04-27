Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E38F9D9
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745771891; cv=none; b=Hl40XhY3IKFCCg99gGYMr7ax+7v2HM4kxDrgzISoxmI/9rQcD2iDk5xw24jI6Jjx3BPiItlYSN/aIHn1T80PD1FnspQKDIqHJI4WS74S4GBTXZEJ9gkPfBNr290DdsOD026kwKDj15Dq6H/nJBH2tmaoViVI7LzFO8TTReYF3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745771891; c=relaxed/simple;
	bh=gDBMSGprEVkaS4/Lhp63aOUyzAX3fkLkumP7SR0MQpE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HZiPGWbJ1yjXgFefJv24KFLa6F4Ra6mY3dDChCEdRMD4OALWsruzK2L+HOQ631LElqnFvHpcsNFS88DEvJSZ49ItoIXHPUy6S+Asx2OuZHP61PuR483AxyFAufQIkqyBJj0bqT1/JiT+FL8b1R8umt7TZDdAC3ZO1GoWas4NVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OJZxtGET; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OJZxtGET"
Received: from github.com (hubbernetes-node-2628f34.ash1-iad.github.net [10.56.158.33])
	by smtp.github.com (Postfix) with ESMTPA id 9C49C600342
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745771889;
	bh=I7QLEk2ZRPXDx6t2u8IhBKkBx3mlqRjgdRSsbJmvfPo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OJZxtGET9HodJLHJ+Wk6TQe9FMV+DbBZom61mTmUh/IuTh7kBdUcFWPUixX8zvspi
	 lvRK3e7v+6KkwAqJb3H+GDf//3pYXuvQGLVd9Z13td5+Vd17PFU937xWS1hMbBR6nX
	 lIYTe/mEaORT/zmoAE5WEMWPU4zLB1lk098jktyU=
Date: Sun, 27 Apr 2025 09:38:09 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957508/000000-7dd5f5@github.com>
Subject: [bluez/bluez] bfac9e: org.bluez.Media: add SupportedFeatures
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

  Branch: refs/heads/957508
  Home:   https://github.com/bluez/bluez
  Commit: bfac9ed35ad8bfa96782ed271816e7a8f9a868b6
      https://github.com/bluez/bluez/commit/bfac9ed35ad8bfa96782ed271816e7a8f9a868b6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-27 (Sun, 27 Apr 2025)

  Changed paths:
    M doc/org.bluez.Media.rst

  Log Message:
  -----------
  org.bluez.Media: add SupportedFeatures

Add SupportedFeatures property for feature information that applications
cannot find otherwise.

Add feature tx-timestamping. Applications cannot enable it on old BlueZ
versions without that feature, as it requires special handling on BlueZ
side.


  Commit: 7dd5f5ffdaddf89728aaa571e32aaa8b201f6d4e
      https://github.com/bluez/bluez/commit/7dd5f5ffdaddf89728aaa571e32aaa8b201f6d4e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-27 (Sun, 27 Apr 2025)

  Changed paths:
    M profiles/audio/media.c
    M src/adapter.h

  Log Message:
  -----------
  media: implement SupportedFeatures property

Add org.bluez.Media.SupportedFeatures. Add feature tx-timestamping.


Compare: https://github.com/bluez/bluez/compare/bfac9ed35ad8%5E...7dd5f5ffdadd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
