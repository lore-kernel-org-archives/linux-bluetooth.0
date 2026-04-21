Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA7382F34
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772224; cv=none; b=ImugHBepHp6nvTXyDDXzhfwYo4Xe3mCqIXUj3PhJYb+RDHwlLIyjm5O5EWwGpKKYS/STV3trJ0mr5jzE5SURggWDCgVr77JLi1c269n8apLOIeIbkrgqiCjvwvce0IVJ+KRxdoBR8z3LkEDOvhN3OkFX/jTCBG03uofaPbxMqi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772224; c=relaxed/simple;
	bh=s1Cga8gPNtruAu1oPSy5EYtWSjKLd0B/2hCFgXyQ3AQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RJWq2w9JRc7ifzm8/OSGii1APYE0/kocQaCCcrC/vHMoJeR13zR8XOVr1m301FRyKD+PONaqzlaaU0CZr5L/d96zRLMhIzusr93oo+Grr7J8GbpaqSjeG7Frdex9d5K7yrb01dF3vwB8dMppD9GY0YI3ydm6ob0JQXBWKC2+TI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=esAZbgub; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="esAZbgub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776772221;
	bh=jYrPgL8pbDQkvImz08kB2UHTJLHIAxkmHRO/15YB+Ag=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=esAZbgub/2L6UN6qymiq+aXSqlqHZoxJ9qyu4ckn3pZPpyLqFalOtYNPc+dK9tLAQ
	 Rd//Y3SroPIx+tUCqnQ3r+lanWGB3eWCTUTBdX2DY2SiFSmiEiX6CBWAvRfL3DsyED
	 xj8x9HUDIeWNTvWTdSJIKev1YSfmPpSXaxz03b0c=
Received: from github.com (hubbernetes-node-d5bdc35.ac4-iad.github.net [10.52.125.76])
	by smtp.github.com (Postfix) with ESMTPA id 84D4D9411CA
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 04:50:21 -0700 (PDT)
Date: Tue, 21 Apr 2026 04:50:21 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1083806/000000-5cb819@github.com>
Subject: [bluez/bluez] 3b599e: shared: rap: Introduce Channel Sounding HCI raw
 in...
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

  Branch: refs/heads/1083806
  Home:   https://github.com/bluez/bluez
  Commit: 3b599e808aa76bee41658e90ceceb46636d6f373
      https://github.com/bluez/bluez/commit/3b599e808aa76bee41658e90ceceb46636d6f373
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-21 (Tue, 21 Apr 2026)

  Changed paths:
    M src/shared/hci.c
    M src/shared/hci.h
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: Introduce Channel Sounding HCI raw interface support

Implement stub callbacks for Channel Sounding HCI events and add the
required protocol definitions for CS configuration, procedure control,
and subevent result parsing

Add data structures to support Channel Sounding Processing
Add helper function to get hci conn info list and integrate it with RAP


  Commit: c8de4adb4137872a6b22a847aaf0bb4ecb744668
      https://github.com/bluez/bluez/commit/c8de4adb4137872a6b22a847aaf0bb4ecb744668
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-21 (Tue, 21 Apr 2026)

  Changed paths:
    M src/bluetooth.service.in
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add Channel Sounding config parsing support

Add support for parsing Channel Sounding (CS) configuration options
from the configuration file.

Add CAP_NET_RAW to CapabilityBoundingSet in bluetooth.service.
bluetoothd requires CAP_NET_RAW to receive and process HCI LE events
when running under a constrained systemd capability bounding set


  Commit: 5cb819540263d9f47994769490d015a9267b83d2
      https://github.com/bluez/bluez/commit/5cb819540263d9f47994769490d015a9267b83d2
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-21 (Tue, 21 Apr 2026)

  Changed paths:
    M Makefile.plugins
    M profiles/ranging/rap.c
    A profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: ranging: Add HCI LE Event Handling in Reflector role

Open RAW HCI Channel for CS Event Handling
Parse the following HCI LE CS Events in reflector role
and route the events to RAP Profile.
 1. HCI_EVT_LE_CS_READ_RMT_SUPP_CAP_COMPLETE
 2. HCI_EVT_LE_CS_CONFIG_COMPLETE
 3. HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE
 4. HCI_EVT_LE_CS_PROCEDURE_ENABLE_COMPLETE
 5. HCI_EVT_LE_CS_SUBEVENT_RESULT
 6. HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE
Send HCI_OP_LE_CS_SET_DEFAULT_SETTINGS to the controller
with default settings selected by the user.
Map connection handle received to device connection


Compare: https://github.com/bluez/bluez/compare/3b599e808aa7%5E...5cb819540263

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
