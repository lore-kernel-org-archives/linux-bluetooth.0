Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BAD273D91
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169069; cv=none; b=BcMnhqvHbB1/5YkFk44B7eykMux5YgXyx+ojzegzGmxB8a5Mf+l9yGYz3Br08SKVsz4x08GI+0/MNNMu/1VmhWz88HklrvnYlr6dfRc678N9/s4POJenA+7wsfBRwC0JymvWHdHLCoWOnslOuJ9kkPam7lc9LmnE4Zsf4FtxkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169069; c=relaxed/simple;
	bh=WxcgN088AJbDz5f1VcwVYKP+aHOPb25jPLN2fMScHik=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lcCQfAVsvQ6gdD970ZdCiDlOCW8i4j99NPxfrlg1OFNWvRhX+lVbtO/u4QXteoRaTE5Q6hK+sgSxHFJQorKk4QDt5otVff0d4VhA3uN8dE3vV2N7yroe302MDU+dsEpvX7yu+ovPoK9YMzcY++XB+Z+VXMX5mZ2Ksh3LdCA5Vvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=L+Yq52cL; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="L+Yq52cL"
Received: from github.com (hubbernetes-node-7983da4.ac4-iad.github.net [10.52.168.50])
	by smtp.github.com (Postfix) with ESMTPA id B37397003C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752169066;
	bh=wdWaIb/wCUY9TFwUQLMvPI9YTktF3RFlJLy4x5mG6D0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=L+Yq52cLw3Qcp9JXn+6tFPrTyvwmmhSAlW1FSaKUA/zL9ybaWGErftaNBWf+5dflD
	 algF68AQGhnvedIzbJl3EvVfpiD9WFW609FcB+XKH5rXQpddNK7yIkKJlJ26CWNMIe
	 NgxepZxcXPVCt2wPfiMRhVKjI8qp12ZAQU5A27VI=
Date: Thu, 10 Jul 2025 10:37:46 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981156/000000-1501a1@github.com>
Subject: [bluez/bluez] ac421a: shared/hfp: Add HF SLC connection function
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/981156
  Home:   https://github.com/bluez/bluez
  Commit: ac421a8449581d35f592a9de605d9e4950daf198
      https://github.com/bluez/bluez/commit/ac421a8449581d35f592a9de605d9=
e4950daf198
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-10 (Thu, 10 Jul 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add HF SLC connection function

This implements the minimal SLC connection exchange, i.e. AT+BRSF,
AT+CIND=3D?, AT+CIND? and AT+CMER=3D3,0,0,1 requested to complete the
Service Level Connection Establishment.


  Commit: 8a00a8d37d9cf46dcf9a531ff55dd5c4e06e1bce
      https://github.com/bluez/bluez/commit/8a00a8d37d9cf46dcf9a531ff55dd=
5c4e06e1bce
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-10 (Thu, 10 Jul 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add SLC connection test

This adds minimal packet exchange to test the SLC establishment.


  Commit: 9431868d965ce475e1f569d5ddf4b2f7934379a8
      https://github.com/bluez/bluez/commit/9431868d965ce475e1f569d5ddf4b=
2f7934379a8
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-10 (Thu, 10 Jul 2025)

  Changed paths:
    M src/shared/hfp.c

  Log Message:
  -----------
  shared/hfp: Add +CIEV event support

Register +CIEV handler on SLC completion to call the update_indicator
call back on unsolicited events.


  Commit: 1501a187c63b28a567208fb379144f267cfd2f29
      https://github.com/bluez/bluez/commit/1501a187c63b28a567208fb379144=
f267cfd2f29
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-10 (Thu, 10 Jul 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add indicators tests for HF

This adds the following tests:
- /HFP/HF/TRS/BV-01-C
  Verify that  the HF accepts the registration status indication.
- /HFP/HF/PSI/BV-01-C
  Verify that the HF successfully receives the signal strength status of
  the AG.
- /HFP/HF/PSI/BV-02-C
  Verify that the HF successfully receives the roaming status of the AG.
- /HFP/HF/PSI/BV-03-C
  Verify that the HF successfully receives the battery level status of
  the AG.


Compare: https://github.com/bluez/bluez/compare/ac421a844958%5E...1501a18=
7c63b

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
