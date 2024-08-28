Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A71AAE29
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870332; cv=none; b=JcdqKIh5YsvoHC9F5TM2AGzbyR+93gAE/0ZgC7TXLgVpvnFn43T5vh549+PNORWu4hM0I5O6029B/oNGk8kM4jL0MH1FCT5QQUC+fY4Abotr1/7RNCYZzzk78hwURUzYEcgjNGMEpARCgTosS/hXueJzjzNDwhZtKro+AjWfUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870332; c=relaxed/simple;
	bh=geDBCrJA1G5D2slGfQoKZ+kul2QB1YYIvYRQPCIXLSM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AfW2seSnC80Ulg/I7lZ+lH/O7soJ5oMApx29jOzJWnhp35WBv7NYiPEsmfAKdcL7IfMEY5PkF6Zf5O9cy1P4X24R+teO8RP2bA9rKsgOh8JELgivVcD/gfUVTgcmDN/ejr8mYbhFjCZWzx2Q1pRCkLmFvRedP0j3Enka6fXI3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZdWWIC1W; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZdWWIC1W"
Received: from github.com (hubbernetes-node-91932c9.ac4-iad.github.net [10.52.134.20])
	by smtp.github.com (Postfix) with ESMTPA id 3595C6412A1
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1724870330;
	bh=4EPtiiim4JBzeEKh3Oue7GLLb+6L8R6BUwvX+mAZQCU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZdWWIC1W+KatxbV8YHit7t24J3A8x0X+irI6CXr4zaweBWHk9qwm0F/8s2Z+11XhG
	 KMBnUlTtx2kOgMb92bfcz1ByXonuhCSCBWxTUdCtf3J6hsFQfT3ftOE4nteELeg++W
	 s3omWOk5HnbYbPjZ5F8vRNgaHNBE1lz/uvfRnUuU=
Date: Wed, 28 Aug 2024 11:38:50 -0700
From: xiaoyao <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4ed706-32a081@github.com>
Subject: [bluez/bluez] 366a8c: adapter: Fix up address type when loading keys
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
  Commit: 366a8c522b648f47147de4852c5c030d69b916b3
      https://github.com/bluez/bluez/commit/366a8c522b648f47147de4852c5c030d69b916b3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-28 (Wed, 28 Aug 2024)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix up address type when loading keys

Due to kernel change 59b047bc9808
("Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE")
some keys maybe store using the wrong/invalid address type as per MGMT
API, so this attempts to fix them up.

Fixes: https://github.com/bluez/bluez/issues/875


  Commit: d6515f4ca7d4134af5c277945d140742deda498b
      https://github.com/bluez/bluez/commit/d6515f4ca7d4134af5c277945d140742deda498b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-28 (Wed, 28 Aug 2024)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  Revert "adapter: Fix link key address type for old kernels"

This reverts commit 7ad5669402c9acff8e4cc808edc12a41df36654e since it no
longer possible to have the wrong address type being loaded as they fix
up in place when that happens.


  Commit: 32a0811685c5dd290f1152bef2dfbde3b2848446
      https://github.com/bluez/bluez/commit/32a0811685c5dd290f1152bef2dfbde3b2848446
  Author: Felix Qin <xiaoyao@rock-chips.com>
  Date:   2024-08-28 (Wed, 28 Aug 2024)

  Changed paths:
    M src/shared/att.c

  Log Message:
  -----------
  att: Correctly handle negative return values in can_write_data


Compare: https://github.com/bluez/bluez/compare/4ed7060ca9df...32a0811685c5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
