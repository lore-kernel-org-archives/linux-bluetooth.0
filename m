Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2EA2D839B
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369056; cv=none; b=ERulLvg00kJlyrTjttcWmkjvPi53Ovs02+DW5OF5pRsWr6tlY1GPzxXKlEoW2VVA80IhVU4GIvx2CGdQWnMaqfd7CjODsDOBNJCHpNF4/3clONhu2kV6Z0H3Qo1GGDl2evrdkgC416HzfsVS8NLP9mbEBUeelIRQgS7qiCqtiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369056; c=relaxed/simple;
	bh=2prTO8pxzl2M4eVAm0ensNKU02QknA4vdYMTsjD5j9A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OqZtTLwKAlR/dVqMK6YDBJ1JnH4qNMWT5Xd2rQHIDRAiCTSOqxnM7XxcGT9IdbXvmTP4IwnhZfLH1qg3S44iyLXEyZPGshVpn+f6KeLOPPoB+b4F/Lb14lcCb9F0gZsyJ/KEAfMMbrxZgitf3szPPGAKz6e/t6ao9Pub8MEHB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KUVNXw6h; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KUVNXw6h"
Received: from github.com (hubbernetes-node-35a4d40.va3-iad.github.net [10.48.156.36])
	by smtp.github.com (Postfix) with ESMTPA id 5FFAB8C04B0
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753369054;
	bh=xIiTklVaQNnOw2yJWEMxUqlBcyLiNewt6G/cIHS/lO8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KUVNXw6hwbvgiZSyikP8k3dsiroMoPTQF4JeTsevM9oovYDdxbjWKjO7ZeTSFlkHJ
	 48nfUt87THnvUnXfHOKAxqxpfriuC0oB+8/iNhetz0tbulrbqQyPV19TNsWsDPdlIQ
	 dFzDqB3MAZq4fA293F2ZOWO5nhUEv2N4B5fprnfc=
Date: Thu, 24 Jul 2025 07:57:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/975328/ed17a5-000000@github.com>
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

  Branch: refs/heads/975328
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
