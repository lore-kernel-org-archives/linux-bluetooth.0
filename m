Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C493D5643
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168598; cv=none; b=PQv90D4fz7XeVDXD4tcdlUgXaO+BKFD1+QnHqVqTwS9O3FW2TFPK2Xa3W2TSdNfNndpwm4c265nDsgRuG2GD2tnh4ERWLDdaBGV7+ICl2kR9t9JdUtxPGgecAO4zEqjIsEe1gdJRI7ZnynaaHaBv64jsVh7cDRiFUTqQNK+1fD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168598; c=relaxed/simple;
	bh=8tPBJcjBZwNubGhXSmHo/dR05PXLzYiFbQGd4WBBEJg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jearFxRN5Gs0cGiY/zygveyB7SeK+wtC5Mi1Gh50omuonXNlqCTmhQ/SiLJQsd1kvCnGP1AqaHxzz2BjdPF/tI5djMPn1H6HeYWB7pydzpgU664Tp6TIfg/XvXLM4Xmrp3pS1OtS5+yOcxn9ShCIr27QoswYjUw6XSMRl9xyUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GwEicxoq; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GwEicxoq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789168596;
	bh=uh+n9dQdtbFkyGYUV6SEPQ0QZhSHtgslYhxmLaMvLBk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GwEicxoqJJm7xK9E4N8sswNZMoi4RceVBM06iq2gFGsMkB9jwoPrZGy7l/RsojeNi
	 Iz6EunxRyS3k2g7X4bLgzoRio9+XVMyV5toWUW87AbPSNibG5/hO7oFGYMKk3Af6Te
	 ZHEBqKVzvEEUdTSoFXAPY0tDT6XszKDVdsTw/Hk4=
Received: from github.com (hubbernetes-node-d1a1c43.ash1-iad.github.net [10.56.131.30])
	by smtp.github.com (Postfix) with ESMTPA id 0D46B600E2B
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 16:16:36 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:16:36 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1163256/000000-b75e95@github.com>
Subject: [bluez/bluez] b75e95: org.bluez.service: enable D-Bus activation of
 blue...
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

  Branch: refs/heads/1163256
  Home:   https://github.com/bluez/bluez
  Commit: b75e95e35adec1400622b971e8e471f72c944e47
      https://github.com/bluez/bluez/commit/b75e95e35adec1400622b971e8e471f72c944e47
  Author: Grant Moyer <dev@grantmoyer.com>
  Date:   2026-09-11 (Fri, 11 Sep 2026)

  Changed paths:
    M src/org.bluez.service

  Log Message:
  -----------
  org.bluez.service: enable D-Bus activation of bluetooth.service

D-Bus was configured to activate dbus-org.bluez.service, which is only
an alias for bluetooth.service, and so isn't resolvable unless the
service is already enabled. This means D-Bus cannot launch bluetoothd
on demand in most cases (for example when running bluetootctl without
the bluetoothd systemd unit configured to run at startup). This changes
the D-Bus configuration to activate bluetooth.service itself, so that
bluetoothd can be launched by D-Bus on demand.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
