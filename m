Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.165.48.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594339;
	b=bqkX5TFrqwYBoQgsTOKRiB6YitNmMLkLpplXcvlGHih1rXR2y5BEx1GJ1yLHhAKKrHk7
	 ROhXI9JosFyJKpcyAL3h0OAingiP/nFv0eUC0E7Rz7axTcJps2lMYudf8EFDpA4cxkMRZ
	 TuDpezrq3PhMK6/Oun/orf8+fSmHpZwzW1ZfFSLgAjhXBoaHEKBl+g8PgwZ5OvR244Q0+
	 mDBIElYZFNHsypZpI0M8qF1GYPe92e/oU4qnmqLTrmp0XfZ+K16AmoJ/AwxGs18mboWlk
	 RMqB64or5kENugQEgnkKoDq85oNnypG4DvhkgkMQbMILxpQ3yZeR0U6FN9uelcMzjhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594339;
	h=DMARC-Filter:Received:Received:Received:X-OVh-ClientIp:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:x-ovh-tracer-id:X-VR-SPAMSTATE:
	 X-VR-SPAMSCORE:X-VR-SPAMCAUSE:DKIM-Signature;
	bh=xir/Ekev5N4mjzLj0xcz0Rsjkx36hw6Go6Z6J+0jWHo=;
	b=PYBCq7PDsmlghAorj/da7gd/lFfa7FnR3h2FPtIzAQtObntqMZt+JLj7qWJ3+PU6NJ17
	 Vn0dg0ifaVHbuhBY+uu8HRj7EWyXD/JhdRV+pQ0pgL1rdNvH4hKnrnQyWquGpZs/yS/We
	 wiz5J4CFG9AwAgKCGNLHXLnMx4T9GRyvyuPnIcxzLiiUo1XkXe+VqTstlk8cIfZEdmC/8
	 A0TQprtiiaGPukSJQATXYtseCWZ7zZukGBsAdSeIK9Kmi+XJ3LnfB66wWyky2J1liQe6b
	 aPyfxw/lnBy3/ISWgb2dyEqG0n+39Bj2nZNSogiQrp6PAHvMhUyfbVi5Mt96nD0yLZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=medichon.fr;
	spf=pass smtp.mailfrom=medichon.fr;
	arc=none smtp.remote-ip=188.165.48.29
Received: from 11.mo550.mail-out.ovh.net (11.mo550.mail-out.ovh.net [188.165.48.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16D606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 14:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD16D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=medichon.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=medichon.fr
Received: from director8.ghost.mail-out.ovh.net (unknown [10.110.58.202])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4j8sgl4Hqkz5w1W
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 14:52:03 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-gl4x5 (unknown [10.108.42.75])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 786C6C0106;
	Wed, 21 Oct 2026 14:52:02 +0000 (UTC)
Received: from medichon.fr ([37.59.142.98])
	by ghost-submission-7ccd8bbbb6-gl4x5 with ESMTPSA
	id 8cfNEZLR2GrcIAwAWDeZ3g
	(envelope-from <abo@medichon.fr>); Wed, 21 Oct 2026 14:52:02 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-98R002b4da53ac-d7f1-47df-9405-bc8493e0641b,
                    05BFDA4BFEC350FDF8004146BCFDBCA9DF17BA8C) smtp.auth=abo@medichon.fr
X-OVh-ClientIp:88.190.90.129
From: Arnaud Bonnet <abo@medichon.fr>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	jkoolstra@xs4all.nl,
	skhan@linuxfoundation.org,
	Arnaud Bonnet <abo@medichon.fr>
Subject: [PATCH] Bluetooth: btmtk: remove redundant memory barrier with helper
Date: Wed, 21 Oct 2026 16:51:12 +0200
Message-ID: <20261021145112.64213-1-abo@medichon.fr>
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
x-ovh-tracer-id: 15101413975834975838
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTF9qtoi3tSx1+QKyIGt9BUWZHYs30HfsfJ2N49k4rfwYUqUlZ2ZgIzqSeydFiP4LSuTwqmOg9zF5YWJqS/oVWKN7RLL2AF8sFyMIQrrbxqeZj7yvACIYYYqjObN2xIS1wCyz52VyMYQNVsllMnPoDQb0DqTihkGkKfb59TBse/3+OWKaY1dMjcHNxqHFn24rMkjMIW5up31Bicg+rYyswoQsz7Q23WuDGippsnh5+kyR1H7HvzYgXx3rHEKI2dQ9NvpT36r1GqsvgV2JRixe7YG9tqI2yk9fUR1koSWYrOyfdl68h1QrvunaVV+/oWfkXcgomWU+mvKvTrc9zA0e+TkXFtQBOvN5pYavJzvdevntOnxqxM4CeIiDgKNyQkep3UK9VvK9KvJrv06hET7LPVN6oDssF4eOG7h+D23/KaT8iVVr6Z6kSVJ7YPZMwlb6tIN6kdSvSjXS+5ueZVGPpQNJBEGXA6g8HHS2WrJm+Iv1pgqFHUe20Yi9x5Ti3+Jqcs6y1aIR3h6PWNurLQgtXjJ8JYv1gR14qpead15J0ijbJCA9NtuN/XmheLoIynzvFWFFACM4AGzNrrktK9j/VTia9IVxoiiKGmnrnL2GpXpowHSa9yDzleCmryYX8/Z2xGnYgwgWWgyEUD6XUKE6866s11qfCMrQWEyAgTp8i503w
DKIM-Signature: a=rsa-sha256; bh=xir/Ekev5N4mjzLj0xcz0Rsjkx36hw6Go6Z6J+0jWHo=;
 c=relaxed/relaxed; d=medichon.fr; h=From; s=ovhmo3801317-selector1;
 t=1792594323; v=1;
 b=DR4MDDXn1q6Ibrz+eXo8ZjhVyasqFfbWAStu16K5UneoeqPiFqKBZF4SCghcmA+rUw1noZXu
 sZapgzGN58C/Xz3b/Zz65ympBiQlZRLsErq80QF/qSQXtWnUtHD73tqV0gPcLJBuy9VtfYpwpx8
 WtSw4suDL656bpjaOq6oy3k6fvwfbYHYHjc+33CTMU+l9mQGc7+l8Opi9DgaEDffrd+hjH7fsHy
 GcwaPrzxkTgiX3PrYG/Tbpiozh+ZLRHm9CWWpX+blsfFP4Dc2deifjYL/cNf5EMHrqdAEr1n/Ra
 lGwYiTmtZTvTs0SqUHRxczSOcwoi9wkmeKC9DTm4E2WaQ==

The test_and_clear_bit() call works as a full memory barrier, thus it is
not required to emit a barrier using smp_mb__after_atomic() before
wake_up_bit().

Replace the whole sequence with test_and_clear_wake_up_bit(), which was
introduced later in commit 52d633def56c ("sched: Add
test_and_clear_wake_up_bit() and atomic_dec_and_wake_up()") as a wrapper
for the correct sequence.

Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
---
Tested by building and manually checking generated assembly on x86, arm64
and riscv64.

 drivers/bluetooth/btmtk.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

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
-- 
2.53.0

