Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5C47F2C1
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930554; cv=none; b=El1a3t/tFNwBPCpLX3HwLsDfWMuqAMLaeBxxpH60MT1K3gXu2/QqL+vtEK/c7Ge8Kce10jVRi+ePUpZ2aBKbwGDlfT1ePYplvaHr0f2T/xGiuTxlWdk3Ufb+wqY6u+mnLaH+aCYymCxKahIMxZkmXv/UAqgdDL2l/Yh5/UUNdHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930554; c=relaxed/simple;
	bh=A5ujWRSWAsgy+LVRPZw7ncAFb3UaW5uXpCCHOPVDfD8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CBhWM0KPa3oXraWwROm6hy7fAXA5V/6ADhv/xQac3hl309NJIpV/LIUHOkXBOt/QEyfQ7/l57fnOO9ZAVhA+SOYyiW7CJcFyFfOOrYFvd1s2MCWmuu/DT75D3OUF723lFcfoSH3ILNHL7w2macPfBOTOAFr9kJ6gAMh7qJBZXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Hvklw72D; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Hvklw72D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780930547;
	bh=tQsImV+zFB+KYWKhVrU1eY7jRu25BcWYMnoWGDszs18=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Hvklw72DEj2fxTCOgIVShwe/xtALHYKgrNVWp0iq5mES4ehUDMkCZl/krDChFY0oZ
	 /qsnUKovlVbT3zKFy0l7Ca9qCbQYGHYzwvpM05tBZMebSjobcIIwBkG0Ykb1MloWg/
	 S6ccRcpTlv9RL0JInHe0MD15OB1qKmY7iozhNSXs=
Received: from github.com (hubbernetes-node-fc00fe2.ash1-iad.github.net [10.56.174.27])
	by smtp.github.com (Postfix) with ESMTPA id 3162A60118E
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 07:55:47 -0700 (PDT)
Date: Mon, 08 Jun 2026 07:55:47 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107789/000000-4db6f6@github.com>
Subject: [bluez/bluez] f9278b: avdtp: Fix GET_CONFIGURATION cmd
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

  Branch: refs/heads/1107789
  Home:   https://github.com/bluez/bluez
  Commit: f9278b28dabae5f252432a1a1258477ac8ace703
      https://github.com/bluez/bluez/commit/f9278b28dabae5f252432a1a1258477ac8ace703
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Fix GET_CONFIGURATION cmd

This fixes AVDTP/SNK/ACP/SIG/SMG/BV-12-C


  Commit: 4db6f6a6d2440bc13d522ae3d66917d8146cc296
      https://github.com/bluez/bluez/commit/4db6f6a6d2440bc13d522ae3d66917d8146cc296
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Fix error handling for AVDTP_OPEN cmd

We have to return BAD_STATE when local SEP is available instead of
BAD_ACP_SEID.

This fixes: AVDTP/SNK/ACP/SIG/SMG/BI-26-C


Compare: https://github.com/bluez/bluez/compare/f9278b28daba%5E...4db6f6a6d244

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
