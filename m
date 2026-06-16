Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2F345757
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612393; cv=none; b=B14nXOVa5iZAqKEeRxIRXbsdW/aZ0ieYM/cPM+se8xApdO+VFXqPnEXwXuA1ikKMY7g7ZWbFXj5bQKuGL1rEFwbVmrz+GwLZQjd7sQhw9H9ztj9twX9w/kuEG9rOV2U08Yc0cvHoWf2iqytZ0u/1OSG+jSa04/hPxR3xgTPoyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612393; c=relaxed/simple;
	bh=w3YEWe6+KwTC7+dBT6YZSbgDWKDODFgI9QSujDk10Wk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qBT4ACoOb72wCAZFmv+UmZXdwXMJhU1nqj1OflYTo/AE83z699hZ8D5RYiXfDBvLpMNUZDNtEYfLmHv1LPJYVqHS2TfM4Q5wB+dujuBC5YQzreUDLTjxuJzZM+N80HeZ+GaiJWg2I8J8K4Y47aIH2FQVf+s3bxf3fei2HDcULDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=j/Rw4oYb; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="j/Rw4oYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781612391;
	bh=gClBhwvIbp1cHPBZXuVvd6NEk101NilfISWbYF5pmTo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j/Rw4oYbRPZ0G+shDZ9qTDUMjyazU3B8IaDBQMQB3Gl+S0nbq5U7flL0BciZuRUAq
	 ZbySVyGcwggZQHYJxRskM8dx3tvhuhD8ie2pCLiz64REOM12N0zEBBB+z6OgDTq1Hw
	 +pPerNShr/tjBIGOkEjWYTeFl75aibN8hG+V4oWo=
Received: from github.com (hubbernetes-node-3e494ce.ac4-iad.github.net [10.52.210.53])
	by smtp.github.com (Postfix) with ESMTPA id 90457941170
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 05:19:51 -0700 (PDT)
Date: Tue, 16 Jun 2026 05:19:51 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1112111/000000-d8e60b@github.com>
Subject: [bluez/bluez] 654362: shared: rap: Check role before sending CS Sec
 Enab...
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

  Branch: refs/heads/1112111
  Home:   https://github.com/bluez/bluez
  Commit: 654362f5880156fdf3467baf04bbab7407477be4
      https://github.com/bluez/bluez/commit/654362f5880156fdf3467baf04bbab7407477be4
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-16 (Tue, 16 Jun 2026)

  Changed paths:
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: Check role before sending CS Sec Enable cmd

Add the is_central parameter to verify whether
the local role is central before sending
the HCI CS Security Enable command.


  Commit: e98e534dcc27c8861a626cb5968da391c29246aa
      https://github.com/bluez/bluez/commit/e98e534dcc27c8861a626cb5968da391c29246aa
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-16 (Tue, 16 Jun 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: ranging: Add CS Initiator cmd and evt handling

Introduce support for LE Channel Sounding (CS)
ranging procedures in the Initiator role by enabling
required HCI command sequencing and event handling.

Add handling of core HCI LE CS commands and events
This enables cs capability discovery, cs configuration
management and execution of CS ranging procedures
in the Initiator role.


  Commit: d8e60b357ae7e770262746b47809bb8ac6a21368
      https://github.com/bluez/bluez/commit/d8e60b357ae7e770262746b47809bb8ac6a21368
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-16 (Tue, 16 Jun 2026)

  Changed paths:
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: remove the old wrapper API

Replace API bt_rap_set_conn_handle with
bt_rap_set_conn_hndl which has extra parameter
to avoid compilation error for individual patches


Compare: https://github.com/bluez/bluez/compare/654362f58801%5E...d8e60b357ae7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
