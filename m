Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12231D730
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776296140; cv=none; b=nU2WeesZjiuDpeWZznYAHP/i1XMt1TaoqWExoTM2npPqapNca0t6P90GB6G7smepQ0JwAFJv7MCCZjkK32AVGvIr4MXooVh2RqK3B2bC0dbe0HLq2DZvLLtv+dZJWI4g4ED934AETiea5/ssKxQUl/kZek8CbH5qkAltGn84STg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776296140; c=relaxed/simple;
	bh=MHhCiYapKSkKWFygJLgj04EqRYRyACWqZls9L5asc40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TavB/QSSHXOoUo2J9W6Uy79RwORz6Ui0rQJu4bBpQ32JPiC8+flgJYbrL05XL0MUpPAg4BYzEMP9OEL1uzPl4u+mCmeN2ciN0eDedyJ2A0PdZ+BNpl1dW1c3gQgL3a7opHzDGkk905LHEtXyI9dxRWpxHgP5ezyQw3LPCcjZIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3pCBlmP; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3pCBlmP"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso5412601a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 16:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776296139; x=1776900939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtvt4KnahXapURT5aFQtvU/CH8l6W8PxDKVGLxGvjHo=;
        b=m3pCBlmPjedMYpxKLzqB0rDc6ZdttXj3ZIDufNqRhWxcaic/f+GN0vWOy+CwHX3Yls
         C6IhvcN5qoz4/xaT1DOD2qxRzmca3MUkPE4qvNObbjUWEVa+3PmwlO2jXC8ZMkfahhOB
         1w6SfYUpsOr+/ttJthRilBEVeOqcnRchaeSq5DXV8D6lplqn+FVHWoiYue5WizOJFk+Y
         +3xaVQ+OtjHsrfh2R/X43pxpOf3wcVkRRS6or2Q2VyuAyJg4c9WjBOftG+kKwjWjNomv
         IWloLGJjuP5pvmLjH4EEniuFg+/JZncdqMKxgrL2LzFfpayni7GWRCucjn3qnilPb+P5
         HNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776296139; x=1776900939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtvt4KnahXapURT5aFQtvU/CH8l6W8PxDKVGLxGvjHo=;
        b=MVgAqVHKndRAZzhGBiGFxnmuBkAzvYw2QMoYYOKIVGYIMrMZhbx3/F5+SAWni+qRdK
         xec5Ryn2Ko/rqvgLe8HUPIpn6RW5f83iDEqsZ9PxKHMzJOP6KVUy1J2hP+0P5f6mWg8d
         AaEq/huiycXiDQrrihQsbVKZULVSOycIYZu0tg+fcpSoyONvq2Lir79AbneKESGe6sRc
         SuWGZ3Lmt7NGenlPqgAliaM0nbkiaLG7pb/hNUSPLTJImSfh+TbgayGcKkeOXzxgGMDP
         4w5rOn6jCNX0uSHhtYirszawWWW1QyeV/D10yUAz68BgQCbIV2LCPE4//D+BL+4rEvzj
         Mgbg==
X-Forwarded-Encrypted: i=1; AFNElJ/tzCrNKNQD4y41uK1MJL+baAbTLt2nU5OSorGoG23LhNV/RJvermxIKbwhyqbWIw3vUZRHi0hRqRcV8T4hERU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsD90d+F1T+fq6d3Yx0lN30BrGIx0QfQAqii+nEUrsQqBP+aF
	Ctx/LdKwquF70A8ebLQhfBoxrDDLl+t93w5ZVnAEcg02Jraw6Q/2u+LJ
X-Gm-Gg: AeBDieuq4OK+/GpN/w31sGwBVWy3GLmKIWVaz6bVBNI4MWa98u82ickp1cMuLhwrdUv
	t9ljhbiq29amiGBHZrpmmWsswczlGXqBeSc+iwrzYgTU3GR7AP+WFvlrG6Tg6Hbr/3U9dN7IIiU
	DAjG0Ca6sT4xNvVlqRa2SLrH8kHNE5hOlbZpOIyip/PAxCA8mf2RzkilBAdWYHGmnGugt3HEV4V
	Cs++LA/Jjj1VmWnKcCsmxaxiAbFWsG8aTc8vll8+v3U/GjEJD/5FKpy8Ea3vMC+J4Y/K79DXvQL
	x6+C7ZTnBbse0pTHTRXvx01RlxL00F3zIz4qxtqqtStqR4Q+fSgogZCgmVI2YMRpXqqpj4IwA5n
	w5mW25a2RwF7cY/RIA2r0QOBJKIrN8ql/Lxd0P3/cYqhZKbLzQROsif1mZspixbgxqtDiigGhXg
	pZlIlH5T8N1Q1drLdqEa6eQAlsfEgwFEMtw10TJKJqtWRLfn7QeRH7o6fbLn8=
X-Received: by 2002:a17:90b:3e8a:b0:35d:a542:2dbf with SMTP id 98e67ed59e1d1-35e428320a8mr22548221a91.20.1776296138675;
        Wed, 15 Apr 2026 16:35:38 -0700 (PDT)
Received: from localhost.localdomain ([240c:c001:1:2e07:d16d:209a:fff3:5532])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132d1086dsm173152a91.16.2026.04.15.16.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:35:38 -0700 (PDT)
From: Wxm-233 <lty2wxm@gmail.com>
X-Google-Original-From: Wxm-233 <2200013188@stu.pku.edu.cn>
To: kuba@kernel.org,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: caif: potential UAF in cfusbl_device_notify()
Date: Thu, 16 Apr 2026 07:35:03 +0800
Message-ID: <20260415233503.923-1-2200013188@stu.pku.edu.cn>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

we hit a KASAN slab-use-after-free read in
cfusbl_device_notify() under syzkaller-style workloads.

We reproduced this on 7.0.0-rc2-g0031c06807cf.

The crash happens in the NETDEV_REGISTER notifier path:

  bnep_add_connection()
    -> register_netdev()
      -> register_netdevice()
        -> call_netdevice_notifiers(NETDEV_REGISTER, dev)
          -> cfusbl_device_notify()

The faulting access is the parent/driver-name check in
net/caif/caif_usb.c:

  if (!(dev->dev.parent && dev->dev.parent->driver &&
        strcmp(dev->dev.parent->driver->name, "cdc_ncm") == 0))
          return 0;

From the report, the freed object appears to be the device behind
dev->dev.parent, not the net_device itself.

My current reading is that this is a cross-subsystem lifetime issue:

- the CAIF USB code registers a global netdevice notifier and
  inspects every new netdev
- BNEP sets dev->dev.parent via
  SET_NETDEV_DEV(dev, bnep_get_device(s))
- SET_NETDEV_DEV() only stores a raw pointer
- under concurrent Bluetooth teardown / suspend-related activity,
  that parent device can be released before cfusbl_device_notify()
  dereferences dev->dev.parent->driver

So this does not look like a CAIF modem functional regression in
ordinary use, but it does look like a real UAF in the notifier-side
filtering logic.

The trigger is clearly fuzzing-oriented and cross-subsystem, so I
would treat it as low urgency, but it still seems worth fixing in
net/caif/caif_usb.c, likely by avoiding naked parent dereferences in
the notifier path or by using a safer or lower-scope identification
path for relevant devices.

If useful, I can also send the full KASAN report separately.

Thanks.
