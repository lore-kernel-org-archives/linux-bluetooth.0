Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612158;
	b=w/01SFaXRVlaUgKgKLQgh55UjNRL8NF+NtauBHdA5Gk21kVjEMBXWXzIAB9h6KGzMxe4
	 g2B5s0PZmxAEkJf2b4nToBH9M+EowZfRMkpViZMspP/vIzO4CFCTvA5OwZH8e2LY6xlbk
	 A50M1ABzj0Q5QQGcnK2Y4AkfulCt6R84Kl7RhvZ+AuPW7Z5+7ByjmKq1k5tQV5sFrg71L
	 Dh5UaNd3E9h8fv7QY0HXq2xDP2aKE63/5+1NPy6BtSuF3mUn4fB7tggEszmDtezWd84aj
	 yaTiTghxBwQb7A8fQ0vXt+2JdfIeL/Qm7Pw+HL4+g0ZIrehZh/zs89m59kpA+vKjTJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s2Uai/Jx+DsKJXOsj9Tyr4955RyN79SwqNHEfqnOVlw=;
	b=i4gGgAoFftTNUb4Bbzu8uUa5cj9rqyHWRdfk0y7fl/+NDj6gQOxOnS15Gxyvfn4gXcVw
	 /SkEaRQhU+1PAEsBK4DMCsZ6Bvvh6TrINig5CCqOInHRDtH4xFJiH6FsMTjXRWqyJQc1g
	 Q53P2TsSA8G+bf1ax23P12M5BgSsaqvpJoHbIbXRfMIU3wHD0z6IqxMSxCJv3M+0Fe0PI
	 vYeSRRd9OIc30G/kYr7r6GyqRNw35PogsnrfgI7sh2v7WnAeE6a9bNr5QDIsqERaDtWEw
	 3g8Alc7OG40vh5q3vnruWautiuBjTVMMJk9iz+z4+d6kV/3hrkfe6hvwg3ogHjjVEBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lVKTEc2l;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27157606A32D
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27157606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lVKTEc2l
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so5903473e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 05:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612157; x=1796216957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s2Uai/Jx+DsKJXOsj9Tyr4955RyN79SwqNHEfqnOVlw=;
        b=lVKTEc2lNHdpTwKr8lglyGtOBtHeG9zD/QDgjI5phvAjvuQSxC/8xEkjYBC1CNulpD
         E5V19yYj/qLxSTAfqfTy52s/SOMdI/p83EjWJzlKYeBckAUhqxBaisun6ZqsChaZwLWK
         j8qyBtD96Sq6+kCSYXrTJ+93ASjHrV2XDjEjl4jzgLRW81n5163oJzLS6r1peth99zM4
         iMeGJY4WJmUaGgUKoDXg7oOpBPRaYwkH1S9yCuNqM87e/fSmBZigCKWZKLBTIOZOxBIx
         7AvJyYinYCcb7lw8QZNPmcfRua+ULTq5wBHdHwGSDCx4p+ZqyOem22ZXUPq0NxP5VkWV
         k4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612157; x=1796216957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s2Uai/Jx+DsKJXOsj9Tyr4955RyN79SwqNHEfqnOVlw=;
        b=OcxP3y7qCv0K5IPGl0P/nVsh/lPaeiGClWpWMW2fP70UrgR8heHeIFDTkDaqWsgdSr
         osbBb5syksfaa+q3Angsx8n+Sk0t8VBtwxJBVzguuI4fCTo9uPWbpCppwOwpsDz3g2ar
         bvf9ZYQKp+gFp0o9n4PhkLZYQljNV/x/kGiXbvi09TIq+W9qQSlyUar1lLfXEjVXfOzQ
         5KhSKeigMgIbnNi51ireuEQ2P5wf+f3sZ3z9HGPuPnBfB0eTPn5k0nXPo2zuFthftGFg
         KNlEbJn8nux+dBFcb97nR+CTKEIcJIR0l/o+yG8sgatyIjONE1PahtymTmXC45StL7Lo
         h+GA==
X-Gm-Message-State: APuU4Z+8YIV3IkxQ9Qff0Ns1IEXpznlcNOGPvw/09l126cgEaWhZs+it
	5KFP/l6gfIdS5C2pak6uvmpdEyLYsT6ZCOKMCTWyQghk6r2m54I4GoK2HbxbwFhQ
X-Gm-Gg: AZFdTZcPzNugXr5nD7TskJICKANwHS40nxCL9eciQVwCRJlYOT/8fVmCVBrl6xmxCY/
	1Zuw/S3t0AwQOyOu1RZQdu9mAajohfZtQh/JMagAQIMy8foj15nmLopwGRWRPAqc46iek/odgBb
	j+TR7uLEmnMjqYy5wUoLsUqvMbwEHrs9ALfQhWcm1yFXj2mD21/fgCUbVVhBflicuWaQAUzJs3M
	Avv+BwR09oxLy5JqPu/ip9P3Z7y5F2x989EjhBFW8vx6no+fOQxGogK91qIjzd4Uw6nMh8p+0bt
	+mzrw/aYtZcHGUHZ6g0PK/78z6ITCiQcQQhr5BQ+M2SH0RGCsLPFMebGOk8yrQBAWZv8k5dwQGm
	y8WbvvIStNCEplq6vdCRbJuymKlw6RD3/fOGz1mTq7hFttAXAAYRvEbGcGbturFkE/xCZKQ5qQL
	PFpXK6Vhw8EPdLI06tUgEi9Gh1kLMJIN3OH2qIqZMyhNhNJy31YrILW/qcbPc/zcKRNNa0D5Twm
	BcTJtuvwj/qJ+RmbZC9NpgK0NGpjTs44Fc0gW0J6fN862NWPM0yjTN5IcoSPQhaLv4n293V4uh1
	ibJ3qNTK8xEiYUr63EnlVX5auVRwhcJa
X-Received: by 2002:ac5:cf1d:0:b0:5ed:e8fc:b13c with SMTP id 71dfb90a1353d-5ee8261f236mr5261299e0c.8.1795612157012;
        Wed, 25 Nov 2026 05:09:17 -0800 (PST)
Received: from shine.local ([168.196.221.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b60b201sm17299447e0c.14.2026.11.25.05.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:09:16 -0800 (PST)
From: "Andrei A. Bykov" <andreiab9019@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: hci_core: preserve LE feature holds across encryption events
Date: Wed, 25 Nov 2026 10:08:28 -0300
Message-ID: <20261125130828.18441-3-andreiab9019@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125130828.18441-1-andreiab9019@gmail.com>
References: <20261125130828.18441-1-andreiab9019@gmail.com>
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
index 4aa0b49ae..68cce0628 100644
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
index 014207d2d..3ccd8027a 100644
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
 
@@ -7478,7 +7474,7 @@ static void hci_le_remote_feat_complete_evt(struct hci_dev *hdev, void *data,
 				hci_le_set_data_len(conn);
 		}
 
-		if (conn->state == BT_CONFIG) {
+		if (conn->state == BT_CONFIG && !conn->abort_reason) {
 			__u8 status;
 
 			/* If the local controller supports peripheral-initiated
@@ -8190,7 +8186,7 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 		hci_le_eks_oppt_encrypt(conn);
 	}
 
-	if (conn->state == BT_CONFIG) {
+	if (conn->state == BT_CONFIG && !conn->abort_reason) {
 		__u8 status;
 
 		/* If the local controller supports peripheral-initiated
-- 
2.56.1

