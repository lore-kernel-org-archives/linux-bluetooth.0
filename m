Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574538D011
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781431595; cv=none; b=aIKJaHfVma5s8rGfVEyxHEqd9/hbm8IdTSn4z65rIBv0+sQ/X5ky0xyqGCr06m30JNNtNCElCaxeV0fPKMyfP9nLBtjtcdWQc75GanNTtagBkYL6JB+Wkm3YcVgxo8BdBUVUciAU8y7vTmclib4W8NiXozFOkS4QzInWFy4GpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781431595; c=relaxed/simple;
	bh=yi9mrekZvzXmPJCuMWgRBiDSMOkWGKnjzrlR039hFCM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CZgTTsj+Fq+RMeNqDi7lL9jfWofZIAjg540r3hvJH5M87+v4JHK902kKZMu8hmTYTJq0lkbMWDccBoHXvr7U1JNO2S9U1RS37GHMkUIwv6tcpjcb85oxkkO7/qjgjObxJVAXLspYRKB3z6IjUFM4bYCvTCnF8bFZexT4KM7rzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FMI5yT23; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FMI5yT23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781431591;
	bh=8PzDwZoKv6BtsDZ8DNdDrO4IxDgb98K8q0CvTZL5apw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FMI5yT23Rf33sfdZ5mMVny48NHO6v+i5jxshhV0Xabh9enxspQKd9LfO8qhzOadCQ
	 tt1jaRxP28B7xllSW0z1JNbQz+W1ihoItLfYaiCMiv6taXMWjAi2XGkpR62ZcV9Jki
	 3Iqjj0CZSlqnFtAEX+kEGmEgDgAcW8IvTSB1Ssc4=
Received: from github.com (hubbernetes-node-e067874.ash1-iad.github.net [10.56.207.19])
	by smtp.github.com (Postfix) with ESMTPA id 79964600C7F
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 03:06:31 -0700 (PDT)
Date: Sun, 14 Jun 2026 03:06:31 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111248/000000-964d7f@github.com>
Subject: [bluez/bluez] 36c635: shared/bap: Initialize ucast/bcast IDs as unset
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

  Branch: refs/heads/1111248
  Home:   https://github.com/bluez/bluez
  Commit: 36c635d5936726274ecb7cc07556be591a2248f4
      https://github.com/bluez/bluez/commit/36c635d5936726274ecb7cc07556be591a2248f4
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-14 (Sun, 14 Jun 2026)

  Changed paths:
    M src/shared/bap.c
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Initialize ucast/bcast IDs as unset

Also change some lines where CIS should be used instead of CIG


  Commit: 964d7f50d6baeb1b506d9f96f469a0ecf205ac85
      https://github.com/bluez/bluez/commit/964d7f50d6baeb1b506d9f96f469a0ecf205ac85
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-14 (Sun, 14 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Don't link server ucast streams before CIS IDs are assigned

bap_ucast_io_link pairs streams whose CIG/CIS IDs match, but the IDs
are unset in Codec Configured state, so a Sink and Source bound for
different CISes get linked. The stray link later propagates a
disconnect to the wrong ASE and breaks Receiver Start Ready.

Skip linking until QoS Configured assigns the IDs.

Fixes PTS test BAP/USR/STR/BV-362-C


Compare: https://github.com/bluez/bluez/compare/36c635d59367%5E...964d7f50d6ba

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
