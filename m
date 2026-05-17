Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1521A453
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779052067; cv=none; b=LqiuN+N6lb1V5DGMjQ8Y1h2qhUPwxTf9ZONV+04d2pQpTBcHp9Qizw1wNxqucoFBkmu4hmium4fh2tkle+mDnCh1rZtzxudi/LNYpM+tPJeBoDAyp1IFNqmTZC0eQyikFDS+gU9PAB4ovlRLvakZYQIuSfAANkYw+CN7B5njqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779052067; c=relaxed/simple;
	bh=tnYUcj6VPNMMQ3BEzw7uWdmGgK/6XuX117SHvU5KdIQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Rtm62qevK05D6285rieRr7IXwDp7VEuxaTy13H+fzYNz1KSqsfjI4Avjk37+MZF9JdbwrNvW1BtmedXAZyl0NkqH+YHMozvNXdbhvarhSzk53tN9CHfiqLTB+i4AOIH33FRPiOlV9QFORuHO2RhrhvDUprIGfB0Eq9tRWlm+aIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E74SAQFj; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E74SAQFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779052065;
	bh=kstmKZIJ/wJliR3PxFWKTnA39Vp+Ppy969mAcX9jm9g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E74SAQFjSsA3LXCSRDv302ESYM3n6zFC7TrritcwXg2PlcX0bEDRJThxkA9KxBY0i
	 5OIId3676x3EYawOOtEuhzBWzigaxRTa+87pmgNsLXTsVHVbeL+ggiw2wao7hXDXbH
	 Resblj6OStoa/e5H8JkhLBJOwGtIfggcmZEY4hig=
Received: from github.com (hubbernetes-node-366ad81.va3-iad.github.net [10.48.138.41])
	by smtp.github.com (Postfix) with ESMTPA id 727BA34097D
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 14:07:45 -0700 (PDT)
Date: Sun, 17 May 2026 14:07:45 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1096181/000000-0ea80f@github.com>
Subject: [bluez/bluez] 0ea80f: tester.config: add missing CRYPTO_AES
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

  Branch: refs/heads/1096181
  Home:   https://github.com/bluez/bluez
  Commit: 0ea80ff50dd4fb09eb7594250336e70943818d99
      https://github.com/bluez/bluez/commit/0ea80ff50dd4fb09eb7594250336e70943818d99
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-17 (Sun, 17 May 2026)

  Changed paths:
    M doc/ci.config
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  tester.config: add missing CRYPTO_AES

Kernel commit 4a1507625b0 ("Bluetooth: SMP: Use AES-CMAC library
API") removed CRYPTO_AES from the default Bluetooth kernel config.

This causes Bluetooth testbots to fail silently with "Not Run" status:

Basic Framework - Success - init
  Read Index List callback
    Status: 0x00
Bluetooth: hci0: Opcode 0x0c03 failed: -110
Bluetooth: hci0: Opcode 0x0c03 failed: -110
  hciemu: Failed to open vhci
  Failed to setup HCI emulation
Basic Framework - Success - pre setup failed
Basic Framework - Success - done
...
SCO CVSD Listen Send - Success                       Not Run
Total: 30, Passed: 0 (0.0%), Failed: 0, Not Run: 30

Fix by explicitly requiring CRYPTO_AES.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
