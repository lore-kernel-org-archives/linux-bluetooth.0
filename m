Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BB2264BB
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763244774; cv=none; b=Gbm8oQgEFwu+Yazsto4CJgS+t6mWsgEz5W9ltQ+r1duwwPoVSnSdugoZd5Bvl38ly41NoDpVngnx26KO5emH1dlE3S13IPNwhlzj3ZsWMKu/FiYSspK/LTgb4EMR9kWxcBxqGe5XoCesroUqrGk/IlPGRCYEfOLsjTr1TltCS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763244774; c=relaxed/simple;
	bh=4gzjCSrncBfDhULd95LVobFQ8zySOB+OuTP/ahuPdxM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=b1Nwr0U0yTbhBVKI/eAJ6y3kZPPsVYBWt8POWXwUJ9eTN9wFTE8fA8urWFh2Ecvls8oK5eb72F9bQh0OOW5e/caCUM63qfwEmMqq3lWBlYJDH/ly1tqrCEtyrb+nyubtL+c2HWt3QqecYibApkQiz03vTia1+c4wavKEPw0L4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HWnm5QkH; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HWnm5QkH"
Received: from github.com (hubbernetes-node-580adef.ac4-iad.github.net [10.52.201.23])
	by smtp.github.com (Postfix) with ESMTPA id 9A393204EA
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 14:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763244772;
	bh=oYi93og5fyG3qtf4OArfDwbOAmBv879345YnSiDGDmE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HWnm5QkHaGrBD21KzPNqPg6zQPxjCqv93UweHqZEecYH+Ubdhv3wGzdQQhcDF0AIY
	 NqXz8BhilJ01GEAlhGyD+8sR8F7yzFFDxHKoEiSw3v0zvTcPDmDR9B9FhXVvDGtbYZ
	 SCdREJ4KrKjX8XV4A4GioIg8Pu8EdYri/LSYS8Hw=
Date: Sat, 15 Nov 2025 14:12:52 -0800
From: Andrey Smirnov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023879/000000-245bcb@github.com>
Subject: [bluez/bluez] 245bcb: device: Fix the return type of device_irk_cmp()
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

  Branch: refs/heads/1023879
  Home:   https://github.com/bluez/bluez
  Commit: 245bcb781850cda852fe1523ab9ffb4dfc1b8193
      https://github.com/bluez/bluez/commit/245bcb781850cda852fe1523ab9ffb4dfc1b8193
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-11-15 (Sat, 15 Nov 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix the return type of device_irk_cmp()

The return value from device_irk_cmp() is returned directly from
device_addr_type_cmp() which implements a memcmp()-like interface, so
we need to return an int() and a zero for equality. Returning bool
will cause false positives since false is 0 and true is 1.

Fixes: f1fb4f95f49e ("core: Fix not resolving addresses")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
