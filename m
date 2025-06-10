Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1FE246797
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749579254; cv=none; b=T7H1JdjGJX/0V+6DFg/tH3daHtm8xyRnKMb+B/oXBzVGMznAA37krKWpJjhFlHFYNoE238i+DD/zmGW21EUOcyi2ChVyop7awcxUmUZv6cjesSKJiTm/m+7iCnbzLzGhr5dUFDCVi9I1prl1MbUvvrvT2knFZhmfr8SNwkJE1C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749579254; c=relaxed/simple;
	bh=r1a+jnWQNzuEC/yEXNxfASBU2RleGq/JDmvHUydPiOI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jhdn3NCI3YRTjDnnVpuXhpHfn6WNRa87kOE9s31L06sX0KOLqHhz3MssCUDLTClzqCJsJitvuKOJpkdfT2/AK/LCMT1NJbcX85+wck1SyXKIxr3OiaZ01pVO8OEyVEHwAVS8fNXrYSJy4ZoOJ9BaNttq3S+LLErDXGXl/tw4MZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=C2Xiaw6c; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="C2Xiaw6c"
Received: from github.com (hubbernetes-node-af2f4e6.ash1-iad.github.net [10.56.208.39])
	by smtp.github.com (Postfix) with ESMTPA id 490E7140BBB
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749579252;
	bh=VGKsk30cpwEX8bMK4uxikP89ErAa1YVvFdjjmye4kTo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=C2Xiaw6cB9p8v9Gg3Ri/nF0Y264Ka8hFt4/YeBj+UaOWKpqbnQLWt8sW0pzdQbE7l
	 1tDBbxFol1U8Ajz41ylbETt8rvE85gtOen/LVuEoOccuRUq7f3de3EUPyHPlL95KMj
	 p1B5i9EQaXd2nNR3sZ8pxKj0JOMew0dJaJApeovY=
Date: Tue, 10 Jun 2025 11:14:12 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970489/000000-653039@github.com>
Subject: [bluez/bluez] 1eaebb: btdev: Fix not setting sid on
 BT_HCI_EVT_LE_PA_SYN...
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

  Branch: refs/heads/970489
  Home:   https://github.com/bluez/bluez
  Commit: 1eaebb4f1a94cbbd4d97bf548538e4e7be4381d2
      https://github.com/bluez/bluez/commit/1eaebb4f1a94cbbd4d97bf548538e4e7be4381d2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-10 (Tue, 10 Jun 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix not setting sid on BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED

The event BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED shall set the SID accourding
to the value set in the periodic advertisement it is synchronized since
the kernel will use that to complete the connection and notify the
socket.


  Commit: 653039fedd15af7a3d6683eb964893b2771cb9c6
      https://github.com/bluez/bluez/commit/653039fedd15af7a3d6683eb964893b2771cb9c6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-10 (Tue, 10 Jun 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M tools/iso-tester.c
    M tools/mesh-tester.c
    M tools/mgmt-tester.c

  Log Message:
  -----------
  iso-tester: Add more tests for getpeername

This tests setting SID for broadcast source in adition to existing test
that was testing broadcast sink only, so this adds/updates the following
test:

ISO Broadcaster SID auto - Success
ISO Broadcaster SID 0x01 - Success
ISO Broadcaster Receiver SID auto - Success
ISO Broadcaster Receiver SID 0x01 - Success


Compare: https://github.com/bluez/bluez/compare/1eaebb4f1a94%5E...653039fedd15

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
