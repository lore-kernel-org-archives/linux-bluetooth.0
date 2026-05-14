Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860633ADB1
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779433; cv=none; b=U4Cd/5Ntr9eK8VdY3k25EO4qC321GS5WJ+drRP9jHaVZONmQwKtRkwFzVw+wi3vELVNMfL7mB21d1sI9SapiYstkXctjPe5G+UOEB262fDFBtrqXO59eFyXFNqTjHLZATW+kYDisTjWxWqQSU1JrNED9V/z9KsvyABe9Ltaadz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779433; c=relaxed/simple;
	bh=UxCBYGY3s2MIDYx54tYdfNvb9kBnDW1Yy02G6slmgsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cpsu77tBCF70d4yqD+be9DJzyGIuydOw1RUCmsmVftwnm/ICnWHRUSQpujAXcNuDDjjjx8637fRW8O3zdZGsjIya9UiAJV9H3D/FgAI8gYRJUwjq9etAOJDGIR9ZSvJTt13LYsgC4ayCm7qhStg0b9Hp+wCXtLnXyY9RZ1jC8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOB51kRW; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOB51kRW"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-57513733658so2662481e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779430; x=1779384230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3HI5Nvh1903Kd6e+7GWP1fzYcWJf2b91PQiVaTWuSs=;
        b=cOB51kRWSYs+ybQ0w1t1OyDgrheghwbOqSZeHsSI5wW6p2YcLLWSAGIiCCg5z7ui5r
         4I+/84IrpjXLUoMdHJOyLmnKgDF7xaEaJ/zfEVg6q8tAAwqiCqRTlEQ52lT96LLoOaQU
         H+FhyihdP2PethICpz3PcRLm68zPrnhEiEHiKJ8cWWrQjEOdRTJ2x+VcVlTmCwl9h50y
         bqHrTf8ElR/c3jmGPwrP7XA/SgVPqnstNKFvccfBbtB0kNur2vHkhOIgQlIG7//8+Kw4
         SOEzrLB9CdrP6wYsuzNlYIpns6tcxV0/rHVZ7dOoRzchlkFkj29UbYPK9sTAsWXA13aH
         hBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779430; x=1779384230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3HI5Nvh1903Kd6e+7GWP1fzYcWJf2b91PQiVaTWuSs=;
        b=QsRNCikUXuXNQis5H6TDZzWUlWh9UjFPot0BuRiJjGNLbhzbDc9I0buw3MovDz4eFs
         J6r6JHYI7+jIWVzHDc6oybwbazdOIaiKvLACXXEadydKslL3S8MGqmlLWMDjtf1JIZav
         KIY7XSZkBsc2X7r9l/dJoYLK2SW9GIf12qVEfR9hmUpLH9+ZDOR9x54tWv1whJ8o1Hf5
         95N+1Y1wcAYh8fN2lSfgFork+Vi5lG6iiWSDJ35zVnPUiYE3405eIUREigqidhD+meho
         igb4ndjnhyLgUIh5x9bTpfaqqobTQnXSFjiFkTVpQbyV2O8CY4Np76uit2QeVxsZi33V
         o3Sg==
X-Gm-Message-State: AOJu0YzqmIdjeDUURCcA9Szbwl03Sev2EBB6dkmu1cLxZeUH97za09ad
	zVPH6BZiohhPs3SWwSKLBfLjE0/5AZdm8+y9rkm9pbNDQI7dT+rNjILdb+UfFRzWZok=
X-Gm-Gg: Acq92OH+Tj8rKpap8ZenCYsfisaVnr4jOT9TvOXn5m/m4O9WVEwlJP6+o//n8Veiapm
	1nsOCo7aEiwVxvuwdcB41pZgLTM4mArmFz7HNPhurNOnmAPU32P44DZv0BtvmTvT0tgEJpBqPzl
	pl6yFpDtxxwyH/SQiGzSLkrP+nGv1K+L+Npb4spc7NwewYGnSccM3LEPyHPZt+cOvhzfMrgj3bV
	avDEom2Xj+7Edq+UVrkvV8QSs22EBdlsP2k+JRk3oaOG3OEZHUB/YIsImAkNoUNf57hLQ4p0oOe
	ine7nzo20wwOtnfbIC+nKCfKgFwfO8PuIN3p2hBN+wVkFjs7382r1XgRfJvaEJT5FUWrfCsw5/3
	C12nBcD0lX4nCSgKOlC5QNURBTsF7JMeEA7orjhLnILFneb6sMrBRmeVWpBn/68bTwuBBrCS6S7
	+vLrAU1Et5bY2GLBxC2neaSLV7LIYob/tlDYeRIKnE7oFOGPfym3tmJhAuKu113PETk6hduao5u
	/JQX6UACf2R3TcZGw==
X-Received: by 2002:a05:6122:e14e:b0:56f:694e:1f10 with SMTP id 71dfb90a1353d-5760bff04e1mr292136e0c.5.1778779430251;
        Thu, 14 May 2026 10:23:50 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-575fa2c3040sm1658483e0c.4.2026.05.14.10.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:23:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-05-14
Date: Thu, 14 May 2026 13:23:40 -0400
Message-ID: <20260514172340.1515042-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:

  net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14

for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c00282:

  Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - af_bluetooth: serialize accept_q access
 - L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
 - btmtk: accept too short WMT FUNC_CTRL events
 - hci_qca: Convert timeout from jiffies to ms

----------------------------------------------------------------
Jiexun Wang (1):
      Bluetooth: serialize accept_q access

Michael Bommarito (1):
      Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer

Pauli Virtanen (1):
      Bluetooth: btmtk: accept too short WMT FUNC_CTRL events

Shuai Zhang (1):
      Bluetooth: hci_qca: Convert timeout from jiffies to ms

 drivers/bluetooth/btmtk.c         |  4 +-
 drivers/bluetooth/hci_qca.c       | 33 +++++++--------
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 87 +++++++++++++++++++++++++++++----------
 net/bluetooth/l2cap_core.c        |  2 +-
 5 files changed, 85 insertions(+), 42 deletions(-)
