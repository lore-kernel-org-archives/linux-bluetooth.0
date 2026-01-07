Received: from xtrwsrct.outbound-mail.sendgrid.net (xtrwsrct.outbound-mail.sendgrid.net [167.89.101.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5067835293B
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.101.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812131; cv=none; b=O9PjtTY5Lww+gA0lmLWGgFoYKud+dIyYGL6QtDaZV0U9EN3a3C4HnJb3thoZf3w961B4YqVXZw90CM6CpG1M9hrNnMVGc7rjys+OZV5TseiSVGGpajJWgUaS+1betGxFypO6oe6sxLpT3uLbwSRHRnag4+Jq9ONCIh5evklgwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812131; c=relaxed/simple;
	bh=m08QAfN66GWKV6nk2k/C7i1C98vjOv/qTT3PIr+GUZ4=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=tdFVma1MIVrr4gvroMTd2qel8tr+50BfRBgIW99mZIT4fUs8Ja0i10icG2U6ZSapMnCPk7M5iOCRuCN2dBesrDC2UUHt6hMBTyunK33zlzXQVulcAeyH7BnkdyE4OwT02IyXphz6hg6USYrovx7yNaBWhNWLZwFUfW72YD8ZVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V4jc0GIR; arc=none smtp.client-ip=167.89.101.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V4jc0GIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=fsOZoaUszczFSqSo2luywl+RAulGgglp3GDmNqc5ZwA=;
	b=V4jc0GIRH6Y5C1rs+Yh1wYL54WUNNE0u2+MoEXKvIOZ/BHef2gajs3iJytBT3cIsx12n
	gbJ5sznXIgkuuuezGvYQAhro3EAEYNQ078yojwmeUDv9sQwMqlrLoVkLDk7kbcdXwtC7oC
	ChE2tP/R9P+nxxr+SubeJ40taU+BJp5JE=
Received: by recvd-678ccb598b-rzcsz with SMTP id recvd-678ccb598b-rzcsz-1-695EAC1F-34
	2026-01-07 18:55:27.986154867 +0000 UTC m=+1802941.671337832
Received: from out-24.smtp.github.com (unknown)
	by geopod-ismtpd-16 (SG)
	with ESMTP id EckIsaPPRGyNCFe04E3yBQ
	for <linux-bluetooth@vger.kernel.org>;
	Wed, 07 Jan 2026 18:55:27.964 +0000 (UTC)
Received: from github.com (hubbernetes-node-9fe6a79.ac4-iad.github.net [10.52.145.30])
	by smtp.github.com (Postfix) with ESMTPA id 554D6640BC6
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 10:55:21 -0800 (PST)
Date: Wed, 07 Jan 2026 18:55:28 +0000 (UTC)
From: Dmitry Baryshkov <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/b35b6b-38ac68@github.com>
Subject: [bluez/bluez] e73bf5: shared/shell: Don't init input for
 non-interactive...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2E3tJAIsPS2eJvEZdbdOipSFHMeIdYceY9IQHBHxVyi4FCEd8uOxM+FJ0GG?=
 =?us-ascii?Q?0Wa5ftnwomUe4GYgxDYKU9O92QecVjv5PD4aFNl?=
 =?us-ascii?Q?1r7EKbHoHR=2FgHXe3XCCGmjVX9F74adXm78kh3aJ?=
 =?us-ascii?Q?JW4VzdYtYXQf1eX7A3VGllUn4bK2dUDYkZ8S9X3?=
 =?us-ascii?Q?f0w1HgtIc=2FXfnvES3meep=2FRhpqhuM2OAI1BtIde?=
 =?us-ascii?Q?3HOtU+63=2FQ1dhbcPapQeUoDKfFYFD7Zeem4LwGx?= =?us-ascii?Q?Yu0L?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: e73bf582dae60356641a32fc27ae03d359ec4c47
      https://github.com/bluez/bluez/commit/e73bf582dae60356641a32fc27ae03d359ec4c47
  Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
  Date:   2026-01-07 (Wed, 07 Jan 2026)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Don't init input for non-interactive shells

Only the interactive shell is supposed to read comments from the input
file descriptor. Rework bt_attach_shell() in order to stop calling
input_new() / io_new() in a non-interactive case.

Fixes: https://github.com/bluez/bluez/issues/700


  Commit: 38ac68e239090f01eb39511921a703667266c310
      https://github.com/bluez/bluez/commit/38ac68e239090f01eb39511921a703667266c310
  Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
  Date:   2026-01-07 (Wed, 07 Jan 2026)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: make bt_attach_shell more obvious

There are only two cases, interactive and non-interactive. Make that
more obvious by using if-else rather than two if-checks.


Compare: https://github.com/bluez/bluez/compare/b35b6befb12c...38ac68e23909

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
