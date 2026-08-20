Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345FA397E86
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252389; cv=none; b=c8ziYrtPG2PjcB7YiaXIdsCVbhH8jqsun+jQ22XfFqTyT42X9wQV/1LnnCZUGveM9ItFPy4rttZzSreFUJAntZ+c5zSxMw050UWkrlCbvITkyq73wNJh2HjCVpqNakYyCG51NpS1RhRFJAGhUAPs902hCH2l2HmgYHapSsgnPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252389; c=relaxed/simple;
	bh=mCwjTRD5ypxCzIkiNdN/EsGrkmRNEgJw4+suy5e33ZM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jZ1QiysxgBc9MIyBVspOHjn9A6BciD/NqZmRHZ47lfan4Jzk9Dc2GsnhTWY8A2FawcNLGiIBGIavjA5B5yj32iQgNU6eVYZeHHrn9Iofadof+g7u5dN8OOsVycuIyekhUn8pVSwc/RCikadIJGC8ivqg8u4aaWdRnlvXLHPzVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=m49n7a3n; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="m49n7a3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787252387;
	bh=63uCAaAoUo+uREmmlN3O5gbMoKEExFys7gIf+CwO7yQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m49n7a3nMRNKHJdtbb9YMMtMuwu7ZdwlXMNLZQvRT6BfZn+nyIUYqjj4c3wGtWpWH
	 hVtyfbZy7HVrLEja7VcsmX+MOikVEJB4u+GodIL3VNQwUNe0ux1ocFZr6q9vlCNWSu
	 9usZbviIWSR0u1vQm8yIseCN5OS1Wd7KgaxH/0Ko=
Received: from github.com (hubbernetes-node-bdfe5d7.ac4-iad.github.net [10.52.172.39])
	by smtp.github.com (Postfix) with ESMTPA id 217D3324271
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 11:59:47 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:59:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148699/d917c2-000000@github.com>
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

  Branch: refs/heads/1148699
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
