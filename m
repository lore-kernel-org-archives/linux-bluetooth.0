Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9232AE8D
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782603768; cv=none; b=Krc+ohm5HJaoFmREwOnCKC6DlVpxs2EwmocAH6I3j2pbNWtD2FLmhkIgX9R+R2EiH7yA8dFe/8WHSjxWbMqvhGrFYRW/vJR4rRFoXNyaPzcvMNNe8NnW2zdGeYKGZCaCqatCTJ7fexDBqskriQWJ4HI1L/xtL1M5l32Ut19ZZ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782603768; c=relaxed/simple;
	bh=tNBsyHN1si9eGRVmbDz+JOtfGDOBWUG3eCp8MPW0GQI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FxKGVXbvY1eMveSnuEIKdTb0thT/ZOskk3/9pdevx9PTbXSIptz0RpfQSjG5I77xWLK10xRSqEuUKjr1KsN+3aU0yENnt2DSZrvRcc0CDLRpAkTwOULknOeC67aEVXZQjo5iJOt/mXkM+wu4grH9hED6hZV4Y7SS0662g7qBG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B+fp/EnK; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B+fp/EnK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782603766;
	bh=TT7r9zOLL6C7sIuEx5P1zrrQAH9Qz4EH/vevgwNwNL0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B+fp/EnKwk9qwt3xsik8s/3rBo8qTCcj7TXOBHj2/F2aBW0RhXseLmHSlXS6Ph+CU
	 HX4Fon/OVlPbiZQpFXP1RUv+xeoYwbkBxaKlEeClpG2dA7uWVdeymAl+yCQlmidbjC
	 mM1T8e1L0F8ICpyweHk81y4bCo+OPdRnIc2A+iuE=
Received: from github.com (hubbernetes-node-15e4d25.ac4-iad.github.net [10.52.150.42])
	by smtp.github.com (Postfix) with ESMTPA id 846BE78BB21
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 16:42:46 -0700 (PDT)
Date: Sat, 27 Jun 2026 16:42:46 -0700
From: Matthew <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1117539/000000-92a265@github.com>
Subject: [bluez/bluez] 92a265: profiles/midi: Fix zero timestampHigh
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

  Branch: refs/heads/1117539
  Home:   https://github.com/bluez/bluez
  Commit: 92a265695b4952bb26cfe5549ebe62a949ace070
      https://github.com/bluez/bluez/commit/92a265695b4952bb26cfe5549ebe62a949ace070
  Author: Matthew Cash <matthew@matthew-cash.com>
  Date:   2026-06-27 (Sat, 27 Jun 2026)

  Changed paths:
    M profiles/midi/libmidi.c
    M profiles/midi/libmidi.h

  Log Message:
  -----------
  profiles/midi: Fix zero timestampHigh

BLE-MIDI timestampHigh can legitimately be zero. The MIDI parser used
timestamp_high == 0 to decide whether it had already consumed the packet
header, so packets starting with 0x80 0x80 caused the next running-status
payload byte to be consumed as another timestamp header.

Track whether timestampHigh has been read separately from its value so
packed MIDI events with zero timestampHigh are parsed correctly.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
