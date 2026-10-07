Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED045C6E0
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387853; cv=none; b=r+RUaKml5Mrb1b5prp6PquUWVmz3heEQk5TvPpXpEAdASQzM0BW90Gr7JfhKhTZswnSE5NlDF+A/PMX2MrNE6XaFM+/aRC1gzBUChHN1X1p/tSb6Txaz7NXR79GVogD9FC8s+atCt8th/cKO8IAnwrmipZGy2mfwyp8DZlm95T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387853; c=relaxed/simple;
	bh=ujIhf5dXNFwk7pQ4zK4rhcG/WcsUBG2agGgkAUBKP3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piQZllHHWs0NOeDNwtHSthWao0thU3bsK66CdoEwH4Qk+PhQUB6KROeSTzgiPa4nKnIU+RccYkasuAW7lO5efgibFH0T93FcN04zURgXg4cO4rpBbsHccGEL81dMHUoNNL34A0FMrOteM9O5Dscxbp7uDUodGkDxA8EsbxHWXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8DtEe9j; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8DtEe9j"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34ba85727b6so529076eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791387849; x=1791992649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsnzOzDPEjaVflvgYk7f5xErna+YXNMqhlw1VDbZP4Y=;
        b=C8DtEe9jk54QNYEqefDgVoGWJ0U8LkXjRIwVpA5F3WNM3yUa0RA9POcOtH7WPQQune
         qaEi+AO3oqxqwpza9tMOyNHXMHTbDyQ6PEbv+xLlpkMJaH3lx8/+NfdVnmD1zWrWeCzY
         8qXwVvmSo49POGyK845bzBZhCdfUTOxFmTUGyrCtjsGW1M7voR7KF1FqJbrqLhZh3O+W
         sVwFcM8SqX12qDatO7bIwMndtO3+Ibr8mNFgmEsh2gVs3fm04jmwSocaF4RLojpfUQtk
         IRSc/8xbUO6ZlLbtFKd7GB5US2ssuiLNDH/aUMGChCuImJOA7LpK1SsdaF7zHUaoSju/
         24Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791387849; x=1791992649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DsnzOzDPEjaVflvgYk7f5xErna+YXNMqhlw1VDbZP4Y=;
        b=a5N+wkfSxxZFWv69fsoD9b0pbKxhjGLhABkbBCePe4Fvb301wV3E6CO7xeP0a41Hey
         ZVIiYLJ0lqSjadOQLKkrVKDg+8ojwjuE5wB2mEY50V84RT5EcYagvfaJjaMqO6iT6FiU
         4oGHryfmPR4G/VfhYiMrmCopSnOghacDm9eLaaAKbJgL7WuDPeI6t2me4sJCvq5xT7Cp
         N3rSg4EZ3YoPLhM/lehwr0zRdkXFUmVwgkZMwBDZym9DQKyS3JMr543qt2kTV0yttfd4
         DSjYdaBZs8X84BK7j8MxD3MMeNkKSZArnJwQJ/24K5pW6AKV9k/mrFOzc6mR+eN7kniG
         dP+A==
X-Gm-Message-State: AFq9FYK/lkclektSIE3W3NPD4pWLvjkchKBGEbkhJIgK/s50iTkIbrOw
	IzYMofWnlyytznVG+hH9BoKzfVHkvDG9G6kRf8+e9zODY7mMLd2PpmhmFB6KWBP8FPg=
X-Gm-Gg: AYBFou2Bnme85bbgVE9qx8fqbdTAxuajuPw6vwdrOPVHPog/bQnMSAqxZR7oquQem7v
	kwj3f54jKsz8BDzZ8b2ZPb2F0GDIeAVGhvbryBKGJbm6kIMSnp1xPL00nOUZPSA4nZpv/lEW0jS
	xpjynKKqHI6gO0G71LoKJcWvtnzb2SE+G97Aa2mT1UBWbYzgIF4ktKzWkd0SwM12jeVpf1N8CJo
	sQjipL+CuIG/sK14SBUsgFgleIKZ6S+su0d7cbAw4Mm39D4anZ4F/9SlPHL7wQkHX/2b22jJvcd
	Y0aO+ifGLlcGTah7ImJzZ/pFGrbmrzPAbnpOxs4OSQ9XImwz9OTsHMw7dEn8STK6BOM7Qkz9f+C
	xGHX+93RRb8jm8R4xu+oWDmzXq6ZcT60o7pG6zixe5hwwqGxIdFScHxQ5yX2ioYhAXx+JrOCZlF
	ECEuQnobjCmDRNEfQxneRuo01gd8nFRT8QMjTaophrTmuUoG4anrW5/71t1A5GV2fAJOPbihLV/
	RujmkBMjYNU4u9SflWqg/KVa+zSX8Q2ysdo51lU
X-Received: by 2002:a05:693c:400b:b0:34b:101f:cdaf with SMTP id 5a478bee46e88-3515dc1a998mr4087176eec.1.1791387849001;
        Wed, 07 Oct 2026 08:44:09 -0700 (PDT)
Received: from hitalo (190-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af7ab9fsm7876955eec.18.2026.10.07.08.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:44:08 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH 1/3] Bluetooth: hci_event: Don't fail a connected SCO link on setup errors
Date: Wed,  7 Oct 2026 11:43:51 -0400
Message-ID: <20261007154353.148223-2-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007154353.148223-1-enghitalo@gmail.com>
References: <20261007154353.148223-1-enghitalo@gmail.com>
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

Only fail a link that is still waiting for its setup to complete.

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

