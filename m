Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60599204583
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755553104; cv=none; b=cwoPW6yRJi76hnC4gTwgu1DzltnpjlZfZitpkmfpWBQvd+8uDt5PJ89yhN9y/AaGszzuw6Ox+KaPypJJPiecMdNe1EVkF8ajFXtYgzIkhMMDJjEik3J+N/VuIKn17hvcQXqjIRJL/cwuvBhNCQbxDEvS59ty3eoYWrtakA7Hu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755553104; c=relaxed/simple;
	bh=fQfC2s4O35UoiuQ+bvHn26lP/K9YkIqZQkK1SBThHVQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uX6r7D4I1KcbculainRkAg78xgMnkQb+H2bownLfaxvZ2y/D/Cx8mrgojhD7mrmakFqb2ClMNdDI/7AFUJsg20UNnhwBzuo54svP7/GzweuxqsV1eWVvHLNCU2FHDgjJ6NThdVWyT8LkrhYw4DEOrROtOhHq1ylMGEMnF6omxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aL330ee0; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aL330ee0"
Received: from github.com (hubbernetes-node-2e44776.va3-iad.github.net [10.48.207.58])
	by smtp.github.com (Postfix) with ESMTPA id 74C35E1071
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 14:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755553102;
	bh=QOtB1mAtNhEPlAC9reVT1cNE6GDio3v2KTqPJpDGiFQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aL330ee0pMEvqfgINuGeaCcgE46nXuC+zi5IPYHrVFDpI/fAcVb/Hupgqbt+s1WJn
	 JsZ62qqrr2LG5ysrrjqsTSmekbq7yL3AzYVMei+6ZhEmzM0dpymS53So0pSN8z0ten
	 TfIrX7KazGmvpssDWazhMCDN8stGzCHBT71xaQuE=
Date: Mon, 18 Aug 2025 14:38:22 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ce8216-0bb66d@github.com>
Subject: [bluez/bluez] 0bb66d: transport: fix A2DP Delay values missing from
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 0bb66d3d1abd7d25b840d535c03b1b9613727d5c
      https://github.com/bluez/bluez/commit/0bb66d3d1abd7d25b840d535c03b1b9613727d5c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-18 (Mon, 18 Aug 2025)

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
