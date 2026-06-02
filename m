Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9193546EF
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780443313; cv=none; b=CWrtDm6sLcauvZ554hiVr235CAw4Kp+KrvA6HJgdgZa+B8kM3fj6+Ts6+rq8/8N+uXVg+Rt/bsMIRSSWmR0vqIYlZUtrsQy5a2XyQQW0dudyHb7UapEA8+Zm6KjX7rNLjYQWAkfqFYxSoJIi1yPpNT1iAF8M/i3wACCL/C+TCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780443313; c=relaxed/simple;
	bh=5WGH1E3+q5dh3QjHIL39ElESPr6aOtwdfQlqg2sCihk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZsiJ9KDDOZDw1AgUC008DmtBNZ2E8hbrssFYfpkTyxKp2Jogs9doIeNxzZnbU7yxIqwiHkvLrCnfiwa6D7K2ky76AhsHlGaus14OxALIxt0M5Df50d7qgp/DVAJtJ//gzwjN8mrsENAFIZjkNvaa6yRnX94GbQYRlrupGlmENag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4Bs36Of; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4Bs36Of"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-915660e5b8eso320145885a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 16:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780443311; x=1781048111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VH9hbNCtShw6JmD3y+vRYHGyk8aXTiMz2VCmZ5+oy/k=;
        b=j4Bs36OfD9vPcXRXDzRnj7GhNMKtMb1bl92WBVTzdp3dvBVIk8FZJTy5w1p4ThpE8i
         rdk38YY/CRVPqJTg5dbDgcqciNk4yBHwWdrR4PI7mN0EiVrRhvl6BJy/YP/F4mmPhiJr
         gDBWP64MobxVBSaz7E+rDpUcwZtVvG26rA+o5U4f9hli93nTA2fE6xYuDO2zjwM8VMAr
         ofwC70j/CPW7WpjzNmd2eQOLJgRuExWLXtxdW3zg0tuwZyvLYr1Se7huJH3HfjnEtnjF
         3sAa4D4XgxguUnniHPtI0q7sEEf3Z6VD3P9otNt/T1h8S0IFRS75Yj6W45pAI7OMDVH+
         oXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780443311; x=1781048111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VH9hbNCtShw6JmD3y+vRYHGyk8aXTiMz2VCmZ5+oy/k=;
        b=sQHe8EjSlCmLdRQKiEUIje81VyJ3G7TOpLG8gf/aK1r4xP0PsaaYLurwKuJeBm/KR6
         E9ToL4aOxa7QgBsJpCY0UR98GT1cKyL2kvT/SY7q+CBLAB8iB7NJBNj0tc6MpXZ4UMPU
         SyQr8wKecxkhDfpVT196a9W2q7qb57UdFSbImNlPnrQ61Rhvs5spxu2ickRorNv4RtKW
         ++XndW6q5GFsYn8B36eELnIYPxqfErubziYLuehMbu7g3/mg+SU675gpBnnO/LcEUR2c
         3bfQCh/XZv3/OkG2DP8dwrncQ6EWuEbyRGRNlHqoQ/YJmnLTpsnm9T656fbD+jgYfEnU
         oEPQ==
X-Gm-Message-State: AOJu0Yx0zhmamSHB1dJoEmRHeJii0BQDlMbkElRk4n+mt2hZR8Z4Q1c1
	tB7AHYEqv8hz0VdFuFVg15gho5sr75d4rgDCZ4Lcv6zFxqAm5VsVdjIxzofAfeqtQQ==
X-Gm-Gg: Acq92OHJIt2r8xrOhh73m2od/wYY8RPraaV7zoiS7aoaEaxmfdpb5sDmeJx+oiwTsY1
	HRA1Rr/bkMzDrozQVvgthEXU2B/KLPF+DXo64fIiDM652Mj7QMBzFJvl5nVIOIP465VLkVHbeRH
	EkbdN62DgUYsn3gmMLDCH6vDsn8LSREbv91Od2XNqajEb1poKPUqWo67yiPc4YaFpfQqHC4BeB/
	8pQ1aZOIOrPEVJ1BtqgAcSTT06363tGI7ac1cHTp/xy7XVW4qcGmvXvji10PJGFtfhmoehOxr3k
	5Bl9vNpjvazRPKqjT8QjS8QBofeOUFMhkVeqcItb3k89eqRwSWbtiWIZZQ0crEde57Gz6ZjzHh5
	OssK60cSQlyac3Eu7HJ+mds8Gd+U6nX9vgIvyOnyajUhoWZYhsnqvzcXb5skC+prAAB9p+DhfBB
	DaUFC7DsHY7LZkWuJ5NRyB7VeZ9A==
X-Received: by 2002:a05:620a:318f:b0:915:5379:b511 with SMTP id af79cd13be357-9158a8095a8mr225650285a.43.1780443311386;
        Tue, 02 Jun 2026 16:35:11 -0700 (PDT)
Received: from rainbow ([146.70.171.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a2465e7sm84251085a.19.2026.06.02.16.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 16:35:11 -0700 (PDT)
From: Jordan Walters <jaggyaur@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix Use-After-Free in hci_unregister_dev
Date: Tue,  2 Jun 2026 19:34:14 -0400
Message-ID: <20260602233414.209730-1-jaggyaur@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hci_unregister_dev() function fails to disable the cmd_timer and ncmd_timer
before freeing the hci_dev structure. If an asynchronous event or timeout occurs
during device teardown, the timer callbacks may execute after the device has
been freed, leading to a KASAN slab-use-after-free panic.

This patch adds the necessary disable_delayed_work_sync() calls to securely flush
the timers before the teardown sequence proceeds.

Signed-off-by: Jordan Walters <gloambit@gloam.sh>
---
 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 28d7929dc59..1cbc666527c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2671,6 +2671,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_work_sync(&hdev->tx_work);
 	disable_work_sync(&hdev->power_on);
 	disable_work_sync(&hdev->error_reset);
+	disable_delayed_work_sync(&hdev->cmd_timer);
+	disable_delayed_work_sync(&hdev->ncmd_timer);
 
 	hci_cmd_sync_clear(hdev);
 
