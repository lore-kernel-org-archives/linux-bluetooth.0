Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417241;
	b=1pLw1JduXNFd9fZm6PLxU8bFbSZr/bGi277F+QeLb9KmNPcX+ugq0CH/JGaIvYmSzEK5
	 /DTMv5Zsq2QHhBhi/s3owmMQvN3Oa1+CKC/SC5B/F7I4+upS/CHhjA2iMCb7s3HDBPQuV
	 3vMCqZ3OIDLU0ea8fRAyQP/N5LPqw/EAK1Hx2h2nbT8iKNQXNzc0TNWv+Lz/tYp8scXOW
	 3svTfl4wS5toRnm9RfR84oGF3G56vtKN5xjHwYj5A7LeKsZjaSO3Y+PFCsVblo6YA75ab
	 egBCjDcut1tDleR/Xovgxk2T6I38cyYWuZCj2COTxJaRBK/+yVtMvBNobvlAkD9EaYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uH6hK/H9JVYEm/NtIKeeSCgyp6yYaM59G3HYCFQCfN8=;
	b=thYCMRPWoaqv3crgDTFyNXw5kqDDGVNorlF8NzFRJZz9dZtRrL61csoNE42FArHiYrwW
	 x1ArdbNxYGEk/rjreieIEmIrmdo2FkaOKburVQEi7/pEyDrfa+xM2mGebQAyAOuVNjQj2
	 fnMJpU7NApMcKr3Xjv/zKUfMUnlf3aKWKfayULe/Z/feBCfuzgEpTIs7p8qpWcQiYW0yl
	 FFViFkh6dzsJ/IYwu6NfT9IzNf5bYaLx573UgRGdws6UTmuu2UvJH9rR1TnT9vtsTbLbo
	 +PDvB3DXwZpOlGLdp1ObVxvN+/wDRGxVl/qved0ITZH3E551iWhQOmtB0PoNVSxDG/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ56TXaH;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A92606A31C
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 03:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34A92606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ56TXaH
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2eb18f4da15so4714695ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 20:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793417240; x=1794022040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uH6hK/H9JVYEm/NtIKeeSCgyp6yYaM59G3HYCFQCfN8=;
        b=iJ56TXaH/PKn54XbWz7ljFKCbtMUUa9B6F303ZSClcEWbM13PLFWkK97ccxNgbihY9
         vNdQAKppPddvQYTdi1o1fMtlgDtQmxBaNV6AHd6Xa16CiYPmBtkKlOYTIHpgj+YWVtjv
         NXFRLkXbOQzaCxJ3HndoQXpZUuGccdds9ONG+Hl3X9N9Q2bQX5kaoc5m9lkJ2EKuB43O
         j+y526xwdK3sC1ejZq8/v0ISJXjETMN/zNckSZMAE4QkHSkZwo08y6DR/A202oFNHD67
         I80Tswxv/rG3xtBxqka8Ujc+44G5vlrl4nqCrObOhjTwieT1dj/BXYHEh4tHuEzOyE7g
         6kcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417240; x=1794022040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uH6hK/H9JVYEm/NtIKeeSCgyp6yYaM59G3HYCFQCfN8=;
        b=S/KagIYlOxAFKG0cihVAphRg+hQkFwUy4gE9l/LbX8Y/E1zmX77pu8LnXOVB98ozVz
         TNazgNJM6BdN9+zrXuP+hlZqWFhiSZnOFYizivOqHjG00gfjzbzjmGjW6am0E/Ng9D24
         no14yHuXfJTQ+Cz38x4+lQjadkDlHTr7yUU1FVQ9y4EoSY7PlHIYNIjtubL70HGKgbcN
         BVPCatfOloCzSMsQrjo0xQBQcBA+1Zn5TI/ZWBy95kRXccN/pt+ZlGBvoa13W9r9zZqh
         aLgdsq+sEZ078RxybF83jJepb+XwEEV93jcXn7QzIKYEHdXQQ2DCCWGETrxnD0VncpwA
         IDLA==
X-Gm-Message-State: AFq9FYKELuL5N2RFAg3CNJB4VOJ4GrbFAsdcI805tU1C2HbAFBjxjAqw
	cRKz9t91aQnbEGH3cFwUXETfnMjqPyI8PRlPFf2Mb8sHS28X3W8EAOH6
X-Gm-Gg: AYBFou1YsjV4qtIUbDKvHmz65kR+wPlZQfogTPKWDSJvXc9Ly8cEnz6KQaoDXwngOB9
	7yMUu6qfqGZlHkP8eFBDfMJd9qex4ebsgHWAbQk66vopRWsmHVdEF6lwZZzDAxJ2JD8N+Vr9sWa
	Hjasre6yaD6uDYowhZZ43QiHqXN0R/+nn1eaqAdwBqo5d1nmtpuMRG7C0fGXMUHpuEPWIKaUhcm
	2T4Fy7fpj0QGaPWbAo5AUmXTigBrEx+UNJIVYuyj/nGQtMmt7AkVaCJtfLLlqqz6u+rD+VpNtll
	iVyXqbCpxNhAACPO/ihaQpitY2kkTVSihxz8TCjKhuNBJ5YWKbgOEQlJoBqnXPxz4J77F4z58wF
	MWICLROm4oUCR3yR5hXaNRM+KkjHwp4JtKy0ILreoGYshqOYqYS7wkQvnLXijTc0C2/vJQe7Hk+
	fDmc4QJrRV5a7kGCsvichaBvnBhnIzrGm2z+LLk27tOt4EcYCvV6htq5T0Pf9Un4wr4VsM92WRv
	/CiMPdqrzRxKJwYmAWVww1Smu7+uQrzGsVYLS35t+ly1ZlAwBAJixhqDAv/CuJr976BdunARCjV
	VQTVCf0oEklL29IFGo/Q10vo
X-Received: by 2002:a17:902:cf4c:b0:2dd:c100:7cc8 with SMTP id d9443c01a7336-2eb3651f559mr37166605ad.68.1793417240011;
        Fri, 30 Oct 2026 20:27:20 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39231422sm13203495ad.23.2026.10.30.20.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:27:19 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2 0/2] Bluetooth: SMP: Serialize root channel updates
Date: Sat, 31 Oct 2026 11:27:12 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v8-60106ad0c49170f5bfb4-0@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMP root channels in hdev->smp_data and hdev->smp_bredr_data are
used by HCI event processing under hdev->lock and by SMP receive
callbacks on hdev->workqueue. Power-off already removes them under
hdev->lock in hci_dev_close_sync(). Two other writers do not serialize
with these users:

  1/2 The force_bredr_smp debugfs switch creates and removes the BR/EDR
      root without hdev->lock. A connection confirmation can see a root
      whose operations are not set yet, and a disable can race with
      power-off and release the channel twice. Take hdev->lock in the
      writer, and skip the deletion when power-off already emptied the
      slot.

  2/2 smp_register() replaces both roots when management powers on a
      controller that is already up with HCI_AUTO_OFF set, while HCI
      event processing and SMP receive callbacks can still be using the
      old roots. Run the registration on hdev->workqueue, where it ran
      before commit 2ff13894cfb8 ("Bluetooth: Perform HCI update for
      power on synchronously"), and hold hdev->lock while it replaces
      the roots. The caller waits for the work without holding
      hdev->lock, which HCI event processing on that workqueue takes.

smp_register() still warns when it replaces the channels on that path.
This series only makes the replacement safe.

Cen Zhang (2):
  Bluetooth: SMP: Serialize forced BR/EDR channel changes
  Bluetooth: SMP: Serialize root channel replacement

 net/bluetooth/hci_debugfs.c |  2 ++
 net/bluetooth/smp.c         | 38 +++++++++++++++++++++++++++++++++++--
 net/bluetooth/smp.h         |  3 ++-
 3 files changed, 40 insertions(+), 3 deletions(-)

---
Changes in v2:
- Address the CheckPatch and GitLint long-line failures reported by the
  Bluetooth CI: https://patchwork.kernel.org/series/1197223/
- Trim the crash reports in both commit messages to the headline, call trace
  and allocation/free stacks; no code changes.

Link to v1: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-0@gmail.com
