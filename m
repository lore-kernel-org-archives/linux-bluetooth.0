Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324823BB3E
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMCWilw1"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5988e55ede0so160519eaf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jan 2024 09:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822573; x=1705427373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CALQPjgbYuWBGZQs8nNVBq5T/HxB3E5FfujH1TM+1jA=;
        b=BMCWilw1UgOdrfSBRpzrxWYOPLpkmmqq/0U4a3bMl6NQ1/sGtvXpzwnpKuO9NLCdG+
         UO5C8kHntmWyc02Fa9uhD25EGxi912ZPftdoSCzcPn+uPC1fxtCbP30o1/THk6MGLgSf
         LOn/Hn3sYcs7fqcUdIbYZoTy00vu/k2Km3aPAgsLR8j6Glc0EkGzRkIxXnf8mSs1sCz6
         YN3SrzkvH6xgaIwoKmovbtT+VMfqMt745JVnxKJ2UjhtjaXYZt1INT3M7SPmiq3ygXM+
         HJbKEf7CFwXgPUunYiZs3bjaShAP9vBOic2kYCipnCHHNTC4OPWTsatZhwzm+qF+JadO
         CT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822573; x=1705427373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CALQPjgbYuWBGZQs8nNVBq5T/HxB3E5FfujH1TM+1jA=;
        b=uHdASh1Lh0vlWWl2TGvaP4bacAG/ceE/jra/u8lTsfuxR8ZjkSMhfkdoSXQuD+1KJJ
         xsivOlEU3a+6NhC1o6Cxp/cQfe5UifpDoOZ7ZWJkFr3JyQxHmfSgx0vNvBamDoiljitj
         0a5JgbONQQY4BJP/V8vz2eMhbvpp2zfq9tTtMpAi8GvGdTkFo5Ua483vmfvE2QMOmLvJ
         iCsXtGJTYXk1fNLZS4xR0cPgZj9j7leH9YkvRwfHO6ZMnPQgm/NQB+JvA0GZS16SdAdM
         d7nzYbxQYhyy6Css55DEmidcjT9iVBGqzkKeVyCDdnNlOVJmbQ9wpKd7yDeyEqRzCUPt
         h1xA==
X-Gm-Message-State: AOJu0Yy8v6pXp73r64onrmDuc47lO4UpPeVG9F73Co2agsTV9W0muee2
	6jJo6jw8ZYcF9kkVd3oNyhuSaerMugo=
X-Google-Smtp-Source: AGHT+IEumfhwxdHQ1WAOIlMiOk1visc+fTqyry55qvdXqarAFzqW8zszLoYs+OcswYB/OchMGmH4Vw==
X-Received: by 2002:a05:6820:240c:b0:593:fb56:1206 with SMTP id cp12-20020a056820240c00b00593fb561206mr4171858oob.17.1704822573507;
        Tue, 09 Jan 2024 09:49:33 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id o184-20020a4a44c1000000b00595e66557e6sm476814ooa.6.2024.01.09.09.49.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:49:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/4] Bluetooth: hci_event: Use HCI error defines instead of magic values
Date: Tue,  9 Jan 2024 12:49:26 -0500
Message-ID: <20240109174928.488595-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109174928.488595-1-luiz.dentz@gmail.com>
References: <20240109174928.488595-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonas Dreßler <verdre@v0yd.nl>

We have error defines already, so let's use them.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_event.c   | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a94a8491ec7a..1cd212bb3789 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -653,6 +653,7 @@ enum {
 #define HCI_ERROR_PIN_OR_KEY_MISSING	0x06
 #define HCI_ERROR_MEMORY_EXCEEDED	0x07
 #define HCI_ERROR_CONNECTION_TIMEOUT	0x08
+#define HCI_ERROR_COMMAND_DISALLOWED	0x0c
 #define HCI_ERROR_REJ_LIMITED_RESOURCES	0x0d
 #define HCI_ERROR_REJ_BAD_ADDR		0x0f
 #define HCI_ERROR_INVALID_PARAMETERS	0x12
@@ -661,6 +662,7 @@ enum {
 #define HCI_ERROR_REMOTE_POWER_OFF	0x15
 #define HCI_ERROR_LOCAL_HOST_TERM	0x16
 #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
+#define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE	0x1e
 #define HCI_ERROR_INVALID_LL_PARAMS	0x1e
 #define HCI_ERROR_UNSPECIFIED		0x1f
 #define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 23e0e63ac312..6130c969f361 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -95,11 +95,11 @@ static u8 hci_cc_inquiry_cancel(struct hci_dev *hdev, void *data,
 	/* It is possible that we receive Inquiry Complete event right
 	 * before we receive Inquiry Cancel Command Complete event, in
 	 * which case the latter event should have status of Command
-	 * Disallowed (0x0c). This should not be treated as error, since
+	 * Disallowed. This should not be treated as error, since
 	 * we actually achieve what Inquiry Cancel wants to achieve,
 	 * which is to end the last Inquiry session.
 	 */
-	if (rp->status == 0x0c && !test_bit(HCI_INQUIRY, &hdev->flags)) {
+	if (rp->status == HCI_ERROR_COMMAND_DISALLOWED && !test_bit(HCI_INQUIRY, &hdev->flags)) {
 		bt_dev_warn(hdev, "Ignoring error of Inquiry Cancel command");
 		rp->status = 0x00;
 	}
@@ -2342,7 +2342,7 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
-			if (status != 0x0c || conn->attempt > 2) {
+			if (status != HCI_ERROR_COMMAND_DISALLOWED || conn->attempt > 2) {
 				conn->state = BT_CLOSED;
 				hci_connect_cfm(conn, status);
 				hci_conn_del(conn);
@@ -6679,7 +6679,7 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev, void *data,
 			 * transition into connected state and mark it as
 			 * successful.
 			 */
-			if (!conn->out && ev->status == 0x1a &&
+			if (!conn->out && ev->status == HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE &&
 			    (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEATURES))
 				status = 0x00;
 			else
-- 
2.43.0

