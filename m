Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AB31A81D
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764881398; cv=none; b=rIcMOCrvwBgnjr+sOAJYln7xJtfFkq8tCbRz5wV/GJIU7dlYblAi7HbsLsUJueYbozGq0L1+P/JirHm3KeNK03pJHzvryB3OwFX1pHyuSVgzHEHwzVBJoUMXvLn7DQWFHUFEfj3G4gYAP4gFH5LdX5IrGsJa8tIaY5XALRQ94sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764881398; c=relaxed/simple;
	bh=H2ZBhXDdY9kXZAVqocr3oqJ7d5HP0CMvW9a7W9WBSsU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=E2XktPPXHOJj4B0F9Ey77PdjdtuJTgyUf8mdy7gtYjr4ROBMY4e+81pR2jXh95NBTzsyufiUjV1/8SgKE0GZVZWOaBPWiE9rvMoOW7ZQpNd0IDP3Kmu5L4Wkb0DcgV0lfpvecXUpm9PMFXiP4pvodNaUJL0vGUsqDXa/nJHo2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bXX5jAe6; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bXX5jAe6"
Received: from github.com (hubbernetes-node-578484e.va3-iad.github.net [10.48.134.43])
	by smtp.github.com (Postfix) with ESMTPA id 351214E0CC3
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 12:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764881395;
	bh=1OpFH/21h16UqcAG/tRgEtwCbsKao05nGKMeb1URu5Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bXX5jAe6+KPtBrodWUzRU/mvhuQI3Wt3srjCuVIfD8uGgSOwvC1H+NKBAZcifL/hx
	 6G1LEKNv0AAxDPbxZcjs+55WLOP14n6e1lczOhR4ZV06wYp31Wqb5ed3hzkdPauIL/
	 FYZaALLxkXTG+Y3VfyAaOzcEFt6+DE6rX3E/qmkw=
Date: Thu, 04 Dec 2025 12:49:55 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1030592/000000-d5afae@github.com>
Subject: [bluez/bluez] d5afae: main: fix bool vs. gboolean type in
 g_option_conte...
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

  Branch: refs/heads/1030592
  Home:   https://github.com/bluez/bluez
  Commit: d5afae15115de73c483e4a7dd6e479376e8592e2
      https://github.com/bluez/bluez/commit/d5afae15115de73c483e4a7dd6e479376e8592e2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-04 (Thu, 04 Dec 2025)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: fix bool vs. gboolean type in g_option_context_parse()

btd_opts.experimental and testing are bool, not gboolean, which may
cause memory to be clobbered and crash.

Fix with separate variable for cmdline option.

Log:
ERROR: AddressSanitizer: BUS on unknown address
    #0 0x0000005b9914 in queue_find ../src/shared/queue.c:230
    #1 0x00000057c0ff in btd_kernel_experimental_enabled ../src/main.c:721
    #2 0x0000004ff52f in read_exp_features_complete ../src/adapter.c:10230
    #3 0x0000005be40b in request_complete ../src/shared/mgmt.c:306



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
