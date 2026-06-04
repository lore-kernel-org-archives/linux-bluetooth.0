Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FB3D6CB1
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572298; cv=none; b=FnTjWsU+y8thTUbWD0VgFQzppN1SYDrrUwQdsmwqA4bPqEI83vWpCMtoQK3XI00VIBLLNHfuLg/5Mij2HZKBnunY0RcVj26j3/8fqxtGNVUshWmR816Q8TQPaC746plAx4m2NVNieNEcRVyT3/Ar+O7ACG2v3Egi6eJhVPSRsFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572298; c=relaxed/simple;
	bh=HISBh6tWXKBork3kzWs6emU/Nnv6rBIGBMvw1Fp4+pc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=u57IW1xUxOxlaewZYYM7aPYEyJvbRJx3S2KEtOPGSmJ+CQC/icd+9o7GSmkul/C/5B8Lb8puj+IWAcZ9ebPRL3Mq+Ly/PusyELDeHWmVVrWw/LjPS3fLoLyJ20zClvrXDqN5p/CFtl1pvig42qc6DX+6JS1UaB1IqvVez9mdAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CH44dpmp; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CH44dpmp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780572296;
	bh=GxLvu8lKtIGZb/ISt+IMVnCni8eQzMKCFNKPaEkw4Ts=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CH44dpmpvoDwJIGs7Hvyh1EK2pppha1zJAmB19KsHHBtVl3UqaDucyKjRse4m0NJ7
	 Roiw/Baur/Zjaqok57fZ6VUmqGEoMxJzAQCTjhlOugvQRZykM36U3cos3QNr6fKIDB
	 QtP8HPxgKfRZ8KOGlJ9wEO5BAnPrCmSI2jWfXS/E=
Received: from github.com (hubbernetes-node-c000180.va3-iad.github.net [10.48.209.48])
	by smtp.github.com (Postfix) with ESMTPA id 90FA378045D
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 04:24:56 -0700 (PDT)
Date: Thu, 04 Jun 2026 04:24:56 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1105806/000000-0b64d6@github.com>
Subject: [bluez/bluez] 0b64d6: shared/rap: Add client ranging registration and
 no...
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

  Branch: refs/heads/1105806
  Home:   https://github.com/bluez/bluez
  Commit: 0b64d66091079975c6b59586bd299d12ca19f809
      https://github.com/bluez/bluez/commit/0b64d66091079975c6b59586bd299d12ca19f809
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-06-04 (Thu, 04 Jun 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared/rap: Add client ranging registration and notification parsing

Read the RAS Features characteristic to determine whether the remote
device supports real-time ranging. If supported, register for real-time
characteristic notifications using the reqtracker for the CS initiator
role.

Parse incoming segmented RAS ranging data notifications by accumulating
segments via iovec and parsing complete subevent headers and CS mode 0-3
step data, including IQ/tone PCT samples, once the last segment arrives.

Changes in v2:
Removed unneccsary DBG logs and unused variables.
Use helper functions for readablitiy and code indentation.

Changes in v5:
Fix use-after-scope in read_ras_features where a stack-local padded
buffer was referenced after leaving its scope via iov. Use get_le32
on a properly scoped buffer instead.

Add null checks for resptracker and reqtracker in HCI subevent
callbacks to prevent crashes when config complete has not yet been
received.

Fix Mode 0 frequency offset parsing: the Measured Frequency Offset
field is 16 bits per the CS spec, not 32 bits. Update
CS_MODE_ZERO_WIRE_INIT_SIZE from 7 to 5 accordingly.

Fix step mode extraction mask from 0x7F to 0x03 since CS mode is
only 2 bits (modes 0-3).

Refactor parse_mode_three to call parse_mode_one and parse_mode_two
directly, eliminating duplicated code. Similarly refactor
get_mode_three_length to use get_mode_one_length + get_mode_two_length.

Fix typo 'reflecter' to 'reflector' in comments.

Fix DBG format specifiers: use %u for uint16_t length parameters.

Remove double blank line in fill_initiator_data_from_cs_subevent_result
and add TODO comments to stub functions.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
