Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE813958F
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440799; cv=none; b=p03pSeqUCoOt+ktOB+kx9cLaS/Z6bC+XqTyvQStYrkQ/F6XGdwYQTw43DsYWh+rJjGmcgqaLqSDOKD3MP7D+7bjsxmVe7oCznOx18JTqmjJ6F11PziSxTmkChrHoGXdXkoYkXkUGUzljlH9NqZLN2NOhJWqC/EWW8Ol25+RWuvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440799; c=relaxed/simple;
	bh=U3JXHJoXfxXplytEMZ36wZ4tJSsPc/8Q27PTauh6eWU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UkMGRyTxasukkQv/G0SumXqbVrl2a+NICowK+IoiGge0w2lAhKws3CsBnc+EKe5z3snFiK8n9z9OSYBf08kggvsLpB4KzBVNsVD7+jubpwRagulv2F9KBGp3KHUg75no5BdjNcbiWwReKMgGnVYOTpWbOZzWqYDGf++RqBHMwH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2q4ir+o; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2q4ir+o"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4eb1b9865e4so561429e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2024 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717440796; x=1718045596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9B5sTBsDV/euPRNapmwxQ9v3fRRczY8l/+j7l6rxQ+I=;
        b=S2q4ir+ouZCfSjGpT5hFemG1+iRnPh4Tu2IvkORahp2sZQiUuZeqKfcPef/CGYp1Cy
         Upaf41Qa+yekdWZZS5dnodP9k+6rEzfHhoEG3/c4nMfOTQyM0Hrcv24hqmv6IhxcFhrm
         kzy2SoPvaOA6lA5DKjM/NSRJLWrTxq7MRVuHti9T4KRt2FMXGdxDDS6qAXVAQ+tukda2
         tykO7aXGpP3NbCVkELdc0wZQeJt86DcurOJjxR9NvAASFt7Wl984vVWoxNAQYAv7vpml
         PmU9y2ZudaluGRCZOzqG5KZjVja80EkcmGsnBo4t4TJ+KkVY6lZv/RBLn61iqWYscYAf
         zCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717440796; x=1718045596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9B5sTBsDV/euPRNapmwxQ9v3fRRczY8l/+j7l6rxQ+I=;
        b=ofrSgLYuCfHRGr71jMJpwxPvN9JkFFVV6+Rgy8OUgf0ac/1tTnPVKBfxeeHlXnxIKZ
         zz/LMZRrW0udc+t6rBs99fgAhkA9DRN1DfRfEeNoeMFht5Aue92IOJVpg8NZYgYj8w7R
         Akju2TXkfIisgqyhGj7aRNG+cDRxNk4OL+4HdY7liHKNBt7h/8iv6Sr+hbcCmfeqLrZv
         PHrRXNAJgJ5e3Qlpbfy+R1TaZQa/+7gk1/DDcglHdihtoG6eiDAxpcWd8n/VN5Mk9gU/
         J8MoYJMMMp6QVliFNui367bPIYTJWunjhPgqdG4CPbxUJndclL8NliteG+bWG0IiHrUi
         4P7Q==
X-Gm-Message-State: AOJu0YxypfXe+LXx522CcYnSbI3X0hgJBVUfZ8/OPu/9ZU+1P2A1ZWE1
	iChDUjCNEvAwp3ybxauQkNmksSq/j1DgyZl8Ah9I6pUuORdM43rlUhbiNQ==
X-Google-Smtp-Source: AGHT+IF9/1+UghZIZrP5QrymJnAXaA0NNmVUomwJPYEw+LiMfd4E7biyIVYZX+KP3i44PNoMxyIN0w==
X-Received: by 2002:a05:6122:12b7:b0:4d8:37eb:9562 with SMTP id 71dfb90a1353d-4eb02c71bd2mr9396580e0c.0.1717440795088;
        Mon, 03 Jun 2024 11:53:15 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4eafecbab81sm1231658e0c.0.2024.06.03.11.53.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:53:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] shared/csip: Fix memory leak
Date: Mon,  3 Jun 2024 14:53:10 -0400
Message-ID: <20240603185312.162337-1-luiz.dentz@gmail.com>
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

