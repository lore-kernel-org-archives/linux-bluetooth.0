Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C951779A5
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973892; cv=none; b=QXwGmAREIFGwSfrSlYdkXSxjVPYa29KkAXyIq3dxuzmyV03xAAvHnwnHYNYg+HkVrSKbsiogzZ2coaWA5n5ZYLU1SsrSNdQWzIwp6OvpDxEf9BIxdd6B+Csd+DMVAuo/A1qSqKHeX9O/PiXHhVClnnyuc8xhP9kumtoJWZr5qAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973892; c=relaxed/simple;
	bh=mCFa3j4A3iw50thVhE0IhpgxjaDcey5i7pTaEVQY2HQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hWb5jdYcjYyWm6DxnlunqIiRarNznvvVxtIqgLR9TyZZ1Fy3T+X4f90tbn+3MAfHJejLby5J+S+f9dAC+0pZyX0yuhLlG2exOGEG+0CN9cOghOSkOsIxq5R8t68m684MhRqZkUb49CZNUdKEi0hQGzfacSJ41V/ZIz455BFI2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZRYnLl7B; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZRYnLl7B"
Received: from github.com (hubbernetes-node-5f207d0.ash1-iad.github.net [10.56.163.38])
	by smtp.github.com (Postfix) with ESMTPA id B72076C1004
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1727973890;
	bh=nSaKSmJm5w4pVHL4uprBCL1nJjLraq2qLjD5smhymtM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZRYnLl7BCzalZxPgCQObRApuAkIexg7R6OZkd+7j3nliGI940uoAYDSbO3HW7M32v
	 0COw8SpsJdPkO4f/sH1k9XvoWEiIpRxZ/uLH9TGOGFpltA0XWNsXE9gwlEydix2/pu
	 uSQs4I+VzERBhPDQlME984TFzU+YYD3BL85DPVPQ=
Date: Thu, 03 Oct 2024 09:44:50 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/38734e-8146d8@github.com>
Subject: [bluez/bluez] 43bd13: client: Add Broadcast Assistant/Scan Delegator
 scr...
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
  Commit: 43bd13f7c70072cb1be62350424d25d7675f500b
      https://github.com/bluez/bluez/commit/43bd13f7c70072cb1be62350424d25d7675f500b
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-03 (Thu, 03 Oct 2024)

  Changed paths:
    A client/scripts/broadcast-assistant.bt
    A client/scripts/scan-delegator.bt

  Log Message:
  -----------
  client: Add Broadcast Assistant/Scan Delegator scripts

This adds sample bluetoothctl scripts for the Broadcast
Assistant/Scan Delegator scenarios.

A test setup can be created using these 2 scripts and the
broadcast-source.bt script: The Broadcast Assistant connects
to the Scan Delegator and sends information about a broadcast
stream.


  Commit: 8146d8f7dd675d7b0f8e997f39add23b1cc4e578
      https://github.com/bluez/bluez/commit/8146d8f7dd675d7b0f8e997f39add23b1cc4e578
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-03 (Thu, 03 Oct 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix load of misaligned address error

This fixes the "load of misaligned address" error that appears when
parsing PAC caps:

src/shared/bap.c:6497:7: runtime error: load of misaligned address
0x502000063639 for type 'uint16_t', which requires 2 byte alignment

0x502000063639: note: pointer points here
 02 03 05  04 1a 00 f0 00 02 03 01  02 11 00 00 08 00 00 00  a3 00 00
              ^                        00 00 00 00 00  01 00 00 00 01

src/shared/bap.c:6498:7: runtime error: load of misaligned address
0x502000063639 for type 'uint16_t', which requires 2 byte alignment

0x502000063639: note: pointer points here
 02 03 05  04 1a 00 f0 00 02 03 01  02 11 00 00 08 00 00 00  a3 00 00
              ^                        00 00 00 00 00  01 00 00 00 01


Compare: https://github.com/bluez/bluez/compare/38734e020513...8146d8f7dd67

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
