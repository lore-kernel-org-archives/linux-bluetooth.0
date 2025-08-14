Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4477E23AE9B
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186145; cv=none; b=grMQhvno8tGDk+9cGI7kRpWn0I3+vLQanmtmL5Af3jJ7uKczoMZ1qe73N9n063WsHxR7/WLYE2wTWtp5Z/awSg9GiUh0EcUF5oE0Ey0kNfJplljgGg1MVY8MH9eEx+0ewI/LOb8Q5Tvf1zLw0q7dQZ7PnalQjU5xknYzSvX1dno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186145; c=relaxed/simple;
	bh=E+YD4cmFS1nK6ldvQJ9k2q6MrbCXy/inPbO5OJERXXI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOj9T2ld6oBs1YLVC+HOqJc1GUiUCXlQyjgtXfumcCXbvK+7GK8mgfHTyDx/y99HA754348Yvnk4Zw7sizDzbH7nfJ36HhwTpFrveSS7cI//3voiIN01AMRT/28sZFlgJG0JNrDq0+pvZUAYhXqgfY1DYcr9tBTBwXUamJZZ2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP46fSoc; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP46fSoc"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53b174ac3e5so435508e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186142; x=1755790942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15dhquDye7gWzM42UWDF9E9YFUSXnJEtKVAz8ZdJoxg=;
        b=RP46fSoc4aVX3/o8G4dG55B4JIABRet7i5MBD3YVwKktPe6YPzw7py2bMvJ9x+6age
         sQr0ARE6x4xjgJohC0Erpv4hWGBzD/InLILSO2CpH4ZKXH7haZpKu9qzsCmV7GJGhX13
         gbh7OF4D4XycxCTPdwtYz+M/jZDcIsuBs5LCvXwD/qjEc+Q54k47VLjxE13VQhsL4HuA
         K8mMpeIN/f2DKEGM0MdWDy7jrtIXuuPolo3f0b28yWzuT5fi0zoMY2/Aj0iYkWoMdu6D
         OCzjxqbzYcw96CHUVNMdAnSitq4ZzbyNU0TcqfdBE8GVS95USNGAsqf9YTeZiOC3kwO7
         1R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186142; x=1755790942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15dhquDye7gWzM42UWDF9E9YFUSXnJEtKVAz8ZdJoxg=;
        b=mP70bRF74hTzK3xib34v5wk6gFjH1DGlgUHtVTB4FXq+o2bCih2u1a4xhNJlZULywk
         e46d39xqE21tMupfNQj8UrbMDwMLl5hUm5V2NMyuzsfGmUjitha8eO4wk72GGeANCvqb
         YDiq6j/kXgbHuS3Z0mlrDK4I9LQeR6noXP1tDOdI22D689/SJJDQ6IA6AD4tc//cbkyM
         063TOay5pXEXklskKUyDPe2YlVrQW/N/0P6cpvgdjf6h+SYV99xTm3XycIGBHdmz4i9b
         h910XYv45Ifoyt5gL+C+ClIStb4s1BWguLqZHNWubtjPPH8qYMQAh5E35G7KfM6AFjJx
         x5+w==
X-Gm-Message-State: AOJu0Yxp2Wu1cdZdzbtelPFe5uyVjfpxGjLyAAv77dp1ndBsmIGQb3R1
	/Na7WIENpx2W71Xgtf0+oMDLHTLOd7XsPPSEIgEPVnI8ovHdGVGSdbQ0Rs/DNBuE
X-Gm-Gg: ASbGnct6dXLM549avThGlq4XmDYdLN2vLb9kjGcHyZdtlJCzdcXZc7C6zMvxJNaLebq
	9i+q05AVCq2naucZGIje+mZhhcyoOC2t/eAdfTPN9n8ogCqa7zAfojukx1tW6NxJi17Vne81Dv5
	a4XlqjjXpZnMs+PmDB19P9UE9Pna6r4dvbHW1ZMqNntmvQiTbsda4RWp8TVtsiLzEigyw/A5jdj
	isOObnINxZNig+n63PwkmBDLAs6GY2uPxjNOqm8qd1qCCZtaA+kAHJaXbXEE7Jd61KoHP1aov3A
	GiCF92cN88ziHhx1ImD/B8UaKqmZniGX7c5wQBrnhoUvOFTIdtc7g2zRcr1grWYzA5f7Rt/U/l6
	iq/epSJn6XCvu+FUAyXovVhy4Bj86iJ1+M4EDxRrqVx3EcRKlqtNnFDdv3ozIgmsfjMznObs7vQ
	Q=
X-Google-Smtp-Source: AGHT+IEMoDsF0B+l2ZfMnrC4zF8XP0lPuqY1F8y8z6zUosYqbgd/qxqZfWITWdUJgYW9EJQqqzoCXw==
X-Received: by 2002:a05:6122:2a4f:b0:530:5996:63a2 with SMTP id 71dfb90a1353d-53b18ab4bcfmr1328727e0c.7.1755186142595;
        Thu, 14 Aug 2025 08:42:22 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b01ae76asm4723431e0c.8.2025.08.14.08.42.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:42:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/5] Bluetooth: hci_conn: Make unacked packet handling more robust
Date: Thu, 14 Aug 2025 11:42:06 -0400
Message-ID: <20250814154208.8433-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814154208.8433-1-luiz.dentz@gmail.com>
References: <20250814154208.8433-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to make unacked packet handling more robust by detecting
if there are no connections left then restore all buffers of the
respective pool.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 41 ++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9d2324eb1211..89dc0429de77 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -149,8 +149,6 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 
 	hci_chan_list_flush(conn);
 
-	hci_conn_hash_del(hdev, conn);
-
 	if (HCI_CONN_HANDLE_UNSET(conn->handle))
 		ida_free(&hdev->unset_handle_ida, conn->handle);
 
@@ -1151,22 +1149,49 @@ void hci_conn_del(struct hci_conn *conn)
 	disable_delayed_work_sync(&conn->auto_accept_work);
 	disable_delayed_work_sync(&conn->idle_work);
 
-	/* Handle unnacked frames */
+	/* Remove the connection from the list so unacked logic can detect when
+	 * a certain pool is not being utilized.
+	 */
+	hci_conn_hash_del(hdev, conn);
+
+	/* Handle unacked frames:
+	 *
+	 * - In case there are no connection restore all buffers to the pool
+	 * - Otherwise restore just the buffers considered in transit for the
+	 *   hci_conn
+	 */
 	switch (conn->type) {
 	case ACL_LINK:
-		hdev->acl_cnt += conn->sent;
+		if (!hci_conn_num(hdev, ACL_LINK))
+			hdev->acl_cnt = hdev->acl_pkts;
+		else
+			hdev->acl_cnt += conn->sent;
 		break;
 	case LE_LINK:
 		cancel_delayed_work(&conn->le_conn_timeout);
 
-		if (hdev->le_pkts)
-			hdev->le_cnt += conn->sent;
-		else
-			hdev->acl_cnt += conn->sent;
+		if (hdev->le_pkts) {
+			if (!hci_conn_num(hdev, LE_LINK))
+				hdev->le_cnt = hdev->le_pkts;
+			else
+				hdev->le_cnt += conn->sent;
+		} else {
+			if (!hci_conn_num(hdev, LE_LINK) &&
+			    !hci_conn_num(hdev, ACL_LINK))
+				hdev->acl_cnt = hdev->acl_pkts;
+			else
+				hdev->acl_cnt += conn->sent;
+		}
 		break;
 	case CIS_LINK:
 	case BIS_LINK:
 	case PA_LINK:
+		if (!hci_conn_num(hdev, CIS_LINK) &&
+		    !hci_conn_num(hdev, BIS_LINK) &&
+		    !hci_conn_num(hdev, PA_LINK))
+			hdev->iso_cnt = hdev->iso_pkts;
+		else
+			hdev->iso_cnt += conn->sent;
 		hdev->iso_cnt += conn->sent;
 		break;
 	}
-- 
2.50.1

