Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF46139CE3
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550864; cv=none; b=TztuMONNxjlLsVgR/r8Q4I+f+lqT1EEBvRaH4nvr/aPB/2kqGLgVLxTCSBd825f/+teFxkwUlzMlGDhf0BnTtx7Ag+ezpRBnNDt+ixGi+cc6ZGwJgVobXFUfcNjuE3P3l4pi+SycmhfbPfQ0X3PFW8xdL3yugshrpw/NzUoQ2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550864; c=relaxed/simple;
	bh=ovTpBhqWDgvd4Z8acSYhPfkqSmpGDTnVqDQV28URe5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gBCJZMVOHQywR2gTxd1NjSD6vrqhhtaSQQ6J9dm4jrDsSzf0ZGFpqdMcKJHshdk5XGkoodmwHqVO72wbIxIgXye0O38NlDF052HFsfC3DzVoRwKcIH37+UyRVnyhh7bzdjRk+B3GMsTtmI76a884wUbft0Sjh/77zsg72XY4Ll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRu0LtoQ; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRu0LtoQ"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e8110ac0f5so2159234137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751550861; x=1752155661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6S5dTRQsRKDllwRj3mHYdhutkXNZvtHjcwLDPll3r8=;
        b=FRu0LtoQbmbZnNQGwJjFu8c1Qr6FxuDXs0W/cSOjxaiVGadI6WeXQjiMUrrxEusp+S
         pMbERrV8q3ntT4y/qVWIbNQsMAuSUSGvRS4h+RSqmo7i1aLR3784/bMM/iuuaK/lBHjL
         7Aj6kB6BlAaADBHbj+T4hfO+fnp95DNXHbrYCX6Ke59SOOOWrsca0NztG8No1Wazp7Jb
         99u0RMTBhRAjobHw59REIKwLGGTcu9Gt960wGZ/0OL8XUSTcIY+C9XzYgJbbbSINWYBb
         8lZPsAmj4wPc/U3WAKUm8WSuxlp0WfSHriCHe5vp/MtKwsAkHCy0BPRSPYyTra1uPZic
         SsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751550861; x=1752155661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6S5dTRQsRKDllwRj3mHYdhutkXNZvtHjcwLDPll3r8=;
        b=hHO2kvIL6M51mXoSWj4QVxqpAhaAvyl48GFB4elbwmOppGrDN0Ct9dXalzwg20bD1A
         HkejBlSyvr43P1XH5zMpdKbpIDSqq5Lb/WqJg+EgVKj8eSkWwe03B+LZAGSY5FwOuer3
         ltksjmOhBBtoamv369HVEVgXr4KFr0u7KkH8R6nTGV3gL99sxFR/OUhRIE+/4gB/NSvE
         kLdPJ1ZGZYZ+wPpOAD2d2Kj5YFoRFIjQ2x1hj2q0HMMw+8cBg/yMe9uwch1kZefvy5Ke
         Amfa7c6rj3OxyYJIxjPz9fdGZbChBYdJ390SrV3S5Rt81ehegnX6zzvztsamyyKAMt9I
         DtdA==
X-Gm-Message-State: AOJu0YwwBTTXPKo/SE0EOvdYHgVqUt9e4oPvp9ECBeNVO1cAXf29OhrM
	EpJQzQgkaQupJGq+dXtzg0IUB7sKxzmZk7KHkgj+/TLwn7kcKtkgTh+cJhCOXqt+dHU=
X-Gm-Gg: ASbGncudWHegu+TwpJaQS7oYz6Z5bZnjisb9p6OFLSQZg+H4kBUZlFPg1CG6MpFaRIG
	mEK5pKEGuRr0Jk9IN/N90g54+vK04vr3mAlP0IHSnfOvU1rm5bjt8wTjnm54yg0RAlK6uKHRxXS
	Q/nSUfYTAKtMx/Ri/kkBXulVqr2vq/dMFp27ziqwsS07qBVWLgoDlmnolAlAukNVnu7e6fIThx9
	MQ0xUGlkF+FR20qLz8Tpkexo31q55hsBV20Tj1FeVwA/lN//7ia4l/D2fiq7xxoGYbOzJ/DGIIe
	B3P9uIWfkD3ztPNmoMY8gne1MjnIlCBunV22eQq2gZrwlVpl5jVllz8FK+wjY0bXnTAW3vYnijS
	JUQy7nDGvZiIVzPSzX+/Fn50RzhWfMSg=
X-Google-Smtp-Source: AGHT+IHTXHuw5C33ixLbph8DkBFgNA1YB4oOjOZqmcemmK7A6yJZFi1tRimguGUix7PlkhooY53fmA==
X-Received: by 2002:a05:6102:41a5:b0:4df:93e0:fb3 with SMTP id ada2fe7eead31-4f176424671mr2488790137.20.1751550861216;
        Thu, 03 Jul 2025 06:54:21 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-884e98b90c1sm2112778241.17.2025.07.03.06.54.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 06:54:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix attempting to send HCI_Disconnect to BIS handle
Date: Thu,  3 Jul 2025 09:54:18 -0400
Message-ID: <20250703135418.1693699-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BIS/PA connections do have their own cleanup proceedure which are
performed by hci_conn_cleanup/bis_cleanup.

Fixes: 23205562ffc8 ("Bluetooth: separate CIS_LINK and BIS_LINK link types")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ca57eab15169..92a24a82a03f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5493,7 +5493,7 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 {
 	struct hci_cp_disconnect cp;
 
-	if (test_bit(HCI_CONN_BIG_CREATED, &conn->flags)) {
+	if (conn->type == BIS_LINK) {
 		/* This is a BIS connection, hci_conn_del will
 		 * do the necessary cleanup.
 		 */
-- 
2.49.0

