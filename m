Received: from o1.sgmail.github.com (o1.sgmail.github.com [192.254.114.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639EB28FFF6
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.114.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946410; cv=none; b=f+cCxRU2DIlAATZX7qnrmzG9atpnugUB9ODAsIOdwF59mVgaDg5xSXE3mQoDncZ/BkCENtWumdnKfXyHhhtv7YYKUdlaZSoJBeIrYrIbXeWx1lmsjfo14cIHZQJDIqBb0BFgYJDzqQOfAyuXDeYvHk5qkJLxjumX4V7M48iWvSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946410; c=relaxed/simple;
	bh=ygA/oYaJOXjaETMhtr7YKlHIZcVvRfJoCBQbx4+ii6s=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=WqLBxycuo6tR0fbH6VbcvQAoEqys+Xx9TDOXq6DZ0NF4ZoPn5jV+bmzKCRSEA8SX9as2xkn85yw5e4uGzypmkand4bj9v+mtbtqBkdhrtf7AaQI7Krm/c2HzzNuqJxrqDMwKxQ5CtLgKyPy0tyHoBV+E+xkWAfZFcJGy7mHW+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=xaWfFAMH; arc=none smtp.client-ip=192.254.114.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="xaWfFAMH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=PtdexdvOE0f5NsScYhhvmARSSMaHGDkHO7YI+7Ur3M8=;
	b=xaWfFAMH5fT1MER05gH84VCE7b9wOAbGCwfPy397J3NM3XhbX0VK1IA5PVPSw66FcIwN
	ZkaNbq9IQZLaTxu0pzig5QTgTf0Zdo9eSMthhyT2MxJwsXo9m70IaxeAhS5msYmCbzq9wL
	DvDZbAqmyStsOAtwNuRSNmXUQljA2dmf4=
Received: by recvd-5ffc458897-brhxf with SMTP id recvd-5ffc458897-brhxf-1-6932F1E4-5D
	2025-12-05 14:53:24.728591587 +0000 UTC m=+2666996.100737919
Received: from out-21.smtp.github.com (unknown)
	by geopod-ismtpd-58 (SG)
	with ESMTP id nHf1HS97Q2avmeADZ1UxBA
	for <linux-bluetooth@vger.kernel.org>;
	Fri, 05 Dec 2025 14:53:24.712 +0000 (UTC)
Received: from github.com (hubbernetes-node-a71872c.ac4-iad.github.net [10.52.211.112])
	by smtp.github.com (Postfix) with ESMTPA id D2102401207
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 06:53:17 -0800 (PST)
Date: Fri, 05 Dec 2025 14:53:24 +0000 (UTC)
From: Pauli Virtanen <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/d383c8-c42a49@github.com>
Subject: [bluez/bluez] c42a49: main: fix bool vs. gboolean type in
 g_option_conte...
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
 =?us-ascii?Q?u001=2Ezu6eUoWwK70GvXWP+kE2GIYMQflaq6Ix3rraxcwcvSqstVpfwwfs1H7iT?=
 =?us-ascii?Q?j=2Fu7Mau0w5pPZd2OpCSrPHF+2C5b=2FFyvmurMMnZ?=
 =?us-ascii?Q?=2FoOZn=2FsG36z0RYylOcx=2Fl68PCFZ4yDku0wejVgN?=
 =?us-ascii?Q?eqLnn4otdZw=2FDrWebq5UZMSGhoIc14KnxkAcr+T?=
 =?us-ascii?Q?6yfuGqSWqBFTfq3h7ZHdkDDXGfjwiPaY38RoAxP?=
 =?us-ascii?Q?7wL1BlPsItLEj0ACn8RcaY1qsEdvjLBkWI49emV?= =?us-ascii?Q?XfSC?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: c42a49a243e48182b8d5050949cf26e9a961afe6
      https://github.com/bluez/bluez/commit/c42a49a243e48182b8d5050949cf26e9a961afe6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-05 (Fri, 05 Dec 2025)

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
