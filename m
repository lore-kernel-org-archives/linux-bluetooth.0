Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1700D28C2DD
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771010907; cv=none; b=VGzrOi2xYzJ93aZ7yUb+uCVrv3GkVz2QL7ANIBGPRnH6z4kksTT4YkMsPwQc6fPYvuXkFuQcsLFW2dKliNmQMorWjRbruHYz9v+DV1DAK7IUETGTUv7Zx3uD1Lfogrjd0jmTFXBdUEIcqpdS8ifgu1ArkWifQv+CDVJqLZwx624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771010907; c=relaxed/simple;
	bh=vZVqLaKMiM+/76XhITa9anA+wGvFeBDppLOMEWACCoA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WXEw5qvNC9pk+OsYGoMgwd+Rx/gPigvc0yFHqpFUOJMq+Ze/wDbjZwtCi19LyBI/EwlyigyeUz2L+kEp12G52sTRC3vrCKBh5rxEH7GwpyKr0znVnlljUmvWZN6u/3fb1XWo6bbDNjf20j7sYngQzqA5kqayCvwGR1K+6Ycq5G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DZJ04hai; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DZJ04hai"
Received: from github.com (hubbernetes-node-4cad3e9.ash1-iad.github.net [10.56.224.15])
	by smtp.github.com (Postfix) with ESMTPA id 3AE24141170
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 11:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771010905;
	bh=jtwZeazZcGp3AC9s3phKxRE/PD2ZTQkvla6edoezYDU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DZJ04haiE2lPTOPW5WUceByydZkx7I/prmubN006lE2mnR+ORUrwO/RMYDjSsSj1M
	 jB8lPE4+Kh65V7uZkda2bMpz/6YmoUJ7YxpzTaXxwstf6oI+00axujoSr8v5iZoIsd
	 OB86DlInB1s2iIUowcQeMXoc9ls6g/LyvSEb64tE=
Date: Fri, 13 Feb 2026 11:28:25 -0800
From: Copilot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/copilot/fix-dualshock4-random-inputs/235fdd-066e59@github.com>
Subject: [bluez/bluez] 066e59: input: Handle HIDP_TRANS_DATC continuation
 frames ...
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

  Branch: refs/heads/copilot/fix-dualshock4-random-inputs
  Home:   https://github.com/bluez/bluez
  Commit: 066e592c13198d1a090ce4605bee3d3a09610287
      https://github.com/bluez/bluez/commit/066e592c13198d1a090ce4605bee3d3a09610287
  Author: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
  Date:   2026-02-13 (Fri, 13 Feb 2026)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: Handle HIDP_TRANS_DATC continuation frames gracefully

Previously, hidp_recv_intr_data() would reject any frame that wasn't
HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT (0xa1). This caused issues with
devices like the Dualshock 4 controller that may send HIDP_TRANS_DATC
(0xb0) continuation frames, leading to "Unexpected continuation frame"
errors and random input behavior.

This change:
- Extracts the transaction type using HIDP_HEADER_TRANS_MASK
- Handles HIDP_TRANS_DATA frames as before (send directly)
- Logs and gracefully ignores HIDP_TRANS_DATC frames
- Prevents connection/synchronization issues

Fixes random inputs upon connection for Dualshock 4 and potentially
other HID devices that use continuation frames.

Co-authored-by: Vudentz <2156363+Vudentz@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
