Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF125013C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677215; cv=none; b=kN+A6FwfexwNCW4YbfFSRxWeQPC9TQcmAb4o39ICKRnFKOkQT7TJo/52eI9WFt16q1sPUIgciwSAs3JbpTrcXRZyvAptDMZOAIPze10AxVLjGwthWm8GR3IWA3lRs6BdM9lhNM2F/taznUwQe5mglI8nVWY41HnjAxXrLUaMxzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677215; c=relaxed/simple;
	bh=Aiqfh+mFRo5Ii7dLiFrZeMDBfqsQSVq5e3O2NU0K6rg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ssuNESJkGPhk9T7Vhfn3BRpOgVJpuJUr1VQA9J7DHL/aUBXpvd+sLTojMbsYEV/E8bJrbffFHObHfXlX6oppRqohEzaY4zQ2irH/6CNK0u6vKT5ugfuPa22eXhPASHBz3D4kr1CXXM9EbjmykGdO28MdipusKKGtyiubtFpV1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RaAig+L5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RaAig+L5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790677201;
	bh=Aiqfh+mFRo5Ii7dLiFrZeMDBfqsQSVq5e3O2NU0K6rg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RaAig+L5QpI0mLAEBkfHmjQZqxjDEqpmU4/k2O9EcNFmI6miZ3LTRwCfAQKlsoLZj
	 QSbCofMn8uk0gqnG94sFlVg+PVnpfhwaPOoCnyN3ZAQdGdcd/4QtfsJT+Xli176qdv
	 nrfz3hOx+jdZqxIly38WEU7Y545dO7SQbjhSNFiP4yg/tZhWSTNRXCOVbsu+42j4gE
	 2qr+QEKeUqMEY8aLiMoCAOBEgSsS4lzcQ3vbM3fvDeZsj411iEreWXIeEmymCHF/lb
	 juIK4sxIXD1fb8nCUHAr62wcCIO67OuBlSAKXPOiHi1axG9ALg8kJmm3nWm8xVIy0V
	 YSMqO/7xhJXnQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 81E6717E0D7E
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 12:20:01 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 6/6] client: Display SecurityLevel in device info
Date: Tue, 29 Sep 2026 12:19:53 +0200
Message-ID: <20260929101953.254969-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929101953.254969-1-frederic.danis@collabora.com>
References: <20260929101953.254969-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 client/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/main.c b/client/main.c
index 314aead8c..8298fc9eb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2020,6 +2020,8 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "WakeAllowed");
 	print_property(proxy, "LegacyPairing");
 	print_property(proxy, "CablePairing");
+	print_property(proxy, "SecurityLevel");
+	print_property(proxy, "EncryptionType");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "ManufacturerData");
-- 
2.43.0

