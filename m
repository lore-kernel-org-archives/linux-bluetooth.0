Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.105.50.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748266;
	b=ag++Nm4ComEOJxXNTHsFKlnyJuDa0ecW7jqtL8UPKtzShoKSC04pHf/sAgEs9iJoVJNF
	 06eCpxwV0xmchFEfPaHq20wvjj11YxImW/TmCAkpjdPAgtIZSK5iR84VRdhOQ0OeTV1XA
	 0baEMYF6TwR3eiPID4Tc5IfyyMAarg5tAK8StpdHuzxfgpwLlIMC+w74rZdw4C18CXpLu
	 IMh2TO7/K1Z+Fbmd6Q5jYshRvqfkIde9eRkILiLSnqtY92G8xrkHY/8c9c2Fjv1ssfXnz
	 KZxeT6F+mr0qXi4VLK+U05e67WX8eRDUED0f+71FKCzlwUU0VYGZJFEzGYPVnQagQCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748266;
	h=DMARC-Filter:Received:Received:Received:X-OVh-ClientIp:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:x-ovh-tracer-id:X-VR-SPAMSTATE:
	 X-VR-SPAMSCORE:X-VR-SPAMCAUSE:DKIM-Signature;
	bh=ZRRTB6tWjdlBw8MET61qHeq4ie6fC3tCqKffLXdLHGw=;
	b=ZGBYEsxej8BWNHiT3nnGDIKBEJO9XWFzS7X2rvUMdMynSxP1tMixF+notvhNsDbEoMOI
	 AejIph1E4th007Busnwy8DN1EFg3ch6bARW3OW3J1/ia2ESEurINCaDSONLFKKwzYteZ7
	 8CcUPEi9LorITfKJ+/afhhhFo8qUpvf+zB3YvCgr0wODGbEzPSDliyUWhWu4osFnMAYMq
	 pploZcoXtEEivGmltzT5PQQcC8zkfraII1ur7gm8CUFvscAU2YFmjO8Tlh1HRCvet2LB6
	 Zsx+gfp3bdg1vw373W9grtl7zdsBOD9+9HAPiVGekkkPuw1MLfcWfWGkdT5VAeG7wMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=medichon.fr;
	spf=pass smtp.mailfrom=medichon.fr;
	dkim=pass header.d=medichon.fr header.i=@medichon.fr header.a=rsa-sha256 header.s=ovhmo3801317-selector1 header.b=P4tTyd3a;
	arc=none smtp.remote-ip=46.105.50.107
Received: from 6.mo576.mail-out.ovh.net (6.mo576.mail-out.ovh.net [46.105.50.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC8606A31D
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 09:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EDC8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=medichon.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=medichon.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=medichon.fr header.i=@medichon.fr header.a=rsa-sha256 header.s=ovhmo3801317-selector1 header.b=P4tTyd3a
Received: from director2.ghost.mail-out.ovh.net (unknown [10.110.58.177])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4j9ybz6TQfz5wkl
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 09:37:35 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-zbd2p (unknown [10.110.118.184])
	by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C9321C0CB1;
	Fri, 23 Oct 2026 09:37:34 +0000 (UTC)
Received: from medichon.fr ([37.59.142.113])
	by ghost-submission-7ccd8bbbb6-zbd2p with ESMTPSA
	id ZeeuKd4q22pW2Q8AKSMJ1Q
	(envelope-from <abo@medichon.fr>); Fri, 23 Oct 2026 09:37:34 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-113S007ae3fb8dd-bd0d-495b-af3a-0693ed38505b,
                    4E1EE381F50BCC5D3752DB0F3D6F19972A1B9F27) smtp.auth=abo@medichon.fr
X-OVh-ClientIp:88.190.90.129
From: Arnaud Bonnet <abo@medichon.fr>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl,
	Arnaud Bonnet <abo@medichon.fr>
Subject: [PATCH v2] Bluetooth: btmtk: remove redundant memory barrier with helper
Date: Fri, 23 Oct 2026 11:36:45 +0200
Message-ID: <20261023093645.4669-1-abo@medichon.fr>
X-Mailer: git-send-email 2.53.0
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
x-ovh-tracer-id: 3089187869984448094
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGf4WNQZ0/WeHRcS6TM/enV/U+1qGPNziH1nIWDvG6Wto+nBvFkEow2wKE7yLTnGtVIBD2118czGEHUWj/jjTzEQOeYGI0FGh95bU9KniKIV4jnMOzYP31ukUi5L7CWzokui7KbPq1dmv1qnZfZ1Tjuu+EZUqRJfnA0D6NsulA434OcXpbYBPaT4PYFod/qhYxAb8s6YBR0Uzi2awK4UJcspK2G0KdA9qgLovw3YpK/MUgEyXPMbs3fX4Xo9rXvB5sqp40ILyigKduE+dksw2Ai3mahF2m2fnLByorxkyu9588xr8RnqFdPO8bSGs/oUdXgVYM7k82XFcIHmLi21E57YlQ5o1ZaNhgLiyIGLh804Ler2iICvyzFf/oRDOSJ3Jx8FKv5ZNfUQb/n80sp3snzvCf9LLXtwOH0jIHudWT+amOJL/vvF9GIV6Cfji8uCHHLlAgrKvSEQ/PxVtD5n3+Q0eIk4VB7jvIy1TWJ8s5TEdOYMNdwBOuV2ehzXM+V3sl8tKWZPCg3eroFnfW3CUGPTxLam86laGnmO+Stfg9uz465VWQsI9WwPBl4Qcab51ZXzJFpEI8mzbrrxD6IzoUERTvEwNev1SJfOB+/adwyuhAB8LBE2X59xVpX+VMeHMUO5RIQR7ADsE9zsXDn1rUGaf3K6u2fpCA7+abNZiWGBQ
DKIM-Signature: a=rsa-sha256; bh=ZRRTB6tWjdlBw8MET61qHeq4ie6fC3tCqKffLXdLHGw=;
 c=relaxed/relaxed; d=medichon.fr; h=From; s=ovhmo3801317-selector1;
 t=1792748256; v=1;
 b=P4tTyd3asudec34GpxvJux8V+IWF0PdqbsbK/GR5HeTLf5hQCrQxnkOfjV6JKSABr/hgzpJr
 hcL4ix0BmCiLtdhvfjp17KzWk/lZeGlqPpufTg3kN6XA/+4Y4Xi+cWrkVcM0TEUehealpAAH6Ak
 kFymHcNe9A062Mx4UB/40XSQ+IOPOxGAKNrf8FzgH4JfU3AXunqXkNx/8A9rrIQ7I4IJNIDrjHr
 fS0nv10FzSDyBjTXM3uOv3wVR/7Cco5ghPb8CUsTt0Xi7AEy0u0YRG8QUhh/EgyurJjy1sm6ZjJ
 GVfaEN8f5qZcB/vmh2+dxMSbSLDhsWJYh6GPKQ4VpGOHw==

The test_and_clear_bit() call works as a full memory barrier, thus it is
not required to emit a barrier using smp_mb__after_atomic() before
wake_up_bit().

Replace the whole sequences with test_and_clear_wake_up_bit(), which was
introduced later in commit 52d633def56c ("sched: Add
test_and_clear_wake_up_bit() and atomic_dec_and_wake_up()") as a wrapper
for the correct sequence.

Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
---
Tested by building and manually checking generated assembly on x86, arm64
and riscv64.

Changes since v1:
	* perform the cleanup in btmtksdio.c and btmtkuart.c as well

 drivers/bluetooth/btmtk.c     | 8 +-------
 drivers/bluetooth/btmtksdio.c | 8 ++------
 drivers/bluetooth/btmtkuart.c | 8 ++------
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 75483d8230e1..a620e24b6c17 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -607,13 +607,7 @@ static void btmtk_usb_wmt_recv(struct urb *urb)
 			return;
 		}
 
-		if (test_and_clear_bit(BTMTK_TX_WAIT_VND_EVT,
-				       &data->flags)) {
-			/* Barrier to sync with other CPUs */
-			smp_mb__after_atomic();
-			wake_up_bit(&data->flags,
-				    BTMTK_TX_WAIT_VND_EVT);
-		}
+		test_and_clear_wake_up_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
 		kfree(urb->setup_packet);
 		return;
 	} else if (urb->status == -ENOENT) {
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index b9563df72983..b6e16716b169 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -442,12 +442,8 @@ static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		goto err_free_skb;
 
 	if (evt == HCI_EV_WMT) {
-		if (test_and_clear_bit(BTMTKSDIO_TX_WAIT_VND_EVT,
-				       &bdev->tx_state)) {
-			/* Barrier to sync with other CPUs */
-			smp_mb__after_atomic();
-			wake_up_bit(&bdev->tx_state, BTMTKSDIO_TX_WAIT_VND_EVT);
-		}
+		test_and_clear_wake_up_bit(BTMTKSDIO_TX_WAIT_VND_EVT,
+				       &bdev->tx_state);
 	}
 
 	return 0;
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 4af6fbbbd302..744a87acaadc 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -229,12 +229,8 @@ static int btmtkuart_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		goto err_free_skb;
 
 	if (hdr->evt == HCI_EV_WMT) {
-		if (test_and_clear_bit(BTMTKUART_TX_WAIT_VND_EVT,
-				       &bdev->tx_state)) {
-			/* Barrier to sync with other CPUs */
-			smp_mb__after_atomic();
-			wake_up_bit(&bdev->tx_state, BTMTKUART_TX_WAIT_VND_EVT);
-		}
+		test_and_clear_wake_up_bit(BTMTKUART_TX_WAIT_VND_EVT,
+				       &bdev->tx_state);
 	}
 
 	return 0;
-- 
2.53.0

