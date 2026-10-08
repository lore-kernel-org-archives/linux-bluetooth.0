Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150AF4D7962
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472378; cv=none; b=VBKmOJwbeCpE3ScPcS8V6Csiphf1P8Jidgv4yVMOLLMPi55B/FvlBpv+/YK+GsApqViBckO8dfqec7BIF5uRj7g34Y4whqMFmgj/F0ZCgrUJgANnmkt5XFhoPGlPr3xQDYc4ZAYrISc24QG4ilQXz8Pu6URdJ5GlVf2+IRwLZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472378; c=relaxed/simple;
	bh=ujIhf5dXNFwk7pQ4zK4rhcG/WcsUBG2agGgkAUBKP3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5RuKEVrBa/oeei8Vqmk+y67zvjWgTynNyFxfBnI5fZ0LRaWQ1X9ky+WT2zjQ9a9eGjDDx4Lzob0cjali21CSPVKRuiRFSprBM54+ERviyJ9A8UOZSaOpCDu8iDRU1blxvTmbPY3ARH2sV1R4xZ3PPLhVmBg8h/IWv2L4WNCR3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXGK/E9E; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXGK/E9E"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535aa147d8so19938eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791472372; x=1792077172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsnzOzDPEjaVflvgYk7f5xErna+YXNMqhlw1VDbZP4Y=;
        b=TXGK/E9E8fKSoQBHZ+WDY5e664KIA7JIZqzKyp4Wyek7DaTo82RumzTm+iRP7aJ5/L
         IgeWojEWkOLWqO24qQFZ2rTvVfzb8eQoE8f64CSodJbRkXhhbx66ojuv1z0pDRlIXrxU
         kttfsCClvNyJwasHDSpKrMT0f28afKVg8sbsTP+6IjQhH8hVIa9Aq/4A5Lup0AFBdY2t
         yoh8o9V13t30humvlg3S9dAGka7NWp96blmSZ8MwMJmgNHtJAGG5inJrV1KVhFvY9gva
         rUQxoeUg0cCAubYwfnNYKRx0uUtakuzUEhck2EdyYQCAnKwrJQVklZZ0+AL3vG6uuUSX
         u2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472372; x=1792077172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DsnzOzDPEjaVflvgYk7f5xErna+YXNMqhlw1VDbZP4Y=;
        b=Ogz12a3JtCmfDfhfX4Rpujw1Ol/ZMm/XOgrVoLS/ggTvDToGa7yxcrmSCZVw3BlzOJ
         afnMGH4z++s4zmL+Rh98jEtVaBggy8HzF/A7FCpBRj8ZhaJuJfQIQh/au0PlCbg7KMPv
         4KOAEp8eE/+aY6+t2GI6CI9Bd4rtg2cU7JU6SkfiIk/srfiNESk0pNgK612diGnloHDZ
         G5bZAYb/Uw4l5XkX5K6EYUv4TVJkbSEvvyT8PmL+9ChOtUW/M2jRgwQjJpJ41MwQh1XS
         eaaTA4aMd8Qsi/ZcNAdQ3XCx5uvs0XiSzETSTx1/E/JaSD5EH+IcSvLQtyGS76a6d0zw
         GAIQ==
X-Gm-Message-State: AFq9FYKdhalHlZBN3hEr+x+BxT78hgxzgd9r7QKGUX5YLSEkFE/esmKm
	65UIWrBU6TBbW5c9kUiFVGVjYzVIhKdHt9Bt0yRVXBUR5UDctxzXcBzueonFay3lnAQ=
X-Gm-Gg: AYBFou1sVrsnn3o34v9z8FD51vgtYbsAQl4rsdnK0qdt897+1gMAY6Bt1lQ1ARtZ3ft
	iJN5yl0W4SdOcPozsWkehFxycD1oyBL8f/ZAqBCIud+NZjZxDVAgKXrT4TQTSOoXAw1A9nM3jGL
	xtprJ/WPrhL8ASXx/lCtJePtk4vI16DgihuCOFVb3zERIjz6aUzr097FF1yC5XkufWDqE5URdgT
	jKx8vlp+2smH6LO6nfArUedqViNtuv46TXl+CStwm6sjSDD5c90R4i8Cs5xa5+mG2Qv3HUXyilX
	zKV+L4Omxo7P/wotgqX701UxhgzqNdcbSmih9RDMtRi64G7P+uDehIw4DlLiQcpKoE8rzdZLne+
	Qt83E0nRUFpr5oOZZdyJMvD91bNsrODNtcbT4FUL8UtSvf27Hi6h2z6E9IMMKscHMKWbCnyv7P8
	vMykAwyaKedv4SKUALV5SYlgWNfMAxNSVd7GhiYcKynCjyhDm2gzZE7iD5u0oG8QtCNjWn/2i9o
	RjkkgfrTZSiIVS4MPw6ouHcD1dLawtFFeAxQI40
X-Received: by 2002:a05:7301:7307:b0:351:7e15:9c59 with SMTP id 5a478bee46e88-3517e15a574mr3527292eec.0.1791472371527;
        Thu, 08 Oct 2026 08:12:51 -0700 (PDT)
Received: from hitalo (190-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515afd00e0sm18052389eec.23.2026.10.08.08.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:12:51 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH v2 1/6] Bluetooth: hci_event: Don't fail a connected SCO link on setup errors
Date: Thu,  8 Oct 2026 11:12:33 -0400
Message-ID: <20261008151238.2138665-2-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008151238.2138665-1-enghitalo@gmail.com>
References: <20261008151238.2138665-1-enghitalo@gmail.com>
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

