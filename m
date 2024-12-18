Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1E1B424F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532815; cv=none; b=paANOkz/EZO9nW6RFE4r+tPS2ZjvTi/1JJI1Sick2SO0aRt9zLgIVsT8n0pFo4VxNQgfCbEcKqXagYSO0J+zCmrLSJ/Oig0N1m8lX+2znpPdjiFKVQFh/hYluKbt5/7eMuN1guHdZ5o3OcPFy7odi1Xwz9D+lmGzqQZYXImQ7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532815; c=relaxed/simple;
	bh=XMJVxzUf50fPyi7syGkMUfvD7oVEYKpAP/aiDeGl3+M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ms0Kv3Q1Be63hWF/XXekbV/GekvgngdqiIupGllTS4XictPZh0N8bdL+yFsNRhqK3EbLQqXNqiIo4+BdmnyLa2f8CObBz02dwhibBc8ojmA39/me+soQvOv1sYNcPgVsoxcGQfGNdhWiSXP0iVt+AuIkfAhIHbIhWlXl/t9QKus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mbD1KkxP; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mbD1KkxP"
Received: from github.com (hubbernetes-node-4ae5255.va3-iad.github.net [10.48.222.11])
	by smtp.github.com (Postfix) with ESMTPA id 72C878C03E7
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2024 06:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1734532813;
	bh=Zj445Fjdr5GLdHu5xbuRIN1w0x+CKmiI/fn8oN62QFM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mbD1KkxPyEXiKYNU+1FYcRcgZ41jiSGH7r8A1xvkAEmtMP6RcLjQTNmE8/ekAMo/L
	 rEwCnZmgWePH271NoMgP4Mseg69DviMh1dgH9AakxhkaAROK4Lg6JhaylQL8EwPwNs
	 bxarlbxSbzkYs10iKBVYbTUOC3cJ9lF2QQaPLdJg=
Date: Wed, 18 Dec 2024 06:40:13 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c2caa2-dfb1ff@github.com>
Subject: [bluez/bluez] c0fb6c: client: Add command wake
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
  Commit: c0fb6c067e48e1c867d2447a275253bea4d7ec40
      https://github.com/bluez/bluez/commit/c0fb6c067e48e1c867d2447a275253bea4d7ec40
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-17 (Tue, 17 Dec 2024)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Add command wake

This adds command wake which can be used to set WakeAllowed property:

[bluetoothctl]> wake XX:XX:XX:XX:XX:XX off
[bluetoothctl]> Changing wake off succeeded
[bluetoothctl]> [CHG] Device XX:XX:XX:XX:XX:XX WakeAllowed: no
[bluetoothctl]> wake XX:XX:XX:XX:XX:XX on
[bluetoothctl]> Changing wake on succeeded
[bluetoothctl]> [CHG] Device XX:XX:XX:XX:XX:XX WakeAllowed: yes
[bluetoothctl]> wake XX:XX:XX:XX:XX:XX


  Commit: dfb1ffdc95a00bc06d81a75c11ab5ad2e24d37bf
      https://github.com/bluez/bluez/commit/dfb1ffdc95a00bc06d81a75c11ab5ad2e24d37bf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-12-17 (Tue, 17 Dec 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix not being able to set WakeAllowed

Setting WakeAllowed was not working as intended since
device_set_wake_override was changing the current_flags which
btd_device_flags_changed checks to determine if flags has been changed
to only then call device_set_wake_allowed_complete.

Fixes: https://github.com/bluez/bluez/issues/1045


Compare: https://github.com/bluez/bluez/compare/c2caa26a4d62...dfb1ffdc95a0

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
