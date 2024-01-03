Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E291DA21
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jzEv7B7s"
Received: from github.com (hubbernetes-node-413e5a9.va3-iad.github.net [10.48.141.38])
	by smtp.github.com (Postfix) with ESMTPA id 70A638C05C9
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 13:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1704316354;
	bh=xJwxRz24ChFnQNa0JZe1qoXnV+sTSquAqpLw+aVaYtU=;
	h=Date:From:To:Subject:From;
	b=jzEv7B7sgqopyguSOFhTbquYQeT4Ax3mDUjD4NfHziRrvcP+Mr7+vHQEnQaC+XBwV
	 yNf9bkcwBygC/cpBi4ZMGFnX2Z/TtNF46yUi04jsMSEO8y9PGHwfIGb/zRevLYOddA
	 cO++rjGWAogoMAc1ed8OUsoVqBIHIhx7JxTQ4pm4=
Date: Wed, 03 Jan 2024 13:12:34 -0800
From: VinitMehta-NXP <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7ad566-60d601@github.com>
Subject: [bluez/bluez] d206ab: monitor: add Qualcomm and Mediatek MSFT opcodes
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
  Commit: d206ab94a79e0c6c96265fca1155caea18405a73
      https://github.com/bluez/bluez/commit/d206ab94a79e0c6c96265fca1155caea18405a73
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2024-01-03 (Wed, 03 Jan 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: add Qualcomm and Mediatek MSFT opcodes

Qualcomm and Mediatek has 0xfd70 and 0xfd30 for their MSFT opcodes,
respectively.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Hsin-chen Chuang <chharry@google.com>


  Commit: 60d60166e4bfae8555fb671e5a99952586cc6b56
      https://github.com/bluez/bluez/commit/60d60166e4bfae8555fb671e5a99952586cc6b56
  Author: Vinit Mehta <vinit.mehta@nxp.com>
  Date:   2024-01-03 (Wed, 03 Jan 2024)

  Changed paths:
    M client/agent.c
    M client/mgmt.c

  Log Message:
  -----------
  mgmt: Fix crash after pair command

After pair command, if the user doesn't provide any input on bluetoothctl
CLI interface after receiving the prompt(yes/no) below crash is observed:

dbus[782]: arguments to dbus_message_get_no_reply() were incorrect,
assertion "message != NULL" failed in file
/usr/src/debug/dbus/1.14.10-r0/dbus/dbus-message.c line 3250.
This is normally a bug in some application using the D-Bus library.
/usr/lib/libc.so.6(+0x27534) [0xffffa1b67534]
/usr/lib/libc.so.6(__libc_start_main+0x9c) [0xffffa1b6760c]
bluetoothctl(+0x188f0) [0xaaaac9c088f0]
Aborted (core dumped)


Compare: https://github.com/bluez/bluez/compare/7ad5669402c9...60d60166e4bf
