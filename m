Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DC3BB3D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FETrJKWU"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-595d24ad466so1902619eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 09:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822571; x=1705427371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O9VWxaOqAp8yt9/GjSW4V6FFOkCfgXsvX1IU679pRv4=;
        b=FETrJKWUS6PP32QshfX6pw/8CPOjFvbMPV5nCp6aHB50vi34WEwi/b3N6a0h8Besy2
         y2V2qpdoDnMvkmAM6mzNqa4N8X3T85A8kO5BnmMcTm3ND3xnebXAvOFI3QTQ06ARGDNa
         YBDtBzjHGtXikF9f7T2Ryjs7bD3lvV2NkP8PatndrCtCqrg/23+doiQf2eOPIaPdNjXY
         n5QW5pBTbaIwM8r8yEI/M8KpjrvNnVqim44SK/xhTrlFwIeZieTd2QnQjLEBygP3Hetp
         Vad1+GIeA2Rpsj27wiFrcYMF0aSu6V/cckDT/COewkgneRiwoPjbEft17DBQGdb13MaC
         Y8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822571; x=1705427371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9VWxaOqAp8yt9/GjSW4V6FFOkCfgXsvX1IU679pRv4=;
        b=IGeVNPsKN/y1M+Py130T7tbaWeTDY5S/tn4OsHn4Sw5qR+TTEJ3A+v7eW3VTeXpve1
         BYaHauarJc8OuTon/g7oYzLabb0jj0gjkIQJSfTFmINmBigtQB0MPJ3IMAyIIBUMDMbo
         IwAnAQlfiLHA4RgWE//gvWG2V/zavVJUBZtSVkEc4bnRXctFO086Mo7vFcObqhTZhzaE
         v1pFWcbokmbNxz+qfhyt+uqDZkLmuf0hmAskfsxNshq14Uc7pZxX4MS4IFnpapG+uu6b
         q1/Pjd+bLu8LppBCuPwJj0aEE7Lqw3R+w2XUfAoZB7wYGItG8kLjFXHrQ29AXwgLYtXz
         fhqg==
X-Gm-Message-State: AOJu0YzP9EQzTqp/RneUZqgMaVRKev3eUvCWGQlb/c9ipHDqLHbrQKKV
	Q2E8zXx2OaFisHeT1rWQGbcuX+KDG/w=
X-Google-Smtp-Source: AGHT+IGNHgP08B+N7FR1pqY2r/HHg70TsdiH3Eyz0bqwR7Y/VljRYZxr/t3UMD17gcBiho5SRir0uQ==
X-Received: by 2002:a4a:ac49:0:b0:595:d85:260a with SMTP id q9-20020a4aac49000000b005950d85260amr3853472oon.2.1704822570920;
        Tue, 09 Jan 2024 09:49:30 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id o184-20020a4a44c1000000b00595e66557e6sm476814ooa.6.2024.01.09.09.49.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:49:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/4] Bluetooth: Remove superfluous call to hci_conn_check_pending()
Date: Tue,  9 Jan 2024 12:49:25 -0500
Message-ID: <20240109174928.488595-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonas Dreßler <verdre@v0yd.nl>

The "pending connections" feature was originally introduced with commit
4c67bc74f016 ("[Bluetooth] Support concurrent connect requests") and
6bd57416127e ("[Bluetooth] Handling pending connect attempts after
inquiry") to handle controllers supporting only a single connection request
at a time. Later things were extended to also cancel ongoing inquiries on
connect() with commit 89e65975fea5 ("Bluetooth: Cancel Inquiry before
Create Connection").

With commit a9de9248064b ("[Bluetooth] Switch from OGF+OCF to using only
opcodes"), hci_conn_check_pending() was introduced as a helper to
consolidate a few places where we check for pending connections (indicated
by the BT_CONNECT2 flag) and then try to connect.

This refactoring commit also snuck in two more calls to
hci_conn_check_pending():

- One is in the failure callback of hci_cs_inquiry(), this one probably
makes sense: If we send an "HCI Inquiry" command and then immediately
after a "Create Connection" command, the "Create Connection" command might
fail before the "HCI Inquiry" command, and then we want to retry the
"Create Connection" on failure of the "HCI Inquiry".

- The other added call to hci_conn_check_pending() is in the event handler
for the "Remote Name" event, this seems unrelated and is possibly a
copy-paste error, so remove that one.

Fixes: a9de9248064b ("[Bluetooth] Switch from OGF+OCF to using only opcodes")
Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 22b22c264c2a..23e0e63ac312 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3556,8 +3556,6 @@ static void hci_remote_name_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
-	hci_conn_check_pending(hdev);
-
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-- 
2.43.0

