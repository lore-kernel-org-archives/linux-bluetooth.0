Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EFE322B6D
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782586284; cv=none; b=X+8M+eM4F+elX+CaI2cyPbTlspIdoNT3k/Jrpb/7auvWe7B1Tc8G7EDr/UbQawlYHDgf1nFByMVY21tv5Wqh94slZJfSR1sOdSsEGRTnktybm4FT5GCWLeCKWbBXHkCROYE9aSES49fH5nHhGJUHoUMb1LWMJAfHAbX14b194CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782586284; c=relaxed/simple;
	bh=VbrBTdWfusEixi9IW0W76PPovDUo5OzjjTqjxtFwz1A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KtGMes8dwvNkKc/sZ5kXmhFIuxqzEaBigDodJmm92rlCvLLw6ufVxWymCFL8qh9rUdzIEHuvp66t9AQdeW6PUfIqZUjakdrudD25/D9AxtZwW9yUbmvaCghdg679bPigYgDRGq5UUDjY/02/AZ0BbrnxRmLaGA5yYhmcNVuYzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YfJ9spgn; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YfJ9spgn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782586280;
	bh=wDmRonDwkwlJnxlFlBWfkg8x0gOtKJkVYn7Sz/PhmaA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YfJ9spgnAWNmaqyF9NkYuf6r8tkjqdYyJgobU+wcLTqjMOL4rvi/RUcWunGuDp0J5
	 QGFm2cgZ8uRz+mdscqW1ufzPtyyER0YL1CxV2WGiYEugrcrXbx4Xj59Axeaxuy+9ab
	 k/CwSJ0sxTWUgc0cdA7X1FKuJW+9iy856GJVbAuU=
Received: from github.com (hubbernetes-node-c322354.va3-iad.github.net [10.48.200.23])
	by smtp.github.com (Postfix) with ESMTPA id 1CB4728B0C3
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 11:51:20 -0700 (PDT)
Date: Sat, 27 Jun 2026 11:51:20 -0700
From: Matthew <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1117512/000000-059aa4@github.com>
Subject: [bluez/bluez] 059aa4: profiles/midi: Fix zero timestampHigh
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

  Branch: refs/heads/1117512
  Home:   https://github.com/bluez/bluez
  Commit: 059aa4163196e27c54414ad5780adc71a8d95c64
      https://github.com/bluez/bluez/commit/059aa4163196e27c54414ad5780adc71a8d95c64
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
