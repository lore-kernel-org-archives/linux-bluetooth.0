Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2147A38A710
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208205; cv=none; b=eIiX0n6lgX60xtTvm7fudqpNwMAoVWVvptfAMdYVPKcruEDaAyyHawstv8cP1JcxX3oUaB5DZbb0FmFiNYj+jPmD9ewIGImOIjYDvpSwlsyjq8hh7UCu2gRBhSfMwgKzF3MJTuHuhXYSFiyrVV0hi3mkUALdRDqUe4H91ih0TN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208205; c=relaxed/simple;
	bh=VjJricKD9Y+WHp64+3QcRzVIj1c9JeoPF79bMfI3pgU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YvBVYRoRofMM8dQMjYHOAFxgK5X1V+eHW/d9g1yWjRz0aF+PVpElJ2+n0+EEoh7Z6jBRMH1C77uU+vXkTMJhfHqozhUOn2HSlk5kppEGnU0BLn+SBi1Zvkn9cyOazaIdcF6FErI+cFfqb9RCvw0T5iFZ4GBb368Q0BtJ5KXvHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BYOJwjoY; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BYOJwjoY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781208201;
	bh=bdoytplsVGI2Le6o7cl3H2B2/gjSn1Rdfsps/yFDoZE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BYOJwjoYwX+SAhds+Tsu0IpxapVjLVbzrJRSIYBjF2J1cAS5eYWDHwnKP5MyH97jt
	 ty3iv7ALQrQVG9Tf/teTKZ+gDxaVBLWuTYiydDGzq2DM/SYj9uwDvs/16kjz7EdxZB
	 YEz+wlhK7qeXg+E/O7B892+6kHtOVIe2fjidRELc=
Received: from github.com (hubbernetes-node-d2161f0.va3-iad.github.net [10.48.12.74])
	by smtp.github.com (Postfix) with ESMTPA id 083AE7811F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 13:03:21 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:03:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1104856/269d2a-000000@github.com>
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

  Branch: refs/heads/1104856
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
