Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97421CA0E
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Aug 2025 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335609; cv=none; b=aBtekWg7wmEE45INZeFwGoOaSCgTQp2uuroo0ao1YErsvNAY8lVrGNqAjcIi5FjihWqxL/nWfa2XgLYZ1/RHB1kXyjY71IeWMDQ8p+7IB8tXNUms9PdjpooouRwST7+kdK1gh6ShQ9S606w7l3LJNBPg+hLM2+cqH/c/wYTWFfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335609; c=relaxed/simple;
	bh=QlLnuTCuyf1OCNLQ0WTeBuvuib0Cm8Ru7rfzBaPjt+Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=scjBJWW4KPp72V8tfQ1lSRoa5JF2IRv5xiFOzPkXmuBDN7TyZbkT5/3V8IetqK0Un0jgJafHqDEvP0hRzXMpghK4aLNwORpADxW9Lno8I4bichKcMPbMjJEpt0m986uBJtkf6epwGDwVz0JoEDLbabC2M8tSg8BvNbhG8RjeuiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UT2AT64r; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UT2AT64r"
Received: from github.com (hubbernetes-node-65143dd.ac4-iad.github.net [10.52.174.54])
	by smtp.github.com (Postfix) with ESMTPA id 93BC320835
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Aug 2025 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755335607;
	bh=qZP4tD75dNRee+B3B5IcPk3Vm5v15SIeyin+sFvmck8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UT2AT64ro4kPUduqAJaYgMSyor/D7XlMnmdjvMsAimopLHxAbccrIsjbni2uKMLCG
	 KfbD6hZPaEpElnS74et/mjhfpVVMWx8p6VwEMcg7R5IS4QX2TH3rTClYrsjblxlakX
	 CR1eBtLCzdETXxzhZ01SE/mLZ6j5mhaum6ctEH5M=
Date: Sat, 16 Aug 2025 02:13:27 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/992140/000000-40cdfd@github.com>
Subject: [bluez/bluez] 40cdfd: transport: fix A2DP Delay values missing from
 DBus
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

  Branch: refs/heads/992140
  Home:   https://github.com/bluez/bluez
  Commit: 40cdfd1c961462d3fd889521ecad078854c31d64
      https://github.com/bluez/bluez/commit/40cdfd1c961462d3fd889521ecad078854c31d64
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-16 (Sat, 16 Aug 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: fix A2DP Delay values missing from DBus

With headsets, a2dp_transport::session == NULL usually until stream
resumes. During this time, delay_reporting_exists() incorrectly returns
FALSE, because streams corresponding to NULL session cannot be found.
As no further "Delay" property updates will usually arrive, the property
remains missing even though delay reports have been received.

Fix by setting a2dp->session when processing a delay report, if missing.

Log (bluetoothctl):
[NEW] Transport /org/bluez/hci1/dev_XX_XX_XX_XX_XX_XX/sep2/fd1
[CHG] Transport /org/bluez/hci1/dev_XX_XX_XX_XX_XX_XX/sep2/fd1 Delay is nil



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
