Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779003AEB35
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478542; cv=none; b=EonHAQJpKMs19JQFPBJ6+cbFatZouZYkqkucQo3WRCbgCAjTOr52zKaaNksw7V6oZg8dBKiUlfWcHI5tBbOLa9T7qeX7VCukY+90ZdYJWOMqVQ0rwRKisJrLtp451Vh/pvFGbGOuhJqoVL11AL0Rsji3X+2exPH9oLohsa8Zt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478542; c=relaxed/simple;
	bh=mEuP4ip7xvTqgWC5sYLv8XBXHb8alNZvxwr8EJpvAu4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=K4U2bEND9RbljHW/u7lNUgGQbL+7hNYX03HhNxUA007YK1Yz2vymyoRuRy52JlE7rpjkhpOhbw+tSZXvJtZJEilh/a5prQ+x+X56ccXM6aVdWv2qeruIyDhKT3lVuqHON4ljMalrCScl1L/+C8WAQPFYjV1T2EGAiIr3uZwmNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=lsSK+IUG; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="lsSK+IUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791478540;
	bh=8JP9IS37bWi0jPj+RTNnBhcj63EKOiNqqklDYyDKExY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lsSK+IUGJE7XnsYI5222MxqVX8BpLggXNOV1qyybAlwADC/1z5UTxCANhs2/FMBIO
	 A1DIwCUKyhOEkNzx8WrFwNXdD1t1S+8v74nh98Hs1ewrKkiuYtin2aNhCjvknrj0QQ
	 Wv7UfPiHFfvKIYOCUXMVvCmdxB8pkcFziKaEvq018z3yKRK2ALpID1/eK2E5OaxXk1
	 QqG9dju4AF1jBxPx6SMQXkwlyiwjfPUELWWu2zXSzCJU1nzVEkNhTyc1miyXLz95/R
	 jwrXZZGAsERnhXMINr1p4eFFhSw51IPMMz8nRSCPTsov0oddMVYgph5b+asZeaG8b3
	 AobsdWukxReYA==
Received: from github.com (hubbernetes-node-8716805.va3-iad.github.net [10.48.64.103])
	by smtp.github.com (Postfix) with ESMTPA id A0E5D50168C
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 09:55:40 -0700 (PDT)
Date: Thu, 08 Oct 2026 09:55:40 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181653/000000-2d7977@github.com>
Subject: [bluez/bluez] 9fc9cb: org.bluez.Device: Add Role property
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

  Branch: refs/heads/1181653
  Home:   https://github.com/bluez/bluez
  Commit: 9fc9cb887477044ac90162170b1f031d598f3d7d
      https://github.com/bluez/bluez/commit/9fc9cb887477044ac90162170b1f031d598f3d7d
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  org.bluez.Device: Add Role property

This adds Role property which indicates whether the remote device is
the central or the peripheral of the current LE connection, so
applications can tell a central that connected to the adapter from a
peripheral the adapter connected to.

Assisted-by: Claude:claude-opus-5.5


  Commit: f447eeb2dd2fe46a98239cea8bc3fce0a10b0ae7
      https://github.com/bluez/bluez/commit/f447eeb2dd2fe46a98239cea8bc3fce0a10b0ae7
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Add Role property

This implements Role property using the initiator flag of the Device
Connected event, which the kernel sets when the adapter created the
connection as central, and emits PropertiesChanged when an LE
connection is added or removed.

Assisted-by: Claude:claude-opus-5.5


  Commit: 2d79772deecd82f3139f01e248148e56ae4ea340
      https://github.com/bluez/bluez/commit/2d79772deecd82f3139f01e248148e56ae4ea340
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print Role in info

This prints the Role property with the likes of info command:

bluetoothctl> info <addr>
...
        Connected: yes
        Role: central

Assisted-by: Claude:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/9fc9cb887477%5E...2d79772deecd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
