Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE812641DF
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099243; cv=none; b=qRpziTjFn1Cf3PrQgGt6JLaRLbKADMOjciAssr9EgcTeerWER+mb2C27PnoJyQvSYtAdk8M49n1emdbNVdjbFvVgdB2uj7LCWn2TxZRqxxmrfmPwwjkJEmZZOkhVDUWrgMUWOSAKecIG/uAHObb+hLlwD3VGn1CVnf9LaI9JTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099243; c=relaxed/simple;
	bh=RKx3mGENoFbmQU0chmCucjaUZaFe3zpTyJfDhY4DEJc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kyD8B5crLyMR6v3zHNUNfKX6ZTPyp+ILDNct6kBpC9C8z8DBL4sLQ0L3LvCgjpULYLBfXoaGFh6SFyK5/8MOysVL+nQ6+saDJY/mvSkdMxSTXVWEoC9SMyF+Vk7N9HMWBGUiRCzZILdyZFugopkhREy/tXDYkXKXIZg8gFgHGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=C5rEe5a9; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="C5rEe5a9"
Received: from github.com (hubbernetes-node-0ac6ab5.ash1-iad.github.net [10.56.146.23])
	by smtp.github.com (Postfix) with ESMTPA id CE3DB92116C
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 06:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1741099240;
	bh=yUr+XER5MqWH7/+PG5Kq4JxMaad6r6x7iwBpwCszAGA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=C5rEe5a944ms/LslURt3ixrS/uxJblKs1RgHWIewmsbbpjQCl5fZsyrbFLusN6Qv6
	 mWWIivAzNjp2vNgJWASmGwWe4g7IlSkMGoEM3g1lb01u/NBxYOnB+oIAxsL07ojsJG
	 ZBvxAdBA9aGTwHWjKv4zH5Mk+hWAn5zr3d4AxNs8=
Date: Tue, 04 Mar 2025 06:40:40 -0800
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8479c2-524fa2@github.com>
Subject: [bluez/bluez] 7a09d2: uuid-helper: Add A2DP to the list of known
 profiles
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
  Commit: 7a09d207fd9aff93ca474b6aa9631abdcd3e3163
      https://github.com/bluez/bluez/commit/7a09d207fd9aff93ca474b6aa9631abdcd3e3163
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-03-04 (Tue, 04 Mar 2025)

  Changed paths:
    M src/uuid-helper.c

  Log Message:
  -----------
  uuid-helper: Add A2DP to the list of known profiles


  Commit: 2f48028af3a87dc8fdb98aa165b09c52d07eb8d7
      https://github.com/bluez/bluez/commit/2f48028af3a87dc8fdb98aa165b09c52d07eb8d7
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-03-04 (Tue, 04 Mar 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Support single profile connection/disconnection


  Commit: 524fa22ed19ec857e00b87c6eaffef8b862520d3
      https://github.com/bluez/bluez/commit/524fa22ed19ec857e00b87c6eaffef8b862520d3
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-03-04 (Tue, 04 Mar 2025)

  Changed paths:
    M client/bluetoothctl.rst

  Log Message:
  -----------
  client: Document connect/disconnect optional profile argument


Compare: https://github.com/bluez/bluez/compare/8479c279ea93...524fa22ed19e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
