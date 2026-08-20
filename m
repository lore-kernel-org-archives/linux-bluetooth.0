Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFFA38D402
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249765; cv=none; b=Vt/RJ/JZie4AP981HyNEFXmLWT7RPaZS8Jf4nZRcZAmn9c8UsNyBcAjvEIExihPAQeghWKfzVoalGDhh6Y+vQodmWM2o+SZnQO/xrLPvEXb8K8uQKS6FPuWcRI1nKZbzHwpBDbuo4y1cC0jWGuguDvrj8XyL+99p2a4V3LE2LNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249765; c=relaxed/simple;
	bh=8Z9g88TfXbE3P8BlN0VJbyO/8oucH2BopmmYUjx8SU4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dJQEeaJE9jsxDlq0+E3tLUBxRLeGn6njnrQVlcy08eeG/O1+ioAvs6MCXyah6C5w2ujkNuBxyngh7BSxgYuaKslERKyEXPu+2OlCR80nw3Mqbc3Q+jiPXCKKzNRohDyoUAjGzgShZ22NCItPfOt4UoDlptBx5OVU/jApATslMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DyI9BFP5; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DyI9BFP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787249763;
	bh=aeSbieoZ14eC1FpZBmHgQtT9PY/6CikM/hBY4d1nFEM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DyI9BFP5i637QPa7hvIF1rWGtkgj3c/lT/4DN+gF1VmYmeyEycNxfLT+p1gkfu1p6
	 NJAChAT78e22GY6yhj64WCyQmzaO9OpLvd1SaSgNroIZI2QFsnuIpzMGB//cAYH34k
	 Wz9HCsDooR8h8d2GB1wrBM1yrdQAObZJXKZx0wVs=
Received: from github.com (hubbernetes-node-a727a6c.ac4-iad.github.net [10.52.125.60])
	by smtp.github.com (Postfix) with ESMTPA id 8C2B5A0326
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:16:03 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:16:03 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149256/000000-b625e4@github.com>
Subject: [bluez/bluez] 93792c: src: Modify MaxTxPower option documentation for
 Ch...
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

  Branch: refs/heads/1149256
  Home:   https://github.com/bluez/bluez
  Commit: 93792cbd6e832cea4f958a07d3841444d2381311
      https://github.com/bluez/bluez/commit/93792cbd6e832cea4f958a07d3841444d2381311
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M src/main.conf

  Log Message:
  -----------
  src: Modify MaxTxPower option documentation for ChannelSounding

Modify MaxTxPower configuration option to take decimal values
within the range of -127dBm to 20dBm
Defaults to 20 (max power).


  Commit: b625e4eb5057868b972a305aa0b2eaf5c27de0ff
      https://github.com/bluez/bluez/commit/b625e4eb5057868b972a305aa0b2eaf5c27de0ff
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-20 (Thu, 20 Aug 2026)

  Changed paths:
    M client/cs.c

  Log Message:
  -----------
  client: Enforce Valid Main Mode and Sub Mode Combinations

Introduce validation for main_mode_type and sub_mode_type combinations as
specified in the protocol requirements.
Reject invalid combinations and guide the user by displaying
the acceptable mode pairings.


Compare: https://github.com/bluez/bluez/compare/93792cbd6e83%5E...b625e4eb5057

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
