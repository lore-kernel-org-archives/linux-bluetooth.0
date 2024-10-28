Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0519048F
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150182; cv=none; b=m0fhhOy/S/ZHB8OxENlFDpX4AeoYvR1qDCKpUkV/GxIkOylbfEzCk9HvtIgSq28H/FwwLu2Cp2Zzd88IJ+PfnaopoYWTzeQBEAAFWFpFm/HXVssHFYewM8H5nJHqpr/xE/eIQa9ThQP7DnqeyN53BAFRLSUcxYQlYufZmJ+MIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150182; c=relaxed/simple;
	bh=fExLD/gUoKHyx2OAinfqJXxoNpe4FJkVHRGK9NdKNKc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oUoubeOBcxLrZ0C11u7qO7xjZJVsbwgN15QpJI1c4cw6g/BqIVl/RpelsSbQzuNsY0/aeaXDrjFaf+BC0gD44C8eCwGK4ddIRVtjnLUEsBEWxHHNeTTdWpReGDm7byaof6H2vXNi8nMiL07sRxccPbYQALoGpxfFxt+IaWF39UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mwdLpMJR; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mwdLpMJR"
Received: from github.com (hubbernetes-node-03a54d4.va3-iad.github.net [10.48.152.32])
	by smtp.github.com (Postfix) with ESMTPA id 359BB4E095D
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 14:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730150180;
	bh=l5vS0MOW8yzYfsyiQTxHdjKQVeuCbv4ZGd9/YNwdC7Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mwdLpMJREJB0hj+kNRVZKJMkvWCbaU2lWnKZ+Q62C5TC17Du192oO2l8ArAdaJDwI
	 EVNDz+4+H/0CuJ+hrEhQh3FxaQzkirDlx/Cb6B+SOtUSr2LGgrLg+s74wTMbLJL40y
	 IQ7+FFJYBzWbJpH7hM4SaegUGSOJMXXPOJQDOYEc=
Date: Mon, 28 Oct 2024 14:16:20 -0700
From: Daniel Beer <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c009be-d7bb2a@github.com>
Subject: [bluez/bluez] fa1f2e: sink: clean up outstanding AVDTP requests if
 the s...
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
  Commit: fa1f2e5ee14dd740293fc5f491816cb185c6e7d7
      https://github.com/bluez/bluez/commit/fa1f2e5ee14dd740293fc5f491816cb185c6e7d7
  Author: Daniel Beer <daniel.beer@igorinstitute.com>
  Date:   2024-10-28 (Mon, 28 Oct 2024)

  Changed paths:
    M profiles/audio/sink.c

  Log Message:
  -----------
  sink: clean up outstanding AVDTP requests if the stream goes away

If the stream goes IDLE while we have an outstanding request, connect_id
stays non-zero and is never cleared via a completion callback. As a
consequence, the profile on this device will never be connected
successfully again until BlueZ restarts.


  Commit: d7bb2abed626a979037a042c02b9a4027c6eb943
      https://github.com/bluez/bluez/commit/d7bb2abed626a979037a042c02b9a4027c6eb943
  Author: Daniel Beer <daniel.beer@igorinstitute.com>
  Date:   2024-10-28 (Mon, 28 Oct 2024)

  Changed paths:
    M profiles/audio/source.c

  Log Message:
  -----------
  source: clean up outstanding AVDTP requests if the stream goes away

If the stream goes IDLE while we have an outstanding request, connect_id
stays non-zero and is never cleared via a completion callback. As a
consequence, the profile on this device will never be connected
successfully again until BlueZ restarts.


Compare: https://github.com/bluez/bluez/compare/c009be5c5973...d7bb2abed626

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
