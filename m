Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C031E0B91
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751048156; cv=none; b=JvLRm5btCIYhoVzPiYyA4k+55eh81B7p1qy9TYJyaxMNn+gawXDeGVdfQ79O+GWCUxMwJn85ra1B9m3KGlsX2JdA+eSpu1SFRHculfWyGPKh91c8QBYVGzC7J39AhM7hrLrTscdaukQg9MSBBV/u9zrvcQ7C/HqBRlSG3Z9t1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751048156; c=relaxed/simple;
	bh=cWfp2bVZlb5/JYVLvEWhQVG2ghTf0X5peEWW2OHHyNA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SdXCCLMYFoPs09PGUaAz2/RprbCaxPAPBsACUnldBSgPuXnFitWEPOds7eOtYHeDxmImYWZoEjyUs/U/DmkKbcom59JYOqy8+TuE2YwVm9bpQFSYos/LrUVBZCOctJduZskb2P92q/BS0zWuFRbq6DeJygKlfO/33TutTMx1Y7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMqtjy/K; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMqtjy/K"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e770bb7b45so640429137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751048153; x=1751652953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OREOvp6OrkVWubltBXib1I/xwDpMOns70Qw+MvbSJy8=;
        b=VMqtjy/KPE9l+dffkaXeptQi3OhokBIsOGJyT7w3L8Lt7JyaYVBVCpWj+Xw6iZ6uzl
         090twaGvTATrn3LUli5floETWBg/fA4yMwUQxVnvdPUYYJm0uRJNamBOjCVM+7ESn2Fw
         F0QzEl/bC9uMWyxMMoKZhHLSGgDpOOoXXDsrllKVXTNgqspW/hnepKo6dn17rWCFEPjV
         86BfhJh/qxNs+R58RtojiZxIlAC+a26ZSbOnR/LfBPoG+jXtCfNF3I3n5z4HCgOpW8os
         roEuotdKJe0R8YSUJ2Qlt3B/xb2IpZ3J3TQFr/6KIqsjWutGVdtRUwz48zX39/ezZYze
         ODfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751048153; x=1751652953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OREOvp6OrkVWubltBXib1I/xwDpMOns70Qw+MvbSJy8=;
        b=MYQklgBwcu9Il3VziicM9algIYADXvszy//sUTv8BmigvFz5fzXbUiN9B4ptZWeB8L
         O+EQeoUR8OohSEgO4UU2y6i3yLlNzeGGZDw6QmiMYb4fFCsmLXQy8r3NEA6ZFYjspPql
         Ybj73lPApb3hLswS4GH1GIkLp3F4OtgKfpaIkL3e/llMvqXl2Sm7BAjjhTZUJiP4MtYv
         FNJwuXwC1rJuPGR4vnm1cUDZMw//pBe4oC26Bv7X1Rvkr+KLPOO/QNASKb0VVjowa7io
         iSMtzbb5VwGS+FcwOVuXuDyb7e2svLJq5F73tR/cz+hwrnk5O2VAYoyhpxbupzEHFizD
         LpMg==
X-Gm-Message-State: AOJu0YxUvjmD6zyte9TInWaHU2eq5zU+MBAAzJ3YzwXlRPPpvdGK42CH
	BUJyILg7FnP9P/eCgwn46uACpZKIFs9Co8k3nOTQLmcBzwalAXngiCHowJtVe4JL
X-Gm-Gg: ASbGnctTyC08GdQHPOh9HgaT2peWm+9yU6iYM5gjWMHx0n3gDBAx0g/y/zo7RFEWufO
	RplOCuVvAOVkAnbtahHkpxDKUHJpq8tJ+tvLuZ87TdxhBwHzWhw5mHN8XuYbB51pnp5W9F8OoM/
	Ey//zyYVmg2j8gPqnnfSJdvQyJIgXSqfYxXerM8ZKUd1WVCJuLFBQk6p3eL/ajpDAwtzy19CRtw
	N+VmTuuVzAlQjIsZBJbdKkYVMB8ZVMsLCremSFTDFDpV/f8EnVmFbFPU9ylpnkSG1/SKMxGLC6x
	TtPBiFVZQ+5kAfpg7YI+GU95j0CeOj5sBvMd5DmTNF9BT+68lbVmMk4RaiJTtFSyJ7LITV54rBP
	WxPioVvHKl2r9pIhnYKNMsAcz+AeHd2s=
X-Google-Smtp-Source: AGHT+IH23DMtuZWAXGqtmr6hsFGkNRalf/GTJTD22djDjk5V607/lf8l8q+Qg3zMoaeqRaHMJhIjqQ==
X-Received: by 2002:a05:6102:5109:b0:4dd:b82d:e0de with SMTP id ada2fe7eead31-4ee4f766856mr3650257137.17.1751048153449;
        Fri, 27 Jun 2025 11:15:53 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-884d5224562sm569388241.34.2025.06.27.11.15.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:15:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-06-27
Date: Fri, 27 Jun 2025 14:15:51 -0400
Message-ID: <20250627181551.520358-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e34a79b96ab9d49ed8b605fee11099cf3efbb428:

  Merge tag 'net-6.16-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-26 09:13:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-27

for you to fetch changes up to 89fb8acc38852116d38d721ad394aad7f2871670:

  Bluetooth: HCI: Set extended advertising data synchronously (2025-06-27 14:01:20 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - MGMT: set_mesh: update LE scan interval and window
 - MGMT: mesh_send: check instances prior disabling advertising
 - hci_sync: revert some mesh modifications
 - hci_sync: Set extended advertising data synchronously
 - hci_sync: Prevent unintended pause by checking if advertising is active

----------------------------------------------------------------
Christian Eggers (4):
      Bluetooth: hci_sync: revert some mesh modifications
      Bluetooth: MGMT: set_mesh: update LE scan interval and window
      Bluetooth: MGMT: mesh_send: check instances prior disabling advertising
      Bluetooth: HCI: Set extended advertising data synchronously

Yang Li (1):
      Bluetooth: Prevent unintended pause by checking if advertising is active

 net/bluetooth/hci_event.c |  36 --------
 net/bluetooth/hci_sync.c  | 227 ++++++++++++++++++++++++++++------------------
 net/bluetooth/mgmt.c      |  25 ++++-
 3 files changed, 162 insertions(+), 126 deletions(-)
