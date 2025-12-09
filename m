Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1971DF25F
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294849; cv=none; b=h401MtNBJW10Yj1uFIaVpT8j0tnkbcSouZewK0DzqT0E/l7aXtnxB83ZYi95dP6jzivwGtc9EviBa5z9o0cWf3MtsR09uun9emLMBDz4nyScgHSx66MJbFPly6wzqQUMs2r1uiDcdAA2kZNaA4LBKNdRMtAiqjMDGSBmmCG4Wl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294849; c=relaxed/simple;
	bh=YTp9zXxGqaaD51OX3xVH1hI3qr3B3biA6iukScTCGPI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nEWfPdtR5gzEoIWjUnjLyBurAy4Lbfnb5R+pPVEqetyQGGCe4ReXuWBlE2VOVmDGbaXnIHJ1eonmYXrKUFjSQ9W4lSZUKM6M6LGs5WXewfYDNFiWFTn8NND0i2ft/plLvq1mX988Xwcghh4kMST9G9v9G5jTzjGQd2pdFIvcwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mGmVVrW+; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mGmVVrW+"
Received: from github.com (hubbernetes-node-d89bf7d.ac4-iad.github.net [10.52.173.33])
	by smtp.github.com (Postfix) with ESMTPA id 96CAE6411CC
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765294847;
	bh=+o8A+Qa4KQ6aGwFppRgDe8OCVewFt6/FGGKkOqpYOJQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mGmVVrW+4rBFevIHAVPHjFrxAe9vidzy07BRr6hlqcewzWuPIx/iJHlkZKmWqEx8I
	 IgXUR9glVhBe+nKLtovwv8mbVPtitRTG97e3Cqav+/fczy3ClBVJou3RljuANydgdy
	 SFeEU6a37KXDOwRmAdY9xg8J04CgDI2NEXMaF4PY=
Date: Tue, 09 Dec 2025 07:40:47 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f1bcd8-359390@github.com>
Subject: [bluez/bluez] 359390: monitor: show ISO timestamps and fix their
 handling
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 359390c60d9b1817470925eecd3cb9dcf1de5390
      https://github.com/bluez/bluez/commit/359390c60d9b1817470925eecd3cb9dcf1de5390
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-09 (Tue, 09 Dec 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: show ISO timestamps and fix their handling

Fix ISO packet size checks, taking timestamp presence into account.

Also display timestamp value if present.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
