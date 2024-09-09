Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40817D34D
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915117; cv=none; b=hgczJP6OFnPStMFDQAuNIlzEazUa1et1G3usW4nVWRPx9g2YybnL3p5C4OQnmeGU7uR19FC1KLHFmLylWSfKHmEVxbSPrGs9rF//UiHi0QAeWDbb3+kVHGa5kAb0Gk3XAG794VdTbmusALa+qe9yR6teIiE2sZaAskzn19Ws3co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915117; c=relaxed/simple;
	bh=tcUCb9xmZfo700ymB9sdx35jhmVGuQJvX1RRwfFxURA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z/neDH5Vh4vw+Djtb4QdUjjANEM6j+dfrmRiMHLhhBHc7rgPS9moQz1Wp+Vz6nrll+fsZFmG4GQJKLgSe7qznHlFf+Uprn0nKBu5FCjtTn6NUeLFCAk7UPwLZ1+3DLgRpk9YGyWJIPDBtD78bWSgDPX9A4sF2KKFwrEekHFEqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMOEzaG7; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMOEzaG7"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-49be3d534ffso994586137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Sep 2024 13:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725915114; x=1726519914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOjMWjBX1KZoKJpSXHwFJPFwCV8bjn+16s44LoVKoO4=;
        b=QMOEzaG7rzooAGSiDZiEu6ARrWkJCUfkDkmWxlLk9lh/uyZF5rPbrzpyYCa1z9MOjR
         NmMYSiwNJv4issluu93ZOXr6cNJjJkYUHbQaGgs4v3iGWv/5AHNxk27UhyKuEp+ZcCvT
         KRWWuJLYpHfyZtnUzhfaNtpby7kK+f28a200ujhQr+KvX1rwD7+zs8sl6UE0W6AdHRTB
         cR8xDrpHIUMhdDL6naIqRF+Q9QOdjE+6sUFPR+3mRO3q/a32bvtLLngsBtVdrMlw8GbT
         LB41KNRyeztPa28k0YZ6XAVZeRYihxM6Zo8Vj4bdowMPNaxx6OO1OEyhRln8jGje1ads
         xTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725915114; x=1726519914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOjMWjBX1KZoKJpSXHwFJPFwCV8bjn+16s44LoVKoO4=;
        b=czGBFE57ReUaP3RnIfvjiLC7kP29z2RXvEbvhMUTL3aOy4o8uSQnn1N9fiPWdPu3cz
         BnWHZW55tJaRiIsbvOprdK1zt1fMRI9/FY097X874F7BNUTPWJgpiurandABVJN9eqUu
         4enOb6XbxVDWo7kNjm/OP+oOmyDmwb4hDW7o/BtuaOGgqeK3gmAlypSRi34O1lNk8FjG
         uyYvKSE7D2bO8BoJfLV8TNc1D3rJcPXEippASUePNsRBZa11aVzwilj9PSrhBxhP9Qsm
         R4r9QHFUsRbH9MH+C07iJF5AQMCagwebqYAbvkiNAdnfaQM+vviyLNJYvXN0kuMtLPev
         lDgA==
X-Gm-Message-State: AOJu0YwflugsHyVtUmuV0+dM7iZk+BC7dysEKbGXnAm3WCk1HjradcdX
	jALr7j5R4L5MM0CHUeACE9e6ho7JCb4a70KoGJmMbcS+H41nSFmcTloLYg==
X-Google-Smtp-Source: AGHT+IEdGi69Nj3qgM8oG7jBbz6IELCbfDIhpHvlYIUCzGNpu67H+BfMJjV8t1DSIUYgl4MjSmOU7Q==
X-Received: by 2002:a05:6102:e13:b0:497:1b98:1f82 with SMTP id ada2fe7eead31-49c1527c59amr1678752137.6.1725915114059;
        Mon, 09 Sep 2024 13:51:54 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8489ac10ab6sm572927241.3.2024.09.09.13.51.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 13:51:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btusb: Fix not handling ZPL/short-transfer
Date: Mon,  9 Sep 2024 16:51:52 -0400
Message-ID: <20240909205152.2397337-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Requesting transfers of the exact same size of wMaxPacketSize may result
in ZPL/short-transfer since the USB stack cannot handle it as we are
limiting the buffer size to be the same as wMaxPacketSize.

Also, in terms of throughput this change has the same effect to
interrupt endpoint as 290ba200815f "Bluetooth: Improve USB driver throughput
by increasing the frame size" had for the bulk endpoint, so users of the
advertisement bearer (e.g. BT Mesh) may benefit from this change.

Fixes: 5e23b923da03 ("[Bluetooth] Add generic driver for Bluetooth USB devices")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 36a869a57910..83df387aea92 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1341,7 +1341,10 @@ static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	if (!urb)
 		return -ENOMEM;
 
-	size = le16_to_cpu(data->intr_ep->wMaxPacketSize);
+	/* Use maximum HCI Event size so the USB stack handles
+	 * ZPL/short-transfer automatically.
+	 */
+	size = HCI_MAX_EVENT_SIZE;
 
 	buf = kmalloc(size, mem_flags);
 	if (!buf) {
-- 
2.46.0

