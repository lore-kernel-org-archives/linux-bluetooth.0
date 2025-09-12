Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4297633A00A
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706247; cv=none; b=Mo0j/jfmBR0IyuntiT2KB8NqT54VJP62QJDD+mlhBobqlMetacoRBT1d0z/MV4dhSaqdy3C6FG67lyfI6nCxepo+IMo3NTG+Dez9GrSzdszAeUhzeNJsGdsbVMO0bcxIBnHvuuqo+FMVbChzinYG5mCbKg9RYG+k/+X8f0ck7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706247; c=relaxed/simple;
	bh=oqZ4ySQ1XTc3W6o2Twg4hB0f82DUC1/Y6MuNnKPhzAA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=G71aVyN2nyQD4kSNB3BVmUepjrbTzyj/md1H9Cya8zcKVzOQLMDREr10qQbNJCoogzeQQgExPoBsAXhNwqmgYk+G0GEd/vDJyAZMCknpNGajHHLfybNpQubw2V0cGJqrIihzyOV8eYtfq+f1DB98Qu3MQgZYkvDMSFUfl65A91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDw0E0QX; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDw0E0QX"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-52a8b815a8aso1001572137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706244; x=1758311044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+qNTVi7aLLCdmwvdH+5As7K/AxaxhK72Rc9rweL4dk=;
        b=TDw0E0QX7CxbbsMuBJ/Rpfi3q1P/h2tM/9vQa4TDfV0COMImmEzN2M1Xu7uA5w3IzD
         lIqkvSiEK6p4sxuWICxa/A3kmIm7g+vXIUmb/sTdSlQ0M49m1gGp6YYyn3w8NAzpWwp+
         CFSIu/jTaGjOLNRVQ5fBFVuAzdkd1IcrOqFFXwY7KRlrvn+xopK4vryBtDh9VCzJjYdR
         AusfCGUVvZlnQdcutlLbFoty6SJcIq4iJcJ/yq57RCr9ctHBymm9d7Os4dkhU7yMGGyY
         ED4IlyItJ2adQ2c3dLnSeJr/bq92Qr1ARSrElEczpSNVYgNclKkVU+664LiVRBL/gT7c
         lHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706244; x=1758311044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+qNTVi7aLLCdmwvdH+5As7K/AxaxhK72Rc9rweL4dk=;
        b=pw5ULVcbBFto1dmMe8EPpPyGWcehOz4HsahSrFSc26Arsu1BK84NULOZqsod97VEJC
         ZWYGh22JICiOBWy0X+VQ+X2ghQmKkRodZRBJA/pGrn8IK9AeIZciYszQXU8OjI1uA/9/
         yd6l77M+0rP/eOdqPdxgp4mDMoB8BfiQAOWHBQiKneQAAiq0ltGt82g39bkc5KKD1VJr
         pyWloVjM+5Uem8LtKAFh4ex/YpN99RaFMmCWwbfLCsu8/+1zDtjIbT3aob3wvxx9kk8M
         nrXcsD3KoyWV88Fbt8Q9+4MtUhN6FYgisfHn7kHcd6U9VRHzQdu/LiU7ZciWM0BuDmJP
         zN6A==
X-Gm-Message-State: AOJu0YzFsX85mY6q4UvNevm0cEqwQmUcoFIEIzrpXtXXM4H0NTjCDRD4
	pUKN8fryZYYz5wZbPwXsYdkXtS9K3F3OywqsBnt8y20Oye5H9b1D6ud33s+XVA==
X-Gm-Gg: ASbGncuek8JSTmej0o2K0JW+MoD+0Kdd3HrBAUQBQRWBq5+A5x7vo3S0kkcDipP8LV+
	z05Gi5JfuG5rO6MCN9X98rv070wJ3LYXUWIULcSczxlYq9C+2Nl3tHBb8J1rH9fgJnQoamSUvSN
	0PXI8g6st5FRrqLsFDqknEX2EiQySVR7nbjoddUswhrmXFY7ZVjLh0VwXAsFYE8mCV5z3A5i+sW
	GLxsGmelATvK3vvjvCP9wIJxvxchlUzNegF1LpEp2mqCjS2R+j1oWNbLmh7h9hpzdE5eIIzLn4l
	xTOz8lLJ99Q5CCGUF7lL6HU8mEVKicQG8CRZxRDO3rV4YtM/3usLKd+0A0cwZTYa/C1q0gW1aKN
	DVXG2smm+zGPohiIRY35u59ctNJOq2aPjDTuk17QAO+Beb5Ee9QjonAbrfqZ7Hbdq4x5hJAZFxg
	VnHAesin5HsCDGtkcOyrn8ZBvUNLAmh4aRgGR3R7UU
X-Google-Smtp-Source: AGHT+IETmj+ZTzpH+yjO9QTp4Ls9tMafBiEsVYXpQ3sYhDixxTcY3MFIn9lGLO7ZgzVqpXYtvl6AFA==
X-Received: by 2002:a05:6102:3e20:b0:523:da8c:eda2 with SMTP id ada2fe7eead31-5560e9cd2dbmr1507999137.18.1757706244364;
        Fri, 12 Sep 2025 12:44:04 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-55375d5ce0dsm1175634137.16.2025.09.12.12.44.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:44:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-09-12
Date: Fri, 12 Sep 2025 15:43:56 -0400
Message-ID: <20250912194356.121809-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 2690cb089502b80b905f2abdafd1bf2d54e1abef:

  dpaa2-switch: fix buffer pool seeding for control traffic (2025-09-11 18:51:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-09-12

for you to fetch changes up to 317f5866c2f2b2cb9c8fed096f64cfa6dac435b4:

  Bluetooth: hci_sync: Fix hci_resume_advertising_sync (2025-09-12 15:39:05 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix build after header cleanup
 - hci_sync: Fix hci_resume_advertising_sync

----------------------------------------------------------------
Calvin Owens (1):
      Bluetooth: Fix build after header cleanup

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix hci_resume_advertising_sync

 drivers/bluetooth/Kconfig    | 6 ++++++
 drivers/bluetooth/hci_uart.h | 8 ++++----
 net/bluetooth/hci_sync.c     | 7 +++++++
 3 files changed, 17 insertions(+), 4 deletions(-)
