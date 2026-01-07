Received: from o7.sgmail.github.com (o7.sgmail.github.com [167.89.101.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB628285C8D
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.101.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776640; cv=none; b=Zxc+BW1S5+1GhSr1MH4Sk5KJGM3f80p+Bk2cUdGyo4Ow/+RF7lE1ewcokV40CmEzHyIDhqcfbGFKIZIIOGMGfO+NhNrPm56Rl8M7v3BjH7ksI0Xtee3kJFgz2wGNLKjzEkH3XuKhpdeZKZbo2klYuTTJIIJNlHSBykLC95mEAzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776640; c=relaxed/simple;
	bh=Pvu3TY/1Z1NejXDFW85Y1FTeUHJLzHpB8Lm7FLRKITw=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=JQzy+Er3BPl52vzWK99fI6tfBfy+Zfb/foDYcRXhWhg/2kIx2QppAjNPuWMWvij3EmCzOx5rBe7lE1dkpoMQzMHOMIAD54gTlB56QTlFB/mwfp892y7bPs+C3NmNS68LNR0e9Se/xGcvX1GJdiKExD9AFX/C+0PpKTrnAGsejjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MLQTlgAD; arc=none smtp.client-ip=167.89.101.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MLQTlgAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=O+cyMBAYFBfXm54t845PHdT6oFESNaIGdpCwjWxzIgU=;
	b=MLQTlgADBSzCFPCn7FlcgI9lYAqwHT1aPhlNWJe1jEHcGWgQr2gj6HuxtCZV9jPLxiwJ
	xtcEGYCyON3NMMeEJYY3102YDG+bXR+7vllUif5e8HeW6v7oy+aGtHZnuZV7ldVzC13ZTY
	IB1waBTv43Y1HtijACa2jyv/QR3rugK9s=
Received: by recvd-874656597-vhgq4 with SMTP id recvd-874656597-vhgq4-1-695E217D-6A
	2026-01-07 09:03:57.944418697 +0000 UTC m=+1767180.653616592
Received: from out-22.smtp.github.com (unknown)
	by geopod-ismtpd-62 (SG)
	with ESMTP id bopWbwHCQMazLT9dGmY-6A
	for <linux-bluetooth@vger.kernel.org>;
	Wed, 07 Jan 2026 09:03:57.890 +0000 (UTC)
Received: from github.com (hubbernetes-node-acf3dfe.ac4-iad.github.net [10.52.211.38])
	by smtp.github.com (Postfix) with ESMTPA id 8818C21037
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 01:03:51 -0800 (PST)
Date: Wed, 07 Jan 2026 09:03:57 +0000 (UTC)
From: "github-actions[bot]" <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1039291/000000-31b82c@github.com>
Subject: [bluez/bluez] b495ad: adapter: add MGMT_EV_EXT_ADV_SID_CHANGED mgmt
 event
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2EOmaFr=2F1UU=2FZnDLH7OeuCdRX0CsxIfcrGHCrZFU+6memyJLWEfoVOzRRry?=
 =?us-ascii?Q?oaLUMWT5aK+P15stzHrMb2=2Fq5PF2q8ST+3DpYgR?=
 =?us-ascii?Q?Gbd9G1lmyhWpgFzsnpr1RMei06rdRl5xQEaAP1B?=
 =?us-ascii?Q?YHZbWhSRTzu2ZwVpZhDpz9ZgEiYlyHprHQC6FK+?=
 =?us-ascii?Q?xw2GqZOmMym7La4aBMBbl0LNFD48zaEO2mZ+eP0?=
 =?us-ascii?Q?5nxrCS=2Fpj5pa=2FW5OotKBnSL+i+bKt1oMTKU=2F9NC?=
 =?us-ascii?Q?HV2PxxbOBLx3pgsz2uMxbnTUKg=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1039291
  Home:   https://github.com/bluez/bluez
  Commit: b495ad25ed257bdbe1fe4f10ad6e146430664841
      https://github.com/bluez/bluez/commit/b495ad25ed257bdbe1fe4f10ad6e146430664841
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2026-01-07 (Wed, 07 Jan 2026)

  Changed paths:
    M lib/bluetooth/mgmt.h
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  adapter: add MGMT_EV_EXT_ADV_SID_CHANGED mgmt event

Add the MGMT_EV_EXT_ADV_SID_CHANGED mgmt event to notify userspace
of SID updates for extended advertising.

Signed-off-by: Yang Li <yang.li@amlogic.com>


  Commit: 31b82c0d7a368771770814be96ec68db42406812
      https://github.com/bluez/bluez/commit/31b82c0d7a368771770814be96ec68db42406812
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2026-01-07 (Wed, 07 Jan 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: add timer to wait for SID update before PA sync

Add a timer to wait for the SID to become valid before triggering
PA sync. Once the SID is available, PA sync is initiated accordingly.

Fixes: https://github.com/bluez/bluez/issues/1758

Signed-off-by: Yang Li <yang.li@amlogic.com>


Compare: https://github.com/bluez/bluez/compare/b495ad25ed25%5E...31b82c0d7a36

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
