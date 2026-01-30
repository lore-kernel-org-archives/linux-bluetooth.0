Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36695202963
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790233; cv=none; b=P0fiDBzxon4T1/v6/z0iacNpsOua2QnxSlja/mnuDm99DTQUIqRuYA4EfaFCawC4Sw0OvteRBIezc53ar098IovbALU9XdENRdslCGDQ9DG1EjWDjsi09zbq61EoBD/BT58dLx/Z64XuCL095WbZdQguiGLbGbPiXgEcyKdZejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790233; c=relaxed/simple;
	bh=AqjvsXIQoaul9HuIzNwvwi4uq5UP6qlAwxlStp/EMtQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KLJISwu6ypGIfbT9jAMCg4v/X/L0aGVIGDXxhdOXkcq9W5miAmdFJv8KIrRysEpDSpGx9HsmelPFsn8Y8erMzILGI+Xwhlm9EgnzyJYa8B9RQsB6YmpcXq3imzsRRhEMiX4XFwjs0r2+gXzEo+cktA+0tZShmS8kyxd2dPQNFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GF5nnFL4; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GF5nnFL4"
Received: from github.com (hubbernetes-node-ade5406.va3-iad.github.net [10.48.221.50])
	by smtp.github.com (Postfix) with ESMTPA id 65AAA4E04C8
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 08:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769790231;
	bh=vJxBhztr4g31eR4kMqPFoli3/jC9VK5OHRyRZo59xJs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GF5nnFL4m3lYNDFGAmU8JaZRvOpNmwB2GF/+EPvxpE4j5cMuYDfVrCtqZtM+BiQPS
	 6va53s3vae9tLFW/wdZfUt3YRUKJfzJvRNx07evvVt+/Vn2J0Z1apF9+3W5W7eyM6N
	 tPVjn3stuVb/eULHas/tit3k+tcYPMPYJ1JknyYA=
Date: Fri, 30 Jan 2026 08:23:51 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1049069/000000-55d9a7@github.com>
Subject: [bluez/bluez] 14b2e7: monitor/att: Add initial decoding for HIDS
 attributes
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

  Branch: refs/heads/1049069
  Home:   https://github.com/bluez/bluez
  Commit: 14b2e734eb0c91c38a10ab54f9cdb533d7fad669
      https://github.com/bluez/bluez/commit/14b2e734eb0c91c38a10ab54f9cdb533d7fad669
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Add initial decoding for HIDS attributes

This adds decoders to HID Information and HID Control Point
characteristics.


  Commit: 55d9a71e584c9212c3b5ed4841086dee402e702e
      https://github.com/bluez/bluez/commit/55d9a71e584c9212c3b5ed4841086dee402e702e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Fix printing data twice

This fixes ATT Read Response printing the data read twice by checking if
there is a dedicated decoder then skip printing the value since it is
latter printed by att_read_func:

== Before ==

> ACL Data RX: Handle 2048 flags 0x02 dlen 7
      ATT: Read Response (0x0b) len 2
        Value[2]:
        11 01
        Handle: 0x0030 Type: Report Reference (0x2908)
        Value Handle: 0x002e Type: Report (0x2a4d)
        Value[2]:
        11 01

== After ==

> ACL Data RX: Handle 2048 flags 0x02 dlen 7
      ATT: Read Response (0x0b) len 2
        Handle: 0x0030 Type: Report Reference (0x2908)
        Value Handle: 0x002e Type: Report (0x2a4d)
        Value[2]:
        11 01


Compare: https://github.com/bluez/bluez/compare/14b2e734eb0c%5E...55d9a71e584c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
