Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1300F36EA89
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831079; cv=none; b=f2xgAN0Sb7XncUafT+jQlQ3Y00M+CL28eV54rdygFTZuSIehfHpJnYU9uCddCoioYKt3cxt3nz+hiI6AUuxBc+XAPDe8e7p9qK06w79TmpBNV9RJ8zxcawENqyMquivvxDN9s+oQjmYc9gi5OdpXNh606mGIHw+umc3MTWMTJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831079; c=relaxed/simple;
	bh=3HE/jIKE++CXLWfmVw2UrgCXNUzEor6/7cnN3bkytz0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kji/GT9TIz3Jy9Z//oh9dMVm82z85uPMvqJ+hGrOpTkFrM6FxMeUd4LC0pTII8zrE6f8qKDhRXEwLUi/Nlmjs9ETU0S0+Ls0U1nMsMy4Ak0HYdV0Vb+wrOieOjg1sl7YKWyNw1dLWH2Z7SX1nPYBmrs5sHwcvuDIIxfocoHE3lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb2fk4TE; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb2fk4TE"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5ff05af29b4so3488699137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 13:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772831077; x=1773435877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JOemYbVf3FBqsjG9R8gqzwm6dUKS4ihgfOKOG4bTOQ=;
        b=Gb2fk4TEDuSt2Rs24t3m0sbZFuODVoSbn3o3H+aod8Uzf6r3WaQUwJwe38KELFwA4Z
         zLr2VHRvbCAy19E5bBKNC8A6zxk4COa8iuoWffw4+0WhPtaO/GQQburJSFRRUAn/AyWR
         t4qxZp0RxrRe9uIcQQASUSiRJDAN9neuHHNyUpsNBYhgFYY+7iWoNTz5iio6eiLNFlVT
         NcLAhDfZykoN4sVIf59nVgGNWJmddWCf/ERpbXZzY0FBb84kAUTLduJBOuwUCQViuSDT
         kqWerc66dHb4qaIiADUPemFoow9Wf1PC8MrDKF11GubDlYBR8/mNDux5yv3Dn+bRhW6A
         DGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831077; x=1773435877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JOemYbVf3FBqsjG9R8gqzwm6dUKS4ihgfOKOG4bTOQ=;
        b=BqfxNdFqZNPG25gcOpfAL2yQSZdi+PNsKn9R7Hypz9NHg1UBUkHG6wZrkndwhUIP+Y
         OESVas4zyPLvznX0k+jpbavwzJ2Lc6Gu0fXl+B0LJxABjxsoeaC9F6UCj5MPya37o4uS
         8ZDQf/dwY0Vc5jOs7BVyzxRBNip0V+NzyNby5RXGHLE2TCOjXKAENGehjCoeY7ZC1g/Z
         snHcpsOpms5v549/uqfIMdg8swFXbH05BD38RgjrjKrlPL64pL4X0octzc6ZXbUIVaot
         AZ5Ba+ECICeHbsJbpWDCc/CS07rSsY5NyBYvoSlT4y52qttFVBHBbY5c+pLL+CycECkm
         qYIA==
X-Gm-Message-State: AOJu0Ywge5e1hXFo4v1WCQJjm8D4R7ePw9MzYzDcVk+FpSw11E36ZPRV
	B6/2jH+SfK1V4uthNVGmU+AZmHfcZGLojmtu/7HHISQ53ctuzVwe9z7LrNE9FA==
X-Gm-Gg: ATEYQzyyPPURnx3UNMfP/BXbRz0SfG962NAt2MXxgG8R14d+ETXvfYKoQGOXV+TSOv1
	LRlYFgyEspKItpAJwmEXOyaeEcyWJpKjvtvFmPnNmpN5Isn2AeHGpUmAB8AocVAx8rciO2Wx5IX
	JwvW75+S5/iOKSPSMEvaaGV9Ee/1D3PRbGIiCx5xEmXtSLPkCiNkVlnUDytEDPKc/uvO4p5PxB8
	YNewQ0BVXjztQ1OQTf90rd2wBqCOqnMDJWnDurCTI2g5J3hNgJcszJ1MH1l+/a+RyaTf+TUmbp9
	JsZX/g3qS3Pr405ZddPl+GcLu+a2xdEmBU+vndnl4gO9BKfqjrc68P/da3wrQTu12Q9wYn6kmGc
	eUcb400aHjtXYU+z+UobxKzEKxgVVPpLsxUBoOBzOTopABWp36VA49NMgbuYIX7fMnvHIkKBaBL
	dYUl9jQ6SGwq6N2JJQgcKR4Yzhc5dAgCuAvu4rkIj3DSJiI9pyuUxlahnhqO9/GviOQ5YC+f653
	riDbnFXfQa8sv3vzw==
X-Received: by 2002:a05:6102:442a:b0:5ff:c510:b7d1 with SMTP id ada2fe7eead31-5ffe5ee6e07mr1112392137.7.1772831076562;
        Fri, 06 Mar 2026 13:04:36 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffe898041fsm2873894137.7.2026.03.06.13.04.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:04:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RESEND] Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user
Date: Fri,  6 Mar 2026 16:04:27 -0500
Message-ID: <20260306210427.703454-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 14131e427efd..6606d7f12534 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1678,17 +1678,15 @@ static void l2cap_info_timeout(struct work_struct *work)
 
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
@@ -1709,16 +1707,14 @@ int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user)
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
@@ -1727,7 +1723,7 @@ void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *user)
 	user->remove(conn, user);
 
 out_unlock:
-	hci_dev_unlock(hdev);
+	mutex_unlock(&conn->lock);
 }
 EXPORT_SYMBOL(l2cap_unregister_user);
 
-- 
2.53.0

