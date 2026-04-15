Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5E37A486
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253140; cv=none; b=lSHYNNjTKjyid1gF5iH4x5lZWmwyu2Ss9hm+xtqJhEUVXiWJIVzpgX/sQeyZIYFLsISWmPolxKvI9El27QVZFlHZ4X18JeUqPRqMXmWJy33vw5Vckl6WKCIL4aCsa6GSUYQx9ONHy1olpcoCJ8nX7rN4fFKH1yrNtEX51FW+MzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253140; c=relaxed/simple;
	bh=1BCaEmPBAQxrcFQIUiAllz5NFmDEi3UBcb8eVJnlpNs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XYlhDnExBMCHukuIFt4t23RUU9Jd43dd+xDuHu3whB4didBoINmIMDalaUl6/YzoJ3BoYKEcqthVCfy8+eo1uWD0g3Vb8NV9Vh28RRQnno2WOgTfpH1ggp3imHZrWQRyIp1rplqUtPLStOKdSoN7PK42eO4jzaa5KhcN/JoUbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FUrMnURU; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FUrMnURU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776253137;
	bh=rMevMwMCi/XR+T3htOP1+k9/xkcMtUA+794Gu5AMnsU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FUrMnURU1pZvAWDtS507As+iC/SLc62yrMzSgTY27W8/Z+DpBPZEdTQkMVXydnDyA
	 j36zkihW2Ax2m1e75Xl/hO+eaBEBlUqZjPqx4UdFWNbRFR+29UzdCr2qFcfnKWeSB+
	 TlaGfCvUvWwZuwleyIqslhJYPLGiTnV27N3lF80I=
Received: from github.com (hubbernetes-node-3942a2f.ac4-iad.github.net [10.52.206.102])
	by smtp.github.com (Postfix) with ESMTPA id 62328A117D
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 04:38:57 -0700 (PDT)
Date: Wed, 15 Apr 2026 04:38:57 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081547/000000-0423d8@github.com>
Subject: [bluez/bluez] 1082f4: shared: rap: Introduce Channel Sounding HCI raw
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

  Branch: refs/heads/1081547
  Home:   https://github.com/bluez/bluez
  Commit: 1082f4260f2bd1add5f08cf80e352b0ac239e092
      https://github.com/bluez/bluez/commit/1082f4260f2bd1add5f08cf80e352b0ac239e092
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


  Commit: 65412edd4e5213e695aea1501c198192bf8f95f5
      https://github.com/bluez/bluez/commit/65412edd4e5213e695aea1501c198192bf8f95f5
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


  Commit: 0423d8d6f24ce4ea0f2343c6e954b98126150b5d
      https://github.com/bluez/bluez/commit/0423d8d6f24ce4ea0f2343c6e954b98126150b5d
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


Compare: https://github.com/bluez/bluez/compare/1082f4260f2b%5E...0423d8d6f24c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
