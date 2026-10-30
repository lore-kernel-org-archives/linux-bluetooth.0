Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370472;
	b=cV+Lp3xp4CbvoaqBufxsnWUduIK2cDvWF5/Wn+LxmJDyCyjbX0fjgxZRWxx83SF2UPzV
	 tRcIq7m6wgwictpVRaq/VC/oPIg/y0SOxluqnewdtXj60Bmi4S6L6Nqi7mJjp8alwFeAj
	 nXbHwBwEQqHUUxordCeimJHOztgEZ4t3eXz5Onf9buJ9F+TRzDLwLVcion6W+xpxUJaxi
	 ptn44RsXY4+Pzo+mtdYxOk9g83/YKErDkHFTCqg3BdjfHeP9xclUI29i/1rAzICIbLeU4
	 r1tfN/Uef8DL64ZsrlCOl+3bAKJjo58lPIsRbOv2aSQ93NI2Plbd9epKDqXowp3SekQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0KAayqZiomA+R77ysFRyaCC655BD8Hvw7toET98kCQo=;
	b=hWHnlopMqeKwM2NyuLOF9Z06PVo9uVF0n9lOwyx7JgyklbsSdGcI3GtU9zWtBfSW1N/8
	 dQf9tOY4v/NNgZ8pxIUragptuHmsRU+6uC/HkVkG0pEacq+Hj6ojQmsetnvzsplLji93v
	 sVHUrRTuOaIcJWsA8bila+1XQySnAn8xjXNWSPV5id/shICZGMa3joUujPKkNeT3p7Baj
	 loh+hFr4rbTCPt4Vu7xKtd2BfAyo4+TJ+X82XJsifzO3MZo9Mw9l2pNjoHDS9AHB3m8FS
	 kPlT1nt7qp3g1BceQRPmW7ZUD0pqAJFUiXvwjObmXnqHihwT5Lk3zIwIfsYLXXgDanQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="U/9BE6ou";
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A8606A31D
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C5A8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U/9BE6ou
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06b436dffso189380b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793370472; x=1793975272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0KAayqZiomA+R77ysFRyaCC655BD8Hvw7toET98kCQo=;
        b=U/9BE6ou4bWevQacr1zVcL7CWZZHv0knEkBGjgG77M26caLB1y45uWlY23FT4ActMp
         pqU0tuA5tn7LLzF24UI/kUQZcCorxhIgnJlhqnkxfFpsbEPrSZja+k9lOW7lPllt+JkJ
         9xySMeFvGMwLbkoixA8C9gbq8csZKqlBN+kSvpTeMbUKlJyO5uaIry6cKO6lSINUEqVo
         Em6abhuMiUgR4OLM9We9g7B8AjB1N9DISeNgvTKYD9wACJZqLTLxs5nC8/MteeZhoLTT
         uj7MeQEZDtX/8j2hvOj/9rOAXu+xXtBN3t1hfOqkWGhItiborvueHoyGyvFtoUW+yROW
         wUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370472; x=1793975272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0KAayqZiomA+R77ysFRyaCC655BD8Hvw7toET98kCQo=;
        b=nPrSGFEmRcbyBD9rMDK7DwwV2d7nJCj0+oXP7qVwjn1uEpVnOl2zC+lIAAQQWvwYwU
         ysYt20VL66oDbw4aIEVoAzMr6TLFu9iT9BWq3T3sTRjy/CSIVNaj9hQd2eeuhlqpvhb7
         YKKYSDc0ikD9XPbVvZPlzJL7qCjo7B/VmZduRDrV+M2CVNT9Q+4Z/CyFcS9Il5GGplzU
         wfMEyEUJAevYWZjzZdLSL7JyKiNh/zsEhzlXnU+0sSfWdqyENYSbPgcZjMAoANb0LCfR
         1KOtjX0j+0k8XQ+3M9qKRgs5NVuRNFUIYXgjGQwSW7vQK8IKGkEpvEQVfZybClcIN/4w
         x8lA==
X-Gm-Message-State: AFq9FYJF2iM0M6ftrgQZTb3a3y3ick04bupeoRX13U71OnCvXacbQBdU
	pe1EMYZ7aR2+ie38gDE/9gJaZIQ9FhhxTE0piIRbAuydq90MY9sYVjcY
X-Gm-Gg: AYBFou3v0xrVUd8NGSO9SyCpE86+OQoJHA9PBEzY2bYKHoQAN2AtBA621lmwftU5L91
	TJKAgq7CZa5wQwZpCpS/a2IrLpBv99bMHMksfiNG3GuYBRETXYShy2r0r0SfC79XvuouBQ4LQqa
	6E0kw/zcy6BwyajHUQ2JeufHZSYo4SOH3YzMpksHaQ9zfVlQvcKn3fFsSkVeJK9rhI1APVKG1ZX
	LNBMXBiY50eyjI7YP46yhdWFdwVe2Lmu2BgSOeegk2B+mfQYWxGMkmyYubpwQDzqQSauwQy1SDN
	7589C8YUS90Q6oklZBcyiJToegb+f0xNkSQTPuih5O8FsBBA7L1n3Y50xSDSqmV/zqUFBK4SCzU
	D68U22JZoGRlz5MZ/Z3pFsCEmn5kED+BvCfVYh9m8BXXiedTNLP5H6O6CW8UiWMYbnOf5J/AoU0
	n0MWgoAWm8Y8TmfBZqIVYjTtp5Q5r8ogemM4LJkY89U4KifBat44OUUC+UMRb47d6EU0oM09/j3
	LOr/G7aQNlu7LDlvMeOVz2GVpjO1RJA2aG1GNW3ocf3R/ZdtbvKVgtkA5zBHaQY8KBPeKDuNkd8
	JSvrABKO5PatJqgc0vdXYGdH
X-Received: by 2002:a05:6a00:12d6:b0:8a0:683b:f662 with SMTP id d2e1a72fcca58-8a9bb0d0c13mr2275609b3a.5.1793370471498;
        Fri, 30 Oct 2026 07:27:51 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad43ab44asm74093b3a.0.2026.10.30.07.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:27:51 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 0/2] Bluetooth: Fix advertising instance accesses without hdev->lock
Date: Fri, 30 Oct 2026 22:27:43 +0800
Message-Id: <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-0@gmail.com>
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

Commit cdc36db204ff ("Bluetooth: hci_sync: Fix advertising data UAFs")
fixed the extended advertising data paths that use advertising
instances without hdev->lock. Patch 1 fixes the remaining request paths
with the same problem in the same way, and copies the instance numbers
under the lock for walks that send commands, as commit cac164b6246f
("Bluetooth: hci_sync: Copy the LE accept list under hdev->lock") does.

Patch 2 stops hci_add_adv_instance() from reinitializing the RPA work
of an existing instance, which lets hci_remove_adv_instance() free the
instance while the work runs.

Cen Zhang (2):
  Bluetooth: hci_sync: Fix remaining advertising instance UAFs
  Bluetooth: hci_core: Initialize advertising RPA work only once

 net/bluetooth/hci_core.c |   5 +-
 net/bluetooth/hci_sync.c | 296 +++++++++++++++++++++++++++++----------
 net/bluetooth/mgmt.c     |  34 ++++-
 3 files changed, 255 insertions(+), 80 deletions(-)

---
