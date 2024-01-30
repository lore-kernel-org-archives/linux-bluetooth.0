Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CADE60DC9
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610335; cv=none; b=g6Q6ltTFBoRSr0r2Jm6sB1JRMOnObYIIXXdNvOvgyu8R+Dj6YFudVJPSVvccgAtr1I5sIpkzWOd7atqPX5kbK/KUCXHPW6135dTgOvgyflqBqBzPsjpRa3QN/CQ9+Z4dBWaqR/KUDAlKlNW0rxCHORTfIsuD8ONEK+tmBhTUMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610335; c=relaxed/simple;
	bh=7+yer1B1xGXZd+b5cYdwisoEZEyllw7IlGJHz5RU0jY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dOA5l60HRhoJ4xWzgfVVn66aTQbZPCX1QPAQBb5giy/QoicHpyLOJ2vpzvJD0FwGz+lLOHaxWGreBcYtfew5DWy/8njOJFoNn+WDlCksBjcmI/maBaAZfK+XnBnfGaBOmyhysWsjcJmuijJ7AxlT8OzFzVzbmtSNkui0Z3G63cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wc3680bx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wc3680bx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d8dee47308so17602105ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 02:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706610334; x=1707215134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ywBcdQss8q6e4ixH8in3qk21AH6SiwYvw4fn6uYBzk=;
        b=Wc3680bx+XQRuUQALYvMtDXPVHBUKoZ6StWuDEC4g84vwEut2EnMrLWy6uTJbN5wXa
         9cZt0eS+kLBb6l5kv9uOQtV8WuRVCKzLduIquYexbt/aL6+EbZ1BBG7c7WELksbCDhsx
         AtJzgUf+Rap23IMxWdpA6ooD1zEbzxbRi4XBTZilfTVH49Tun+03+tOMsYzCRBjZf1w3
         mPU7ZkJ+beki8GCLXXafQ1OV9I2QlbGRRtHudkh8E1shoIIE6c+gBlUdZc1CrRq9wc1X
         79plXoc8WQZvmqQqnGLt39ta/KlXkhkh3ALgkQVDMXfstlFR0dHVLHQGJ7FEPDIQgVCP
         K7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610334; x=1707215134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ywBcdQss8q6e4ixH8in3qk21AH6SiwYvw4fn6uYBzk=;
        b=SUC4WmjYMrTjq4OMsukK3STFTPddGIkbdcBQYQdFd7VHR82STO219DpVgrRlcdAHXu
         EhoL2TYSpYJXcg1hSEyoHpmK9ly7ixxidh21it+L5gsVlPAnhSrmbLrXMUnHExWY6wzn
         nWZxDyTI5f5mdMUWaKU0NCZqN4oA1A+vxWikljnGasL2pZbWaMzxylnMrRwWEMxP0YFL
         QOaG/sRBjpbRqviEArOBixscCmQ1ATR9HE/EOldwBcufTfZN4Ud1s3S5TfL+X/b0nLdt
         UN5Wq9r2HoMc9tCw1vypRq71XbU3weFYzJiBS5nKVqWb8g/2O3REnQh6aPOU61VsCfy9
         vs9w==
X-Gm-Message-State: AOJu0YxS0hRoc+S5a6VYUKfF5mOSYhoxaOe6FSk3l4s8yr6GZHryqa8C
	+ZETZlrtqq5JzvXCgKWqYqkY2rD0iNXa2MkoirBSgmEExkc7uMuH/SnU4MQUCO3M9gLqBjUHpMG
	UOZgvV/OYX/sDI8wUsegEg72Pez3ixFx+UuhPrHAaU2Sxrd2qUcDOcY+g8rJqcDEMLK/v8gNkFC
	E5QYNMLOM8J0sZaQZmqKXtBlnzQ8P6+mMUnaRUWfgBJUaCxMhNjA==
X-Google-Smtp-Source: AGHT+IG5Youu+GS9Lgq0HYFPjePZJtbWY7VfIxmE+79fw7O7hEVeqqcGwqNHYsq1EfkH3mz5bQBfUaDns9my
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:683d:ac9b:1d63:b3ff])
 (user=apusaka job=sendgmr) by 2002:a17:902:f212:b0:1d8:dbda:46b9 with SMTP id
 m18-20020a170902f21200b001d8dbda46b9mr26358plc.1.1706610333239; Tue, 30 Jan
 2024 02:25:33 -0800 (PST)
Date: Tue, 30 Jan 2024 18:25:00 +0800
In-Reply-To: <20240130182459.Bluez.v2.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130182459.Bluez.v2.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130182459.Bluez.v2.2.Ic61e507a408f2dab76fd079263b565802fe3537c@changeid>
Subject: [Bluez PATCH v2 2/2] Monitor: Avoid printing stale address on
 connection event
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

We now remove potentially stale handle when assigning a new handle.
However, that is done after printing the handle and the stale address
associated with it.

Directly use print_field instead of print_handle to avoid printing the
stale address. We still print the correct address on the following
line anyway.

---

(no changes since v1)

 monitor/packet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 164cc82bb2..3c32735b73 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10083,7 +10083,7 @@ static void conn_complete_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_conn_complete *evt = data;
 
 	print_status(evt->status);
-	print_handle(evt->handle);
+	print_field("Handle: %d", le16_to_cpu(evt->handle));
 	print_bdaddr(evt->bdaddr);
 	print_link_type(evt->link_type);
 	print_enable("Encryption", evt->encr_mode);
@@ -10655,7 +10655,7 @@ static void sync_conn_complete_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_sync_conn_complete *evt = data;
 
 	print_status(evt->status);
-	print_handle(evt->handle);
+	print_field("Handle: %d", le16_to_cpu(evt->handle));
 	print_bdaddr(evt->bdaddr);
 	print_link_type(evt->link_type);
 	print_field("Transmission interval: 0x%2.2x", evt->tx_interval);
@@ -11084,7 +11084,7 @@ static void le_conn_complete_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_le_conn_complete *evt = data;
 
 	print_status(evt->status);
-	print_handle(evt->handle);
+	print_field("Handle: %d", le16_to_cpu(evt->handle));
 	print_role(evt->role);
 	print_peer_addr_type("Peer address type", evt->peer_addr_type);
 	print_addr("Peer address", evt->peer_addr, evt->peer_addr_type);
@@ -11213,7 +11213,7 @@ static void le_enhanced_conn_complete_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_le_enhanced_conn_complete *evt = data;
 
 	print_status(evt->status);
-	print_handle(evt->handle);
+	print_field("Handle: %d", le16_to_cpu(evt->handle));
 	print_role(evt->role);
 	print_peer_addr_type("Peer address type", evt->peer_addr_type);
 	print_addr("Peer address", evt->peer_addr, evt->peer_addr_type);
-- 
2.43.0.429.g432eaa2c6b-goog

