Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F0238C3B
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963108; cv=none; b=bEOptSX8IGgMNrKTqBtQVg2nS64jZZPIkFIxnH9le9ipfS9gOY9HB8UCONeKpda3JicIOROItxjOidXcQhdGBNzlXELIwi3VGbrWiu8iV0cefUHcnLA2LDxPmzxmJEhyvoRtBY63Tb7Ai/kpJHfSXtGwDIqomPhHCOaKAC/9Ntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963108; c=relaxed/simple;
	bh=7QkYv0MSv8pU4oisYI/T8sYrG6/bTwt+TDd8tVFjAoE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JB1lfHFQdPyvL4QSG4KeWqh+c62asK+GsLMBzqq5l0PYavrVdFjuvmJFF42Tjwcs6LBFRC1sjK9Qr7FYvl1MpIjSDEH4mBoJon/U/ywIWVZG1WlxJQ9zCN2HcXLBetRsUay1V/b3ib0JwtJApAcLQObOGefXuxsWy8r6UbgmTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mxud8vkx; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mxud8vkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776963106;
	bh=vt2VUcWRusBBMNhtf21uIWY8/Me3G5wLkzw8xR1Tg7g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mxud8vkxKGsipAcl+pH1byWrJ4yGzHRHWpbYq4WBoXnkuh/D3SGlt2H/mst85fy5Z
	 j1QuTMmCLxHaNxEQI9X43ZBSI49r+mb4HObsgZfAfYl88lATQJvf5sHuSAMLjnYY+8
	 0pG4TlB0aPBTCbOtqxeLpREtOa2zqSRxlz8Lpvvs=
Received: from github.com (hubbernetes-node-828152d.ash1-iad.github.net [10.56.212.70])
	by smtp.github.com (Postfix) with ESMTPA id AFECF366898
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 09:51:46 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:51:46 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2c3961-bc87ee@github.com>
Subject: [bluez/bluez] 928f2b: Add permissions for btsnoop-analyzer workflow
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
  Commit: 928f2b28c1c743a42802bacf8a341d25000147a8
      https://github.com/bluez/bluez/commit/928f2b28c1c743a42802bacf8a341d25000147a8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-22 (Wed, 22 Apr 2026)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  Add permissions for btsnoop-analyzer workflow

Grant issues:write, contents:read, and models:read so the reusable
workflow can post comments and access the GitHub Models API via
actions/ai-inference. No secrets need to be forwarded.


  Commit: d9da103fd1a23fca3cae5166fb170846919c1835
      https://github.com/bluez/bluez/commit/d9da103fd1a23fca3cae5166fb170846919c1835
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-23 (Thu, 23 Apr 2026)

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


  Commit: 55262e1a2ccf2eea18207abe5fdc1428d4aae345
      https://github.com/bluez/bluez/commit/55262e1a2ccf2eea18207abe5fdc1428d4aae345
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-23 (Thu, 23 Apr 2026)

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


  Commit: 868b9e3745dcb7b99a00222c055ea5464e3be283
      https://github.com/bluez/bluez/commit/868b9e3745dcb7b99a00222c055ea5464e3be283
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-23 (Thu, 23 Apr 2026)

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


  Commit: bc87ee6b0c56cb0405e70271e4210a2560838c8b
      https://github.com/bluez/bluez/commit/bc87ee6b0c56cb0405e70271e4210a2560838c8b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-23 (Thu, 23 Apr 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  rap: Cleanup coding style and unnecessary code


Compare: https://github.com/bluez/bluez/compare/2c3961e3b0fa...bc87ee6b0c56

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
