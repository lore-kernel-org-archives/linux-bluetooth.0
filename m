Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8331AD55
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459615; cv=none; b=u0GGhZcFP+5yZ1eLDzQa4gItRoGYEzwg/nNUiQjSVcGw7lO0EmM8KWq43S4svai3+ZrFWm27oC4T5w3VBPhBeYSPfS7b6J862McgOjuPlCb5gPqZDAGWdNrYXlOhqmtn3gKk/Mw8KPGlsvCFWZKf/VjjIEcfG505UIRdRpPtsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459615; c=relaxed/simple;
	bh=R0lliba53OCAxwb9nCj+TtFDa2cxFlpIKm7MJGNipfA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OrvJv2kOJhERUThWrk2ANy+nw/NPgjR8fZ39vI++GdLtH6IBS+d5WbrmJnBrGvQYl0L+z/NFP8hEowzGxZuduDJhUGeJXKKptuJl5IhsYsoH58PXeZlAeBBcBhdXBYZ5tPDLbup4WGT1KwKeeagnGRvR6FrJBKz4XPWLjbIF768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgM34In2; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgM34In2"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f2faade55dso1058631e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720459612; x=1721064412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=To33v0mOFKh3KXvqbt4cvoIr4v8E7Pa9yXvGm/Nj+VQ=;
        b=hgM34In2zs9z9tTMIs17naDyO07pegG4Zb2ewlTMRXHScS/JxbYMTSU++qdouHsiqO
         6OJfFLJZutvKM9fH8oZAPVLWWjS2snqbMtMXp7InrDT3LIHOISGfxola0oNWmrSkSm7H
         0mh6NQf6RQ4kydeoVzikn+RbP9E2Kd5hleWi/hFMPiMXCFYYY0VxFqUiUxCe7df7dO39
         fgvZwZCp8CfTbGAL5yvEmj0F7tDCw5HQ36FYwCwpzysM1INGKzkG0Kax7x5J6qwiojUV
         joJ/D3fHuVQdkIgarUL7bTIBVsDPdag6Uoxl4D6QW9OyJZbxTRANmcFQGuOq1ClXRgL5
         RVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720459612; x=1721064412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=To33v0mOFKh3KXvqbt4cvoIr4v8E7Pa9yXvGm/Nj+VQ=;
        b=cmF2E6NP3J0EM/c63ykb34hb4GhAdcc2cP1A5GXRa6+pAUnCrPoSo6fNXv+w0Y24Sd
         c2kbwQON77/MsQL13/csDNnWcatHaqFyDQGf11ILonUQwMFzPu0u7+HIihB2e1YDxoB+
         UAtsOo1k8cLT3zoB10tyBf9TH1czb0+hVFH+0QSpZ54er+R9cSyef0PcrK/gEMRdTF4j
         vxUp/DoeXmfSEJ1h334WZHJP1bcO9mRZujimgNb8RvMl45tG0KFRwFcXXOoZ1Bh+y9rf
         yxrQ9kAgSjt2veqxRecZnesMT6T8I2MRl9qwt15vGXsnFH9ald0W39AErm4Ib1kIPT7e
         4XiQ==
X-Gm-Message-State: AOJu0YwXTCMtnULx9Vv3ov5ukorWD7bT2rtT8wcetZ+DrTSO8oxvwD9f
	zW+RsH1rnlpTN7wLnPhdtXqbsPptNJq3ut0qCMtGeK+vmyM5kqq5SOb/HA==
X-Google-Smtp-Source: AGHT+IG/7puQkdFkEl437WdxelBJ1IadSoVE9q6OvWagFut0bO052lwgDI+HgkTNW0bc4EnWsLZyHw==
X-Received: by 2002:a05:6122:4781:b0:4f2:f139:b2dc with SMTP id 71dfb90a1353d-4f33f2d4462mr243743e0c.8.1720459612064;
        Mon, 08 Jul 2024 10:26:52 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f33d9ed261sm55017e0c.7.2024.07.08.10.26.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 10:26:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btusb: Don't fail external suspend requests
Date: Mon,  8 Jul 2024 13:26:50 -0400
Message-ID: <20240708172650.2752501-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit 4e0a1d8b0675
("Bluetooth: btusb: Don't suspend when there are connections")
introduces a check for connections to prevent auto-suspend but that
actually ignored the fact the .suspend callback can be called for
external suspend requests which
Documentation/driver-api/usb/power-management.rst states the following:

 'External suspend calls should never be allowed to fail in this way,
 only autosuspend calls.  The driver can tell them apart by applying
 the :c:func:`PMSG_IS_AUTO` macro to the message argument to the
 ``suspend`` method; it will return True for internal PM events
 (autosuspend) and False for external PM events.'

Fixes: 4e0a1d8b0675 ("Bluetooth: btusb: Don't suspend when there are connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2d5c971a59ad..bbd75ba9874a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4700,8 +4700,10 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	BT_DBG("intf %p", intf);
 
-	/* Don't suspend if there are connections */
-	if (hci_conn_count(data->hdev))
+	/* Don't auto-suspend if there are connections as external suspend calls
+	 * should never be allowed to fail.
+	 */
+	if (PMSG_IS_AUTO(message) && hci_conn_count(data->hdev))
 		return -EBUSY;
 
 	if (data->suspend_count++)
-- 
2.45.2

