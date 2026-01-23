Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA02741AB;
	Fri, 23 Jan 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168242; cv=none; b=Yn87pzQIwd0kaY77nAiBo538PVmlJ33sLTd9EV5u4u0OVYRV+hm3SoDKIpj6xvbWWBM2TacNMPum878ZSgDefrbkHSGzquw+9zxluYjWa8S1cXsSvaRIwankUDjFCKLJo2CQCTM2RVClXm1IyAwUI8KcGN9ZNDVq42Ql6MdcKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168242; c=relaxed/simple;
	bh=YIhD96ncLAqKhFcbwSqeqDW2wIh2UJYFEu5TkwwbpNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7bKa/GcRDG3vs2cQqgEGdrrt65YIYg3JGUFa/jAx04vuVWtdjJ7dWNYk+UVvijC6dhkE7wYiCGZTCSmuDWoiRVra1RYFIGgKN/u5EpuFelizd9BSfZR0YB9RKpRTPtZ9bTikxwObq5fwhKzWZOqUkCsl14WksEJNr7iLdxQKoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cEGwOmPi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vWOEIsaI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cEGwOmPi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vWOEIsaI"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/ZYBRVF2SmSOTJgqZxlAZTKkgmnbGKkRQ21DEWSGPI=;
	b=cEGwOmPi5La98B4JXmUIoevawntGMHSmZXgXJkY0A3BPnF4a4VgiygzYn3H/+oFlwVsuFa
	6L+IQ2xMBPslec7T0utzw+CI4xmQJ2VJpU1DDyumhN3znqN00wN8/TuNeiXCIUOdbn3JXI
	9rSt6LnNXIYSMxnHOR0yQ2GcIeJVYEEI0CBcsPta+YJAO6ZyufU5dRkok4/D3UGZhneM4a
	N73xuylTLZ5wwa0sEaIxoife+7HxavQ8q4sb5G67suYHllwsf3lwe+LU3YTWoC3VQar/oc
	cS26bgRWJZtC3CQaol8lr1kRgi7HivBMcq9x9f0aYHKbj6iVJ8982ryrr/HIGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/ZYBRVF2SmSOTJgqZxlAZTKkgmnbGKkRQ21DEWSGPI=;
	b=vWOEIsaIiCIm/vIBSrS9XtufRCaT6M31Kj4x8qo2YxaiBhCnF/kLnXq2GvCmA9K4PC6qj1
	jRqJxWaokcwUVoAw==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/21] Bluetooth: btintel_pcie: Use IRQF_ONESHOT and default primary handler
Date: Fri, 23 Jan 2026 12:36:52 +0100
Message-ID: <20260123113708.416727-7-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
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

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Fixes: c2b636b3f788d ("Bluetooth: btintel_pcie: Add support for PCIe transp=
ort")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

