Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F541EA65
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737696797; cv=none; b=oJha87NG8dOBsneRCCB2W4kJcVvq4F6G10QN1KpJHEgkdQ5AEDYgdWTJOiIxYrSZGBz5cedezuucCKFUgMf+PCbJu/fBFvOjtql+8E6UDCGZisSgj5Slz/SdSzh5dTCOmo5bmC29Ni1NYeGWUIsnR0FTrmfcTmUQT7F/Iv4j7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737696797; c=relaxed/simple;
	bh=kfxJO7UryXOc2hUzcpX+Luo/YsLXqyKZVOcrkmyU5fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aYA8diF/L84QoAh5Aql5BRju7UvmU6o7Op32gmZrBhDGhPNqjiTi64r0SRS9bNI/Yl6287uLI9JEy1nRl0YwC9lUyp5u8VARsDZZrglIE2SyKtnS+4KgvytV4mHioczGmEHaW9+Em9lscto41F8DjuZq+atANxoS8VGReClJR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ONZ0oqjz; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ONZ0oqjz"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f2d8e590e2so199015eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 21:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737696794; x=1738301594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7CHOhjlbqLmPqr3LdrpbxR4OF4uKkVOK28XhR8E+RE=;
        b=ONZ0oqjzh5RC9q3gwlhxGKy+Kmb65T2taJq9+iVQaEnKMRPXmHqw77mYGeKIHKwlP7
         8uhZSZmLaIv0H95X/g3ZngWla53LjqSONUgOEHwgfDb+kpdwkGxPvarvJ0Hhh15f/GL2
         TGLAI13Qqr0hLz78kmMgc3bvOxKtjkQGnmubg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737696794; x=1738301594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7CHOhjlbqLmPqr3LdrpbxR4OF4uKkVOK28XhR8E+RE=;
        b=lZP1BqpBL6MDcHuwzdujRUIsQYm6OuPJ4OvQi/oB6e5vkzl+L+IYpbdnsX9Yt+oEhk
         Bfhb5KREP+6gx/m6JU61wLtihfN8ZxSEhuzdP5aUzn8WU1g9VHiQTOa85TdGLl3sZUWz
         bQKV0D1vkOqK8d9Z5NxNpMP6DRoBnpxNMJob6tcXZawSm/jm9AtyGOKUqkiET7ajPKlR
         tOkRzYj0X7aTRJKcvV7hnmqZI4VSFHLdTt94EAbyPAEchQIeFqF8P1WE450TQZ570ONT
         LAr8NSvqyZrDHyU+Opx7s7teRZ35kPQqScP7MD5flpU05CRG0CFPewwsiE2IstUwoRKt
         cHmg==
X-Forwarded-Encrypted: i=1; AJvYcCU4qSezkERChMVXt6ugJVD32ysAL5Mf3Yu6ct9QNfoN3TS45vgkLOPdXxTF7nDaQYTClbo9Fptkx68jhVXcNwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8PlnGQHV+0Vnri50Kz0H5jAuWIIB70gB5dq6/3rfxBSq5Ro4b
	75Uh7L/SigfqdU5oZadSmsJkk7fIUlAR7dbSFYS2nQcfvuSw9kwdFI4YKX2aCA==
X-Gm-Gg: ASbGnct28bX/VnE5b0jgUUL3KFrGOa2XvpWwOK2UhQtRNlvTm9uY4SJcYcRrjz1j8s1
	Mz/yvplXcqMJtZxlv1afLWIoG4X3EswovB9N4zfCf1QNbhZ+2EPI98aOijsICzXF9goMWdKf3Mf
	Zha6GGR4TGJeaqevShQXvUGqJcxw8Tgl1k502/5DjKxud1+HBZMy/ABrsilNNFFPL0SDCtaNGne
	SkMaOd002pw1Gfw/TLoHyuAhzjWt0Ve8ERm3vu9C0A6u91yJCb7UiejnJyBjA++if2ApNub1EIU
	RTyLn899wSvrG6RH5gP56pkMamsv0F3gapw2DSF3CrNsHFlI
X-Google-Smtp-Source: AGHT+IGQxRrOihs5beELdvoOVX38HRb2136cNTduZLSSsPZwJtu5RxrcKh5Os+r1YzEkrCqDpPxjCw==
X-Received: by 2002:a05:6808:30aa:b0:3ea:f794:a5b with SMTP id 5614622812f47-3f19fc08ac4mr6705396b6e.1.1737696794267;
        Thu, 23 Jan 2025 21:33:14 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f09810f7sm270795b6e.37.2025.01.23.21.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:33:12 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.15.y 0/2] Backporting the patches to fix CVE-2024-35966
Date: Fri, 24 Jan 2025 05:33:04 +0000
Message-Id: <20250124053306.5028-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Diff from v1:
Adding a dependant patch [PATCH 1/2].
Link of v1:
https://lore.kernel.org/stable/2025012010-manager-dreamlike-b5c1@gregkh/

Backporting 2 patches to fix CVE-2024-35966

Luiz Augusto von Dentz (2):
  Bluetooth: SCO: Fix not validating setsockopt user input
  Bluetooth: RFCOMM: Fix not validating setsockopt user input

 include/net/bluetooth/bluetooth.h |  9 +++++++++
 net/bluetooth/rfcomm/sock.c       | 14 +++++---------
 net/bluetooth/sco.c               | 19 ++++++++-----------
 3 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.39.4

