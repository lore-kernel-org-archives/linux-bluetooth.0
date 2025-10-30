Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C3634D93C
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843728; cv=none; b=uQXWLLPc8fJyUcoSzsHxcbXagCUnoGkmSkNETR/wbNLah2REWxBlYM9tUYx0GLMGRxUrbJuKdG9XIbJCoiV4fb0/4sbk0HYrMW8BZpx9LBTWj+kfYR5+i6r0FnS7VqWxpC2CxXUD1qp0cgqkS+rGBnqGyRAoIYcA7yL78WQJZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843728; c=relaxed/simple;
	bh=P4sVJs6TvIwOIW2e2Pns+l2C0s5WyImyZ8xUb1FLRzY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rz0zVzA02cSQwLXrkGb+fyiWNaoWIdOi2mV6X/vLN8QAC574n6W8REWzRDlb4fJ/Acda8rCjtAq7wswacjhQUVAYPIRbE1q3r+t1yU+UXH1tX6j4Rx9pJKHXr9ud2qyPAO+yRu8qmLbnh+tnehxhw0PVYfHbo9Hl02XMs1rKDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0IxmXp8; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0IxmXp8"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5d967b67003so1546355137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761843701; x=1762448501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I51elFZXgkbCyenDZZVaSGBFbw1PPbSY/OrMUb2uVr4=;
        b=f0IxmXp8/DdaA1yw96GiVyPUF7H/klAGLH+geSUhBnAMm1GTPLICUVTAzmeZrLuDL+
         47FPmvT/FWh7oiocQ37I+cyxeW5Gou6ig4qoLzgEu2JurB9rOg/z5oOkGrGERn3XQeSy
         C8NHri5f5HTnO8xmuY7waaohbQ1cfOjm4p2IMUCoA9PSNQbK7Cha+G6Zj8SZw/oDmCF3
         vrWaTB61Chi2UITKq8T5DeCnK+Ak+Wtp8D6X4a7Gpaxpj1buj9OQVxhqQKPCboBdSda4
         +ZvUIAgSDFjzhgzD224nMlh3bnHqVDLXsw7OMtESj9XR3O4Gur0Tl985yLLbJpeAvtQ0
         qRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843701; x=1762448501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I51elFZXgkbCyenDZZVaSGBFbw1PPbSY/OrMUb2uVr4=;
        b=av2fS/mG/7NToWSVBu+ETcRRv6t+tQ7jyrL/FOeukvgVnoYKnYiXCf27zwtQT6rxab
         VaWCWl8AITot377GCMP15jCYvEzSXDPsOeJN4o76dEgfcEMTg7CvROXJM0aO5YGhKr4u
         rXLvvTLCWL3L9j+f/Aj+Cgs0UTmhJG74mYAbFusIKjgAPH+fi4YgDGkswVs7Q+MVO3u3
         R5Qe+NHaJN8pVwXzhNr67fqQZMR+D0NyNFJfwPBbcDwC4A01OHUHHfPBJ6czHt6Uba2+
         0T2+Dk8Z4dPnpwI+QLRr4ZWAbJNIVtv2RSf0ZwBTNsYmaC0JluP/2lwmJZ8D6w45bc8C
         hwvw==
X-Gm-Message-State: AOJu0YwzGjWWlmXRD1WFXDJM+nWR9MPN5LRIKHnTCNDVGGdBVOo7SR1r
	p9ZYhEWAU835H9BhK4PFyVNL+2Bb5ePRf9erQl7YPlr78BoJfPBpRE+5woOBBVje
X-Gm-Gg: ASbGncupefEvLpqnWOndhDY0D1JVACmI/Xs1V+biI6ixxF0eWvQ65xDZp+bqY+JlLZd
	pNIoWvVjuhGX65piEHr4+bQ0KMVbFhU8qL0zv5k43lDnDJL8WPopb8eTXceCxFmR0nNBsNvFCeE
	hDrhr2GxrCnjlKBdgbaCMp18UBa54Krw/6rYCZtQMJCS1lVstYaMkmyeidr1r0NwWX17yTCjrPp
	fhdQJYKjTRc98Exu4cMkav6XHT7QOIjvvSqRg73z+Jk+tWRzVLwreYLc2eY/R1ctsuR6AUuEIzq
	pFPCmE0OkrZiVwzLZemjtPrX+0srom86ajuqlQbdkDFUD8n+TjcADEnimOvSCD67SRBqgSN6s2R
	Y2WxoV8uc5skIcQBniuAbOgictQ5PrU6EsmuWddYzKo7CwIYrh3FFlqftgUzmZ82TR3lVN9UlDV
	TRniI=
X-Google-Smtp-Source: AGHT+IF+tSizRwAnMDBQ0k++xccFax4QAICuU/D/cIZ2UExkgjPN2saGhZyLNagAe0mVcoAZhFX/IA==
X-Received: by 2002:a05:6102:32c1:b0:5d4:1e69:fdbe with SMTP id ada2fe7eead31-5dbb11f99b7mr111746137.3.1761843696381;
        Thu, 30 Oct 2025 10:01:36 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9350197756csm811781241.11.2025.10.30.10.01.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:01:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] btdev: Fix crash on BIG cleanup
Date: Thu, 30 Oct 2025 13:01:26 -0400
Message-ID: <20251030170126.251566-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030170126.251566-1-luiz.dentz@gmail.com>
References: <20251030170126.251566-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following crash:

Invalid read of size 8
   at 0x400F26F: le_big_free (btdev.c:606)
   by 0x4024636: queue_remove_all (queue.c:341)
   by 0x40246C2: queue_destroy (queue.c:60)
   by 0x401B7C9: btdev_destroy (btdev.c:7820)
   by 0x400CFBF: hciemu_client_destroy (hciemu.c:301)
   by 0x4024636: queue_remove_all (queue.c:341)
   by 0x40246C2: queue_destroy (queue.c:60)
   by 0x400DA91: hciemu_unref (hciemu.c:441)
   by 0x40072F2: test_post_teardown (iso-tester.c:701)
   by 0x402BB0A: tester_teardown_complete (tester.c:713)
   by 0x402BB41: default_teardown (tester.c:266)
   by 0x402B43B: teardown_callback (tester.c:434)
---
 emulator/btdev.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 8c72a24290c6..c53db7040d39 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6863,7 +6863,7 @@ static int cmd_term_big_complete(struct btdev *dev, const void *data,
 {
 	const struct bt_hci_cmd_le_term_big *cmd = data;
 	struct bt_hci_evt_le_big_terminate rsp;
-	struct le_big *big;
+	struct le_big *big, *rbig;
 	struct btdev_conn *conn;
 	struct btdev *remote = NULL;
 
@@ -6875,7 +6875,6 @@ static int cmd_term_big_complete(struct btdev *dev, const void *data,
 
 	big = queue_find(dev->le_big, match_big_handle,
 			UINT_TO_PTR(cmd->handle));
-
 	if (!big)
 		return 0;
 
@@ -6892,14 +6891,17 @@ static int cmd_term_big_complete(struct btdev *dev, const void *data,
 
 			remote = conn->link->dev;
 
-			big = queue_find(remote->le_big, match_bis, conn->link);
-			if (big) {
+			rbig = queue_find(remote->le_big, match_bis,
+							conn->link);
+			if (rbig) {
 				memset(&evt, 0, sizeof(evt));
-				evt.big_handle = big->handle;
+				evt.big_handle = rbig->handle;
 				evt.reason = cmd->reason;
 				le_meta_event(remote,
 						BT_HCI_EVT_LE_BIG_SYNC_LOST,
 						&evt, sizeof(evt));
+				queue_remove(remote->le_big, rbig);
+				le_big_free(rbig);
 			}
 		}
 
-- 
2.51.0

