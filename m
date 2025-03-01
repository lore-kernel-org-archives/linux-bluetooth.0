Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5FBA3D
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740810205; cv=none; b=fiAPADclxoGZQaE47duE5jBi093MnBtBw0kcJRjZSryqLvLGHRlszIhctREvwfYghyibpX0c9Vv76TZygHSNRE3IjKqbMkkv1uG+CntHwlhkH/LCEm8o2nfMuIR+4R03ayrcdra5cP7KOoyd9J+e5M10OTxc9uxTOTFkrtf02Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740810205; c=relaxed/simple;
	bh=gwBb6++nAVZnN4nUxQRbrboVnnBxIiGFc5uMy2Bj31U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkrIeAGxoY9Q5QY7InGCWtNnHljsN4KAkoD+MuYfhI6WAAfSKUQa1YpAENGh8c6D/G1f/HR35pgZInpDC4Wl/H53AoSkkrRLLx+N1pSjnWGtR/lhOm4ixvXsAb0B2FBpUUuGzyprV+g6yopkPuHOTaj2zc24Ca83KywYHWiXRV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9tF6dlv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9tF6dlv"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso5120194a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 22:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740810203; x=1741415003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4AGPOTZZ28pZ0+JxqHSzXvkL5R/rbx5Vu3ALvrMxYs4=;
        b=E9tF6dlvaN0ugMmc5dR+wkzj/2vz3fNIsKKRupL0J69LOrEgSt4oGoGU4Z9ie7bz+2
         8RKAK2Z5c8a+aAmRao3vNG+WJp+tL87Kju4wvDR6WjKZ9cWP5YLq2J9iqbiR3uPFzG9r
         U/yzfQJaN6ymmwvVAUJ2yxdFx+Y1lHJi3XfLRKHEMYbO2cAikcQ9JIYVbrLH68+BiO+W
         SpSH7bOcyDaQqTJj/U16ddSWJlTx11fFiqm8I5H0w76EzvUcLe7eC5nJ6rTSZ8BcbDvS
         ZnpM7p1toyi5AtcqRyyG67ZLrmS4wbRiFqNgPk49MDjQl6ub3rcAgPy0bGFer6wzfer7
         swgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740810203; x=1741415003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AGPOTZZ28pZ0+JxqHSzXvkL5R/rbx5Vu3ALvrMxYs4=;
        b=LSKmbFq1iijzlwFCo+c/6hel1usefQS1aYoRxMskBT3UxCv2tdjxpyH1+u7uwfSLF0
         r3l8W1XptdNyF3lIoppOLkmvl/wc5OwlQbHlB1PIPxZ8p8dPh9bZHkVpXDTl+vIGAhDV
         ubrewgGicqSHl5PwCwnD8r3RUZ/Iu1CZSJOC0TPreAnmZszxi5MNJ86sGMOSAsMUwUyz
         tWX40odn/J58cNnfXoX0dEz65Hlt/Agai4QsZHzN04RR37NV+d+unuqYHVXdaCcBEG3V
         ycI+evmGmDLtWc1qbq+rYz+ldjT/JA/TRCd6Zx2M9J8hDYj2vBzgoRYaOKV87//lr6rh
         dg6w==
X-Gm-Message-State: AOJu0YzhmRPDW8GfRTo2QzlCWOVMWgveiUJbxPUvKcg72+IY0ZVhIjLW
	y8LsqouOO/VwIHnO/sBCs6KFQga3OmDUhlN8u5+1a0vqUalZe1mD/kw+3rp+
X-Gm-Gg: ASbGncvYybZv0kjpy6qhKkxIpvuX+5XTN/CZDSEo/ck+PfjCaz0mWOoMzU2BLZpJDBG
	h542WVZl4I7g8op0MCPwcHmsV8CQK0K6emRkSWr9ZO6JPc/ThOGEDg8F1nhvaBymEPG8X1L9Fzm
	kXZjoOvR26UUb0sI+5cz3Uw6Er01vH0PcQ7rI3pciWzhH2YiZ5xLzLKwT3HmBsWn2sAYrZDCi/T
	T4odvF7iYxq8epAhp9862kznDq29j7nLrb8JEXi9mQ/UcC8TWQ2ysokMnqr7/grX5LBI5aHDX1Y
	QWiflUV9oU/eNzN1NSg3X9eoQVqpP/u+Xl68DYlVWemtCRo33/EvYOOYvhTX1Xq2Gydt6/6RVWF
	Fl6xDrr9GYYhdDyauirGAmkWCPrMxhg==
X-Google-Smtp-Source: AGHT+IGAQiiFRsr5nbMByxSCvglZsWWJLO38AnzSLuTToid3A3zrdfJv+qgX4pmtqYiDCYIOqeWwKw==
X-Received: by 2002:a17:90b:1e51:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2feba92bfc9mr10630026a91.14.1740810202802;
        Fri, 28 Feb 2025 22:23:22 -0800 (PST)
Received: from localhost.localdomain (168-228-202-55.static.sumicity.net.br. [168.228.202.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f121sm7014625a91.47.2025.02.28.22.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 22:23:22 -0800 (PST)
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>
Subject: [PATCH V4 0/4] Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers
Date: Sat,  1 Mar 2025 03:22:57 -0300
Message-ID: <20250301062301.18029-1-nishiyama.pedro@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These fake controllers cannot be initialized because they return a smaller 
report than expected for READ_VOICE_SETTING and READ_PAGE_SCAN_TYPE.

This affects fake controllers reusing the 0A12:0001 VID/PID.

Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")
Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
---
Changes in v4:
- Check commands for READ_VOICE_SETTING.
- Disable SCO support if READ_VOICE_SETTING is unsupported/broken. 

Changes in v3:
- Correct the fixes commit. 

Changes in v2:
- Separate the driver changes from the quirks changes.

---
Pedro Nishiyama (4):
  Bluetooth: Add quirk for broken READ_VOICE_SETTING
  Bluetooth: Add quirk for broken READ_PAGE_SCAN_TYPE
  Bluetooth: Disable SCO support if READ_VOICE_SETTING is
    unsupported/broken
  Bluetooth: btusb: Fix regression in the initialization of fake
    Bluetooth controllers

 drivers/bluetooth/btusb.c        |  2 ++
 include/net/bluetooth/hci.h      | 16 ++++++++++++++++
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_event.c        |  4 ++++
 net/bluetooth/hci_sync.c         |  6 +++++-
 5 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.48.1

