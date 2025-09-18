Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED5B2749EA
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217823; cv=none; b=QBaAnKY3J4BrkSqGLEdju0r17wH7g9tZIwTwb7riO+dQWrE5YbwyvEqNnrZTKMrii+srTmBDb9zNeZGbTdt5QIzhBo1G7xjEaOQX+4vCGCm4397F6RdI3stAdFRo5CgyyVscDHEusw9yy4gZ5UABw1ZPvO1j6Mi0ARBgT3wf+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217823; c=relaxed/simple;
	bh=bSsf66uVyMgyxIBediaMS1meofYMvu7eWSdag666Tf0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=b3tfQUVc5WsVuWSoYrRF8A3hVFSuteL9wj0abSaMjQWtbkBjf0guz7pQSALFY022hrCAOmRgITMFWkXE86tvj5ct16QrrVV/97Lm7PzxsJiZ8rrG6HHJ96Jh+5HUVId6OfDKr0iKBmIghMHsKGqQLdW5bkHma0nMVH7zkoX+cQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H+4j2blQ; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H+4j2blQ"
Received: from github.com (hubbernetes-node-b4921df.va3-iad.github.net [10.48.201.83])
	by smtp.github.com (Postfix) with ESMTPA id 320E2E09E0
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758217821;
	bh=QkY5lv6MLs3EtytSStaqoh1jFvaOPJ+tf8NAqm2jk1U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H+4j2blQy5Lc/4yWAMdV9sOsdlRsrNOTzqFdhpxQdhhlFx9/Ki+8H+55SLI7G0WiN
	 VHlqsTEiKoXoPc63DiP0FYlH3w8Yx757FIOayhxuYNkQmSu1DsLmTat/ZxWi/rcWuV
	 wnIhlItTcQiQ50+nyhMlj0FIoetG650C/z1ktWmM=
Date: Thu, 18 Sep 2025 10:50:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.84/000000-632f02@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/tags/5.84
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
