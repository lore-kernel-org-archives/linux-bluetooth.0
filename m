Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA914EC59
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397108; cv=none; b=iPDkMSiqEPKcLfTdt7zIPpNFzV3omCF7KofrYEKWTI7DqUCtBpUptK6r1z5wZP8qJ7v1yW9TdBf/Lvoo2ffOQPbLAKJROMVzmnm3pwgH1aLP/wwFvWzIOEtgsNwuQGz3z4zS4/oy4MNlZiUovcOOIqdLaJcpbh3p9JmRU4X7OwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397108; c=relaxed/simple;
	bh=UQoqL3LyZdE+TC3Mg5KqGKWrjCxIXMIRFHKHsGwAvIk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EMI6NCt3DcBUx+4Wi4/flc7+LFiZk2ZtV+J/O9tUIsG3z7ZEerJsf7lU2MiqvjreMEJS1CwDDmX76qwOJlo/ZNA6cPUH6OPbA4IQSeAQpuupWF6vLC+xtEFp5m05NhgkBk+h3T6/sM7pe1hImZIVbMoEVqPz2M3YD4XBti6tWAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RNEQNuIP; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RNEQNuIP"
Received: from github.com (hubbernetes-node-e82d150.ac4-iad.github.net [10.52.140.40])
	by smtp.github.com (Postfix) with ESMTPA id C2CC55E1109
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1728397105;
	bh=EoHW8HEJIj4ecCLJ6PgJs+DlzXX97f1I+Qi1nd0tFTI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RNEQNuIPjTb88CviUvU1Qyknp5bMeUCcDlBGDLjlpGe/a9iXr62+ZCKAkGzA03sTQ
	 mRybvkaS0BLReYGhEaylDcjNANVVysx/X4jK61vGLE8m+JLLhaklyVKfwRRjhBoYDF
	 Ebhr2AGQZdb93QYGPd8zCg3q6bjiPrA0a6ckGhzM=
Date: Tue, 08 Oct 2024 07:18:25 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/31e5b8-bd7d49@github.com>
Subject: [bluez/bluez] bd7d49: avdtp: Fix state check before sending delay
 report
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: bd7d49d54aa3aa490ebdd67b3dd2317d29213d45
      https://github.com/bluez/bluez/commit/bd7d49d54aa3aa490ebdd67b3dd2317d29213d45
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2024-10-07 (Mon, 07 Oct 2024)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  avdtp: Fix state check before sending delay report

The function which handles the incoming delay report command was fixed
in 2fd62cd. However, the function which send such command was not
updated. This commit fixes that.

Also, indicate that the stream does not support delay reporting with an
appropriate error code.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
