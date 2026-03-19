Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E133F589
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920974; cv=none; b=L1TPp6DGLoGcl5QdS3WfoXMPVHa+MusRHeyQa/IenX72DgTTwqR2CHob7aDTgDxBM7abKvnItoTGdWURuCCiFmNWTQWVxCtqY/E1/MY8sQyqxFShdN/EHl1ey92dNpR1FFBQwc5jq2Z0aGq+uWdgQzXmk5BZB1/YgtRCQI3/zW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920974; c=relaxed/simple;
	bh=y87gQ1l4hsul9Sa1g80eX8oaG4aa+H7IY/QyddmwMY8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=apw0i5u7h0636BSgLDTe1IA+evraNeI5I+bNJEjqzUdowxAYLtOwB0FWGNhjXPvMuMJdcJNUMQV1FwXB6ctxTidvUBagguAkBSY+jTcqQFohRwFPvHrqIIerWZWT56hUuEd7QHetvjKy6aznAERLbM7XnO/xd3NrC4V16zh0Osg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hbm0rtrT; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hbm0rtrT"
Received: from github.com (hubbernetes-node-ac6b7f7.va3-iad.github.net [10.51.90.37])
	by smtp.github.com (Postfix) with ESMTPA id C124C9211DF
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 04:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773920972;
	bh=a/tlGCY7fiQ9FkSC6mXhop4H3EsNLAymN5ZaoPAcqtc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hbm0rtrTGfDZ6KZsILB5PBURR3Ul2v3HRrkrV+FSILfCQcdoiPGCcO+Vbqk10QRvr
	 qtC8oXKtB0pzT2J2ojZfELOcW/fdrCWU5iZGwqM7rYYLV/NjDTd3MY6Dr66XI9ED8F
	 QQe7D3JshOLkGMQJQFjPQlsP8k3GHlXAjMkwZrgY=
Date: Thu, 19 Mar 2026 04:49:32 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1069215/000000-46937f@github.com>
Subject: [bluez/bluez] 46937f: adapter: Fix "Failed to set default system
 config"...
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

  Branch: refs/heads/1069215
  Home:   https://github.com/bluez/bluez
  Commit: 46937fd52f67f7a9dca9fd1cc367dabb4f029715
      https://github.com/bluez/bluez/commit/46937fd52f67f7a9dca9fd1cc367dabb4f029715
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-19 (Thu, 19 Mar 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix "Failed to set default system config" startup warning

When using a stock configuration, there will be nothing in the list of
configuration changes to apply to the Bluetooth adapter, which since
5e5b46c5c0cc ("adapter: Do not send empty default system parameter
list") would throw an error, as sending an empty list to the adapter
didn't generate one.

bluetoothd[3291147]: Bluetooth daemon 5.86
bluetoothd[3291147]: Starting SDP server
bluetoothd[3291147]: Using external plugins is not officially supported.
bluetoothd[3291147]: Consider upstreaming your plugins into the BlueZ project.
bluetoothd[3291147]: Bluetooth management interface 1.23 initialized
bluetoothd[3291147]: Battery Provider Manager created
bluetoothd[3291147]: Failed to set default system config for hci0

Fixes: 5e5b46c5c0cc ("adapter: Do not send empty default system parameter list")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
