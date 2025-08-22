Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0B2F9988
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870762; cv=none; b=bswUxiiEpUoGewa50bbX/bEKaCMyuIwjTId/DzdIIgWIidDikwSBciTretH7+YVgcvCU5YnowT+3d22Z34xLK/yEe2k9CxGPaL1m2e2Eo5cyZFT6oaiznM1P6cg59pRUc/Z9F22htGnFKD707ugbnOUp1zAWpVPbIlGnVXx0Rxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870762; c=relaxed/simple;
	bh=9O2E8hmAmxpI6dJbdXsn7qEpO1gWyvTK2KKogbUuY0k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IDGfuSywYY3nGMBa8vvAk8SXzEvTD68tLyutvRBAzkSjUwh//OxRMlCq1LL5eGX2q7nvqHwzM0IgvR1ynF6JQjk/QPFhoj3pXRK4XoWIFYn5uDJooWHDdDkgDUqDCatB4DJ5ktXe8CGwcu7h50vdsO/dqn+9SDyKQvzT2DIRC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Lq30JQFs; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Lq30JQFs"
Received: from github.com (hubbernetes-node-2174de2.va3-iad.github.net [10.48.170.57])
	by smtp.github.com (Postfix) with ESMTPA id 6B318E1215
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 06:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755870760;
	bh=PxvRCozkQMwi50QcRSUr0AxEtrzZJxzhNAIM7F6XLsM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Lq30JQFs4Y016hc4kpZ39w5lOgt0EZsxIrHFR+S2t9ibEkDJ3O3/2UH1V94dzVHtl
	 CHe7AFs5Xz061B2Gs4ztsCG4EfozdGjQHyZtTa357LrKxiVL/cE87NrShPRJe6FEHJ
	 +F2t0utFz3BqT5VkXt5CKxJVLtFtYC8+6ucZVXEc=
Date: Fri, 22 Aug 2025 06:52:40 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4784f5-3acfa2@github.com>
Subject: [bluez/bluez] dbf96b: sixaxis: Fix official DualShock 4 controllers
 not ...
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
  Commit: dbf96bb28a830ba6ecb3e726b3b21eb8c9077ca3
      https://github.com/bluez/bluez/commit/dbf96bb28a830ba6ecb3e726b3b21eb8c9077ca3
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-22 (Fri, 22 Aug 2025)

  Changed paths:
    M profiles/input/sixaxis.h

  Log Message:
  -----------
  sixaxis: Fix official DualShock 4 controllers not being handled

The devices changed names, and those do not match the expected name in
our list. Ignore the "Vendor" portion of the device name before matching
it.

This is most likely the result of official DS4 controllers now being
handled by the hid-playstation driver rather than the
community-supported hid-sony.

This fixes DS4 controllers not initiating cable pairing when turned on.


  Commit: 3acfa2d50a9f066dd7962885d205ec5f782c2f5b
      https://github.com/bluez/bluez/commit/3acfa2d50a9f066dd7962885d205ec5f782c2f5b
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-22 (Fri, 22 Aug 2025)

  Changed paths:
    M plugins/sixaxis.c

  Log Message:
  -----------
  sixaxis: Initiate pairing for all cable pairing devices

Fix the cable pairing not being triggered on DualShock 4 controllers.

Note that this still requires an authorisation when connecting through
Bluetooth the first time as we're not exchanging linkkeys. Sixaxis/PS3
controllers aren't paired, so don't have that problem.


Compare: https://github.com/bluez/bluez/compare/4784f58ff0ec...3acfa2d50a9f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
