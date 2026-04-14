Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE292405E1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776178013; cv=none; b=FeluzaQxXenDvv0YmuBdVefRKd8KcDhEAD6sNGzvXfCvtuuR2WYa5xIOKitbRpQ+Q0RN2NnTqlH29N5VsYbvkWVQ+q1gPMMnSH7fObWbJm9UoQXo2T+qEgARSlm09aMDiL4btgjyyo9So4cxLXn/3oGtR6Q8WDf/kcuysaIvXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776178013; c=relaxed/simple;
	bh=fIfL6XnOupvTmUm2OYD9GPN7/vgurIDfEHnHvS1/yeA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K3RA+gKsjlSfhf9UzQ4oeRg61/TUHwlGCADPJpmM8OPaO2WQKtaBKYO4uC6adLqyA079+VXjeTx1s7xjhrHXAcolHgwaVBJvwRcHeIgpXuhVwU4OB2wk99xHN3HWSMI4he3X96gjko3YX0i3ikDs6NyGN0x3krSIz68c9hP6BAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnCTiTA4; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnCTiTA4"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso3384971241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776178011; x=1776782811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+0BG5tpb0RU7f/XOooqSEUIWzyM1YnqUsyp/yahLa8=;
        b=KnCTiTA4Znq4cEQH+lz9Dw6KWrVVKir6bv7Endw+PRDM3Vb3j7+oZjFnch8G0Nkbdw
         pjZAIK0GWbXbo9pJDTjNB2uf4dJchhQBT8E2bqeNPBJhqGiF42Q53a4g6ESmN/stBpYq
         LLHvKdg03M9mu5LfOeF12m2U6HEi1Pr+pdXsDqwXJVR/5D3XcMvWro1/YnTlPq/2ZZEb
         AFgeOgCrLyQTBlBuWY0s9upQ92Q/nVvhG04bvUvN6cBA8AkoERzLfD/qkYEXe3MCIL6M
         XF4lQNaYOvc7Pe7GEA8wW+nNMvxUKIYIQR6BYcrLhRHwZNTspN44UFGn/2flwYMNwOTC
         7rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776178011; x=1776782811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+0BG5tpb0RU7f/XOooqSEUIWzyM1YnqUsyp/yahLa8=;
        b=sPe+meDZC8tF5br5AVs8CI0dzVt2Eg5jHo90SYRMIOCsdWHrVD1OATgJTB/14cn0jQ
         2wiNe3KvfxDD00+cYqXVaI7iolyb8okXxA5iDr1YFrV0a43roG7dWBttukLuY+oU8RCl
         ub21mfCGhzcnx8aLsu0mZ6mk3oYMjDv2NNmf7A3wUGInqNxPBXdCAc8cpyQ/NChQtUYI
         tp25HxDMqEFFEkA7EFIJu0YZ9KGlrPzZljA84GpWdAvk3tT/gTzdMP+ks/beI58TRp0d
         DXJ1EBBuWWBrGGWzltKRtlIPEffSkZKGYfKCGHY5n/sWB/U5D6ht+c04Gv0l3aRnjQ3e
         KqPg==
X-Gm-Message-State: AOJu0Yw44UoJQLwjfRns7Eb6oFLfCkjULGyzbLzMbwp34x51svrX4KpS
	ULmuJzVTkkyFAoc8eEU4VB33Iz3MW4prUn0uXtHZYy+FM4LZswpgUlxhQUoYxG8C
X-Gm-Gg: AeBDieu8VYL8qKRvhtp6RyYpv21hme0XFfMHEEJiDsEkVjDGPFgKYs6OXFd11R6VUa7
	6+zYL/c4eb2VuxSR32GavxTvC1NJlMkk/5GEzSThhV/hVyWvjJBR8svcRWzNQN2nE0zkthV+osa
	wVXBL893U/n7qkiUzXegXsNeiWlfeYW6nzkyZ0aN9KH1mMG66wqz0bZR3E9OE6p3IQOllFy+Kmq
	eLvz+uOylEcXDAgsM3/mEjmFwsYbBwVN8IrADgrL7R8SSJvfG/kYCxDagkB6f163WrbYZy8/wYq
	fMehI1t3fo7Vouxqxq1za/NFJnUqyQtkBl67LuBAWiBIjAhlj3BJ4GpRS8A+IlVt9fCgV1Pzjrf
	XNzdvnqsTKRc2NJBAYemI0hDPluGbrQ3SVfdAzQ9yqqCHfxVAc781X8RcnqQNtAe/4v8RpRpvRF
	NdsN/spfCRCRh+tgu7Nx3OWE6zKhJi8xA5YvWe9kCJNc8gXDvdnacvBrTfrN9Lrb+5DTHczFY6y
	njjoyeda/qZg+ivLw==
X-Received: by 2002:a05:6102:f87:b0:605:8280:5e6b with SMTP id ada2fe7eead31-60a00634989mr8412314137.16.1776178010672;
        Tue, 14 Apr 2026 07:46:50 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60fe90d266esm3111329137.4.2026.04.14.07.46.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 07:46:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5] Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt
Date: Tue, 14 Apr 2026 10:46:41 -0400
Message-ID: <20260414144641.1168084-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_le_create_big_complete_evt() iterates over BT_BOUND connections for
a BIG handle using a while loop, accessing ev->bis_handle[i++] on each
iteration.  However, there is no check that i stays within ev->num_bis
before the array access.

When a controller sends a LE_Create_BIG_Complete event with fewer
bis_handle entries than there are BT_BOUND connections for that BIG,
or with num_bis=0, the loop reads beyond the valid bis_handle[] flex
array into adjacent heap memory.  Since the out-of-bounds values
typically exceed HCI_CONN_HANDLE_MAX (0x0EFF), hci_conn_set_handle()
rejects them and the connection remains in BT_BOUND state.  The same
connection is then found again by hci_conn_hash_lookup_big_state(),
creating an infinite loop with hci_dev_lock held.

Fix this by terminating the BIG if in case not all BIS could be setup
properly.

Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Cc: stable@vger.kernel.org
Signed-off-by: ZhiTao Ou <hkbinbinbin@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b2ee6b6a0f56..1b3b9131affa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7118,9 +7118,29 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 			continue;
 		}
 
-		if (hci_conn_set_handle(conn,
-					__le16_to_cpu(ev->bis_handle[i++])))
+		if (ev->num_bis <= i) {
+			bt_dev_err(hdev,
+				   "Not enough BIS handles for BIG 0x%2.2x",
+				   ev->handle);
+			ev->status = HCI_ERROR_UNSPECIFIED;
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
 			continue;
+		}
+
+		if (hci_conn_set_handle(conn,
+					__le16_to_cpu(ev->bis_handle[i++]))) {
+			bt_dev_err(hdev,
+				   "Failed to set BIS handle for BIG 0x%2.2x",
+				   ev->handle);
+			/* Force error so BIG gets terminated as not all BIS
+			 * could be connected.
+			 */
+			ev->status = HCI_ERROR_UNSPECIFIED;
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
+			continue;
+		}
 
 		conn->state = BT_CONNECTED;
 		set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
@@ -7129,7 +7149,10 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		hci_iso_setup_path(conn);
 	}
 
-	if (!ev->status && !i)
+	/* If there is an unexpected error or if no BISes have been connected
+	 * for the BIG, terminate it.
+	 */
+	if (ev->status == HCI_ERROR_UNSPECIFIED || (!ev->status && !i))
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation
-- 
2.53.0

