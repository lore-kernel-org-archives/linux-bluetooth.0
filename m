Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE02E5B21
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297851; cv=none; b=nD/Y97edVlZvLhJ0w9cJBVms1r2NLlGMUbBpy5Bc/8IlUfoqZtBriSxfCAd2FsDjWjwMns2o2khrDLKJ2ZuW0ZhnE6issji96tCle/vadF9iYtSpg9AFygqtwfRp1agmfixRz1u7dpZVGXiF11lBg0F4IM+8Wp9slLWAQnab8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297851; c=relaxed/simple;
	bh=JOE+zrv4i0iGO3but4jXleVr4JWO6LwexWWrOOlzq1g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=A3VISUnJueOyeox42q3ORH5uuZKRQDCL93tj1sMLEWhgsf2GQSQBtnctZRSO5B5m9jcvk8H2t92MKr4ZgdTp34Y1a13uil2pLzrwQ9Am26KpiFJpSr+GjozkJe2Pjaua0B1z3OhEwA2V9CPcxj8zOAP8aNTSoP5A1YAT8TYB9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=U4KZg3ch; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="U4KZg3ch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784297849;
	bh=q7QX7b49xBkiJbvDmsUYxrHF6PZNXgky7cIQCHhkNbE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=U4KZg3chk1XVJGiZ9fyo6/cSFEsQedPyKUeW9tCax/oortxRdchqaRCbSww7xdJOp
	 o+tmH1/IevKFPuuV8Rq+cIWEze7aXWKIbBsjiuMzBE26tZwEnWtY8tmHLWQciChtxe
	 cnMkW/6LC8ltK42trkKOaexzHVBFCE3Si19SQN14=
Received: from github.com (hubbernetes-node-f169dec.ash1-iad.github.net [10.56.206.40])
	by smtp.github.com (Postfix) with ESMTPA id C1D07521056
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 07:17:29 -0700 (PDT)
Date: Fri, 17 Jul 2026 07:17:29 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1129618/000000-9efbc3@github.com>
Subject: [bluez/bluez] 7059a2: shared: Add create_context CS config parameter
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

  Branch: refs/heads/1129618
  Home:   https://github.com/bluez/bluez
  Commit: 7059a2547f09eb71e3fe0faf597918d9e658ed73
      https://github.com/bluez/bluez/commit/7059a2547f09eb71e3fe0faf597918d9e658ed73
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-17 (Fri, 17 Jul 2026)

  Changed paths:
    M src/shared/cs-types.h

  Log Message:
  -----------
  shared: Add create_context CS config parameter

Add create_context in bt_rap_le_cs_config structure


  Commit: ee37dfde9ccfd98fd8ac9d19065d10b654c6db0b
      https://github.com/bluez/bluez/commit/ee37dfde9ccfd98fd8ac9d19065d10b654c6db0b
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-17 (Fri, 17 Jul 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: Add create_context param as part of CS Create Config cmd

- Add the create_context field to the CS Create Config command.
- Route HCI command-send failures and non-zero-status completion
events to CS_STATE_HOLD instead of CS_STATE_STOPPED.
reserving CS_STATE_STOPPED for the clean/expected
stop (Procedure Enable Complete with state == 0x00)


  Commit: 54de92d0bf259b924f89566ab777043fa467d900
      https://github.com/bluez/bluez/commit/54de92d0bf259b924f89566ab777043fa467d900
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-17 (Fri, 17 Jul 2026)

  Changed paths:
    M client/cs.c
    M client/cs.h

  Log Message:
  -----------
  client: Add create_context CS config parameter

- Add the create_context field to the CS config parameter table so
bluetoothctl can control whether cs.start writes the CS configuration
to the local Controller only (0x00) or to both local and remote
Controllers via the CS Configuration procedure (0x01), matching the
Create_Context field of the LE CS Create Config HCI command
- Change the license in cs.c and cs.h.
- Drop RangingInterface support for now,
as it is still under discussion.


  Commit: 9efbc3b2c56a230045209606316e6bcb3dee6f5e
      https://github.com/bluez/bluez/commit/9efbc3b2c56a230045209606316e6bcb3dee6f5e
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-17 (Fri, 17 Jul 2026)

  Changed paths:
    M doc/bluetoothctl-cs.rst

  Log Message:
  -----------
  doc: Document create_context in bluetoothctl-cs.rst

Document the new create_context parameter introduced in client/cs.c.


Compare: https://github.com/bluez/bluez/compare/7059a2547f09%5E...9efbc3b2c56a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
