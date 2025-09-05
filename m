Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058A37059A
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082837; cv=none; b=j7HxmbVg5lOQ3SQLS61xR1KbVorCoAuZtiuHh80JQ0L+Bt0TP1t9Qcd41eYga66crT3lFuIVjROGuBvs0FGXgMUtPxkONs6Hg6QUB1oBMfqzHN2IBgkLpThyoeEGdnbsz3daV/WZIS1HN/iZRFbvSfQ00CMSM8Ur/yMhCzk1VAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082837; c=relaxed/simple;
	bh=fPQeRbdXoThXahMi/i3/VfT57cA9LoFX9CUKngeSwTg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T9oi4rC9lDYhNvRAkBtIIbGKJXB34Wq+hZmDW+5NZL/hKrY2byILY3mKF3j1MoMh9yVV2ySs98WFppFJJEtUF0XfUQxBpS9KHoi528zPUF1vFTZw0FFGvFpw1d6eTd3NkUv4o9Fe5k8lz9hIvD3TYz4uBuCESm1BaJaFVemhBzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX5IHu1v; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX5IHu1v"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-892196f0471so755531241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Sep 2025 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757082832; x=1757687632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHs4YkyGtlE7kYgwvUU+Tn2srfs/K/5awKotVpYykp0=;
        b=UX5IHu1vgGfivRqrZS/UZjD2ql5lLlbLcnNZp8N3BoKxY/UBvIeFkFD+sHLymIV2wF
         nkePd28y4X+w9mwEZD4XAhF2xCXIrNSJOVjoTUeDjAuHA8N8WYWAXieDYbVRBC3Cugb8
         DfH/leL3K8JfkreTmgEcTbw/oMyXUyRQ2zuSWwyQ/McVc5Tivxwp2Mmx+XB5gkiGhU/0
         Jfk8cY8ufhVhbcrIEHXw8xiBSW/XSj8GJicRGvLiWmUcaQAHmqQwKS9uEqKeOj6Ypbk0
         k1hrhWSESTOSx5PcNshvWVueb42N0Tt2qk5buugkahSAq01ftoKdfQPLGreHcehr+//D
         WqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082832; x=1757687632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHs4YkyGtlE7kYgwvUU+Tn2srfs/K/5awKotVpYykp0=;
        b=OqRh92ZsZJ3YLCA37lXoAYRRrDzwpAZxmLtvIF/IwCycNHNFJUSMStEkVtLp0fkUsd
         RQsau5D6eV61jPQtMXwRzjoGZtrkOtDBrgGevzYeYr/kHKWFbEAESPTSdTg3b6coFAq/
         JCaOX3zxd7j04maWh+b4PgGY1r9EHk7dOhPD9jqGLxEb/KxKe6NFPJNwVwtUS4x0+SdP
         P6NcDm9y/C0Xcss8xOP6bs3hNKRHLuc9XrSJHj6yIUHSTUBWXei7ff+R50K0uF2FcJqD
         50ioP/Smr3bUqZzsnmi3dlWWeLOGZ5FRoI1b9MuJw6PY5T8TAhh3gINK9v526zrWgQFg
         4syg==
X-Gm-Message-State: AOJu0Yz8yhDb32XDem0jQ8VD3yU1cCNPTjC9e4bN5JXzZescQS5qzsGQ
	9EdjfQWOSrILGEcPDgm8DL5W4rU1ldxL5VAl0npU2MhytGPBrS6wvGzms7+7mWVZ
X-Gm-Gg: ASbGnctVBS+m108tguZ5uaILTBotSsHOf9CZ4RDW+a0Bd2pSld3T4HGM154m6+g/BWv
	Jkh4RpQpXitoj3A4joJ+grk5wZEkruWqP8FYpo+UdG+papoWDgGSq/9FlCWW70joYvDcHQ2tX1Y
	drzB4rxVF7V0g/rEDkS4777RLuNllceazawAnPZEkEgSfncgN3SI9WXcUiugE3GNcA6JKe04kc4
	aocaX4o5Q1F9GEEPxr5aLf0bCdaw5lT2snfPdjApI+sebyGNPF6ZK3g0sISkSJaoevtvaNg5qB/
	azoPg7z8JLdrp45IHT63yhhdfiqFG5VmGfmUbjA/UdTFtkBCsp7K6Syw8qfuIol9FYsdxXpN3Kg
	9i2VG5dKoKinzpZRqE4/4lIxwKPmyYGtPvc+mhU4LxqmmJfcti4B8YEQwiCBnky52fRZvaRstGD
	+1fa3kgSI1lw5feGtMEIyySJ3mF6l2mw==
X-Google-Smtp-Source: AGHT+IEQaACIgzetmNVlihESr+bu2OqxFgH7y/FEc5yI9fvr4pMfp+PaTNtl88kp/3n0xyRzlNdOdw==
X-Received: by 2002:a05:6102:441e:b0:4e6:a338:a421 with SMTP id ada2fe7eead31-52b19534c68mr6780121137.6.1757082832555;
        Fri, 05 Sep 2025 07:33:52 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-899c47af508sm3839841241.11.2025.09.05.07.33.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:33:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix hci_resume_advertising_sync
Date: Fri,  5 Sep 2025 10:33:41 -0400
Message-ID: <20250905143341.908473-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_resume_advertising_sync is suppose to resume all instance paused by
hci_pause_advertising_sync, this logic is used for procedures are only
allowed when not advertising, but instance 0x00 was not being
re-enabled.

Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 39d0d7b9949c..ea835e36565e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2594,6 +2594,13 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 			hci_remove_ext_adv_instance_sync(hdev, adv->instance,
 							 NULL);
 		}
+
+		/* If current advertising instance is set to instance 0x00
+		 * then we need to re-enable it.
+		 */
+		if (!hdev->cur_adv_instance)
+			err = hci_enable_ext_advertising_sync(hdev,
+							      hdev->cur_adv_instance);
 	} else {
 		/* Schedule for most recent instance to be restarted and begin
 		 * the software rotation loop
-- 
2.51.0

