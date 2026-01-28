Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427B34D93C;
	Wed, 28 Jan 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594161; cv=none; b=Tw/a5TQJ6a1r1bFbYgp/G16usdIBGi3bq1hF9IqJkAz0HiVgZI7gdeayjWePaKhua2XK+fAeGXrwelK8Ciy9Was8eCC6vj74BFraDe0j1rsPVl47a3z/vJ3QWzmgXvoFZ8zOH2XP/qm7rDQSMh6MWZtPbKX1shMSuQDDm+J+hz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594161; c=relaxed/simple;
	bh=yk1FIvyoEPqAhkl2kx8p28tmn8zn2oKyb6WJYkA9S5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neNRR0qW9/M7DIlKKVs94htckoDxFSWC7TpQOpe7xuEGU4vX1qS6NLpvLdf5KDilABVzs+mPWuuyLbVmREBVNVzLhlPvmzD5R6iXSZOJaow/HQc9wfJCd7H/Ak5HfiRDKHhOjizYV3trTMmC/fJrfHyW2bs9B27mvbiC8o5oJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TxnPgQqS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mrXzxxt0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TxnPgQqS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mrXzxxt0"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGFJMl/POgeIcIQDzxkyyJOUi9lJfcsim0vwE3YsQR4=;
	b=TxnPgQqSTTn+rJ2WUCqR7N3+WJBA4py4P43Q/Tybyda7vMOvfkNFhKr1V9oPz42ejAd36x
	2hKAaoKNXJsYfw6X6T8tP8cU2MhYtdP+GPQwVdLz0UKXdhgeAQAkM/yQSQo4On4fHYTtYA
	SST8yILLFCbJg6bGHT6xYfTEV32/flco8zLEgWmtSH7xZ3p2nhMadD4z2LeJoJzfF6yqOb
	Fr3jBDeU9axYkeSfcNRi0rv0YHOTJ9LNC4f9Nn7y6vOyUWszMNwMw1kMI00DTwkTsTUHHh
	nwETpMxIivtX9V6jHzinNtNjJxCeFhJ4/Sweh9s9Vqtrqp94rBP42sZNTQm/pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGFJMl/POgeIcIQDzxkyyJOUi9lJfcsim0vwE3YsQR4=;
	b=mrXzxxt0i2k1TS7oIa61AYNPY5GLxhF7IgFZbEctXGQGxOhUvmq+nD2lWc09CfAsBqXS2n
	v29H52CiRI1cSQCg==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/20] Bluetooth: btintel_pcie: Use IRQF_ONESHOT and default primary handler
Date: Wed, 28 Jan 2026 10:55:26 +0100
Message-ID: <20260128095540.863589-7-bigeasy@linutronix.de>
In-Reply-To: <20260128095540.863589-1-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no added value in btintel_pcie_msix_isr() compared to
irq_default_primary_handler().
Using a threaded interrupt without a dedicated primary handler mandates
the IRQF_ONESHOT flag to mask the interrupt source while the threaded
handler is active. Otherwise the interrupt can fire again before the
threaded handler had a chance to run.

Use the default primary interrupt handler by specifying NULL and set
IRQF_ONESHOT so the interrupt source is masked until the secondary
handler is done.

Fixes: c2b636b3f788d ("Bluetooth: btintel_pcie: Add support for PCIe transp=
ort")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
---
 drivers/bluetooth/btintel_pcie.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_p=
cie.c
index 2936b535479f2..704767b334b98 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1431,11 +1431,6 @@ static void btintel_pcie_msix_rx_handle(struct btint=
el_pcie_data *data)
 	}
 }
=20
-static irqreturn_t btintel_pcie_msix_isr(int irq, void *data)
-{
-	return IRQ_WAKE_THREAD;
-}
-
 static inline bool btintel_pcie_is_rxq_empty(struct btintel_pcie_data *dat=
a)
 {
 	return data->ia.cr_hia[BTINTEL_PCIE_RXQ_NUM] =3D=3D data->ia.cr_tia[BTINT=
EL_PCIE_RXQ_NUM];
@@ -1537,9 +1532,9 @@ static int btintel_pcie_setup_irq(struct btintel_pcie=
_data *data)
=20
 		err =3D devm_request_threaded_irq(&data->pdev->dev,
 						msix_entry->vector,
-						btintel_pcie_msix_isr,
+						NULL,
 						btintel_pcie_irq_msix_handler,
-						IRQF_SHARED,
+						IRQF_ONESHOT | IRQF_SHARED,
 						KBUILD_MODNAME,
 						msix_entry);
 		if (err) {
--=20
2.51.0

