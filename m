Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795815035;
	b=jrCwC2tXRTY3P1Pjhmpk7M3XGoXgmqQMg3/YRaRrYB4oGPbHSLb3UfsNbAFkABmrS4u7
	 K3H1b81ZysMTvpFuEG9Yi77liU7vrnp+/X4Gtjw+VZ3sxpEk1FAK4AxblaMhxORiGlABN
	 1xmKFnzbR720AH4X6I0FOj1caOZs/wM9ueP5yVt0d5+LpYjZPkHX2s9FljK8PFlonH5ok
	 QC5zzT5pGQjvO9w4JHCmzTKDhf5PDdQIpJfEHv7n6KN5WWZnbwxD7tUl2UwU4pCnGTiqO
	 xg6FckWDenuLzQA2iVnG71wGsx6X/nbpyFex2/KTf1cVc1Rg0slCJ2DSe6oGeo+N7Tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815035;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:From:Date:Subject:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UJtT0aIyIh0Gk17dDVlBriRNEz9k++e+jWmODb9dT2k=;
	b=F/x1nsDentKnuzlTZE4wYI/2D871JyNamvIBmT9SPzjk8dyzxnUUd+myUvqrvAj1Bzhd
	 R/1+q6YZjmqqAjOYv0XtMMmjgAfLXFQ5EXaE4ZXa9+IWpH0AT3JZgo/HzpLvc2RxtSrWO
	 VO/raEYuWNJEvHAQEwn6E3FBb0F2eC137ZS6OalbzOEhgo/2OrzhexPdntexHLjxn8j14
	 faHFSLbezz/gFxaC8DmdWEr0gPmAq8lp5CwDHQSqrQqqNrCJfHcc2fHAAMGCqFPKoKkPw
	 s1O8O9Y07c7wGyPIo1aZw18BwNLMOqe/NcuUzwV++obIi13M/v4GAt/7slTFjr3j1ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owP40oKZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4919606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owP40oKZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795815034;
	b=RAchHIUdSFei3Uya802eqMFnGkTBa+YHwAL6l568++g/X5zMv57RXaE8/YhRpH1n8ZIz
	 f/n/FhVfIaLnPtdfuTtWpLHYHaN0GYd2lodXTpQYkCJttDMZoxnEuutbn7XEPWlQvfzuj
	 mt56LkJPzx/bhiMyRmylC3xoJjCzgjeyrmxMsSSD0Y11I/QjJKqS6BMr9wQ6Ud0CCsgFb
	 0ZjhVdIBKk10pjXi7i9UKNt6BJNv4XR86th1V30uMYV3cVam8km9r11yXI5WAd9JNWDpp
	 KrfKf+LWNb9zT8OXBTRQORmAdjtyaJXWIbGWhDI73LADNuZFV6J+SjyNpbXzzruWrVg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795815034;
	h=DKIM-Signature:Received:MIME-Version:Content-Type:Message-Id:
	 References:In-Reply-To:From:Date:Subject:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UJtT0aIyIh0Gk17dDVlBriRNEz9k++e+jWmODb9dT2k=;
	b=Dv3Dnw6a3QN7gC24s64g/yzt6vgaXsdgV4oI4MPAPuVokeChZgox4/qiV/7X0QfopojW
	 9Od16K3zxyoqJ4iH/s8FMsAvZwrsGcm1k8Ld9su2A1G+VePpRoBFqOSfs940wS4rgP0oL
	 zEhPq6GkxyMkVsBfEqcNGKynuxayOzku31bv2Ce13uyuu2Mo0z9f5LjvL77exwOQz/PYd
	 JDrQdtubUoAykoOBXvOkbRoz2RoVLrZAc4YePiNerkP32xayIj/+GNPW+WoxXUx8fteeD
	 FHXRT5Ti+bQKa/Xt4c/R++5swWlcbIOBIOtDepQPponyDKj4MS+75AGYd/03L8K6xhw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0D7881F00897;
	Fri, 27 Nov 2026 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795815034;
	bh=UJtT0aIyIh0Gk17dDVlBriRNEz9k++e+jWmODb9dT2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:Reply-To;
	b=owP40oKZqVfk9bk4nnpkIqj2jWjANTrsd4cyc/F2H1QLU5I/j4HTolseU1MFEdKk6
	 Tw5ljMotQ0JTkQAxUwIm3SJNtlfudEzMbzwi5dwxAa6mMKpCkVkeb7S9rfeX2YMlPT
	 KW5FcDea0c74NnghHA1IB9m0XhRlmfGUrc/8inw8pE/5QdS9bjXhLPC2xKSqmfiXUN
	 jfyoniZq4IPIZ0hFhYBIASCTj8ionb2dUPPD78H1j+G7iCDCDt5CAo9DuYjx+6tfb5
	 D4SyEETxPv3EYSBCTYCcpWAVW0ilcLRV7XURwy4atZmVFRYiKMNbClFeee4CRZ1WVq
	 /TSLmXSdIIb1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 938DE4DE17;
	Fri, 27 Nov 2026 21:30:33 +0000 (UTC)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-bt-smp-n-v1-1-e123c04c15be@certik.com>
References: <20261127-bt-smp-n-v1-0-e123c04c15be@certik.com>
In-Reply-To: <20261127-bt-smp-n-v1-0-e123c04c15be@certik.com>
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 15:31:51 +0000
Subject: [PATCH bluetooth-next 1/2] Bluetooth: SMP: Defer IRK updates until
 pairing completes
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795814356; l=3994;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=xcwj8WZ/dFluIe0JR28QFFTUFzVXNxId8GhbSTKloLk=;
 b=elCItR9I9cQpbQOSPaUKRzfG+rE3idU7JaqIJ6IfCPuwosMaBlsp1BbJtNExgZnfUv6hZ91jP
 Bc02eR2U7Y4C47Tq3iJV/NbMjspnft0Xc1hdGp3aqmmt1I5Sp2mDjCS
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com
Content-Transfer-Encoding: 7bit

From: Dickson Wu <dickson.wu@certik.com>

hci_add_irk() can return an existing entry when two pairing contexts
distribute the same identity. Both contexts save that pointer in
remote_irk. If either pairing fails, smp_chan_destroy() removes and frees
the shared entry, leaving the other context with a dangling pointer.

Keep the received IRK in the pairing context and add or update the
resolving list only when pairing completes. Incomplete contexts no longer
share list entries, while completed re-pairings still update an existing
IRK.

Fixes: 759331d7cc66 ("Bluetooth: Fix clearing SMP keys if pairing fails")
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
This was found and the fix prepared with AI coding tools (OpenAI Codex
agents, with review by Claude). I went over the analysis and the patch
before signing off.

 net/bluetooth/smp.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 62a6b1e8f7cb..3a0fbc291878 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -111,7 +111,7 @@ struct smp_chan {
 	struct smp_csrk	*responder_csrk;
 	struct smp_ltk	*ltk;
 	struct smp_ltk	*responder_ltk;
-	struct smp_irk	*remote_irk;
+	bool		remote_irk_pending;
 	u8		*link_key;
 	unsigned long	flags;
 	u8		method;
@@ -763,11 +763,6 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 			list_del_rcu(&smp->responder_ltk->list);
 			kfree_rcu(smp->responder_ltk, rcu);
 		}
-
-		if (smp->remote_irk) {
-			list_del_rcu(&smp->remote_irk->list);
-			kfree_rcu(smp->remote_irk, rcu);
-		}
 	}
 
 	chan->data = NULL;
@@ -1043,16 +1038,29 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 				SMP_AUTH_BONDING);
 	}
 
-	if (smp->remote_irk) {
-		mgmt_new_irk(hdev, smp->remote_irk, persistent);
+	if (smp->remote_irk_pending) {
+		struct smp_irk *irk;
+		bdaddr_t rpa;
+
+		if (hci_bdaddr_is_rpa(&hcon->dst, hcon->dst_type))
+			bacpy(&rpa, &hcon->dst);
+		else
+			bacpy(&rpa, BDADDR_ANY);
+
+		irk = hci_add_irk(hdev, &smp->id_addr, smp->id_addr_type,
+				  smp->irk, &rpa);
+		if (!irk)
+			goto notify_csrk;
+
+		mgmt_new_irk(hdev, irk, persistent);
 
 		/* Now that user space can be considered to know the
 		 * identity address track the connection based on it
 		 * from now on (assuming this is an LE link).
 		 */
 		if (hcon->type == LE_LINK) {
-			bacpy(&hcon->dst, &smp->remote_irk->bdaddr);
-			hcon->dst_type = smp->remote_irk->addr_type;
+			bacpy(&hcon->dst, &irk->bdaddr);
+			hcon->dst_type = irk->addr_type;
 			/* Use a short delay to make sure the new address is
 			 * propagated _before_ the channels.
 			 */
@@ -1062,6 +1070,7 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		}
 	}
 
+notify_csrk:
 	if (smp->csrk) {
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
@@ -2540,7 +2549,6 @@ int smp_cancel_and_remove_pairing(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		 * remove and free already invalidated rcu list entries. */
 		smp->ltk = NULL;
 		smp->responder_ltk = NULL;
-		smp->remote_irk = NULL;
 
 		if (test_bit(SMP_FLAG_COMPLETE, &smp->flags))
 			smp_failure(conn, 0);
@@ -2656,7 +2664,6 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
-	bdaddr_t rpa;
 
 	bt_dev_dbg(hcon->hdev, "");
 
@@ -2703,13 +2710,7 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	bacpy(&smp->id_addr, &info->bdaddr);
 	smp->id_addr_type = info->addr_type;
 
-	if (hci_bdaddr_is_rpa(&hcon->dst, hcon->dst_type))
-		bacpy(&rpa, &hcon->dst);
-	else
-		bacpy(&rpa, BDADDR_ANY);
-
-	smp->remote_irk = hci_add_irk(conn->hcon->hdev, &smp->id_addr,
-				      smp->id_addr_type, smp->irk, &rpa);
+	smp->remote_irk_pending = true;
 
 distribute:
 	if (!(smp->remote_key_dist & KEY_DIST_MASK))

