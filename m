Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940C3CCFC0
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775235164; cv=none; b=S7Zq0gCqKvtBo93s3TwMV3UKrex8bQdoYuMlwpsdxCzDmp3z90b5uPK0EUVGEAnzpcfvrAQa2kZwVaVYDZnizle+OrAbYaTtQWwHG7TkaUXQCEn2amISqq1AJ5+aipGcDJDu2b6sID5bKJfAUPJHRGDjN5KzT4LqWTgvwii7Szg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775235164; c=relaxed/simple;
	bh=sSw2aARmWIL+1/IB9rY+qkfxlBOfjy/3CdqH+E1a27Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ftGBeBkbh1a9OF1Y5Vx2YCOoW3ER1ofwhIMcPAdLYpop2k7or0hjPUI7TWRRf5jWJOqXnpTBzo3jQ8mELiZmJqcW9nMlC3UA8+WRINocCRwpgakrvPjzd0Sagiv4dv2waljiKORLXvH1kS8ZbymZUtpWT/oOgrnbfbE8Tx8tg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eQmDlHv4; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eQmDlHv4"
Received: from github.com (hubbernetes-node-f6115ee.va3-iad.github.net [10.48.220.89])
	by smtp.github.com (Postfix) with ESMTPA id 9D09C2C1029
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775235161;
	bh=LPYUlHHZuGZcWhWqoVvqynHZ6swcin25uv5G+Olj0J4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eQmDlHv4OOfnPR+9OEwx4Xv/xHI7RkWkpaUEfssScKTmeI+RyITLJBDaPtnpNhmps
	 TN7+CNrw0ioR4ZK+NVeBSDbZYsyzVMByOccdtNYGFdik+M6fwhZcMP4bKB2UNYbEaj
	 rl4vGUWGpndE5oVpMEMdn/vfyvmB6Nq0QA9cqf6k=
Date: Fri, 03 Apr 2026 09:52:41 -0700
From: Kirill Samburskiy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1ce7cf-000dc0@github.com>
Subject: [bluez/bluez] 000dc0: audio/avrcp: Track TG and CT events separately
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
  Commit: 000dc08822ff0ad6730f6e18dfa41a53ce905713
      https://github.com/bluez/bluez/commit/000dc08822ff0ad6730f6e18dfa41a53ce905713
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  audio/avrcp: Track TG and CT events separately

Since we support both target and controller AVRCP roles, we need to
track events for each role separately to avoid confusing events that we
registered for notification from remote TG, and events that remote CT
registered for notification from us. This change is only relevant if
both sides support both CT and TG roles.

Fixes: https://github.com/bluez/bluez/issues/1997



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
