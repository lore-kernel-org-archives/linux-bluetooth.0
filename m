Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378E3B389B
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451628; cv=none; b=nstc2H/1bIh8QhcHVqlJKz3x7yqDg7Wx0lP9z7xAR2Iv02y8TWr6l6I6csyPDbGPjVfpJwsJk9H3MPd35G9gsGN4OScSrvDCQS5grsP+wJjtVN+p8cXBDxvHbAyqaVzX1543llZRRGngEpDFvrMMvWey/igM7Qs01jtfMA1ghy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451628; c=relaxed/simple;
	bh=3RVxQI1q9p72V6nRwYEiCbmO2i1S3+deYtCHOCikh2M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YLKeJqGZpxSBB/JRAf7BQc2hEbbbEGGdzrTAGV+WBF9ZXIIDHGsx6bFYbGd7mY+1s5hrrrxaElv3WsiT+wpPi4rO/9HB0vnxjwmBFCzl7O0snMtnWYt44GAjxjMbyvAmJyd4S4vvYJcJjqAWhnEXtydutfdXKkJV5SbDllgB/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mtuqzN59; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mtuqzN59"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777451626;
	bh=TjHPhCJ23HLrbg4RUc5j6DfVjPmFz7FbMgl2358H4pE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mtuqzN59SfpsENH8mDw2t2OR9er5NV4V6ssKPt7v4y50lqkSy8AW4abLmzPKWNld2
	 wvjGtoqRwuGdv4HjcK1IzE9JOHPsAtYNDJsjWfbtZ+gvCltuKUK58wCq1YxCdSMwy5
	 npQcx/AGkq10slcsGh4syHW5aekjCZDSoBvbIRnE=
Received: from github.com (hubbernetes-node-de47cf4.va3-iad.github.net [10.48.86.38])
	by smtp.github.com (Postfix) with ESMTPA id BDD392811A6
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 01:33:46 -0700 (PDT)
Date: Wed, 29 Apr 2026 01:33:46 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1087302/000000-b6850f@github.com>
Subject: [bluez/bluez] 8782bd: client: add public-broadcast advertising
 command
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

  Branch: refs/heads/1087302
  Home:   https://github.com/bluez/bluez
  Commit: 8782bd37d41050f7e67433bea2c2c4235f09772c
      https://github.com/bluez/bluez/commit/8782bd37d41050f7e67433bea2c2c4235f09772c
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

  Changed paths:
    M client/advertising.c
    M client/advertising.h
    M client/main.c

  Log Message:
  -----------
  client: add public-broadcast advertising command


  Commit: b6850f0300f916c152f6f6f550ac6a815ce81e7a
      https://github.com/bluez/bluez/commit/b6850f0300f916c152f6f6f550ac6a815ce81e7a
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

  Changed paths:
    M client/advertising.c

  Log Message:
  -----------
  client: make advertise.name use public broadcast name


Compare: https://github.com/bluez/bluez/compare/8782bd37d410%5E...b6850f0300f9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
