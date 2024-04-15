Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A682487
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203023; cv=none; b=RQU8rOr69sWXKummO+jA+2btg6yXYvzHmZtGee4b56znVDRk3M2uP8cYlcjQG/G3c29qAVTTkywAxz4WdHsaOXUcvTqF6MwPVrjvNncZi/R0DC6/QHKjPtAr47dHdNLsOFsRfQwRf3Q4d9bYYu9tzOgP4VpHhYSKA56A384/1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203023; c=relaxed/simple;
	bh=Af43eejuMN+h5b6F4cOLFa8RKu4JM1r1iCBSA48/qnM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=peke4RUTjWhCwugSyjJNmn3hJcpgRAsK+VT8aOmdw8bqzjsLMikaBU7+nBq7Z/ozse3NKzCXlcaCbMlaAxHuIGS57DlywWaDWk+xIoCP2bpsh+NL7yduihHRAO5tCnDiLgOrDZKjBFvlIaZXdyl17mZ0bbGKEKWFruzJmdQiZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNtlcTjB; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNtlcTjB"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-479d6a85be8so1241881137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 10:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713203020; x=1713807820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kTZAwtH3rPNVRMJtzibWPmJUeAL5wStpC0zPV1QHG8=;
        b=ZNtlcTjB5YgiwSgu8QEa/dNBMWqoBs5gmIfrrbrfLS+g4lrQ8+qVl3uRMDFVtH8kpX
         LRwOe9nak0c6nhN9lVzHJrTEVYJu4Ki+uRvjN2lp7aog6niRIXJjGRX/6OIdY9/bCfTr
         BHxbUl8ZTpohTGBYdTISs9wT24d9JgE25IkPOoBRR6HoCC4xUcCYBNPnz2xQLd2zb414
         3kbrJGVHa9al0cYeIbqhh9UeQ4JdNdAW6FZL8CMZrFuGkt/HE9c7cxoxWN6JSQe7xbv3
         i1GaRcPZuYS5lgLbHWXKkurlLQrm0LvVd4oNvwgGSSOANbNqwCJlp0tPP6IDHKtNVMMZ
         ObVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713203020; x=1713807820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kTZAwtH3rPNVRMJtzibWPmJUeAL5wStpC0zPV1QHG8=;
        b=Qfy7XfmRKVSwHS1oJ/ccHfVLKN6BY7l1cyaOYi1rHxSXREt9+WzvcJHSB1Bv6WCQsV
         2KHVC/7BXl+vnDFs+6HRyeNGf6MFJD5wDzWRn3f1tB4G2pdLe80Ox1Sukkt0c4HEGbdN
         HJjJg3T4DExpbWpuxucBuf5VTpOGYDvew3zYtR+2fVK3bLSIxkiSOar2uQrt5DNCdNSD
         qFPx4pQF9LAT50LLNvVhQE4pJOTWD/XVvNF8gRtB/9faxJVy845JUYKhby08UbH3W3EI
         fbL8hFHsE9o5k+Ge/NaUXf+dRjq4C+4cbveyBBSAn3wZEIVl7rIUPFP4Vkqb//HtrIAW
         LW3Q==
X-Gm-Message-State: AOJu0Ywu6rNoYmFVbriah8/mPwU85qX3u7Bwt6obo7+uioptqy5lfHek
	JQoJIZPs3FFI2+ecI0MvQwQ3h1GBviZFFPquPOpQ50X7uep0JL9mWWL0Mg==
X-Google-Smtp-Source: AGHT+IEixX7iFLGxB/5iyumVlwzgpAT03JG1sZ4OD05Go5cvrFv9KfDrez/R496QelF1dl27crW9jg==
X-Received: by 2002:a05:6102:3714:b0:47a:3f72:d81 with SMTP id s20-20020a056102371400b0047a3f720d81mr11871702vst.6.1713203020106;
        Mon, 15 Apr 2024 10:43:40 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id s20-20020ab07654000000b007ead959a4ccsm386208uaq.27.2024.04.15.10.43.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:43:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix sending HCI_OP_READ_ENC_KEY_SIZE
Date: Mon, 15 Apr 2024 13:43:38 -0400
Message-ID: <20240415174338.896084-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code shall always check if HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE has
been set before attempting to use HCI_OP_READ_ENC_KEY_SIZE.

Fixes: c569242cd492 ("Bluetooth: hci_event: set the conn encrypted before conn establishes")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 4 ++++
 net/bluetooth/hci_event.c        | 5 ++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f0e1f1ae39c5..94bae125ac11 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1918,6 +1918,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
 				   (hdev->commands[39] & 0x04))
 
+#define read_key_size_capable(dev) \
+	((dev)->commands[20] & 0x10 && \
+	 !test_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks))
+
 /* Use enhanced synchronous connection if command is supported and its quirk
  * has not been set.
  */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 539bbbe26176..9a38e155537e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3217,7 +3217,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 			if (key) {
 				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
 
-				if (!(hdev->commands[20] & 0x10)) {
+				if (!read_key_size_capable(hdev)) {
 					conn->enc_key_size = HCI_LINK_KEY_SIZE;
 				} else {
 					cp.handle = cpu_to_le16(conn->handle);
@@ -3665,8 +3665,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 		 * controller really supports it. If it doesn't, assume
 		 * the default size (16).
 		 */
-		if (!(hdev->commands[20] & 0x10) ||
-		    test_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks)) {
+		if (!read_key_size_capable(hdev)) {
 			conn->enc_key_size = HCI_LINK_KEY_SIZE;
 			goto notify;
 		}
-- 
2.44.0

