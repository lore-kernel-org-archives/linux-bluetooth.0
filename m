Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1F23778
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102051; cv=none; b=ImuQM5faZizoCAB1EbainyANePI5aon1eyNLGuYxySOaPkDAAUfSnFAk88S+r3vxXxIzSk+mVjjE5IDTn+pxYFJrJ8ZEiLKapCV7FQdK9a1LB9OE1VKa5aKF9zPzRpkD6aV3pbtom3Ed9OIqdPLHnzlQ51HvPWWXn/1c7vZu8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102051; c=relaxed/simple;
	bh=SCCApGeELkuDcNwGdLzOHz1W1fdN5uH8OMgJx9EX9C8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oKg1hfIyANB5L1vsgI0Kyoahc590TAOZ5+c9nuUTp6sjfux+eRzsYIgX3QLAF9+emHcJ3WcVFDyLqvo8lPjPLQTEukfFCDLmhRbPCEMWr+6m+5pabNfaE3CpzRmqU3hUqosN8bi/xX5SZYgaxoJcDPhc75hJX7CjfDvfLu3c3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gRcMY0l/; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gRcMY0l/"
Received: from github.com (hubbernetes-node-ed7c0d8.ac4-iad.github.net [10.52.142.35])
	by smtp.github.com (Postfix) with ESMTPA id B3D3F640C43
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1711102048;
	bh=bN0o6cEp4jFasj8UpOEgH8JHduJdkqMwvTKXXOId8m0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gRcMY0l/j0v4pxGoyuGkbYBhAcF5tm2E4H+2gZB7pwADQkPhoKIeba760EbkH+fYP
	 L8aKRX5yjkVpSPaaes2VxiGenDnIJL6KewdpvAjiWk4k1ye+s78mfQkC8oylADrsGM
	 YnHv8D5KUYYYoiNO0CYGAYm918HrX+vEgG3m5xpM=
Date: Fri, 22 Mar 2024 03:07:28 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b8ad34-925092@github.com>
Subject: [bluez/bluez] bbf198: Fix crash in iov_append_ltv function
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
  Commit: bbf198280e701580cf2284800d56811bae71b80a
      https://github.com/bluez/bluez/commit/bbf198280e701580cf2284800d56811bae71b80a
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-03-22 (Fri, 22 Mar 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  Fix crash in iov_append_ltv function

Fix function iov_append_ltv crashes because is not reallocating memory
Use util_ltv_push from util.c

[bluetooth]# [NEW] Endpoint /org/bluez/hci0/pac_bcast0
[bluetooth]# Endpoint /local/endpoint/ep0 registered
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 3
=================================================================
==80806==ERROR: AddressSanitizer: heap-buffer-overflow on
 address 0x60200000a8ba at pc 0x561971611e0e bp 0x7ffd45ab1f00
 sp 0x7ffd45ab1ef0 WRITE of size 1 at 0x60200000a8ba thread T0
  0x561971611e0d in put_u8 src/shared/util.h:254
  0x561971611e0d in util_iov_push_u8 src/shared/util.c:534
  0x5619715c28f0 in iov_append_ltv client/player.c:3565
  0x5619715c28f0 in config_endpoint_channel_location client/player.c:3593
  0x5619716226ce in bt_shell_release_prompt src/shared/shell.c:744
  0x561971623087 in rl_handler src/shared/shell.c:769


  Commit: a2b2d2e4ab0ee375b24007e23f19e3122fa33764
      https://github.com/bluez/bluez/commit/a2b2d2e4ab0ee375b24007e23f19e3122fa33764
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-03-22 (Fri, 22 Mar 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  player: Adjust SDU size based on the number of locations

Adjust the SDU size based on the number of locations/channels
that is being requested.


  Commit: 97fa2525fb104856c80f67af27cd87af09a41c4d
      https://github.com/bluez/bluez/commit/97fa2525fb104856c80f67af27cd87af09a41c4d
  Author: Youwan Wang <youwan@nfschina.com>
  Date:   2024-03-22 (Fri, 22 Mar 2024)

  Changed paths:
    M obexd/src/manager.c

  Log Message:
  -----------
  obexd: Remove redundant judgments and fix code style


  Commit: 9250929edde3b5740e5cf3b33e58a075f0e640be
      https://github.com/bluez/bluez/commit/9250929edde3b5740e5cf3b33e58a075f0e640be
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-22 (Fri, 22 Mar 2024)

  Changed paths:
    M src/shared/btsnoop.c

  Log Message:
  -----------
  shared/btsnoop: Add proper identifiers for ISO packets

This adds ISO packets identifiers so they are properly stored on files.


Compare: https://github.com/bluez/bluez/compare/b8ad3490a350...9250929edde3

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
