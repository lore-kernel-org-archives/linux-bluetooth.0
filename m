Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED936477E2E
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498390; cv=none; b=o3tY6b/6rFHYoD5djMZPSiN6EOFEe91AQc+vtwghbTc1wvaIMTP7UnAys/9tHrKWIPDLcDwg/TpS4s39FTJijiekog77T0O2OxhkHkaOWuNH0E54lnJAARC/2tj9PyCDxQUOkJ1WRvN/xK/QI8eA9VCdbzRrprK6qjerHNfzuGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498390; c=relaxed/simple;
	bh=87TlyBVPvSZkRacf76t6g8A8VOoLXKinMW91wLKTfZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zudde1iO3g3gmR+JR7Tc4zt/RiAOtxEEhkWjEPZlliPdgucGOqXd7UsA+AjqUZSWgtiH5ypm9rtBq4E9I9OuWy1MrCpM9DG4sXPPbr77Xv7o1OTcIelQ6sfByaj/bBtLUh1nF/ImkwixFV6Yp5ZgVm+EQlT3AZ8OgA01RRZ5KdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdCRxxgx; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdCRxxgx"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535aa147d8so58514eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 15:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791498388; x=1792103188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vef9VvR3jOkcdVIQyjRUIzZuqo6ilnwxU+vXMpgLYqw=;
        b=pdCRxxgxSm1R71SDIhiD0zQQTTQlJr4MwlQmBa80gBR7l2S6iIhS04cYtblmG+BDaf
         EryziX/u82of89+AXpUP1zHuYiHJV3sYaLbskWY5U56YBnkV7ukh1Rj12RGrFTlj4wzB
         lyz3Dt32c4pWfnIUasMpZQNKw2q9Nk6DxC2d5k2tS/QDN305WTnofVferkyCTA8ycomU
         kkVhX2QyjHq5aVh/HttEpA4ntuY6e1Lb6HvbciDbYqHkAyhT0C6Jfxywt+Z1C5zwtagg
         gbKTXz7nyEq/8+/TlYI+OZuGUvsZ4SxrnAEQ4yrltc67Hv6qm9eW4J5mgcyI7Zlj+pOa
         +0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791498388; x=1792103188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vef9VvR3jOkcdVIQyjRUIzZuqo6ilnwxU+vXMpgLYqw=;
        b=xJkKQI7KrNIw8C5wMDgpM8DK5K+LekWFjDDC9TqydgE9xAfqeK5wFvxB/i/5f5YBEU
         j6uLpHw2t3G2jnwaOS/UOZ9U8j4JYUJLYnpDyhdVspVj1QxYGgykDapKseyCDxUv1qhT
         Jy9Hy3Rq3YzOjKLeXmWfJ2EidBgTJoTTsbsFePkqIFdkHFU/DitaOP8eSuQ7E5augZ9F
         E9HynjWMyXHlTRLu5BjbfAcIsZszwnbgq/a2FSebV+xVEAH07sY2qnssDHYFgandio1e
         /Dh2BzbI/KPf2tQxVvtP+IZulGQ0Do09UcFoeS7a6LXVnAi3QvxpeolO9170EHrR0eeR
         sozw==
X-Gm-Message-State: AFuF++lui5ItS9Mjcuw7bCanMd9sc/xtL1X9NX+3Xto2riMzMwi6i1cJ
	S+rcvIoSoJH98+8bAHITs2hRbxjhqXIP/ehR4YD1384a/NTyzqYx6CjjAK4WpgqZAhY=
X-Gm-Gg: AYBFou0Xco3/yIsWoyfX3VnCWS4zZ0FSbb7n1I84fSotpmu/bMU4kMWCxNI11mAzpS1
	c/BJrLaREQfUUQ5yItypDjZNArCFJ7EdlGgpVJ4HHMUIYjpqdTistr7zL+r3kYSdbJ5S1TAosgA
	DH/2Rc6r5RJ0DznKGJY8JyedrpIDOBzi5vXxTUi0Qz6G85wYzr1g1yi5nL5ZjN5KGDm5/3ARxiI
	l7wiWARQqBEzVuUZufHzrrVsTRwBrBGS47/lf8djzJQ7R971UcaoAly22sLQZJL3PX7l9DZ+lIr
	bxiy8wsrs6f/6DMY9qwTUq0Eom/mIvPXIUgeiIf6RrrFoB32ypGvCtlhkswPttgnO/u7D1qXB8E
	gPGqoqppAY/XxE4jQz5eZoz0jmFo6qb2rEX8piCLYIWJpzjemyggLyhoiKT/lCW4VqtL9pxWZaX
	mq+Y59iDGm9dtNopmiXUpYL+ah8U2MDqVvWHxr3EOqhUpIV2aYnBcbk0K3C9LD9pwg3oC/z0t36
	GGL3tKZUx9g/A3b07jIfTv6Z1LSJKIDVQYza657
X-Received: by 2002:a05:7300:c01b:20b0:351:e21d:357d with SMTP id 5a478bee46e88-3537dfdd089mr557084eec.1.1791498387858;
        Thu, 08 Oct 2026 15:26:27 -0700 (PDT)
Received: from hitalo (208-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1d6e6sm985148eec.24.2026.10.08.15.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:26:27 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH v3 1/6] Bluetooth: hci_event: Don't fail a connected SCO link on setup errors
Date: Thu,  8 Oct 2026 18:26:11 -0400
Message-ID: <20261008222616.2780570-2-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008222616.2780570-1-enghitalo@gmail.com>
References: <20261008222616.2780570-1-enghitalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Add SCO Connection, Setup Synchronous Connection or Enhanced Setup
Synchronous Connection fails in Command Status, the error handlers fail
the first link on the ACL, whatever its state. If that link is already
up, it is deleted while the controller keeps it: its socket gets an
error and, as no Disconnect is sent, later setups to the device are
rejected until the ACL drops.

A link that is up can be the first one on the ACL since commit
a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting
connections"). Aborting a pending SCO/eSCO setup, e.g. because its
socket was closed, now deletes its hci_conn, so a socket that connects
right after gets a new one and sends its own setup. The abandoned setup
can still complete, and it is then matched to the new connection by
address. When the controller rejects the new setup because a link
already exists, the handler fails the connection that just came up.
This was reported with an HFP headset, where the rejection was Invalid
HCI Command Parameters and the microphone stayed silent.

Only fail a link that is still waiting for its setup to complete. A
Command Status does not tell which setup it is for, so, as before, when
a connection is aborted while its setup is pending and another one then
starts a setup on the ACL, an error for the first setup fails the
second connection.

Link: https://github.com/bluez/bluez/issues/2562
Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Assisted-by: LLM
Signed-off-by: Hitalo Souza <enghitalo@gmail.com>
---
 net/bluetooth/hci_event.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c055d16cf..cbe53e19e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2400,13 +2400,19 @@ static void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
 
 	acl = hci_conn_hash_lookup_handle(hdev, handle);
 	if (acl) {
-		link = list_first_entry_or_null(&acl->link_list,
-						struct hci_link, list);
-		if (link && link->conn) {
+		/* Only a link still waiting for its setup can be the one the
+		 * failed command was for: one that is already up must be kept.
+		 */
+		list_for_each_entry(link, &acl->link_list, list) {
+			if (link->conn->state != BT_CONNECT ||
+			    !HCI_CONN_HANDLE_UNSET(link->conn->handle))
+				continue;
+
 			link->conn->state = BT_CLOSED;
 
 			hci_connect_cfm(link->conn, status);
 			hci_conn_del(link->conn);
+			break;
 		}
 	}
 
@@ -2683,13 +2689,19 @@ static void hci_setup_sync_conn_status(struct hci_dev *hdev, __u16 handle,
 
 	acl = hci_conn_hash_lookup_handle(hdev, handle);
 	if (acl) {
-		link = list_first_entry_or_null(&acl->link_list,
-						struct hci_link, list);
-		if (link && link->conn) {
+		/* Only a link still waiting for its setup can be the one the
+		 * failed command was for: one that is already up must be kept.
+		 */
+		list_for_each_entry(link, &acl->link_list, list) {
+			if (link->conn->state != BT_CONNECT ||
+			    !HCI_CONN_HANDLE_UNSET(link->conn->handle))
+				continue;
+
 			link->conn->state = BT_CLOSED;
 
 			hci_connect_cfm(link->conn, status);
 			hci_conn_del(link->conn);
+			break;
 		}
 	}
 
-- 
2.55.0

