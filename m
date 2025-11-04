Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A352C11E9
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295283; cv=none; b=CoMzZbKr5Dw7CbScIvGShrKc2iOg64CANVY2vcdpyF6sUeGAOatefWU0H+j6rw/ojIbvTCJAg8JIedwfjtAkC+nZh5oSYr50VCc8F5cKAHtpgpwj48qdv19XvttGrQdJhgwG+2A+f9KkiRyX2/LsPPEEYoRMGj97LJLQcIWDLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295283; c=relaxed/simple;
	bh=s7USCwnJrrK6mlhok1ks2/kCBfERtEmutYzSsYkw+y0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HYhdirSTm63RklkMQwKGq7EVHtzC1hMu9OTjkjjY8Si7mPi5ulM1+uGpge/pTOTjos/sjPK0cSg2/vl6W1yl/Vce2Z8uc5Zj3TJzPnwWqFLcIH802MO7zRIi4IdX1L7itJcz/5ngolhI4DMdwnZ2IA6GVAT4j/wvx1ptR5eLYf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnvW/BTZ; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnvW/BTZ"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dbcc814b80so1799800137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Nov 2025 14:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295280; x=1762900080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pn3xzbHXUNYQkS7ILXK0JudVYBFsVEKhPwK7vvBNB3c=;
        b=TnvW/BTZ/5zqOmCZX0lMiwXl75swX1myNJ9P2TuWUeodlV/IKwbXojTlKCHsczCnAi
         pvX1RbXUlE31U78+PEJMfmUhDOEhyoVHz8jNYrNHtnLUqPCJP63SUoTyo78Aw8y+MB2D
         U90aE/MundtrFUMKVrD+A5UgRZThfJ7kB3HsGczmcC8ut3beCT7vcc26Bf8fm9mkD7t3
         ih6EeY175rjYpHThmzkQAVKT0i8ovzqFj3ERuUL9q3XrQKgF94Xk0xn6kEUHEEvsEhos
         6h3R5RKpRUznGLAS+woYzutDJcAfuqlHWyzzSAQXXCBtuoqRKgV+k4hwkgZNNnUm22v3
         MRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295280; x=1762900080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pn3xzbHXUNYQkS7ILXK0JudVYBFsVEKhPwK7vvBNB3c=;
        b=SRn8QV7mgIrIT6gaUxVB+rTqRsAMXX3SE4KgQB1A2/rs/zRnzEbgi+yReiy04EUO9g
         MiKl029lYgavCvHbQ0bkaAuFdNEWJiMEg75K1K9V3KEOVALQ+HIzvEXQpYJ9vAiaVXUe
         25X5uj7su/Sv0ZBGihMIqUopL4Jf1sYWoUPDOpDNB2IDtrVkLmfO1Iq87+7pQdu5MWJk
         SS4V+UDOUhAvcdjaOrpWWK7TE5dnU162XAT5L9APIrzSofQIv71SN/APYLRfjQbkMyYp
         KXE7GPkUzHi+/YAqbr9rud9kzTYP96Ty+Jc9JbM3l9qqARfX9AF+G6xEZ2aiE2XftTH6
         dNLQ==
X-Gm-Message-State: AOJu0YzOlN5HCcvKfLqy4hfEgw0J5waIRPcaeA0ley8uCcAkjReQ2A0G
	/QjzCaMg600WI0hXX2x/P8igYAIt6ejcJ6h5B33cpDu0wf+sOqApEgxQX/WqvFhdq3o=
X-Gm-Gg: ASbGncvB4R9ZXfRSmhbAHiXxUmW5Jq3uEKvBQ/6JVQ/jpkgr6/9YVpyMoWJoAJ+x/Vg
	jKuM79Qr/hYXFr0fyUdYbXE6K41o99OJzweX4HCJI7uGZz0+SyxSDrEbtOq26JCsSrgVX6PDX2K
	2JVOdFWUriumUJbJw2uRLjWOkSGk78iSLLGSiJsWsK+V/DMcW4ZTa04lSAS7zoNas6UC0ilphwb
	yOT+O+RqSZvM4/2DWaZkVdRo2fIjatbuR12YCsqqVzi8XZwUj6TkDbNkv1fo5unlENNM8LQm6hl
	BwezDN26gt4rR1mUXnIVTDRtUEf5APVVpvSjc7YDbP/PvYRSb3IJmudF0sNubt5eA2EvI4Woddt
	47P2KKp10M3Eus08JzCl3kJauPu57BT8s/OQ1CL6I3tKW5f47MqtI/gAsUrnUi1JRRLT8oIE8qJ
	zOIpxlSiPuG99C0w==
X-Google-Smtp-Source: AGHT+IEZdG2TmgxV2iwNJKKQwWRBvoOWbAst976TlN8LxdUu6fOvOaNiJtDx6rntdJr/t729Xkuogg==
X-Received: by 2002:a05:6102:6c9:b0:5d5:f6ae:38dc with SMTP id ada2fe7eead31-5dd8926a346mr398968137.39.1762295279812;
        Tue, 04 Nov 2025 14:27:59 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93542b31d18sm1477013241.11.2025.11.04.14.27.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:27:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_conn: Fix not cleaning up PA_LINK connections
Date: Tue,  4 Nov 2025 17:27:49 -0500
Message-ID: <20251104222749.198958-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Contrary to what was stated on d36349ea73d8 ("Bluetooth: hci_conn:
Fix running bis_cleanup for hci_conn->type PA_LINK") the PA_LINK does
in fact needs to run bis_cleanup in order to terminate the PA Sync,
since that is bond to the listening socket which is the entity that
controls the lifetime of PA Sync, so if it is closed/released the PA
Sync shall be terminated, terminating the PA Sync shall not result in
the BIG Sync being terminated since once the later is established it
doesn't depend on the former anymore.

If the use user wants to reconnect/rebind a number of BIS(s) it shall
keep the socket open until it no longer needs the PA Sync, which means
it retains full control of the lifetime of both PA and BIG Syncs.

Fixes: d36349ea73d8 ("Bluetooth: hci_conn: Fix running bis_cleanup for hci_conn->type PA_LINK")
Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 30 +++++++++++++++++-------------
 net/bluetooth/hci_event.c |  7 +------
 net/bluetooth/hci_sync.c  |  2 +-
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0b86aaddfb02..bd8c6b294eff 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -769,18 +769,19 @@ static void find_bis(struct hci_conn *conn, void *data)
 	d->count++;
 }
 
-static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *conn)
+static int hci_le_big_terminate(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	struct iso_list_data *d;
 	int ret;
 
-	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, conn->sync_handle);
+	bt_dev_dbg(hdev, "hcon %p big 0x%2.2x sync_handle 0x%4.4x", conn,
+		   conn->iso_qos.bcast.big, conn->sync_handle);
 
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
 
-	d->big = big;
+	d->big = conn->iso_qos.bcast.big;
 	d->sync_handle = conn->sync_handle;
 
 	if (test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->flags)) {
@@ -801,6 +802,9 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
 			d->big_sync_term = true;
 	}
 
+	if (!d->pa_sync_term && !d->big_sync_term)
+		return 0;
+
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
 				 terminate_big_destroy);
 	if (ret)
@@ -852,8 +856,7 @@ static void bis_cleanup(struct hci_conn *conn)
 
 		hci_le_terminate_big(hdev, conn);
 	} else {
-		hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,
-				     conn);
+		hci_le_big_terminate(hdev, conn);
 	}
 }
 
@@ -1006,19 +1009,20 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 		conn->mtu = hdev->le_mtu ? hdev->le_mtu : hdev->acl_mtu;
 		break;
 	case CIS_LINK:
-	case BIS_LINK:
-	case PA_LINK:
 		/* conn->src should reflect the local identity address */
 		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
 
-		/* set proper cleanup function */
-		if (!bacmp(dst, BDADDR_ANY))
-			conn->cleanup = bis_cleanup;
-		else if (conn->role == HCI_ROLE_MASTER)
+		if (conn->role == HCI_ROLE_MASTER)
 			conn->cleanup = cis_cleanup;
 
-		conn->mtu = hdev->iso_mtu ? hdev->iso_mtu :
-			    hdev->le_mtu ? hdev->le_mtu : hdev->acl_mtu;
+		conn->mtu = hdev->iso_mtu;
+		break;
+	case PA_LINK:
+	case BIS_LINK:
+		/* conn->src should reflect the local identity address */
+		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
+		conn->cleanup = bis_cleanup;
+		conn->mtu = hdev->iso_mtu;
 		break;
 	case SCO_LINK:
 		if (lmp_esco_capable(hdev))
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6edeebe46d94..51c23264ee2f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7056,14 +7056,9 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 				continue;
 		}
 
-		if (ev->status != 0x42) {
+		if (ev->status != 0x42)
 			/* Mark PA sync as established */
 			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
-			/* Reset cleanup callback of PA Sync so it doesn't
-			 * terminate the sync when deleting the connection.
-			 */
-			conn->cleanup = NULL;
-		}
 
 		bis->sync_handle = conn->sync_handle;
 		bis->iso_qos.bcast.big = ev->handle;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1cbdd2ce03f2..a36d2414a3ca 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7006,7 +7006,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 	hci_dev_lock(hdev);
 
-	if (!hci_conn_valid(hdev, conn))
+	if (hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
 
 	if (!err)
-- 
2.51.0

