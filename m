Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C712E1DE
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570712; cv=none; b=StkO3B46c+0PW9tpWUZjWbsvAggPXRpdaqRRePpIIqPFFf1/MAHbzaaZmtvbL+ORI48ErunsFNSU70CyMcTKbFHtysXgrhcszZv01N17aEjQCbVu4XSVpiSFdadASVVfEgQ4ejt/0PsMjlhl6EWGYUroVVOWzCV6t3QADIRd/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570712; c=relaxed/simple;
	bh=U3JXHJoXfxXplytEMZ36wZ4tJSsPc/8Q27PTauh6eWU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eQ1eAqIkqSZ+dV9yh08CUqmfpfOxsVDTRSthoh7fDlmb6uVtE/yB21wXcf8o3SnRBLDI+mtPCEO9DUxb+cm/wbYzpPpGu8QIbXFgpmQED/z4i24Z9szcRjz1qztdCtFWGyUulxFXyYmZUfcNXgMk9Kny/qRTa4qfUxtwTbEn8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6imXdsX; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6imXdsX"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c9f297524so652966fac.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716570709; x=1717175509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9B5sTBsDV/euPRNapmwxQ9v3fRRczY8l/+j7l6rxQ+I=;
        b=Z6imXdsXJ5+SvE1cVsusl1OSSrW0bCOsH7BrugrTJ85Xd+moFeKxw6zzKLrHPPOaAv
         aWtnhceoN0fAwP6co3MsswKTpUfFWQkoykwLsRwX3Ueg3C7w5VtwR6/gr4GGgcUm2XtD
         MSrKE4nF+i4M7qzmKPn3HVlAvd6JBQtF0VHw7hr//rl3C4q/fCpy+DYtNKLcB/Lvia9T
         7ZA4nJUKXsMCA35w2fMW7fp4LGMBniI95p2hfPKFSSnGdcgX0CVEXGM9NnwwK2fFncmN
         BtCxD4VNF7Jh/ZDJzNsIxeKmNjN+QABrFH7ejslApjjn9Jyc2jCS/bU7NF0PqW4gT6AE
         U/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716570709; x=1717175509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9B5sTBsDV/euPRNapmwxQ9v3fRRczY8l/+j7l6rxQ+I=;
        b=Xm3LML+a3uZ6k8v+wO9aNfd8n27MONtWAWJaZRLG9Zo1PvTziluPI71zgrfRhmxDq0
         jiXaThSQE20jODzZozNetQVhlcVLViW9hrZH8xV+mPOG/hlqCk/uB57hYCwkakkSma6e
         1gSx9geIwPO5MNeZyZficSc2mqCeU3V4wGBVYkfJwnQ3G4q3rV/z/kxsRfvWyG1ploOV
         0npmpx4/7X+IbwMPSLNkBMbTDD23Dt3IHz0k9TFaAjK4vXaJOvBxKg9CImJvJK28MRHx
         SsTuxDmT8nm0l9XQOpCqfYvuV/T+VbaypShNHy9jxnBXxUexj63c0FfVTB94owv0gV+I
         7bdQ==
X-Gm-Message-State: AOJu0Yx2MXo96ApbIlcrmxjTYLItDljeAhkuNODPwWJMgd/HLf3orKVz
	6gS9Nn6mbOWcL6Q+N+9NcTrbaMJ9iFi27c9TwZlR3JRqIS6iQQt/MzgWPQ==
X-Google-Smtp-Source: AGHT+IH7aQ8J+HNTgruVsagONJcmw51TAOLwrfaC6OfW3oHjuNync9r/pXOODHF5mbDjE14iATWdBA==
X-Received: by 2002:a05:6871:80d:b0:233:5570:a2c6 with SMTP id 586e51a60fabf-24ca1170593mr3222990fac.12.1716570709399;
        Fri, 24 May 2024 10:11:49 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-804cc1158ebsm256676241.29.2024.05.24.10.11.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 10:11:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] shared/csip: Fix memory leak
Date: Fri, 24 May 2024 13:11:45 -0400
Message-ID: <20240524171147.2733570-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following leak:

102 bytes in 6 blocks are definitely lost in loss record 660 of 909
   at 0x484282F: malloc (vg_replace_malloc.c:446)
   by 0x5A078B: util_malloc (util.c:46)
   by 0x649162: read_sirk (csip.c:485)
   by 0x5C74FA: read_cb (gatt-client.c:2713)
   by 0x5C4137: handle_rsp (att.c:880)
   by 0x5C4137: can_read_data (att.c:1072)
   by 0x65DDA4: watch_callback (io-glib.c:157)
   by 0x49656AB: ??? (in /usr/lib64/libglib-2.0.so.0.8000.2)
   by 0x49C6707: ??? (in /usr/lib64/libglib-2.0.so.0.8000.2)
   by 0x496B666: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8000.2)
   by 0x65FE3D: mainloop_run (mainloop-glib.c:66)
   by 0x6605A3: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x31DEFA: main (main.c:1468)
---
 src/shared/csip.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/shared/csip.c b/src/shared/csip.c
index e13efb6ce634..87b4590d926d 100644
--- a/src/shared/csip.c
+++ b/src/shared/csip.c
@@ -128,6 +128,15 @@ void bt_csip_detach(struct bt_csip *csip)
 	queue_foreach(csip_cbs, csip_detached, csip);
 }
 
+static void csis_free(struct bt_csis *csis)
+{
+	if (!csis)
+		return;
+
+	free(csis->sirk_val);
+	free(csis);
+}
+
 static void csip_db_free(void *data)
 {
 	struct bt_csip_db *cdb = data;
@@ -137,7 +146,7 @@ static void csip_db_free(void *data)
 
 	gatt_db_unref(cdb->db);
 
-	free(cdb->csis);
+	csis_free(cdb->csis);
 	free(cdb);
 }
 
-- 
2.45.1

