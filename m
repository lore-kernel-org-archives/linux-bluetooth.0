Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54796340400
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 04:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916539; cv=none; b=CqLTLh+rWbVVwHPbwDEop3daXocFRxfzY4ps7qN/gbRNYqYXpxfBqzl+P+6/KVK5HlMj/sGvih654bUX7S4IE7sosN8z4AgBUton7dnirtoCQ5vEL3EgQwVFha7Vu2EgVJhRpy42Gl9W0BtcpkwJBrsNRoHQeFDnrZR79dzXCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916539; c=relaxed/simple;
	bh=s+RQLXyT4t2jYvXUa4+cRQf8b4fszo8lGoaqFtiNCko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hEb1cenAMybDPcAVaZAA7n6YCXZ4UUblDW+O+1cqdUfSh7sVWmkTN/jwYotPBgqHtrq80hh0Xh18wk+cr7QTggSyL0E7+i6Yvgx0Jhh19eTFKqCEo+VEExkPWbVK6znXTeHKLDbw4+rf9Dlfvmu5ACt9XoZed54yCLQx6eAUTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KisJYlKI; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KisJYlKI"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d07so6150299c88.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 21:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790916537; x=1791521337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I1uO3OxtYozwByW7Bts8UG8cJ6huXdi0MymMUltj7RY=;
        b=KisJYlKIKyYAo06ivHbwnH9Waf/1XggKYjTk/FgQSKaIB3bPYh22y6Nmp0eEnynzHz
         vhtWoHBob7SJ3VbKf8nMzw5f/uhYQLWKbfzIYYPQU2/d8sCWqKYZLB49zvM8vB5PIanF
         CXys23L6YsXZpX2N3RhULC0PNYjgzM1IgDnIkxRbJ3Kav1AcDRfo08RPC9E0lKnNvXno
         AQ9NLoqmrpf+SISwbSkmk+Um8mci6fpcj+PWaa9CEZ4ekt3sMgYHdhntI3hGWMKG1uwB
         CxWmNDMYZXpQoxvr55y7c2UuAKBSRinfhrxUHe00UnVqUuTPcjeCdflmLF/1+hUKd3xJ
         5a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790916537; x=1791521337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I1uO3OxtYozwByW7Bts8UG8cJ6huXdi0MymMUltj7RY=;
        b=yFvI2fVQWhij+qdorkYWGc1RFV9iQFDC116CzDbEQpC2OoriBmmQaOgNCNkAtXZY34
         b+Gslp5JZtT9x1Pmz/YjRNnwuwRxuQbeYJBepBK/JeoxHYbW+kwP+iHXKd/mSu7PybnN
         PNVcmfaUF6QWeyypGJbiCjUob56yTZ2mA0lT3Cz7+IICMTKTE9zingeje7anrzgJsF6X
         OhyExO7azGMgu7KbnvuuqKhAM618ADnyhupWFz+iay5bqFCb2q0yJ1RTmmYOSbECdpSn
         nfd4kHVcGRIYIUKOPlrKCMUsnCcEsAvPQZA5nNSayS7xz1fJyLjFXMXEUBrs+JCj99Aq
         LNKg==
X-Forwarded-Encrypted: i=1; AKwUvByPCV27clH0g8w9DCD8BoLP4NB+32X7h8fVqSaQCr8LlaM2+SKHGiczCP3jLEC0kUMHU65R14637EVHNvSmodo=@vger.kernel.org
X-Gm-Message-State: AFuF++ktVf1mzXa6zGsfax13UaNGXOXdqDiBd2b9QUNR0p0amlYGZblo
	X8cJZ5k38ZIOSOZvEj4tbWXlEgEy7hCFZ7SnNosGH/pId3crEzFukmdsCRbbEyYO9CY=
X-Gm-Gg: AYBFou0QOSI7Xlcd12lB9ANDc9zOonJTXLjimAB5pDiZNKrkv1YX/30ZD0h4YtQeFAb
	QdDLJbSmvMTV6JDedazq+k3zVmdPeyCgWHS2HjjndUTspAjvoL7zxt/CkEnZ3kEo0rESYSD5G6W
	epx/P9TDYoD4qSLpXVJ4Ytn8Jn5MkDNDqf9VEwxFlOzdyAiKPUgvrwbXJ8q9cw5ytedLq348lls
	mHpHnUiuBUGj1KdnNbCZkUXiuQmlqrxyES+ltJLDH2mIkn/JonRmOrX6iTDtwF87DWIHLLyAw2s
	oLuFyiKZ/57/kCbUESMTGTiTLGFwKCeyPYKNbtNtW88fS/F/1mgIub8ts73i/XRZ4l3gRqR4lu9
	J3QmtM1DPzjADQXBjubAjaPpsC/RFc/hEJLozNamVsKRPk1ENPKF5fBXxgqCzLdIpLJK0RS7gsA
	abv92rSJqxhnD39pkj9jbUUvL0DhG9PHGj8cEu7N30jwlifMu5W2mK0lcMYC7AFrcO51Oo8FhOQ
	y0TeDYTySos2yv7zO10xr1ODaNwXKuEwi+SIGH9cD2bzUbUitdLKV5+Ck+vkCElBzJ6XXyvnQpb
	T0wnKCI2Bf5MK49PlFUj9d0fYLssSWajbqAQA5du
X-Received: by 2002:a05:701b:2515:b0:14b:1757:fe5 with SMTP id a92af1059eb24-14f56062d90mr1844489c88.0.1790916537187;
        Thu, 01 Oct 2026 21:48:57 -0700 (PDT)
Received: from rabindra-loq.localdomain ([104.28.227.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f46da52aesm2420126c88.10.2026.10.01.21.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:48:56 -0700 (PDT)
From: rabindra789 <rabindrameher116@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	rabindra789 <rabindrameher116@gmail.com>,
	syzbot+48fc5b35b350240fd465@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_sync: Cancel cmd_timer before draining workqueue
Date: Fri,  2 Oct 2026 04:48:09 +0000
Message-ID: <20261002044810.80340-1-rabindrameher116@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmd_timer can expire while hdev->workqueue is being drained,
causing hci_cmd_timeout to be queued on a draining workqueue.

Cancel cmd_timer before draining the workqueue.

Reported-by: syzbot+48fc5b35b350240fd465@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=48fc5b35b350240fd465
Fixes: 40b87657200c ("Bluetooth: hci_core: Rework hci_dev_do_reset() to use hci_sync functions")

Signed-off-by: rabindra789 <rabindrameher116@gmail.com>
---
 net/bluetooth/hci_sync.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c01c8b58d9e8..e1c28bffdc15 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5545,6 +5545,8 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	 */
 	hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
 	synchronize_rcu();
+	/* Explicitly cancel works in case scheduled after setting the flag. */
+	cancel_delayed_work_sync(&hdev->cmd_timer);
 
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
 		disable_delayed_work(&hdev->power_off);
-- 
2.43.0

