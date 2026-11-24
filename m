Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554770;
	b=HcVsteVCVA1USWAlc0LzkF/8F5vEpMVW+9IeBZLCKylDRPTHtFzZo6JsOJqqd1sC6F/1
	 XaRpogrNBxTeRKDKntLBe9Uq7IoqNvVs6UG7h5fxSfpS7iVDIjiweLz3rwbv0amyVeAbn
	 pd5jmpnx8naEEdnEhnmvA4rrR7Uh83DAvqPxTk59eusckJlYyGXJUgLZj3ty6ZkLL93NM
	 GgSCUmlZRUtitNQQ5qIPW1HdoYnrnSgjaYtCGDIOyK3WCoyHQgqcLwxmUal6vAJvoJYd3
	 c09FK+eXcDioLS4WeoiTu8Z+aH9+IDtkUpHnUOkAAZSlTP+Daznk+BJf0Ej+uYR+Kig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2KMr8B1XjeGr5sbvvGEh5j7YxioCwr2NncjqTlPhcoU=;
	b=yRsBb7NIKIN/gOobzBTYdKb6OsACprYJhh/XO4JpKP0tAOlLxkOdzccFkc2XwWMcSImr
	 7SKsN9oG5eYGchUX9r+Fo0qI5VEMNDq9KPGuGHCRSFjIC62EvCrsMB7c/A3TBCEBT3eci
	 IHorLaxuuGsD63BB0p3JL0bUl5C0z2z4S91+JKd0cYPxyHfMRkluzuQoFZ7oS2fz9AOQg
	 WGhbAdmQsqKb0txcVisndduKEJfYuPbzq5ZDN3v0wdtKYgSs2r2rmFnxUTxvalCCFZnZz
	 9sGRgiR8K+LRGNMtCpWwmTs47CyGRJtfGpxdzpPhs2wRKQG4J9lsN93pGU/s1X3/+Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7XudmzB;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81008606A327
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 21:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81008606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7XudmzB
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3ada81853so5817344c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554769; x=1796159569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2KMr8B1XjeGr5sbvvGEh5j7YxioCwr2NncjqTlPhcoU=;
        b=F7XudmzB3UMlmDKY4pxSeier24JSGJsFdvj6+8k67E1xyhKDTD2515LthAx9Dx/1cq
         q4N08LAtEpSX15Ao2DEYIAH3BFsRkPEUlJ5xvKv7HMpPPSaRxtsimOfzGvXu0O8fTff/
         Wb6vzY5tzZCp3hhIKKTmNfiW0r38pg70He4yMolGzOfYWA60BBFdM7jCOXqTtXI04aC2
         2yL6pjGR5/0WAM03AjtdQEPTDIhXZYJRLFyLhmM0LhPURBxKOAx4WvnVsm9/XOVgWvze
         Tn3UEfxmHlQXCZqIjLIEvXemp/MbkiESvG5KCS3OQDwecGucAZGI2ePm4KnKa3VNS0v2
         c18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554769; x=1796159569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2KMr8B1XjeGr5sbvvGEh5j7YxioCwr2NncjqTlPhcoU=;
        b=vW2d4MAzkVfQnN5G5wO7CzaXhw43JOL0nO+2B5QerXczBxFQe9tmDxU1zE6DczNCgp
         SFkdmtuqm0i5gYmdu66uPv06KOPCh6OhzHkYXZzCts0p0Gt0YEYMQ69XKOOlVG6LJe5h
         ODHG+0oTvne/3jxnb8u76ll+noHsnu0ruH+2ZulxCQHj3LUvLCLhNpcj6H5oP5C/Q5Ic
         Glq01ApWzW7Tl/TYYy1BqHSPL3+MA4ggcIj1e9rnO2pc/FhXlXRcfNm0rxpv9lKGvThH
         ubl6aYTYlSfeuTtCGaBJdqFF7pTZYLpSI+yKAPf6oTPTznijW39r6nLMDe0I9VW/C3OJ
         AvdQ==
X-Gm-Message-State: APuU4Z9FVzWZUibEF2bl1D7i6s9tmvhIpvqOIRAKsRG3zwV/4JEY1XW3
	0IHpzmTg215+D+6kswwjqaaP9ieexO6iK1Zl8zyUkiz27b/D3IycrPazIL1kT1Eo
X-Gm-Gg: AZFdTZcEwgxt3+rSFsW1ok7Qz6Jqp4nyIhffAvvWXp75rpd7abLqcL1ia/L5UH68Qx9
	as9RasgGUdPsqbpxbHpq6VjQkhcqZdFOd8bC4gV7kwlUSwSr4pZQxq4faXEb8nLyIh/36fz/cjj
	AsI/txN4eEACPRYoqzyxVNmTggn5WTgvCuCZOeEyFn23L2jtQPW2tMUZM6B/uGt5GlvpTOipQUn
	aH8jCoJuxNKBxQGyMntLTyHHGrGgjhitEp/vbrPlZj3MhnMxlh8zWiDN9o5tYx+9nCfHjQKKZeI
	KoqzeN165pT39nQQoY14j9yHUWfv/o3dnnghPeDkNKN7QkfbQ5aWK+H0olqA7s3/P9JehbpeCjY
	vKYhOwsztuNl7f2ddTBCGfqt2rn+eLPagjxGjyidnWBj7bHraIPXU/Z5dtk7qu5ZX0TDBQTQneL
	Dk4ar7zm06nDlq5FSlf2zL6aA/w/xlKUXEPMt/OxXoA7cmOaYMdaGZqHswWoCrw2Mq36hkAroO4
	Bc65XKJVicBGPsYfP3HkJ6Rm9jpuVJZUX3XfR5afzSGFfXDK+ByMSfT9ITTVQ6tCW+eZGvL4YSg
	0OG68NmHs1wRS9wPHClEr+PbApqtOkSXb/NgLRPmXs+7nVBePo3vfg==
X-Received: by 2002:a05:7300:6881:b0:386:9ffb:33b4 with SMTP id 5a478bee46e88-3869ffb51abmr11773929eec.33.1795554768490;
        Tue, 24 Nov 2026 13:12:48 -0800 (PST)
Received: from shine.local ([168.196.221.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm22124445eec.18.2026.11.24.13.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:12:48 -0800 (PST)
From: "Andrei A. Bykov" <andreiab9019@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: hci_core: preserve LE feature holds across encryption events
Date: Tue, 24 Nov 2026 18:11:27 -0300
Message-ID: <20261124211127.41609-3-andreiab9019@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124211127.41609-1-andreiab9019@gmail.com>
References: <20261124211127.41609-1-andreiab9019@gmail.com>
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
that hold. Route both LE key refresh event formats through the same
confirmation helper via hci_conn_refresh_key().

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
index 4aa0b49ae1..68cce0628e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2331,11 +2331,18 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
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
index 7991db54c2..cb9e4255a3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5798,11 +5798,7 @@ static void hci_conn_refresh_key(struct hci_conn *conn, u8 status)
 	}
 
 	if (conn->state == BT_CONFIG) {
-		if (!status)
-			conn->state = BT_CONNECTED;
-
-		hci_connect_cfm(conn, status);
-		hci_conn_drop(conn);
+		hci_encrypt_cfm(conn, status);
 	} else {
 		hci_auth_cfm(conn, status);
 
@@ -7470,7 +7466,7 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev, void *data,
 			conn->le_rx_def_phys &= ~HCI_LE_SET_PHY_HDT;
 		}
 
-		if (conn->state == BT_CONFIG) {
+		if (conn->state == BT_CONFIG && !conn->abort_reason) {
 			__u8 status;
 
 			/* If the local controller supports peripheral-initiated
@@ -8171,7 +8167,7 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 		hci_le_eks_oppt_encrypt(conn);
 	}
 
-	if (conn->state == BT_CONFIG) {
+	if (conn->state == BT_CONFIG && !conn->abort_reason) {
 		__u8 status;
 
 		/* If the local controller supports peripheral-initiated
-- 
2.56.1

