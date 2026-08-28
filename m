Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE23F1059
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787952654; cv=none; b=kUEgp1cHlachA98Yibl3yMoMzvS20GxqquVAZVQHJw++s5/KWjWzEK5vTRRvRcmmYRHBZKajJIAuXr7E7nGHkahoUeybVRSSN9+OLP5Ih3nm4KmOtgk+ig8NZv0R9dcI4jl8fM6bHR7F85Y1JClhdjtz2j/UW4o+ptbiH8GY4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787952654; c=relaxed/simple;
	bh=ob1pgNMSQ+4KmecWnny/UpzYiQwZdMgQncuZvROUHgc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aZvwviYP8M1kD9FHuAGTvcmpU4FC2p+v+hu2V5bJwZ5EaMV07V28sEyWaCp9GCcufuVtO+zg0tR9/98KpbzFh9vfDRrCU0YygrM2cjHuyFORiOPlEdcAb6i2ahm0VXDKzNabsdLrXOI1y1lW2jIm5U8SAd3exniMrHm0GoycSuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=b/Zs3KQ4; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="b/Zs3KQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787952652;
	bh=f6tB2qYD4ijpAMEpJ0/Rizz32rkdWI7TY2ZDeMxurgk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=b/Zs3KQ4eeW6xQq8lPe69Zw0m2QBVacYHtgQhnlaLCnb/7bwrDHdAw0OFV51ps9e3
	 JTr9cVetsgl187wNRyMCv84srNFWdAU729OHeyr2UCBWvjWnYX8YMjF9vXYawn0nnX
	 yfoybvo8wzP2Pq2v/AcB4rtl4QzSSGfYL8QfU0UQ=
Received: from github.com (hubbernetes-node-0ad3c60.ash1-iad.github.net [10.56.225.73])
	by smtp.github.com (Postfix) with ESMTPA id A69AC525BDE
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 14:30:52 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:30:52 -0700
From: timsweetman1 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1153435/000000-234e82@github.com>
Subject: [bluez/bluez] 234e82: client: Handle system bus setup failure
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

  Branch: refs/heads/1153435
  Home:   https://github.com/bluez/bluez
  Commit: 234e82dea04cd1153ff2f5aca3d6cc4ef7db7c03
      https://github.com/bluez/bluez/commit/234e82dea04cd1153ff2f5aca3d6cc4ef7db7c03
  Author: Tim Sweetman <agenttimblog@gmail.com>
  Date:   2026-08-28 (Fri, 28 Aug 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Handle system bus setup failure

g_dbus_setup_bus() returns NULL when it cannot connect to the system
bus. bluetoothctl currently passes that NULL connection to
g_dbus_attach_object_manager(), causing libdbus to abort on its
connection assertion.

Initialize a DBusError, report the connection failure, and exit cleanly
before using the connection.

Fixes: https://github.com/bluez/bluez/issues/2446



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
