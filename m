Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782885;
	b=SU2yu2i897sFC5NBwhp59O6PxF1n5b6dX3K8LCfOQPyAwCu3Z/TuPKUis39j9JMjmemZ
	 OtyMrWzV9Hmi2UTz1nHsbSb6UyYfr9NOMEx4ndbveWTw2bnKIDtaCRe9LGkufneNeKDHX
	 9lEiMmTmng2bfCRIzeUsoIAxyeQkTeerQVlo5x4xfaG8OYMYbs8KgASvWuejf0Ny73evY
	 d8VTL1mJrveK5nNNUery4WkS6+5tZ60k7snmhPVFFbTYqZY/Q9W2QgD1lH7hTwQ8HuDDV
	 7m9xnv3Pa3oVlTr5adZkTDr6CbGkzxntm1k/+mOIaU84D3imQRDLfzDuDBTVfODapKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lXa2AchWhcQsSea10nNai+tedxcsrEK3LOyVBhP51Y0=;
	b=loRsBw7HR3i7amclcj5GXIb+jDFpeb07zhC7tI7JJCG3MqeFVjN+fpcM1vfvQrr8guDi
	 Z3vWsFfkKT4WcRwuy+NMl9k1A8VR4R+/NrTK97IHtsQPX3t0Lym8a+vMo9c0Vz5uD2HjF
	 krcelRbH7WDdO/QQxXlZpXRF3a4dNTuoXMnFKI4W6gbDFH1IuVGKqdY8bBJkFdOq/9UER
	 XQZVMn5nBIDbpTmcDbCktnsPvc7VCwF1Qn1zXi0LWpE99+16IwH9i3NNR5X7o8qNpD9R8
	 MELqISRdfr/b99yc0DHoVZk+Hl7tNdpO9aoDVJ26B/r5fSjyP8XkgmWkOd1fKCICJwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=fRhW3hsa;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D70606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 19:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40D70606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=fRhW3hsa
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-368581df789so1345732eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1792782883; x=1793387683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lXa2AchWhcQsSea10nNai+tedxcsrEK3LOyVBhP51Y0=;
        b=fRhW3hsatCUMpov6em4vui6CaHgUFPBaMeu48uj0IrcQQhGl7jLkKrJVplz024QnsM
         bQmW5LANOmOpsj6DQq02mdI4taTw7DhvVi9Gg6SzTh2mUJs94GVzVDtLfx/yaAl2bpU8
         6niSsDgBIbgOU0lb6/FU4Tj1wI4Ork3FdElYjFHVkKDBM3XJk070EpawKt8F/Bifm3v7
         FNw/9aMFyqq7H1tBwSUG2ztHBScE1+W5lHLoreqowMKyRMgCakW+/RmW14vkMEo3SnV5
         DiTuSifX8B0hKQdb4zxyG5z6OFrASkC4WwLtqSoEMaIdGex5tW/x3whJuQZQ6xWQKsSG
         4CUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782883; x=1793387683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXa2AchWhcQsSea10nNai+tedxcsrEK3LOyVBhP51Y0=;
        b=iFtAZY4cYDqSQu9l/++XznHt6Wtdujd9CBreUagDQ5zVJl5rClSMiEkzmPzRJ1RFE6
         OEplhGXhYkiVZusQe6dXcrKPxGGK0vRadGRyDIPsV19N0pj1Tf7TKH0+ywqMTTA9JuFO
         M/gtTLPCAbjVgqDsSmTkCeTN7tdNf8kVTx6NgVEg9EUuI3k9nVHF5hDnvxFU91ITb8Gu
         Drw3oBlasWimM9ewuR7jtruetduWzKLf3RrUcFaZnglsg8TJy7kek1jvoUcNl3JyYNJI
         Do1zhG8CrFRXt6dmMALM2xp7Ail8z3V0DoSc1/jXnBjLlKqtOwg0SgnRJCCfOPIFqOar
         E5pA==
X-Gm-Message-State: AFq9FYLRjQqtuD+N8n25kE2DvOJY+AYfPf3QfRDZAXbMSLhihdeiLxWT
	Ug0otmkXgaoYOjmhyLvG8OPtx1rLK+DvKNozqtxwkD/T38woVsNQocbrzqh7YpLyQXhPj6dBswu
	wRmsGdwNNFw==
X-Gm-Gg: AYBFou1o/ufKuXrYuKLxD/Nx0xweL5OHXFB1uMWu/hw/b11egDoiTJRgiYwFzfO37L2
	7kVecSyo7jGnuqG1ApDxcdgvUtKVAY1m+O0Osv+rrJz11UTWwuxYFzBJPeWO3kqzopSG/wBBGBV
	J7ThvvbPqv+CjqgYYchl3QzRaLsDEnOWQQbX+ctsNBqrC962XzLDkdwmB9411BZAvG31Qpe/+qh
	mcQlQea+TYhismMEADUqt8n2asA/lI38CaNpM/tU5EuUWmkI2pHaG6sUYzXTA69+9RP1BLizDek
	o6CrZ9R8R17N98q0SVcpIrjp3K5+qQ3TKRa2VzxipK42AfEJ9FCHylRR1HFLtw4e0kYcUKsgrnw
	VanXsCHxkRV5pupHWsuiMJDuATrZyZYjJW5MJvXEv8g6XxBgUcmdEDETUXR9ELvtMuYB0SG2p88
	9T23U8HHw5+a3ATXzqWfkNxi+BO09/TdyCIycbTQmd+McZty1wC8Vdl/9HoXGorkWktvrVZNBAU
	5dZd28uK2p7TC8+DecHT3voNfDV/Mad1L+OjQL0msa9ijVCYSOiaTpCHCforimuzntnvFmiefN1
	YiGYiJ7dqmpWHowTHN+XGBICaBdMMy6WiQQ3KTlkpsoeOFVujBU9tz5Ieu+onSBYKC7ZmvTxL/N
	+OMvqoAlXvUdN+nOkd3AQeg==
X-Received: by 2002:a05:7301:db17:b0:35c:49b9:3166 with SMTP id 5a478bee46e88-369e877b1b3mr240962eec.6.1792782882925;
        Fri, 23 Oct 2026 12:14:42 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec4d73sm201657eec.22.2026.10.23.12.14.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 12:14:42 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH v2] Bluetooth: hci_event: Clear explicit connect state on LE connection
Date: Fri, 23 Oct 2026 12:14:37 -0700
Message-ID: <20261023191437.87024-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

Since commit 6cd29ec6ae5e ("Bluetooth: hci_sync: Wait for proper events
when connecting LE"), create_le_conn_complete() only runs once the LE
Connection Complete event has been handled, and le_conn_complete_evt()
has already removed the connection parameters from pend_le_conns by
then. hci_connect_le_scan_cleanup() looks the parameters up in
pend_le_conns, so after a successful connection it no longer clears
explicit_connect, nor deletes the parameters that were only created for
the explicit connect.

The parameters of every device connected through an explicit connect,
such as an L2CAP or ATT connect or MGMT Pair Device, are thus left with
explicit_connect set. MGMT Remove Device for all devices then keeps
them as HCI_AUTO_CONN_EXPLICIT instead of freeing them, and if the
device was set to auto-connect and is disconnected, they also stay on
pend_le_conns: the kernel keeps scanning for the device and connects to
it as soon as it advertises, although no one asked for it any more.

Do the cleanup in le_conn_complete_evt() instead, where the explicit
connect request is fulfilled: clear explicit_connect, delete the
parameters if they only existed for it, and put report parameters back
on pend_le_reports. Auto-connect parameters are added back to
pend_le_conns on disconnection, as before. Update the comment in
hci_explicit_conn_params_set() that names hci_connect_le_scan_cleanup()
as the only place deleting them.

Fixes: 6cd29ec6ae5e ("Bluetooth: hci_sync: Wait for proper events when connecting LE")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kevin Dewald <kevin@simpleble.org>
---
v2:
- Update the comment in hci_explicit_conn_params_set() (Sashiko)
- Rebase on bluetooth-next 27731ba091
- No change for the subrate case Sashiko also raised, see the reply
  to v1

v1: https://lore.kernel.org/linux-bluetooth/20261014224145.10801-1-kevin@simpleble.org/

 net/bluetooth/hci_conn.c  |  5 +++--
 net/bluetooth/hci_event.c | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 29da3fe2b9..5de95408e6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1614,8 +1614,9 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 		if (!params)
 			return -ENOMEM;
 
-		/* If we created new params, mark them to be deleted in
-		 * hci_connect_le_scan_cleanup. It's different case than
+		/* If we created new params, mark them to be deleted once the
+		 * explicit connect is done, see le_conn_complete_evt() and
+		 * hci_connect_le_scan_cleanup(). It's different case than
 		 * existing disabled params, those will stay after cleanup.
 		 */
 		params->auto_connect = HCI_AUTO_CONN_EXPLICIT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 56ad10ab96..982b67aef4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6041,6 +6041,28 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 			hci_conn_put(params->conn);
 			params->conn = NULL;
 		}
+
+		/* An explicit connect request is complete once connected, so
+		 * clean it up here: hci_connect_le_scan_cleanup() no longer
+		 * finds the params since they have just been removed from
+		 * pend_le_conns.
+		 */
+		if (params->explicit_connect) {
+			params->explicit_connect = false;
+
+			switch (params->auto_connect) {
+			case HCI_AUTO_CONN_EXPLICIT:
+				hci_conn_params_del(hdev, &conn->dst,
+						    conn->dst_type);
+				break;
+			case HCI_AUTO_CONN_REPORT:
+				hci_pend_le_list_add(params,
+						     &hdev->pend_le_reports);
+				break;
+			default:
+				break;
+			}
+		}
 	}
 
 	/* If we are central and have subrate parameters stored, queue a

base-commit: 27731ba091954eccddb2657053b590d2113e8d98
-- 
2.53.0

