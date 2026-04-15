Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055AD373C04
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273664; cv=none; b=pzyzQlk4sl1fFgb/cCKxKlA0Ks/E9eMBhZ5crs0u8lCz2XJDocRZhrBhKqyJQqtZ+1JaBm3WDbQie7ddPhSkJEPDJOE17NlEUUAWOFzDfHYcaWDI0tRrkDcQFywyb/IBsxYeyp7gQKg2jvmawJw5UweawG8TDxP29C7+WUA7bJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273664; c=relaxed/simple;
	bh=ML0FVNS/EAoi7Vs9IjMYPgTkyBGELwsRZSaKOMPpyeE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IP5L8HKbOrVBbPhDBDnj/WXPueldFZgIX2qGHn1I1UiSe+qNydfDWG7AxCO2gS68rLIBu+/Rfm+WR332ISAczljz5ceCtYH1CcluAwPZ3YlVRGD0W3kBkRV2y7eA+chDUToV1Kla07VuA1TksXTX7jUUrNWeFBqab3xWIIJ9mkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HWYaiGtJ; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HWYaiGtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776273662;
	bh=NkVBWgtLlaPSgPUL6k0TKlrH6Xn7ZxLZo1d2+3I1ABY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HWYaiGtJhd9z0fvjeTDv0Hu/2WknPuhtdCxidP3edW0RIbs9ANd1xYJFNP66VPHnl
	 hET3qM0Q4YU7Zmkl7A4kKHIAUop8rtPEfhd9eS3zQ1561JKWuB/lwzLbeNYoLTQDMn
	 8DRuPG3UxhvxylC7I2ywi2EUwEt9TQtXXmQL9Rj4=
Received: from github.com (hubbernetes-node-384b8b9.ac4-iad.github.net [10.52.86.26])
	by smtp.github.com (Postfix) with ESMTPA id 2D3E99410C3
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 10:21:02 -0700 (PDT)
Date: Wed, 15 Apr 2026 10:21:02 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081668/000000-fc2f64@github.com>
Subject: [bluez/bluez] 89b207: shared: rap: Introduce Channel Sounding HCI raw
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

  Branch: refs/heads/1081668
  Home:   https://github.com/bluez/bluez
  Commit: 89b207a44dce45103bac2afec5856c666a6a6c70
      https://github.com/bluez/bluez/commit/89b207a44dce45103bac2afec5856c666a6a6c70
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-15 (Wed, 15 Apr 2026)

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


  Commit: ed4e66783914101e4e01e834d9d42c2f6381f3a6
      https://github.com/bluez/bluez/commit/ed4e66783914101e4e01e834d9d42c2f6381f3a6
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-15 (Wed, 15 Apr 2026)

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


  Commit: fc2f649917f61268431f05bb0b6fd9749cf41eb2
      https://github.com/bluez/bluez/commit/fc2f649917f61268431f05bb0b6fd9749cf41eb2
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-15 (Wed, 15 Apr 2026)

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


Compare: https://github.com/bluez/bluez/compare/89b207a44dce%5E...fc2f649917f6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
