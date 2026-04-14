Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50FD3EC2F8
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181509; cv=none; b=ajrLirwKtOsQvRui8XbvbHXZmV8KuWPFtNbbZ6GOwLCzwq488BQyF3N7NGVZFulGH4bEwoRXFw7UOy5mDR56DS+r5ZrSOqlbW73t4L6kXquQ67tKZxGf2gGI1LENuzXo7NP++mKL4yiCy9yQuCPa8H6k93osPcNACbf3ZlvPw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181509; c=relaxed/simple;
	bh=8h+I6ODz+le7mLDhqut7JxU+N2v7svP5nkBMcZW6B4E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ne9keXIhZ8uV5mTttIZJLWSEMM7otXsOXVq2O9Bxh8x9Gjnug76G5GjIzpYV2xk98qKIcC+EEdyrGJb18+AlJjVObaz8wk9M4jnJKXdjV3YMweBbgbiLNUrK6AB2K/Vd2dpMj9auUlNoQE+vS8FVednch5aWErqTCtgWvyNNN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hQoP3ERy; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hQoP3ERy"
Received: from github.com (hubbernetes-node-d0e3317.va3-iad.github.net [10.48.14.31])
	by smtp.github.com (Postfix) with ESMTPA id 0B162901062
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776181508;
	bh=YEAeeoVza4r7xMnL1eufsJ+3UiBzvgpWq5BLoTl/4mM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hQoP3ERyqlt7cNHGbJ+elW4VLhoFX6C5FtFMoSM8IqgY/MwxBHClj+w21mVv2jY/G
	 ecE+kPL7+xsy5mYN/uruQ8iVgchuzafWf3uk7LQq47CNF8PRRqaR5DMdJirlOhww1K
	 +FZIuyePHvR4IBnlmuxoMX+vbYbDm1eWOtUSRDpo=
Date: Tue, 14 Apr 2026 08:45:07 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081201/000000-7f151a@github.com>
Subject: [bluez/bluez] d7cd4d: shared: rap: Introduce Channel Sounding HCI raw
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

  Branch: refs/heads/1081201
  Home:   https://github.com/bluez/bluez
  Commit: d7cd4d5e6656ba7bbc60887e9b204b7cb650845b
      https://github.com/bluez/bluez/commit/d7cd4d5e6656ba7bbc60887e9b204b7cb650845b
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-14 (Tue, 14 Apr 2026)

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


  Commit: cd3d94660e57931fc87810e491055e8f8de62741
      https://github.com/bluez/bluez/commit/cd3d94660e57931fc87810e491055e8f8de62741
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-14 (Tue, 14 Apr 2026)

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


  Commit: 7f151a21b42da27f6feb26bd5d8c2d4adef1f317
      https://github.com/bluez/bluez/commit/7f151a21b42da27f6feb26bd5d8c2d4adef1f317
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-04-14 (Tue, 14 Apr 2026)

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


Compare: https://github.com/bluez/bluez/compare/d7cd4d5e6656%5E...7f151a21b42d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
