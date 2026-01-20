Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE1314B97
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925927; cv=none; b=XcLYAPcb5W3KpNItHAHk/4SotFBe1dx7yXiKBWqAtrIGxNqkHx71Hgn/qH4qT9Dmh4MrvmCPuyDt0xoEiOjcAvBjgsBALwmD4Hrl0WWHpTWcJeF2/9ZRsE3GEk5Kr4g8/bkU6EIiLMYS6reXgQ68eem+nTibM/1UmCuDc+S+7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925927; c=relaxed/simple;
	bh=khTuFZBX8YyFLdbm+ng/9n585szFREbkxoZmi1lT0jM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W7KVqCsmN0GFODJ5XtgahGCVflW7XcuFkyxfslWdLQ/l6smEcr8lrJELz43UDz1xhNR1lQa+Mw2FjzQ2inRPLmOG350/AwqYEULEKFDsPGNT4PWP+SRIV3zOh2B/8kmM9pAWla+DZm+EC7EOYlBJIOqg3Zx8aBeGOK6vLriV0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ftjvc+/3; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ftjvc+/3"
Received: from github.com (hubbernetes-node-0b24f29.va3-iad.github.net [10.48.142.32])
	by smtp.github.com (Postfix) with ESMTPA id DB3ADE052A
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768925924;
	bh=iAe45YWJSW/VNoLQBJF0F5+nGNqFHll6hxPUxzHa2Nc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ftjvc+/3oPyyVOG/pQckoqVAwtSLKhRpQhDAprNWoBeBYOLpMMc5dTrdndvngITJG
	 0pp7Ld2CrLA+f248qKpGc+f9KVeSXuX6d4zFeYTrM+8Am1GU1hSLkDYH/V8RCmnte3
	 SCGfiG/bLtBGt+XSQLadry6x0VBCwUlJ+LshQm+g=
Date: Tue, 20 Jan 2026 08:18:44 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1044766/000000-f2670a@github.com>
Subject: [bluez/bluez] 9334f6: doc: Port assigned-numbers.txt to RST
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

  Branch: refs/heads/1044766
  Home:   https://github.com/bluez/bluez
  Commit: 9334f6d98de7f10f824ee4258885da4a002d8878
      https://github.com/bluez/bluez/commit/9334f6d98de7f10f824ee4258885da4a002d8878
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    M Makefile.am
    A doc/assigned-numbers.rst
    R doc/assigned-numbers.txt

  Log Message:
  -----------
  doc: Port assigned-numbers.txt to RST


  Commit: 4f9bde09a62a004b7fd6706534e21436ce77a1dd
      https://github.com/bluez/bluez/commit/4f9bde09a62a004b7fd6706534e21436ce77a1dd
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Thermometer.rst
    A doc/org.bluez.ThermometerManager.rst
    A doc/org.bluez.ThermometerWatcher.rst
    R doc/thermometer-api.txt

  Log Message:
  -----------
  doc: Port thermometer-api.txt to RST


  Commit: 5acbb4eb07b2b422a0c2dfd7b1d598082f957bdf
      https://github.com/bluez/bluez/commit/5acbb4eb07b2b422a0c2dfd7b1d598082f957bdf
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    A doc/security-bugs.rst
    R doc/security-bugs.txt

  Log Message:
  -----------
  doc: Port security-bugs.txt to RST


  Commit: 7f3bb461b16db8ab744e3f7ecd7d3cfde7678a0f
      https://github.com/bluez/bluez/commit/7f3bb461b16db8ab744e3f7ecd7d3cfde7678a0f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    A doc/coding-style.rst
    R doc/coding-style.txt

  Log Message:
  -----------
  doc: Port coding-style.txt to RST


  Commit: b23fbf7f857917e5499bd135c8f3ad2423a59af7
      https://github.com/bluez/bluez/commit/b23fbf7f857917e5499bd135c8f3ad2423a59af7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.SimAccess.rst
    R doc/sap-api.txt

  Log Message:
  -----------
  doc: Port sap-api.txt to RST


  Commit: ba7d2a37c023c39f25ee412f8fa2c98aa2dfcd0d
      https://github.com/bluez/bluez/commit/ba7d2a37c023c39f25ee412f8fa2c98aa2dfcd0d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    A doc/maintainer-guidelines.rst
    R doc/maintainer-guidelines.txt

  Log Message:
  -----------
  doc: Port maintainer-guidelines.txt to RST


  Commit: f2670a54379a15d0be1c3f9e8299306e7195e8dc
      https://github.com/bluez/bluez/commit/f2670a54379a15d0be1c3f9e8299306e7195e8dc
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    M Makefile.am
    R doc/health-api.txt
    A doc/org.bluez.HealthChannel.rst
    A doc/org.bluez.HealthDevice.rst
    A doc/org.bluez.HealthManager.rst

  Log Message:
  -----------
  doc: Port health-api.txt to RST


Compare: https://github.com/bluez/bluez/compare/9334f6d98de7%5E...f2670a54379a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
