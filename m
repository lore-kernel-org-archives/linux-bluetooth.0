Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08715531A
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783694; cv=none; b=j2q8TzpgrKy7v2A/Yr5j2Fb1/biEJyshep/kg6ghvQUCGfGvJvl4diFam8nk8J3cPNeyHE0ISW7DoXi53vpjkR4wNMEpopKzB7ncELX9P4n7ioe739WYti08Rlh0Jjcer4FPfD4PsxEfLob8vtNzAAhR1g2zQxNoVS8fMJDXd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783694; c=relaxed/simple;
	bh=JLm9lzS/vn/cAwcVT3HcVW6APe8L55KK4dq0SZKyJI0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FyKTUZLkAcRxI1YAbZ/1b5s7GNH0zO4MIhXgXYA5JRUp/BQxlToy1XYn6KRYWIWAMX4qn59bjt1ylx61JoQAwCFrFf3+ApVkYFQe+aibJOr5QT6ksaDP/V0K5reA8dUD4uNmyOj3D3rAMgVfzm+V3qbNypDNDx1A04px2aTBQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c03ZvqbV; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c03ZvqbV"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f0e2612303so3821161a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715783690; x=1716388490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrftWPDEcb6mAAm+6I66nuTCv/3OtlWKYgkDves+hT8=;
        b=c03ZvqbVHHOkYW8Ry5+iHytdIHwCcfY87TzRUicXi5RYgLC0ZlzpB2AEYxFHeEqPhB
         vhmg4hnQJf5++wU9HaNPFxGJ+GX2yIUQI5SqYsJxMC4OxKEWzGhchQJ06ZE8QxYwE7J0
         NPaFLKVy8pEnGYSAdeBumRBFPOnYismgZSBm4rl4zbyWlk7f1CeWzaInLTBqhYhUvRBK
         PwVrz35nX6nnY8drYy7Q8BSlOaahMWCLCakzwl2EXi6BzGsUH+M7U53Hv0ASVCAOvp2G
         Y25nr2DabtbQY2bcwDRtEoEhk9lCbYNNAGXFHVcqVWoRQ1CjBE24fbA3k1qqXQiOKrTU
         6+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715783690; x=1716388490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrftWPDEcb6mAAm+6I66nuTCv/3OtlWKYgkDves+hT8=;
        b=SfLv3/kefCXsGDfjMqhy/rykJLlkd3+8pmOmZ5nNTq0Pmmm2o1uDC8CB4T9iR6zSyc
         4tWV7y3sFgAh6rQHVuWXWjHcRlVaAFHL8spEFHERvccUbytg9/e1oW8Ileipv51+hW+h
         XCg2zvEmqDDpjIpcoclasT/jffHaxthK41DUVWlqrG5CM//EaqdtHhyZ3LhQY33b8G1m
         wsCFOPBR9S3wTPpB33NCi4DSWbmRfLMvEjcaNLx3fc8Hy/yhK8p638l0pZ7VQ/VfQ4Tx
         bWdQPp/c/1OCbLGQmNcTn99/Hb1XYCLM9XJ2/iwqgsq9nTyZ1maW3oD6X+zIvDn/v8+h
         n8iA==
X-Gm-Message-State: AOJu0Yw8JfctF/fz5K/ArCqcfNWXQgA4OVddlnT2/PsItUKub5SucFYa
	LqZWzpdS1VraCb8DCF+/vwZlV02KI0r/xAQtsjo7VWq5OCLoC8+Z3ZmyqQ==
X-Google-Smtp-Source: AGHT+IFMn292f/d1J5rE/1y9AXf4D3qemv2cZf715UUfdNgnjR1nDye3QND2P8de8hTFyh3igNiu7g==
X-Received: by 2002:a05:6830:22d2:b0:6f1:23f0:7ec2 with SMTP id 46e09a7af769-6f123f080b5mr1899620a34.18.1715783690345;
        Wed, 15 May 2024 07:34:50 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4df994eef05sm1255328e0c.18.2024.05.15.07.34.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 07:34:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix not using correct handle
Date: Wed, 15 May 2024 10:34:47 -0400
Message-ID: <20240515143447.1371779-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When setting up an advertisement the code shall always attempt to use
the handle set by the instance since it may not be equal to the instance
ID.

Fixes: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 353de476a5cd..d24b08a111c0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1194,7 +1194,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 
 	cp.own_addr_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
-	cp.handle = instance;
+	cp.handle = adv ? adv->handle : instance;
 
 	if (flags & MGMT_ADV_FLAG_SEC_2M) {
 		cp.primary_phy = HCI_ADV_PHY_1M;
-- 
2.45.0

