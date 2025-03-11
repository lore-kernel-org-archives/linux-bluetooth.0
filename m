Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758DB1925AF
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722158; cv=none; b=eHTSjBRfhOU2aNCUIxyyUyb4guTYWkjdIZWV/j60AvYY1HT8wbdpY1MWiSsNMl0QHMkRsjxJYB7RXaC59OoJZZICiWwP0/+yopCplFrWNOLVIleqgSeRZQvqLYhieo9bQ7fLqkKxYeY622QH7SXdNcOukd/wnYamuIBw/aPN4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722158; c=relaxed/simple;
	bh=Uh6O8HZ7gjNr1ux7HsHcg7MrI/zDznD41AJm5lo393Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddjIdAyI+V4K8FANV+0KgFa460VVClGkoq25Du+AQCROWgy+9kmDk96bX7JVwedW1TRf0S4oi5b0c6LL+PQz8QHdsWDlqviWej7NGgODRYFiSKsC2z51nycqgJ1iOr+65C4a7ZaEo1Wf+23Io/EPwZqeK7zDkFTXEIHgvFSmlnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l20AWiHs; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l20AWiHs"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523fa0df55dso131351e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741722155; x=1742326955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IA61+DwrJqJqO5EMJQcDEh4cXSFhukYlE1QypVO4pw=;
        b=l20AWiHsd6me/qYN/3TrCKmGpVEgVe7jA4Qe8VROxRJdOCSBgUjTEDQOHCxWc+0Cqi
         75sNtQO7dT4h6NsxdQxEh3V+zQn4N9e05jOKqkkKhVjOKJszRke1PYqBkOW2LUwZ7uyJ
         o/pxSbug6WmHvRttGuBw/Dau4y2zz7rOD6mRxSB8CqNxtMABRuREuBkhlCwhYFfefxO1
         oDMkSVv0VuDY1J3k6g2l0kppxIRdXxnP/E8xaqZdK6S6XrP6g3FOTJy/N3sxVjoy9mDF
         21/ucENcT5X/WTYY+yPh3DsWTmrXvZ8gEh1aSDOt9Ey/PGAnkOblQn4GjDZslZjnW+Sf
         zz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722155; x=1742326955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IA61+DwrJqJqO5EMJQcDEh4cXSFhukYlE1QypVO4pw=;
        b=g/ENbPXlP8DqcxkAaXezEt7kBTG5XjtGtcotqlMHHrAvMiJVy3gmcYrkg1JhrXkTkb
         fP4Z+PNFkYnAmQ1gvYryymHuPb5Zu1Zoh8Xo7NZnf6AHVs7s1rN/zLAsoGM2tGMv2m1Y
         svMZKFcxZRDIcOUp/EA9ntMC/DVPD8UDp6pZSJGR5HNjgz0tSor+j4S3z2VZ4RO4ibt4
         vyGC/n0Srs8LKcAx4NZVrjNHl15fKMXIw4RXp6LLMTVBMTY9qhAIvASRJAjwUk1FD++C
         GHFOZfMsgG7koGFkOvZW07/I4vEkpP8CDli+CPHX53KgmpfWH5f8nIHxoNr+Zej7EDp0
         +8iQ==
X-Gm-Message-State: AOJu0YxLLzUIo6JFkP/e1hVH9malg6In3eiuvIMKecS7mGJIeQfOoOg9
	2KzG8WjKukVGGoHlyk6fBuPt420ymGA3eRH4OL2ktN5ejFOW9XYh+U9I4DB3
X-Gm-Gg: ASbGncvpMUZ2I5uWZPdQJGNM2txcP/BgXS1iIgV/byxzBiOTEeEuomJP/RCgIMyFciP
	qDE+9/LT4bs0UdY3eVOeqVMqkzadTJb+2TzwfVCV1jHBnzeoqYqoDoq+Q07tPob48zoLzGjxaxL
	/fL5QLurIVvltRwHb9PIK31I6Pp6yzF5ShIwYde+seSsOb6HONY+XCE4tVYxSIEHvgxfXzFGVHS
	cqTCq46YSAoUHc8X/9al/c18jip/X54pRpf1NuK5GsKlo34LRiUvHBlquC0cKViabl/1NL92ZOy
	MzpAQU22bDSHIPzb8xDkxQGF7ZymojqnOY2K0/IwKIDXaeOlwAtNMQCDiYrymZehiCLrLp3pLbG
	3KZt5KqJUWwyOMQ==
X-Google-Smtp-Source: AGHT+IERBnk/sgfjEMpyQrDhUi4tnpnF1idfRoFJ0QHO7KqoTOyCcdsnmlmvGlsvUZMvPPb2qXUGVQ==
X-Received: by 2002:a05:6122:8c1d:b0:520:4806:a422 with SMTP id 71dfb90a1353d-5241968b5b7mr3098582e0c.3.1741722154707;
        Tue, 11 Mar 2025 12:42:34 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5240718596esm935746e0c.9.2025.03.11.12.42.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:42:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] btdev: Fix double lookup
Date: Tue, 11 Mar 2025 15:42:26 -0400
Message-ID: <20250311194226.15109-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311194226.15109-1-luiz.dentz@gmail.com>
References: <20250311194226.15109-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the existing double lookup when calling
num_completed_packets but passing the conn->handle instead of passing
the conn pointer directly since num_completed_packets would then attempt
to do another lookup by handle to resolve the conn pointer again.
---
 emulator/btdev.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 976c1125d66e..1b7b75c21399 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -7460,21 +7460,15 @@ void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
 	btdev->send_data = user_data;
 }
 
-static void num_completed_packets(struct btdev *btdev, uint16_t handle)
+static void num_completed_packets(struct btdev *btdev, struct btdev_conn *conn)
 {
-	struct btdev_conn *conn;
+	struct bt_hci_evt_num_completed_packets ncp;
 
-	conn = queue_find(btdev->conns, match_handle, UINT_TO_PTR(handle));
-	if (conn) {
-		struct bt_hci_evt_num_completed_packets ncp;
+	ncp.num_handles = 1;
+	ncp.handle = cpu_to_le16(conn->handle);
+	ncp.count = cpu_to_le16(1);
 
-		ncp.num_handles = 1;
-		ncp.handle = cpu_to_le16(handle);
-		ncp.count = cpu_to_le16(1);
-
-		send_event(btdev, BT_HCI_EVT_NUM_COMPLETED_PACKETS,
-							&ncp, sizeof(ncp));
-	}
+	send_event(btdev, BT_HCI_EVT_NUM_COMPLETED_PACKETS, &ncp, sizeof(ncp));
 }
 
 static const struct btdev_cmd *run_cmd(struct btdev *btdev,
@@ -7672,7 +7666,7 @@ static void send_acl(struct btdev *dev, const void *data, uint16_t len)
 	if (!conn)
 		return;
 
-	num_completed_packets(dev, conn->handle);
+	num_completed_packets(dev, conn);
 
 	/* ACL_START_NO_FLUSH is only allowed from host to controller.
 	 * From controller to host this should be converted to ACL_START.
@@ -7709,7 +7703,7 @@ static void send_sco(struct btdev *dev, const void *data, uint16_t len)
 		return;
 
 	if (dev->sco_flowctl)
-		num_completed_packets(dev, conn->handle);
+		num_completed_packets(dev, conn);
 
 	if (conn->link)
 		send_packet(conn->link->dev, iov, 2);
@@ -7734,7 +7728,7 @@ static void send_iso(struct btdev *dev, const void *data, uint16_t len)
 	if (!conn)
 		return;
 
-	num_completed_packets(dev, conn->handle);
+	num_completed_packets(dev, conn);
 
 	if (conn->link)
 		send_packet(conn->link->dev, iov, 2);
-- 
2.48.1

