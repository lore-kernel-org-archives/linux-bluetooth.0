Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A61327C18
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539258; cv=none; b=DfOXt86GvxcETDJdu5+pznAgvmQJonBIrsMw73bJgxQgq/DzyjbAzLaUiShnHznusA6agdrJyttNSO8WTpMcDLdqo4ys6Yw5YOkJ3S2omVyI/6xTgrjfs65lDq/0Fwj/Fn0I1PCKtx94hY1yuy5RApEqd0TRJA6ZIAByeP/p/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539258; c=relaxed/simple;
	bh=vurqb4BTW8L9Wz41/7Zkq1vHlAvtPSw8w5M3CjtKC/8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eL3iPe2axMN/k0PMm4zjROCFRCIE/oCZpu/ACs36Ok4pkQr/mmw+pDW9YZnpYXIknnXESyvD+BNYoroWdoPbz4YEfNOcrzuwseQoCDcyfYRBd768K4d7PGrTducJbMp59vJcEVTku2nktGKRSPNbr8scZARdIpilIkbq7mlK8kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WVkPkDpq; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WVkPkDpq"
Received: from github.com (hubbernetes-node-3cf1e0c.ac4-iad.github.net [10.52.202.116])
	by smtp.github.com (Postfix) with ESMTPA id B832A213E4
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769539256;
	bh=rLQyjzT7yqMGIgT1iQsHP34iikQSlk0EFU9l73PcvhU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WVkPkDpqUJJpzL7sIsTXQQQpbXTkOlzjYz3ZLpOHNXfNsGJRO0wjCux0a/cxg5WNl
	 XLeGagXZEaoiEBUkonldE2MrAmFZBPm2u6asOm5uPb0jen+/o2YrjKg1Utg191y5z5
	 RQFxbvcDYENJfabvu9ACGhUU05cWZz/V3q7G7p8E=
Date: Tue, 27 Jan 2026 10:40:56 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047700/4b543c-000000@github.com>
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

  Branch: refs/heads/1047700
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
