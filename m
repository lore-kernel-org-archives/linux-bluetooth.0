Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86633AE188
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070502; cv=none; b=INbSCFgS8oD2VeVRlQvY36ER+kynHHnNJLpOHxw+0R1KlnKpN55gz0/gPxvx8q6mb1oxnfKFe88sRkDDKzTmhVbrxtGXdhXPfLSVFu5csd4J7sYzSNhLGKDoc0P5C47wxoHAXxRn35yyPYhaAznEQtjoXDvcsB2+zSTILoWCSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070502; c=relaxed/simple;
	bh=TsGXtroWwAHzkt32+1zGaFyAa4khptksZ4xGS3voQ/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T218zXIR97EYPFPu0G1UJNZe3tSn8IJUg9yotQQH34IH0c3XxbXn18Iq+dsqUaKTWY7aufO6Czgsr72Em8p59V+csiEh8fvu0/E8NgybboX3e4jquVmDxo4kN7tGXcax4V9peOzTsq7oOG44cNfWFGpFMFtwXyRyu5WULuJ84ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2CZAtlr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2CZAtlr"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9a9be502so25206265ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776070500; x=1776675300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0YOwCPvbeLENHjI61ZuHgN7OrPjwjEbwbPVraHFdjs=;
        b=l2CZAtlrp0Z1ATpEo7cdpTHG32s4zaeya18E09D6LHdQezTnfvqP4iTj78spY2Pcv8
         9TAcKhbNx/kjB5ythKBCvpVCZLo7rH5iKX3q4oj+fG6XjA73x604wNHPkiYLqr03DxNo
         TEbr/fHtNHGQaaHJ3P36q7Vi3hUnmgEIAUtoWVEL/ekevGnK/SW9F3Arp6hZ2sWJazj7
         auNQnUoTSxzOPL+d2Rfh0i9utZlEZqYvmvnjnn2fgObzjTESaKSSSKVQs3EKcoyePclm
         o7e8UuRLKnpQcOyirACgzypWZIIG/DnO4iUW+s0jCt8WLHzsbGRkW81AfzbL+hxJZtmD
         HRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070500; x=1776675300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0YOwCPvbeLENHjI61ZuHgN7OrPjwjEbwbPVraHFdjs=;
        b=UwYxVjGNS380zR8E4E9Mtv3Kw5xb4GXUf+7KtpchvDxi5p3k4JN79ZUJyEpnzokX4y
         2wl2v+jd/MRc2DRjQKc0bysm276qWD0i89aMVre5hjm6FxxLh9cQd8CYQ+seBSfNQIWO
         RMPs4JBAWAyo3R60rSksw+iYMbDe5CYy5JcfFBI4OwGEp+90XKFYeMyfsedgKqJoObRk
         45vbFQJeP5A0jmKYOIKWLPRkxWkFqABYi5BVrBsF4mSlBWEw0C3Q5zM2pLO06Mx+jzfG
         Ng41AItGieIVE7dT5Zw15svI063FMJquJkDJfuNcGvhdnIuhn1XtBT4ZYEmOhM1OX1kP
         o6lw==
X-Gm-Message-State: AOJu0YwBd9+1FcwGhz8UXoFCLxQCeGItDYatcfzVbGmOTLQPnwW0P2oR
	ANIjsF7TDDB28kK0RsPhtIeTbYrrRg6NYOwr18m1MXHNlhmC++0Zrpd9K6+rkQ==
X-Gm-Gg: AeBDiev1LCjAZBVPxrXJLyTnIMqU3QvC3GGF26R6GdX3Qs74pyXeacfoxCTXcE99xP5
	atvCBKM2crr5063OpfuCKTkWUKuu9NpjOQ4xZleUuO+yYDcCygq5KsgqVagNZgGoAwLO7XUMdkB
	3ue9NKcpmBTYNOQs/odtiV0fR0/M/ILdoWj0eWYfRb1jgbdnmtc/CHJ3fb77dy1M8+uw3Y7ENQ7
	axJRaGeT9W0+zTxWFq9Vsn0esOWc7fYbnF6tRzGscXV84UUf0sUXGJCQuNib7D+6co5rG4PoeOL
	BgkS5TO851iz2iIOtQH9qyR5kTgeDlDKXhWqM8PRNb0Mu/tWsLTX+fiV97ASgdg/uuWEc9MUx09
	XoIfPg7SSJ9U/JPKSbq+/QP8N/nXD+0cIdFIBW/076jihVcwFNZ34QOspV0KNFuoUWCPvfYsm6m
	cAsOe4GrSLCszuQoBQdGiMp/YZeuODSZmh21PmTaNmPXHGdPJvBO1A18/H1JFFEs89
X-Received: by 2002:a17:902:d581:b0:2b2:4cd2:e162 with SMTP id d9443c01a7336-2b2d5a4a3e1mr135260665ad.34.1776070500041;
        Mon, 13 Apr 2026 01:55:00 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f2af90sm111337115ad.64.2026.04.13.01.54.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:54:59 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] Bluetooth: hci_conn: Use disable_delayed_work_sync for le_conn_timeout
Date: Mon, 13 Apr 2026 16:54:55 +0800
Message-Id: <20260413085455.74585-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hci_conn_del(), the LE_LINK case cancels le_conn_timeout using
cancel_delayed_work(), which is non-synchronous. This means the timeout
handler could still be running after the connection is freed, leading to
a use-after-free.

The other three delayed works in the same function (disc_work,
auto_accept_work, idle_work) already use disable_delayed_work_sync().
Change le_conn_timeout to use disable_delayed_work_sync() as well for
consistency and correctness.

Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e6393f17576b..6e96a8aeebd3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1201,7 +1201,7 @@ void hci_conn_del(struct hci_conn *conn)
 			hdev->acl_cnt += conn->sent;
 		break;
 	case LE_LINK:
-		cancel_delayed_work(&conn->le_conn_timeout);
+		disable_delayed_work_sync(&conn->le_conn_timeout);
 
 		if (hdev->le_pkts) {
 			if (!hci_conn_num(hdev, LE_LINK) ||
-- 
2.39.3 (Apple Git-145)

