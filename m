Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C5340DB8
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611188; cv=none; b=u9tnadYn0iuZKAOlC8KfQeTlAwzDEYOYozBK4v3SN3u4aivICMfzQynPq8fPm/SUUa4fNOGH0xaZOeA4SI9Pm4U8+cdt5Byb2OScufwtemrvhw/YPbFtw9SKEnUzyQ5VIQX0uib4BCi1VKIHApLEOBPMn4o2HIZlcCwBseFOVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611188; c=relaxed/simple;
	bh=Gs1JZbXjSp3xdLuNbmROVxm4/LKeycaSr94ByE0ZjlA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=s3dyKwKdlEYWGtb+7fOlHHWbx37IHne/r8V1QQT47o+CpaeFEbHQBKErfoD6ZZhgm6oqkrYVYUg6kDQ8d2dGyCwmKzUldIwroFxBs9nyxVybQwyXmjPhq8/Jpa0sOkW4DYpugbsCf19ell1Qz6r1ZGD6yDPZiWF5FcbaUi+itPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=i3zyy6cJ; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="i3zyy6cJ"
Received: from github.com (hubbernetes-node-766d89c.va3-iad.github.net [10.48.142.40])
	by smtp.github.com (Postfix) with ESMTPA id 4FDEBE0A39
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755611186;
	bh=CNGHDI7G/fgQXiPKR/VTJwkwDmiGxCVGxBBR4zCIFzk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=i3zyy6cJDF4cPT3qqcmrER0X9cAq8aev2wGHAr3AutdaZr468OFFZ75xKY9tfcVt7
	 1iJiSFAwWVeISvn2dS3HOSZFVxyBdrLayXWvDIkpIZN5XGzuLwQ4uneiG3eIqPhPrT
	 qtBYaRIKH80zEn2WS0BJUZQMcWNjGFrtmoSenq1Y=
Date: Tue, 19 Aug 2025 06:46:26 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/993065/000000-b779cf@github.com>
Subject: [bluez/bluez] 7784f3: shared/hfp: Add HF SLC connection function
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

  Branch: refs/heads/993065
  Home:   https://github.com/bluez/bluez
  Commit: 7784f3a2330691d887775b8f8066f06aed33e184
      https://github.com/bluez/bluez/commit/7784f3a2330691d887775b8f8066f=
06aed33e184
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-19 (Tue, 19 Aug 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add HF SLC connection function

This implements the minimal SLC connection exchange, i.e. AT+BRSF,
AT+CIND=3D?, AT+CIND? and AT+CMER=3D3,0,0,1 requested to complete the
Service Level Connection Establishment.


  Commit: f6b7ba9862463c36035398d2a7093bfd63743c2c
      https://github.com/bluez/bluez/commit/f6b7ba9862463c36035398d2a7093=
bfd63743c2c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-19 (Tue, 19 Aug 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add SLC connection test

This adds minimal packet exchange to test the SLC establishment.


  Commit: 85d1ebcb539e4d55313caa393dd05cf8986a3b59
      https://github.com/bluez/bluez/commit/85d1ebcb539e4d55313caa393dd05=
cf8986a3b59
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-19 (Tue, 19 Aug 2025)

  Changed paths:
    M src/shared/hfp.c

  Log Message:
  -----------
  shared/hfp: Add +CIEV event support

Register +CIEV handler on SLC completion to call the update_indicator
call back on unsolicited events.


  Commit: b779cf81bb82941d709040d93e02b9003ba6a6d2
      https://github.com/bluez/bluez/commit/b779cf81bb82941d709040d93e02b=
9003ba6a6d2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-19 (Tue, 19 Aug 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add indicators tests for HF

This adds the following tests:
- /HFP/HF/TRS/BV-01-C
  Verify that the HF accepts the registration status indication.
- /HFP/HF/PSI/BV-01-C
  Verify that the HF successfully receives the signal strength status of
  the AG.
- /HFP/HF/PSI/BV-02-C
  Verify that the HF successfully receives the roaming status of the AG.
- /HFP/HF/PSI/BV-03-C
  Verify that the HF successfully receives the battery level status of
  the AG.


Compare: https://github.com/bluez/bluez/compare/7784f3a23306%5E...b779cf8=
1bb82

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
