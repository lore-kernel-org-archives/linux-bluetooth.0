Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272033C50D
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453235; cv=none; b=IN4tKaqwymwxIB5xhoVuYNvkdHmMYvc4bbQCxClpo+/vjkLOQNHDxsa/hiWJhbsaMP35Mj5/nt8rfcwCW2yJB24P3xOBH4PHOdk6fBPS93VI0Gi/8arrf0Y3frI/WyF7skn2KvdVyeAH0M7+qnGndHo0z1WXV9si38zC8hAQ00U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453235; c=relaxed/simple;
	bh=375jKvwYcq0QUXukIrQ1f+N3NOj9DqIX4Aj/+YlX5mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANAbStjpUtz+DR2FCXEhSXWDSFBZPP8DO610gY48Mg6Rc658Z0sGCbCsyKoQbgQPfmFZs9JcC6PteQ7JN84+BDeJAgtbCooTywlp+tsk0fofdfFngIp7ByxKFLeFyGjW081XsNWfdPDd6wnZUFbJtKohc7T8WCtzERtkCOLZabI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=e0plIv+y; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="e0plIv+y"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7833765433cso1555814b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 10:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1762453231; x=1763058031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ASB8FKtZK1f63TZGwMkE6Mcut8cdvc7Tlq+5U4LNTk=;
        b=e0plIv+ywDol0GQRnZeP6WMULY+1FxqOwFU8hTwb4f5U0YIR0qzYdG6sDWUhRmXwpl
         fl6wW2Fm+dLS5dU7YiokNPy87x59rCJzUjZ+3ErRkJV4vTPvQUJFCeX+45tegHPH6OJ2
         X+hArojOp06aBdWJhNI/QDbOLj9dnKU3M2el4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762453231; x=1763058031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ASB8FKtZK1f63TZGwMkE6Mcut8cdvc7Tlq+5U4LNTk=;
        b=GxU9uCYYlsWvkZ8PAuskqFQT6N6Dl5+NY3e4+2xaoFy35/B8suguqzyRwJ9hGbrHFZ
         QPe4OICO28vbavT9bKEokkIdTWpA/bmSW1B0rvA1CVQ6EK2LZnX5Sx85fbO3ecdFU/as
         X02gVwyS33cQ7hX4OK1WoxBA8aTgkosT1hHXfAnF/uOaHY2hUaEy3gJgvI6o2AEOxPli
         snPavRURFNxuE6rGWDC6GIX2YodVS+8RB/ukQzvcvl9pmMcKYvcbBZTxlb6OTGkgXxnT
         iiZ8ymbFyjB1vlMmDfl0wjVmWaPpyfOtvbFJrVrKEYovvEEHXj8LwSQGNFZrOZOUdONN
         cx6A==
X-Gm-Message-State: AOJu0YzHNfPgd/GHNYAmBbOBbQytQkWABhJhMqtd2xBvTkIJGJ6vK08b
	40dNO/GsrUUqsUTOleHDCpk1i5hfScXoXU7638IGmWPkxipqfFHCj4/okSC9tzhmszim/Vmo0Kf
	q3KK8
X-Gm-Gg: ASbGncv72PRRUCdIkzoclMRwUynhK3+58BItZIQWcpwN3a9anwXK8KPrDbYCksn+0vt
	8Cx5aU265rg88+o46JErTaBc6OBXUjTTgySL8WKXypX/WHVEjwm1PfMG/otjNiRVO7vm3L73iLh
	4sUBpjqnCLh5YhTROoqpBO+0P3gLnCvHq07I1tZr4ZUaoHDxJb+R+vrNKmLyITi1O8O4HjK0t38
	3JFAAQWzPV0NXuEUdOXzQqCqJuttlFoAlcGYXXOcM629SkOaUk+L1W8ptpVGwS0mpjRwAyeu0XO
	Lbo2T/0S8TVGRXvIpIfjdKeteiPL0Z1b2WN/IOuvs7FukpqVTtvJvOgmE8lSsu/HDJqhqaTQFrK
	WKHBXJMpfLlc7AZ0JUiBUUUsPuvX4PnWrPrugpJFgj16vZPjvudi5lXyhogGnzrCtFapTrOBG7P
	XNTGzwSoZglT6/VgVsOAm44mZOl+RLLEpqrgkoUP8khSikLjSXLhDBKMM6iQ==
X-Google-Smtp-Source: AGHT+IGjsvWizViuKvqU/9ixMSrMVwXUSyqJ0gQDi1Sv/r9iYmMJdX5r5ZgGWH4p4H/sroNO9dU7pw==
X-Received: by 2002:a17:902:e88b:b0:290:9a74:a8ad with SMTP id d9443c01a7336-297c047f196mr4517675ad.53.1762453230814;
        Thu, 06 Nov 2025 10:20:30 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([110.226.176.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec88sm35062555ad.107.2025.11.06.10.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:20:30 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	pav@iki.fi,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH v2 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
Date: Thu,  6 Nov 2025 23:50:16 +0530
Message-Id: <20251106182016.26508-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105142251.101852-1-ssranevjti@gmail.com>
References: <20251105142251.101852-1-ssranevjti@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

After commit ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in
hci_chan_del"), l2cap_conn_del() uses conn->lock to protect access to
conn->users and conn->hchan. However, l2cap_register_user() and
l2cap_unregister_user() still use hci_dev_lock(), creating a race
condition where these functions can access conn->users and conn->hchan
concurrently with l2cap_conn_del().

This can lead to use-after-free and list corruption bugs, as reported
by syzbot.

Fix this by changing l2cap_register_user() and l2cap_unregister_user()
to use conn->lock instead of hci_dev_lock(), ensuring consistent locking
for the l2cap_conn structure.

Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")

Changes in v2:
 - Replaced hci_dev_lock()/unlock() with mutex_lock()/unlock(&conn->lock)
   in both l2cap_register_user() and l2cap_unregister_user().
 - Updated comments to match current locking rules.
 - Removed unnecessary hci_dev_hold()/hci_dev_put() usage.

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/bluetooth/l2cap_core.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d08320380ad6..29e78801c507 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1685,17 +1685,15 @@ static void l2cap_info_timeout(struct work_struct *work)
 
 int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
 	int ret;
 
 	/* We need to check whether l2cap_conn is registered. If it is not, we
-	 * must not register the l2cap_user. l2cap_conn_del() is unregisters
-	 * l2cap_conn objects, but doesn't provide its own locking. Instead, it
-	 * relies on the parent hci_conn object to be locked. This itself relies
-	 * on the hci_dev object to be locked. So we must lock the hci device
-	 * here, too. */
+	 * must not register the l2cap_user. l2cap_conn_del() unregisters
+	 * l2cap_conn objects under conn->lock, and we use the same lock here
+	 * to protect access to conn->users and conn->hchan.
+	 */
 
-	hci_dev_lock(hdev);
+	mutex_lock(&conn->lock);
 
 	if (!list_empty(&user->list)) {
 		ret = -EINVAL;
@@ -1716,16 +1714,14 @@ int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user)
 	ret = 0;
 
 out_unlock:
-	hci_dev_unlock(hdev);
+	mutex_unlock(&conn->lock);
 	return ret;
 }
 EXPORT_SYMBOL(l2cap_register_user);
 
 void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
-
-	hci_dev_lock(hdev);
+	mutex_lock(&conn->lock);
 
 	if (list_empty(&user->list))
 		goto out_unlock;
@@ -1734,7 +1730,7 @@ void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user)
 	user->remove(conn, user);
 
 out_unlock:
-	hci_dev_unlock(hdev);
+	mutex_unlock(&conn->lock);
 }
 EXPORT_SYMBOL(l2cap_unregister_user);
 
-- 
2.34.1

