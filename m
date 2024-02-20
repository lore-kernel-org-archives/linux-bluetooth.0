Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078E762EC
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452805; cv=none; b=d7leDhEoVVTXPX02QU3ctBz2A/7MG2gEsBMoJPURiMukMQBa2GtAPPyneRzCIt4UzvRLYxhk/x6z8nA8BMigAln9eSpLaTCtIjD3LnW9/+5j3dizt7BSI/Aq6XQrfIB7a95xaL7+tMK2OaJB0EwTvT+5VSskPCUcFv9c76+7EyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452805; c=relaxed/simple;
	bh=ozfdrdAtQIOlLEIIYeYShm+7LwPmM8HtxLnz7Maoc3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=krShB8/KiC1U6MQWQdVV6Ne5HZBRJtTSGfiwtq6/Lg6SxO2qScyA1S44ftCgJHdxgHmYsNqRA1wx8F7Zhlxq4hWAQQMw1lQw+luOG8K0x/dR466yLGBkVNSrMplyJquft2ySuo1fNLN75YjbCWAyQcc0DDPzE4xjAzXJcKpLqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdSjWJ8p; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdSjWJ8p"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21e6be74db4so2594192fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 10:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708452802; x=1709057602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rtatphqznERiVJ4enLULaeElYlS5CJ4pOukIE0BXno=;
        b=DdSjWJ8pQTFygq/41Xo2QG72HtSpTxP3weqZV6bTkxLoyes7HkjPxpzj4KvBNxkY3C
         ALa4gsKc3AgWBCvm+o18YEXTvnsjJ0ZqjLPGNAjuYYpDNn0ODcbgqQ7jRIh/qecpVJQs
         uGkDxcYFaH3zwWEzXH3x2bt7ruxTWMxHDKN3yX7GIVxqHwyy8rr17mOwaIdkZUXjKBqL
         xBvdMPBbVVMYwIclUueJBFVSs17x/TmLp4DEZLyh2JPrvWV5jQcU3MFzqmY+/Quawhke
         dPGLwm+274SRO8I2JQe3dpDsIF88gvuLZOFCuWv9yYkF6gk/o6fnhTrNsrpRU81DXleA
         3X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452802; x=1709057602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rtatphqznERiVJ4enLULaeElYlS5CJ4pOukIE0BXno=;
        b=YeIZAqVG//hJV1x2IEeE7d8fQ5IJu/Z5d6SP9FpWcl+PP3uUAJfrgxgDMOtT1yquas
         hx9ETJzkC5TsG65ttHTPsBk8BQeVdEJzUE72bNEW+4UoKjn0UAW+RCmLYmgGPembnXrb
         npKbDq1RLpOmWthqEZo5LigIGf8imQ5KImTq3hHxV6SvMF/iPLUEMtpB80FoB2guw1zz
         kZ6/LRn/yiuyWy3SOmfEwWhL0h5QZbUl8ig8Ethfd7iTZFkeaQ+MaBuL2bej52ZL1/ae
         JT0VaEWaCA/PbCT16rZbeEC9tdr7w106vbVEmAShkVGnBOfFJCYn5ScOtMq+7ESvIyqW
         B4kw==
X-Gm-Message-State: AOJu0YwHG5eih+cYwYHjojd3ZNdqr4L59GVM9vOml81pPUJoeooQerH+
	3m4bjqGoGkNU27s5k102I/P6VtZ1XkF1xTkesZj78tZIAIytRL2wEETWYk6r
X-Google-Smtp-Source: AGHT+IE9zfk4spEBentGrhTZv5ezxUbtEFOfYYc39CHU9VvTGuxL0AIqvp1pX3prlDZ/D81qkbG87A==
X-Received: by 2002:a05:6871:653:b0:21f:2b1:cdea with SMTP id x19-20020a056871065300b0021f02b1cdeamr4629371oan.57.1708452801744;
        Tue, 20 Feb 2024 10:13:21 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id 2-20020a9f2382000000b007ce34bd1de9sm1788248uao.16.2024.02.20.10.13.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:13:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_sync: Fix UAF on create_le_conn_complete
Date: Tue, 20 Feb 2024 13:13:19 -0500
Message-ID: <20240220181319.368485-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

While waiting for hci_dev_lock the hci_conn object may be cleanup
causing the following trace:

BUG: KASAN: slab-use-after-free in hci_connect_le_scan_cleanup+0x29/0x350
Read of size 8 at addr ffff888001a50a30 by task kworker/u3:1/111

CPU: 0 PID: 111 Comm: kworker/u3:1 Not tainted
6.8.0-rc2-00701-g8179b15ab3fd-dirty #6418
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38
04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x21/0x70
 print_report+0xce/0x620
 ? preempt_count_sub+0x13/0xc0
 ? __virt_addr_valid+0x15f/0x310
 ? hci_connect_le_scan_cleanup+0x29/0x350
 kasan_report+0xdf/0x110
 ? hci_connect_le_scan_cleanup+0x29/0x350
 hci_connect_le_scan_cleanup+0x29/0x350
 create_le_conn_complete+0x25c/0x2c0

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7306020ccda3..669099cf9b1a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6708,6 +6708,9 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 
 	hci_dev_lock(hdev);
 
+	if (!hci_conn_valid(hdev, conn))
+		goto done;
+
 	if (!err) {
 		hci_connect_le_scan_cleanup(conn, 0x00);
 		goto done;
-- 
2.43.0

