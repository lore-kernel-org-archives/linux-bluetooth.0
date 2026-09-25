Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BBB503BCC
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379660; cv=none; b=WEWFYZQKL81c/2/HEz7IhVATkYMfiOIJGTRNHKHAdO8oPijPuvD10I16cgAkqM8SmW4NdyfkgLViCipoUY3eIRw/upsmnp37D0okF95ScUX8ib1xcn/OvdrX6iPU6yMGrfi+iATqHRjAQE3AlyZVhEK4YZjoMnbC0taGH3nVFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379660; c=relaxed/simple;
	bh=4tn+z6nsdXFypthL0a/NNtlTS+Y/MmhojwgHmh6trfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suJRJqJcXEYllkaMfabylJDJQVJ0ySOWPTPAJ9hHma1oT5S9B0nYFkjcftn8r4feU3mw6zpDQuGS3bDZkOBVZcLcinv7x3gHIN+YGmqqbm5acVIPvV37VkxbtPVO6a8/Kdzbvx2MItAdASrrEM2y+DNbpc4RLcIq+fovwfdZhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv7d5/vt; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv7d5/vt"
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3859292bb51so121340a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 16:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790379655; x=1790984455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y11ObLw8cL2ngxna/hD4dY/8DHB1v3g03JcfX3aXqN8=;
        b=mv7d5/vtAYGZRxBxafWIrRThvKtuqChqdPRPlGJpKh6maFg+5y0ODcbk/NxrrC4kTp
         5zbWrslTLN59mJ5jPqEysbB231QTXLR5DTfmHGXAoFMXIMqhBw9qR/ZcngT2H2CGQyWV
         Nk/05CwxUOeiNc3HMApeloCLw+H6i33gkCBBFoiSl/vecSUbYFobN403TSqa8SAiALhN
         rprCiXTZ+qZheybOis8datL/i9a4B5x1OROGi6GKtQfG+KA+lCZy9PW4FVw3ssUU9b5V
         TCMOIv28SRuON97ZQkynaxKdi4d5uGP2jXI3aKKd+p+PbJ8Hmn7lfRVboex9ooPFGl/W
         MYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379655; x=1790984455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y11ObLw8cL2ngxna/hD4dY/8DHB1v3g03JcfX3aXqN8=;
        b=XQoTHZBchQugv4aiH+0XZ1XvYXAkwfJZe6WNcOP6g8h+c25QKyER/KoOurCUPKHFAq
         ca25ML+pWhBxyAl2xVqjlbsBW3u4wpzUcxKnPJzp7fGQheUhrtfgZ/kff71dNaV9e6O4
         L8IMZTMu/VpCUZq0Cc62Rvsa7I04M+1uN4xwjxZA0PQvefeZd4jEImFGPKDQf+FLVAp0
         CCEUag7Rqog6aKvq7a0pSvT3QgkVMN9RSVr6d/ukJke46jVKihDGF15pkjgIaqRNy9WF
         kynvgdlGldfwMIIMjsfA9sO7ELbd/fGcMBPC1R0agrunAJAvO5NNFBGnCZ7B3P8N6Uci
         fslQ==
X-Gm-Message-State: AFuF++mEnYkABfIs0mDtrI6JsHl1uv2BY6+hm241fpeHQ46qkvUPteYs
	SLKrzks45oFB05A1xK/ktEnqKINI8Lp0jTQ6wb746GIPsWg8rGc4Bu5O9gS8xueWTi4=
X-Gm-Gg: AYBFou0TrEtOaMdUB3+lu+2IK7Cba2jDOwgvgVWEHJMfT4KfOhzbkYQ8TQnFFjpDGQK
	APb1co/vkEhC8W+CbDVq73eWiwrNVTSu8xZWoFQWnsY6gOiYqcguD4Ad6ZthEngi8wK5yUmQIgf
	lFHXXvOLYHTPlAu8tr79qmU58Y8reNH1pdXChSPgBMQthJGMw0AV5AprT3BqU9fQIKoRw9JrP9O
	bIo/h3wQGCqC+iE+dOBh5IBUt+XmEPvMlXGmo2x3zUbqJVcVeV5eHHpIbEz2K+/zmOS9X0zGM4f
	TDOr24vORM7Bvnhqun2ht/KmVLTuYEb/c28lHfXoggP51YN8Kl6y9Qk4jwtXA0h62PhUuTl2V8C
	u6+8C9Em3ClVFH99RT4tdl38VXPhOpExpCj9uYTmf0+K/J5LMvsIH7ZOMWWlWeFl8/gjEoM3Rzl
	Q9LUI9OhJUKBIOeOm+KQ5aTlgRfecp2E2W7Z7sy7vNKoylJSj4yNM/w7ne3eOPhE6L1Lf4dH3S2
	oFloqG358OvxtmcfbftYA==
X-Received: by 2002:a17:90b:2809:b0:39e:4c7e:bc3 with SMTP id 98e67ed59e1d1-3a0986a46b9mr4536489a91.17.1790379654850;
        Fri, 25 Sep 2026 16:40:54 -0700 (PDT)
Received: from pandar.dancher.net ([2409:8a28:881:a300:decd:fb28:f50d:71a1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b94936ddsm6706966a91.7.2026.09.25.16.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:40:54 -0700 (PDT)
From: Cai Yu <caiyu7372@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] Bluetooth: hci_intel: download the CcP firmware at 921.6 kbaud
Date: Sat, 26 Sep 2026 07:40:43 +0800
Message-ID: <20260925234043.707679-5-caiyu7372@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925234043.707679-1-caiyu7372@gmail.com>
References: <20260925234043.707679-1-caiyu7372@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CcP bootloader stops acknowledging firmware fragments when the image
is transferred at the operating speed of the driver (3 Mbaud): on a
ThinkPad X1 Fold Gen1 the 801 KB image aborts with a "command 0xfc09 tx
timeout" after ~4 s at 2 and at 3 Mbaud (3 Mbaud completed only 3 out of
11 boots), while 921.6 kbaud completed on every boot in 12.5 s (115.2
kbaud needs 83 s).

This is not a baudrate mismatch: the host divisor is exact for all of
these rates (verified through the clock framework and the dw8250 divisor
helpers) and short commands are answered correctly at 2 and 3 Mbaud - the
link loses a frame on long transfers.

Switch to 921.6 kbaud for the download and restore init_speed before the
firmware is started, which is where the operational firmware expects to
be: this controller does not follow a vendor speed change once its
firmware is running.

Speed measurements for the same controller and image:
 115200 -> 83 s   230400 -> 43 s   921600 -> 12.5 s (5/5)
 2000000 -> aborts immediately   3000000 -> 3/11

Signed-off-by: Cai Yu <caiyu7372@gmail.com>
---
 drivers/bluetooth/hci_intel.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 5926d1f..41f8e1a 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -36,6 +36,11 @@
 #define STATE_SUSPENDED		7
 #define STATE_LPM_TRANSACTION	8
 
+/* The CcP bootloader cannot transfer the firmware image at the rates the
+ * driver uses for the operating mode: see the comment in intel_setup().
+ */
+#define INTEL_CCP_DOWNLOAD_SPEED	921600
+
 #define HCI_LPM_WAKE_PKT 0xf0
 #define HCI_LPM_PKT 0xf1
 #define HCI_LPM_MAX_SIZE 10
@@ -539,6 +544,7 @@ static int intel_setup(struct hci_uart *hu)
 	ktime_t calltime, delta, rettime;
 	unsigned long long duration;
 	unsigned int init_speed, oper_speed;
+	bool download_speed_change = false;
 	int speed_change = 0;
 	int err;
 
@@ -652,6 +658,29 @@ static int intel_setup(struct hci_uart *hu)
 		return -ENODEV;
 	}
 
+	/* The controller starts in bootloader mode and does not keep its
+	 * firmware across a power cycle, so the image has to be downloaded on
+	 * every boot.  This bootloader stops acknowledging firmware fragments
+	 * when the transfer runs at the operating speed of the driver: on the
+	 * ThinkPad X1 Fold Gen1 the 801 KB image aborts with a "command 0xfc09
+	 * tx timeout" after ~4 s at 2 and at 3 Mbaud (3 Mbaud completed only 3
+	 * out of 11 boots), while 921.6 kbaud completed on every boot in 12.5 s
+	 * and 115.2 kbaud needs 83 s.  Short commands at the same speeds are
+	 * answered correctly, so this is not a baudrate mismatch - the link
+	 * loses a frame on long transfers.
+	 *
+	 * Use 921.6 kbaud for the download and restore init_speed before the
+	 * firmware is started: this controller does not follow a vendor speed
+	 * change once its firmware is running.
+	 */
+	if (hu->serdev && ver.hw_variant == 0x14) {
+		err = intel_set_baudrate(hu, INTEL_CCP_DOWNLOAD_SPEED);
+		if (err)
+			return err;
+
+		download_speed_change = true;
+	}
+
 	/* Read the secure boot parameters to identify the operating
 	 * details of the bootloader.
 	 */
@@ -807,7 +836,7 @@ done:
 		return err;
 
 	/* We need to restore the default speed before Intel reset */
-	if (speed_change) {
+	if (speed_change || download_speed_change) {
 		err = intel_set_baudrate(hu, init_speed);
 		if (err)
 			return err;
