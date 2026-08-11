Received: from out-38.smtp.github.com (out-38.smtp.github.com [192.30.252.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71363403E1
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 20:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786481870; cv=none; b=KjXi1F+PQV9OJYayMfdHY44ch8rYTTG7nH64sa4UOz6QVZPMAf8WzsTKnSjNt8YCWDQsIZA1wNhoe5F67NNOaZfgmCrtLoJ8xBVdCiscP7JMO6BS6Ru7Nfz10QdcwF9a8FitLixq49jyVVAGFozwwGcNuTQo/GYloAWI9WgJIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786481870; c=relaxed/simple;
	bh=UIRfMDrXViZ1dt991Kl3w/b23Sg7CS74Cim07Uftet8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GSHXq4OFv+xx1Wsixp0N+5xlyzyWJ2sZGLjQhsdhFscv3vKFRyzJzd8TXefKSWh4+wH13szKD/6lM9kB4js4ie4HWlPDzI0AhxipJmxfFNFy3N2IWzxvJJzcFKFkbs7QII0DRxzb9qa5l2nWZ98cSRS6Ebe9Nn1RJcEoq/PkiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=nHqDimOb; arc=none smtp.client-ip=192.30.252.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="nHqDimOb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786481868;
	bh=PmaYj4ZzUjuDtDuAn7ohClk9AqLTTLKDKeZ2Yh/6nN4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nHqDimOb9RQ9nWtF5NdYzgtZV9rhHpCiKnW/90WwWxxKD+PebXzYing66CMKFY31d
	 loqAUjknY8vLZv6FMdHJwpv2Om6Tfntm9qWEsJHag2w0VKLiurVglIEAByR5mETLAi
	 goMKy2wLV9ZwY219vssh+u5eJXzc8ZEnYi+EJ62A=
Received: from github.com (hubbernetes-node-e23c4f0.ash1-iad.github.net [10.56.200.56])
	by smtp.github.com (Postfix) with ESMTPA id 2D815921178
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 13:57:48 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:57:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142951/91f1be-000000@github.com>
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

  Branch: refs/heads/1142951
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
