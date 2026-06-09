Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABA317173
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028844; cv=none; b=FaqNqv1ffHikHYx/iulFMWs2ETdfiIYpg3ZszGmFrW4I3kc+hygej3rdoXjkVrvpGLwWeCYJ9C/OiqbjifmpwT4mYzdyYZhbXc4ruMNwBsQs0cy9B8RTijH8uTOvnA5HhZAq2XdmzrOVUNGV5zF4R4ZoET4889OCburN/GZLYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028844; c=relaxed/simple;
	bh=+wVS0z2GgBpTs2DBEYXWlkPWiU62AJCr9vZUH5CYbHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GmNvb+vdMsjPs+Ocv643l/MyEcLggVvPV5c+8ar7SX0z1Ie9jIlTgoWCVO8+wpv/o04ucNxXRQWVujRqt7mjkpEVb/hBpvg1F+JjmKxv2B5+U/sqTQ4Q+Gu5wv8okNcSe/GUNbphB+f5ZEEPxXdWVYMyPmUJSr7IvYC1u1/GdW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=xyjUPlwA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="xyjUPlwA"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b613a17bso57946995e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781028841; x=1781633641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKEnzTSgwjqqkCexSP8WlI6hOKbRXkjqjKXrn8JkxUc=;
        b=xyjUPlwAYleoZBiyD0ZEWE+N+2MRsyqFV7QlA9zRyWR26nOmx7w4l7Gsy5QAcUQt9h
         1IVwvMOVJGukKqC2/NyriN9nhC0TZCK0fmOfhRY8DEEtkzTZkId7Mo+A3mDYsa3JrdbR
         N12olhSwyp2of7vqWXxhXS0r1SEfNrRz6n91c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781028841; x=1781633641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKEnzTSgwjqqkCexSP8WlI6hOKbRXkjqjKXrn8JkxUc=;
        b=SI99FQS0D2HgJkv2ERNDTj1c78uqXN50ba1pq/qET0xTktWiFGy+j1AeKgraHc1bIy
         o06a0gfj4tlky6gZuKYD+cnS6gQVi/SFmbsLqe0tfGrvegKgHwrRnd1gVvLIMyt9ANpo
         lz+haCNpztwNWLAxsMH/DsvHNTotcouN172zjrSd0q6sx9kN31EKqqB9QEqe0QpDDLbV
         7rJ5xHjUWbxDbSNiE8h5o7qdHzRJWb7xR8For2gWHUtzjXMv3heliYDANR8qFB2i5m6D
         CFtuf9G99QhOSV4e56EoK5wd7uRH7KLB1I602SIIRCZmMdJE2U/VUDFbgo87GP5BtnX2
         88CA==
X-Gm-Message-State: AOJu0Ywx3sbts6KHA53gGqijdPH0MBFUXOy3Gzd0Kl2mMTmsGTboJlfe
	ltRLMrUMsSW6RTtV8t769L+iM/rUaqEYIfF7jviOCNF6+YGFBSAdL3G+3UaAmIlZ96dGjoQQsQW
	4pgtG
X-Gm-Gg: Acq92OH0ePpLQn7AB1lampwSJtuBR4sbFeEfZYM6cqTLleorW9vsQdRo7dDt7RxMFKU
	dB/qfKOtgQaP4CQKD9jYPp7enIfOGyZgmBdh66q0WGbc6e5vluRePQTGI8FZfLpzq1YIDvSjX7g
	rAryQDNl9TexpR6H6MjTH/uzUDm2MNSVwBsrp9VNZ9MzBn+YrUIwxfGKt9yGS1zi33vXnmk9Z3n
	2V9eC/zPBT+8X63no5909DQs9RbCGcAuTc2sQPXU9PNVa+FRDhmofwHwb81q6bgc4tQw71HXrcx
	ChldpdYHl+T6JuoxlN8YYkfl5aMKJ0d84gjnqb/8bIZgk9nsJ5T/9HhZZbq3FEwoccovax1kT6p
	iyzGjvZeF0D1knW0f4TWB9pbl2qUYYBajk58hYa0g1QXkeOnI08kHRQEh+1cWK30ZbGrdFOmXov
	HrjzhhTJqAwwGuZhP5XV3BJZT7aK9Ifnn17JY3dONllnPO8Z10zQg1jlQ=
X-Received: by 2002:a05:600c:3b08:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-490d72241bamr53852875e9.21.1781028841222;
        Tue, 09 Jun 2026 11:14:01 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:824f:5c20:dbd5:c2c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm70373381f8f.35.2026.06.09.11.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:13:59 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] shared/vcp: Fix duplicate VCS registration in bt_vcp_add_db
Date: Tue,  9 Jun 2026 20:13:51 +0200
Message-ID: <20260609181351.3787741-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_vcp_add_db() called vcp_db_new() unconditionally, registering a
second VCS instance when bt_vcp_new() (e.g. a remote client session)
had already created a vdb for the same gatt_db. Guard the db as
bt_tmap_add_db()/bt_gmap_add_db() do, since VCS permits only one
instance per device.

Fixes PTS test VCS/SR/SGGIT/SER/BV-01-C.
---
 src/shared/vcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index c7f74956e..f05684cfb 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -1939,6 +1939,9 @@ static struct bt_vcp_db *vcp_get_db(struct gatt_db *db)
 
 void bt_vcp_add_db(struct gatt_db *db)
 {
+	if (!db || queue_find(vcp_db, vcp_db_match, db))
+		return;
+
 	vcp_db_new(db);
 }
 
-- 
2.43.0

