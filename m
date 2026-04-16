Received: from out-37.smtp.github.com (out-37.smtp.github.com [192.30.252.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A63612C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 05:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318711; cv=none; b=SiAxM1qJPQdzdJ1qN2jQ7q83CnF+6T35RvmMcBxO7xw0NWjz+6nylkphhlhp9xDDwu/zdaIthc/qXiugKpg93umO38araDGqiMUSzSOPN7YZ1bCD0b0C4G1eP0ZMd20jQTm4OAsDLKVge2ZbPcF6iq4lKU9dNkbAPnN6Fgy80p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318711; c=relaxed/simple;
	bh=J/npKfSCAh3q0t1H6U6CE+kF+5EsjPZAjVEcguNUxgU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=obO0E/fxaC5zt7bIdKdmdL27JhBp8KPRF5XKBpzOLl3lAnf78plYe1qre0Ob5PvBuTNE6LHrwLasEryD5MagVck3TDkbhIGYEO5ib4tlgTeGWGqJQgRkslFtDje6kxQPItxMHrJNofBwYT52iO2h0kSL+s46upWwcT9DR40roKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ahihhHda; arc=none smtp.client-ip=192.30.252.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ahihhHda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776318709;
	bh=jhu2eAvC0XeljfdX61hQHFhFuNPS7Cu1pD8AfFXD9ME=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ahihhHdaWTNQ3zROV0j88actLfIqKNGkCPgZVyhc+qL6/6Wm5TgXEmwCvS/SkpFGs
	 WK14/1lwppDzwinoRrlW+KqGQQS4vzWPKmY/EkVuYfGXkRgNzYojyt7wH87ZmzfrPi
	 kL6VsC/pMkqtHFUw4foLfOVBWjwsf6a2lHGmc7X4=
Received: from github.com (hubbernetes-node-9ce4de4.ash1-iad.github.net [10.56.209.82])
	by smtp.github.com (Postfix) with ESMTPA id 248FF921094
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 22:51:49 -0700 (PDT)
Date: Wed, 15 Apr 2026 22:51:49 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081856/000000-d638df@github.com>
Subject: [bluez/bluez] 04d7e2: shared: rap: Introduce Channel Sounding HCI raw
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

  Branch: refs/heads/1081856
  Home:   https://github.com/bluez/bluez
  Commit: 04d7e2a44fdfb1d3ee8a9e4efc3818490a1e5cf5
      https://github.com/bluez/bluez/commit/04d7e2a44fdfb1d3ee8a9e4efc3818490a1e5cf5
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

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


  Commit: 74942f9365c3d2231d4081c7e3bf03c7d97ce9b6
      https://github.com/bluez/bluez/commit/74942f9365c3d2231d4081c7e3bf03c7d97ce9b6
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

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


  Commit: d638df8cc7fb1787a44cb9eda6bee9749190c7c8
      https://github.com/bluez/bluez/commit/d638df8cc7fb1787a44cb9eda6bee9749190c7c8
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

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


Compare: https://github.com/bluez/bluez/compare/04d7e2a44fdf%5E...d638df8cc7fb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
