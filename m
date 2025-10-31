Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981D2FBDE7
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930612; cv=none; b=FwIA6g51YTR0/4RRhkV7zPO1a/MWC44waLRceuz3FYx1CXlGsaN9FbRMeBWWRWS0uBJlxpfXEGl2jWQQ3/jbcXhYq1EmRPxcI1PTK9v+Q2kyV4bkex+ZWYUJGTeWe9qje9ErsbdYTZUubdpunOot/3RxdcxROlXG9ucDmzVPaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930612; c=relaxed/simple;
	bh=sacgGx/GVrImIcs8thwdi9BCiZy6Fg/WIqig042/jW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7bxuQv0DlXY1yky+lD5k66SzDauvePBKBFgDSLFvj95KyQIvEW1AAtCVzvvHj5Pic9LrjEbGFZvgaeiwErzWgO89j/ajpzu2oVW29ukAiWfV8YuL2AIPlYiXF0NrHlODWDEC4/PIyKwkxY5zjf7YkY3EJ3PbUagAlWff8IlQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsbA4rGp; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsbA4rGp"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5d613937df1so2155286137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761930609; x=1762535409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jR1J7NnLKHUT4xJbBKdvua8cjhj47pqW5fVpAcpn/qc=;
        b=QsbA4rGpwL8hUrwazN44ZVYSn8GKM/Jti/obY/uLUgTl6/WhXnAYuxqGwIahJ4fQ0p
         7XzK0eL6RyYaA0Z7GErzEWJYpCO+iZ4noCxdEd1KPROBb9iQQyvNbzi2z6eT/v/robTL
         ESiNRntC2JQXP6fLlS2ULuHe2WAEdcpdoU6VH4C6J/SZeekfREMlYkfg18pU+U8bDA1X
         10KnoO/sMPA88MxvZm7hJtl/stOm1BaZudEhCNR6kI2h+p6PDqCORvhgk7d3D/vQIp8+
         sZnqucjyK3Z8Ic9+/LFa0xjVmDnjwS2uPrAkTIZW96/2SUUzRsdjoJE0Fekqb/mbLQV5
         sGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930609; x=1762535409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR1J7NnLKHUT4xJbBKdvua8cjhj47pqW5fVpAcpn/qc=;
        b=utuVn4y8O141pswPaY3KYCU3An1Zhd9dkIr7bb/+pMLUvfn+5tRvCGmn2g/cOSl6f3
         E0PvhnR04CkYQmsB3ODSgEAixKxxT6xQcG6O3idxBIlxsWuaf/cbUHR8OsohS7ktTUqk
         SjjYV3VUuZTQneBKtUdCjLj/l6g/uUMhZilY08MMMm1vUkVKjCQeS+Xlq1QljxZcX9sW
         mxpOsc9if61xpjWZ2pD4qvym8n42m6l1EOIB9vhZcAY/R3K/w0ppSTlAB5q8o+ZsyiKz
         JR86ckOwMJxUYDDYJKStT2HmemwtbP+Yr7O+Bzr2Nu3qm7SeHIYXi/tCE3f9u8njLW3+
         rAbg==
X-Gm-Message-State: AOJu0Yx82e/peLUmwWaQiJcbSaUBirFdiNwvwNgS596F3hGBz9X9VXVX
	k3n9Jha5mTbRtEPrOhQoyFdC9cxApEjIr3rGEWGPqd1fCeDkcQwFLtneEVxBrJVY
X-Gm-Gg: ASbGncv64bisU2IZ7lZhaLQ1J+IWhAaaZC76gKCbWIKEQz4oHGNiX3NoEAy9Rhaybkf
	HKGLTNs4YWoATYeiZh47HvjCp8aIUuBmVNfN8wConOm+10tU0MxJXthafYcTgMwPXteZqpJl2NK
	fe6ej7fCjiUM2cCPpkux1MhFt8eopT5ytlL0+7Wt2RtHwXrB0uD2DNHygZ7MGa+9JZAwoPJbLiV
	vPUQcGsz0mcLf5tRFxIFBst8nBrTefeQ+P03Nk62X9dFR9LuR4wrhcl8AcjVRkWLVPm0wJ3iisB
	j2rZwjuRasNND6Vkm5bl2Se+2fKNBDpgALDoFnuI0Tz/y26wYJHNA9VBuMqKl9MrDOz23QoU+y0
	HJPgLZWS6gesqw1S6+A/XDWQ6i3zF7SG3fNLfcBYp1WcyjI2Sl+joblR/zvYVgxgKOgRSzC/uzb
	x2IcVLkDXqRqdPzw==
X-Google-Smtp-Source: AGHT+IHnRm6voXZ9Ob6nAdsDZZ3Un9LS2RDQTgjeNPQITX+56VP+lvrYbqqU8DMB5s3BG4brXIRziQ==
X-Received: by 2002:a05:6102:38ca:b0:5db:3d11:c8d3 with SMTP id ada2fe7eead31-5dbb120649amr1543165137.8.1761930608720;
        Fri, 31 Oct 2025 10:10:08 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93512a32168sm779791241.2.2025.10.31.10.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:10:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-10-31
Date: Fri, 31 Oct 2025 13:09:59 -0400
Message-ID: <20251031170959.590470-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e5763491237ffee22d9b554febc2d00669f81dee:

  Merge tag 'net-6.18-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-30 18:35:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-10-31

for you to fetch changes up to 8d59fba49362c65332395789fd82771f1028d87e:

  Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern() (2025-10-31 12:43:05 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - btrtl: Fix memory leak in rtlbt_parse_firmware_v2()
 - MGMT: Fix OOB access in parse_adv_monitor_pattern()
 - hci_event: validate skb length for unknown CC opcode

----------------------------------------------------------------
Abdun Nihaal (1):
      Bluetooth: btrtl: Fix memory leak in rtlbt_parse_firmware_v2()

Ilia Gavrilov (1):
      Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()

Raphael Pinsonneault-Thibeault (1):
      Bluetooth: hci_event: validate skb length for unknown CC opcode

 drivers/bluetooth/btrtl.c    | 4 +++-
 include/net/bluetooth/mgmt.h | 2 +-
 net/bluetooth/hci_event.c    | 7 +++++++
 net/bluetooth/mgmt.c         | 6 +++---
 4 files changed, 14 insertions(+), 5 deletions(-)
