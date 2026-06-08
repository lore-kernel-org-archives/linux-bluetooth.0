Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B148AE33
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930563; cv=none; b=fggsyiy1EeG8IGj/wAX6b2pZSxCMgE64m/ReCsNFsGerUXTI/7yS3luEiUNy0EbMVm2xLrCf6heNflyuSsN5jAH9IleAdKmWZ8RmUkU+rlHDs+HauG+fDU/yomZmvdYU9B97AyhSETxNDnatYnmRlX8flDlkiZ04qALM6pKhvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930563; c=relaxed/simple;
	bh=XilazAHJ3i8osHx3/tHk5ouyJnwODcBJa0yUKsgIuc8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PwI9ElbcoCwgBdJ1EMtkhIiWgVeRYLdr08Gb2TMVepw6dpIRaUO5fiUVsfQBuOqsnGJydNwxJVVBPCjLEpIHY/BmqidxrPVsOUu0sf7usXMEjonFFdmZdq2q8xLIihe4/fn1whYymHROlwn5glExa26IH3iGs5XiXgsfoR1UP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TTxwu5Xf; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TTxwu5Xf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780930557;
	bh=e+987KdDTXmkJ1g7QYCrtWLdSj4p3x4HCLRUEnfxP8g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TTxwu5Xf0me5GEMvZ0cXpF/Dv+JiUa4zoy7PuT+eHaVbiCKowwEwYOCeOZyoHQ5zG
	 BM9CjJcyAt2OoHzOy69xuy5qwEJD669cqgC0Qul2CdQNVAVX8tsliv7ASHJVMFdAuk
	 GwaopXD3j0GJG24zm13LWj8yk05vjyDUe0V1ONUE=
Received: from github.com (hubbernetes-node-5b74c88.ash1-iad.github.net [10.56.207.92])
	by smtp.github.com (Postfix) with ESMTPA id 5BA3D5212B3
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 07:55:57 -0700 (PDT)
Date: Mon, 08 Jun 2026 07:55:57 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107894/000000-19245b@github.com>
Subject: [bluez/bluez] 19245b: gatt-client: Add PreferredNotifyType property
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

  Branch: refs/heads/1107894
  Home:   https://github.com/bluez/bluez
  Commit: 19245b27a229da41b4c5f417dc544bbf2f87b46b
      https://github.com/bluez/bluez/commit/19245b27a229da41b4c5f417dc544bbf2f87b46b
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M doc/org.bluez.GattCharacteristic.rst
    M src/gatt-client.c
    M src/shared/gatt-client.c
    M src/shared/gatt-client.h

  Log Message:
  -----------
  gatt-client: Add PreferredNotifyType property

When a characteristic supports both notifications and indications the
CCC we always register for notifications, leaving no way to choose
indications from D-Bus.

Add PreferredNotifyType (string, "notification"/"indication") to
org.bluez.GattCharacteristic1, only present when both flags are set.
StartNotify() and AcquireNotify() honor it on the next CCC write.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
