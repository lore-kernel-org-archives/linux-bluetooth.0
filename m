Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529447;
	b=nmBj2td9Q9Os3t0bsMymUWUXnlR4ua1ntlmkxtf2vhjGcZKFGp1Fd4tYXchG8Ayv47Ic
	 wKAAjCIEKIufPp7kfytV6zdBkPSOCzEmSR7teZz81Q9IS5ZtRgy0KbH5tY+OmJ4gxMC63
	 4LRM+GKrplsU13gR1mpvhgptWOEld8/Sg/1AAzKDse8TLKimylrRNaxPPmlSlI6J1IueD
	 BxBwfgL1KlhMshYJgyCmTAbTefCYJRSrgKEIwF3gKzpjzKhoi2YeNtAAzeEF7HG9Mss7/
	 Bn5s/VRbxFc+lyXWjn1zIZ6sJheHuPttfZ6AEzVFVdQ8gGm8FPH38CYKfIkLh6v64TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XShi4tcBiiUeex/UpD4VJCvI1c9XNejU2j6InR/Tko4=;
	b=2MwIeKcxoPw/Xu0ibYnDrR2Cp8mH2cfA2EIKuwEquVjAWnTO/Oxch7ERD+Jkgojy7jpe
	 CpjZ/I0KwN+vQiQGQuoHJoHoTarWajFAfy4bgEk7PiIjYcHDTsfxbGcmUSwXgW93k1HEW
	 FL0ykZ25CXrnfBvg2Xjp7a2f2nbjIujMOv8jmd93V+Si99l1PJ29hNI7q8V2ioCAfglQc
	 tjhlfFuKEfX6pARi9KN0P/6xpB8PyxQJkKyD5JEc5ldwVzbMq1/cuAOp4W/xaiZguDiam
	 MMXCnJ8Q8UUtDMn4Z7UPrY+a+Fm3CL+vmfr/0xKLElhvZHbShVGCs/eUfCAaWPRIiVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rKjh+Un/";
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432E606A692
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6432E606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rKjh+Un/
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eafb65e169so2654973e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795529445; x=1796134245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XShi4tcBiiUeex/UpD4VJCvI1c9XNejU2j6InR/Tko4=;
        b=rKjh+Un/CNcE7k3fd7JY9nVSCz8T6Bo6KU6Qm6T3vrx+6SJfiPSjKWghWYp2uXDhUo
         3kr6Q9jdUclD6RZoVflL/78OQ5p1jdt1lxMxwRLzpuyUehFJ38Vfmg4aTo6IjGtqJShb
         nYfRrqAxGtqsHGzZiLYbBx63qIBfW6dJlGpXuxi5xpGTrKn46KU9r1rf+npSeCebGlr5
         eyFSLxC4lM/8SmJPPguML7m4LNMH/AIE3I/qoKc9OucuAdFS9hwo4jV0PaGgoh1Rc7Hv
         nAj8B+N1szk/xEk8tDyWqmAmkttvGHW2/US7cHCVmLUW5miZKppN6yLln3p+rVSNbHbu
         +8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529445; x=1796134245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XShi4tcBiiUeex/UpD4VJCvI1c9XNejU2j6InR/Tko4=;
        b=JRQ53nXMsZx6031R97P9CAVEWDfB1/LecxmuHCQxaUTJoB+ScF4rIODtWqmobO/clX
         sSVGkK63ZPx2eRTYlkQ1BgkomuzkYq4mqy2X4koXxlD1tlAhsQGw9i+rvPHjFhv1BwWb
         exlsksiqKk2tRMfmpMd0GDJH3EiaQ8aW/hISNCC+eQicR6Ook3svHc/73qrHHXZlKysx
         FwbVTUveBJ9AN5ES81GXLEcRmRKOHEDwLaxn2hUcVfr/pBajuJ09nJsSGX6bw+i7QKFl
         uJ1tTo8JZPyEqPBZ+DHzHIUsY3czae/gmtJgGPFykD5BywUeipNA/5yWy54QaDPgeGxm
         EaCw==
X-Gm-Message-State: APuU4Z9W14Dj8JVH5U+orsliM4IZNDIo1sHa+RQ/SC0dyl/E2mWpgLQ0
	fdjZzJqxhoXbQP4QjSRgThZd4pKvukXvbxmt5xLop7kOke/c/WrDOFoJ6qBguv4g6zk=
X-Gm-Gg: AZFdTZckBzjDoUafxs5cLggC6TLjh3ZXoQ3vSF7cfwmNwRTFIbPIo7oSuHB7SPqmDZO
	drpRLZhw+xWfXouTlFwa8QtorrYtLpVa6687q/H/3tnFeDydeFlReY6Mn3umTCVwpHcs6l1H4Ff
	ROw7f10qfGSjBKc5AgEbXteiCXHPm4pGuC1oukiXQqAv+B+g5V28sBjCu581Gag1p47HPMb4u+h
	t3OJoem+HnxXKUhkYzmqxPCUAzmMdFIGkZm9/jb47KFUzsb3ixgxGejE2eQrN1Lr36y+me5t35x
	7/2LBUhP60BxsA6zSfKP21rbbNo1EFViNcd8UN6KSWS/xuCcSA4VcUBkAex7HsQpoKck+yG5OLa
	NJAZX8q1b8Ms6Yty9BnG5ZvVg87tfIilx+6j0z0baw53yBoJQOifFBeVM219UjMZnZycD65V9/W
	MTTSG7+f2JemU2KD8Dkxi4jCUYUcSzcv5ydVd6a6ha7tm8bktrsdb0zg2Z1XuLuZqWXVjrbUvzq
	bn2va6ud7zRcVzDcqcB8Diuq7HFUiwUkNlfKlg/M2E8+b1mkl5SFGa5+ZOwj4OGm/rOLz4D6pXK
	0IQV+L+VnHMYB4uG3zGgyLhU/eXIWE+f
X-Received: by 2002:a05:6122:4698:b0:5ea:c98d:768 with SMTP id 71dfb90a1353d-5ee8ae8eb5cmr8365635e0c.6.1795529445171;
        Tue, 24 Nov 2026 06:10:45 -0800 (PST)
Received: from shine.local ([168.196.221.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b555137sm14056121e0c.3.2026.11.24.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:10:44 -0800 (PST)
From: "Andrei A. Bykov" <andreiab9019@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_core: preserve LE feature holds across encryption events
Date: Tue, 24 Nov 2026 11:09:56 -0300
Message-ID: <20261124140956.15296-3-andreiab9019@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124140956.15296-1-andreiab9019@gmail.com>
References: <20261124140956.15296-1-andreiab9019@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LE feature discovery now owns its connection hold until its asynchronous
completion callback. Encryption Change and Key Refresh Complete can run
while that discovery is pending in BT_CONFIG. Neither path owns a second
setup hold, so dropping one there consumes the upper-layer hold after
feature discovery finishes and disconnects an active ATT connection.

Keep the BT_CONFIG drop for BR/EDR, whose configuration path still owns
that hold. Route LE key refresh through the same confirmation helper.

On LE setup failure, explicitly request disconnection instead of relying
on a drop of the feature worker-owned hold. The abort request records
abort_reason before queuing its work. Do not let a later encryption or
feature-complete event announce such a connection as successful while
that abort is pending. Apply the check to both LE feature event formats.
The feature worker still releases its own hold and device reference.

Fixes: a106e50be74b ("Bluetooth: HCI: Add support for LL Extended Feature Set")
Signed-off-by: Andrei A. Bykov <andreiab9019@gmail.com>
---
 include/net/bluetooth/hci_core.h |  9 ++++++++-
 net/bluetooth/hci_event.c        | 10 +++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7cf63bc0f..469d4f077 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2272,11 +2272,18 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 	__u8 encrypt;
 
 	if (conn->state == BT_CONFIG) {
+		if (conn->type == LE_LINK && conn->abort_reason)
+			return;
+
 		if (!status)
 			conn->state = BT_CONNECTED;
 
 		hci_connect_cfm(conn, status);
-		hci_conn_drop(conn);
+		/* LE feature discovery releases its own hold asynchronously. */
+		if (conn->type != LE_LINK)
+			hci_conn_drop(conn);
+		else if (status)
+			hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 		return;
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 477b876fd..b224d4d69 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5435,11 +5435,7 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (conn->state == BT_CONFIG) {
-		if (!ev->status)
-			conn->state = BT_CONNECTED;
-
-		hci_connect_cfm(conn, ev->status);
-		hci_conn_drop(conn);
+		hci_encrypt_cfm(conn, ev->status);
 	} else {
 		hci_auth_cfm(conn, ev->status);
 
@@ -6961,7 +6957,7 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev, void *data,
 			}
 		}
 
-		if (conn->state == BT_CONFIG) {
+		if (conn->state == BT_CONFIG && !conn->abort_reason) {
 			__u8 status;
 
 			/* If the local controller supports peripheral-initiated
@@ -7639,7 +7635,7 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 		}
 	}
 
-	if (conn->state == BT_CONFIG) {
+	if (conn->state == BT_CONFIG && !conn->abort_reason) {
 		__u8 status;
 
 		/* If the local controller supports peripheral-initiated
-- 
2.56.1

