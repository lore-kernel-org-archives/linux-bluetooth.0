Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D137F74C
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167552; cv=none; b=nHvaXWCVyMR4PGR6JCB4E/YdVfNBwxWgGcQvt6Qf3il8oBejjH9w5qHcQeer8kbNAc0lMzNSLCqp/k3ajSjxmET6diTAbQy8gSk5jcZyx5dq97+thnwAdTZ/WjQIBu5p5y+E/t9D2RIH2FZt1BnA9DbWERHTsucHkizABQACdYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167552; c=relaxed/simple;
	bh=Ja3b/MXQK3SU070zBRG9MtfNTmonmTqhuXeRxJr9kCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JgGRaTIKnApCCIaETlZaxQXDgfPRd64cZVqCS6xd3M23MWBltEuXyYG4ZC9uQ2JuD0kTxoSRYR/ezETFJJ+1pxCTppyebS4vUO9UC7jCCL+FtYvEKkpXTwgI/pI0/bo/zO/3bmu9i6z5OAJ6gdWhXtnkWggz3siHFSOdvGh0ZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=Z1sZmOyh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="Z1sZmOyh"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f752b3423so1775964f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785167549; x=1785772349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weD0rbd4+5EXM6jyP/vcBkJFQ4s57OIU2OfRCbgEcig=;
        b=Z1sZmOyhda3qrMA9SLerMXtkAsfvjJQXog+3SvWlqLPr0yUBVF4mWPwk4fdZoYx3jT
         fG3F3Sy+GhSbmpnNFXtPnWktQ3U2sFhrGPgoSvXcj9Wx0ooDjeXqMQ2YniesUrrXo917
         SU6lML04A+jwvhtplTLWS9q3HCDCFYSqw3s6CtjQyrNBn/2v/rJkN5LCxnjazKI7/F8F
         IwNzPv+eAwtYzUrGlCmk4/0uiUoca677i7FGpP/D96RYc4opvKiAlyPIrYmEhV+jsuwi
         R37OTFQodLcpgQXukVMKBzYisrCJfS1Jbi3oXgR8/eOaUWsijjgyKHDXiUKfSioWUgcZ
         b2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167549; x=1785772349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=weD0rbd4+5EXM6jyP/vcBkJFQ4s57OIU2OfRCbgEcig=;
        b=qcuX/2w6+I8hWcMfyPSM7ePkVhkOUlxh8Bir6PyS8PcmFS2SU0xiJEpDAoYYrGSaUd
         VSFu6O5sAKVzEF6O8ZrohcTcq3+roVWs4wu25juSKZvoEDSdsQZcFMgTfQYF0qKTFbAj
         evksU4hRsCxhv8x+m4lcPmuZVywfCIyB8njX7T0BJx0oraqW/p4hMP7yA73AxQtEGYvn
         n52Nk5iCOpcYUCCwTZFKt518/qJdaxozlqzn3BG3rTuWja3c7iEqq0OzO69vs/OVvPao
         c2wJD8Y/yvkeVRm7FEUjuYb9CmN4cGsrCVQW3TWluvtXORGzKP7GPqDck5JK7eaEAQi5
         YRAA==
X-Gm-Message-State: AOJu0YxPxkKhGFGtfoT1cPDkOQzbutmtc93dcZ+qv48OsIg0EvKBekqI
	WlH4B1c1KuOT1APcQx/3Y3iCgxcJXjmzdIaOBU0MM8Z6Gjz6+pPUaN/LbpzK5VzANRI=
X-Gm-Gg: AR+sD11+iB7Ft7PfpXwuGEJ175oqaAkb4Qh/GW8FKJZsZ0Rv1xaoAJ08QlXPgaYimQ1
	9i5RZqspAlxDUSmBRaiZl/7NlZCXO4o+s4wEfRkG1/FmZhuMTy2znYoJQy0lQf8IUXIYS/U1hZ+
	1tNi8TEgXM0sKQlY8MQafhv8AixBUwuFgZJlrNuW1ics3vQCwHlnz8+eQUX2SFpWj5//zCCIZDI
	wWbsfoGGiybGmwJWpybND1dP26QYfKhbgPPrT1xTECWr6S2QfVytNEuHUtIyfBWrR74mLhYw198
	TMBXlMK7IPekZZWQALRwXE1bFPiWgbfpmUlfu0hGOLGYZFv0ZQUaYFHEt9YS1lqoOzlWTwaCX3v
	ozW5ac2r9EuuGw0Wd+Ningudi7COglEtsvZkVUSSF8VQmsjWX7Y89BDiHqw17dGChX/eg5SrWPM
	tLSb6GZPRWvMlTrxvbK0U=
X-Received: by 2002:a05:6000:41e9:b0:462:e086:35f with SMTP id ffacd0b85a97d-47f9fc9c6d3mr11694862f8f.21.1785167548935;
        Mon, 27 Jul 2026 08:52:28 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fa9sm51005161f8f.20.2026.07.27.08.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:52:28 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 16:51:51 +0100
Subject: [PATCH 1/2] Bluetooth: use a named initializer for acpi_device_id
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-acpi-bluetooth-v1-1-b5558d53e6e7@thegoodpenguin.co.uk>
References: <20260727-acpi-bluetooth-v1-0-b5558d53e6e7@thegoodpenguin.co.uk>
In-Reply-To: <20260727-acpi-bluetooth-v1-0-b5558d53e6e7@thegoodpenguin.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785167547; l=10992;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=Ja3b/MXQK3SU070zBRG9MtfNTmonmTqhuXeRxJr9kCA=;
 b=YJ73/YIqCiyr/vIYyGSiLUiXYmypjvfpW2utq9i+Nw71F9839qNvRUz5ONX7UufuBwTwY6U2v
 XjB552ytzJiCHb68oTOgLgWu7d7zpT4lYAt4i8ZNrJhW3ayKTvNE1Gf
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a named initializer for the acpi_device_id fields which
makes the code more readable and consistent with how lists
are initialized in the rest of the kernel code base.

While we are at it - unify the list terminator to have
a single space between the brackets without a trailing
coma.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/bluetooth/hci_bcm.c | 336 ++++++++++++++++++++++----------------------
 drivers/bluetooth/hci_h5.c  |   6 +-
 drivers/bluetooth/hci_qca.c |  12 +-
 3 files changed, 177 insertions(+), 177 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1a4fc3882fd2..01da3fecb536 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1314,174 +1314,174 @@ static struct bcm_device_data bcm43430_device_data = {
 };
 
 static const struct acpi_device_id bcm_acpi_match[] = {
-	{ "BCM2E00" },
-	{ "BCM2E01" },
-	{ "BCM2E02" },
-	{ "BCM2E03" },
-	{ "BCM2E04" },
-	{ "BCM2E05" },
-	{ "BCM2E06" },
-	{ "BCM2E07" },
-	{ "BCM2E08" },
-	{ "BCM2E09" },
-	{ "BCM2E0A" },
-	{ "BCM2E0B" },
-	{ "BCM2E0C" },
-	{ "BCM2E0D" },
-	{ "BCM2E0E" },
-	{ "BCM2E0F" },
-	{ "BCM2E10" },
-	{ "BCM2E11" },
-	{ "BCM2E12" },
-	{ "BCM2E13" },
-	{ "BCM2E14" },
-	{ "BCM2E15" },
-	{ "BCM2E16" },
-	{ "BCM2E17" },
-	{ "BCM2E18" },
-	{ "BCM2E19" },
-	{ "BCM2E1A" },
-	{ "BCM2E1B" },
-	{ "BCM2E1C" },
-	{ "BCM2E1D" },
-	{ "BCM2E1F" },
-	{ "BCM2E20" },
-	{ "BCM2E21" },
-	{ "BCM2E22" },
-	{ "BCM2E23" },
-	{ "BCM2E24" },
-	{ "BCM2E25" },
-	{ "BCM2E26" },
-	{ "BCM2E27" },
-	{ "BCM2E28" },
-	{ "BCM2E29" },
-	{ "BCM2E2A" },
-	{ "BCM2E2B" },
-	{ "BCM2E2C" },
-	{ "BCM2E2D" },
-	{ "BCM2E2E" },
-	{ "BCM2E2F" },
-	{ "BCM2E30" },
-	{ "BCM2E31" },
-	{ "BCM2E32" },
-	{ "BCM2E33" },
-	{ "BCM2E34" },
-	{ "BCM2E35" },
-	{ "BCM2E36" },
-	{ "BCM2E37" },
-	{ "BCM2E38" },
-	{ "BCM2E39" },
-	{ "BCM2E3A" },
-	{ "BCM2E3B" },
-	{ "BCM2E3C" },
-	{ "BCM2E3D" },
-	{ "BCM2E3E" },
-	{ "BCM2E3F" },
-	{ "BCM2E40" },
-	{ "BCM2E41" },
-	{ "BCM2E42" },
-	{ "BCM2E43" },
-	{ "BCM2E44" },
-	{ "BCM2E45" },
-	{ "BCM2E46" },
-	{ "BCM2E47" },
-	{ "BCM2E48" },
-	{ "BCM2E49" },
-	{ "BCM2E4A" },
-	{ "BCM2E4B" },
-	{ "BCM2E4C" },
-	{ "BCM2E4D" },
-	{ "BCM2E4E" },
-	{ "BCM2E4F" },
-	{ "BCM2E50" },
-	{ "BCM2E51" },
-	{ "BCM2E52" },
-	{ "BCM2E53" },
-	{ "BCM2E54" },
-	{ "BCM2E55" },
-	{ "BCM2E56" },
-	{ "BCM2E57" },
-	{ "BCM2E58" },
-	{ "BCM2E59" },
-	{ "BCM2E5A" },
-	{ "BCM2E5B" },
-	{ "BCM2E5C" },
-	{ "BCM2E5D" },
-	{ "BCM2E5E" },
-	{ "BCM2E5F" },
-	{ "BCM2E60" },
-	{ "BCM2E61" },
-	{ "BCM2E62" },
-	{ "BCM2E63" },
-	{ "BCM2E64" },
-	{ "BCM2E65" },
-	{ "BCM2E66" },
-	{ "BCM2E67" },
-	{ "BCM2E68" },
-	{ "BCM2E69" },
-	{ "BCM2E6B" },
-	{ "BCM2E6D" },
-	{ "BCM2E6E" },
-	{ "BCM2E6F" },
-	{ "BCM2E70" },
-	{ "BCM2E71" },
-	{ "BCM2E72" },
-	{ "BCM2E73" },
-	{ "BCM2E74", (long)&bcm43430_device_data },
-	{ "BCM2E75", (long)&bcm43430_device_data },
-	{ "BCM2E76" },
-	{ "BCM2E77" },
-	{ "BCM2E78" },
-	{ "BCM2E79" },
-	{ "BCM2E7A" },
-	{ "BCM2E7B", (long)&bcm43430_device_data },
-	{ "BCM2E7C" },
-	{ "BCM2E7D" },
-	{ "BCM2E7E" },
-	{ "BCM2E7F" },
-	{ "BCM2E80", (long)&bcm43430_device_data },
-	{ "BCM2E81" },
-	{ "BCM2E82" },
-	{ "BCM2E83" },
-	{ "BCM2E84" },
-	{ "BCM2E85" },
-	{ "BCM2E86" },
-	{ "BCM2E87" },
-	{ "BCM2E88" },
-	{ "BCM2E89", (long)&bcm43430_device_data },
-	{ "BCM2E8A" },
-	{ "BCM2E8B" },
-	{ "BCM2E8C" },
-	{ "BCM2E8D" },
-	{ "BCM2E8E" },
-	{ "BCM2E90" },
-	{ "BCM2E92" },
-	{ "BCM2E93" },
-	{ "BCM2E94", (long)&bcm43430_device_data },
-	{ "BCM2E95" },
-	{ "BCM2E96" },
-	{ "BCM2E97" },
-	{ "BCM2E98" },
-	{ "BCM2E99", (long)&bcm43430_device_data },
-	{ "BCM2E9A" },
-	{ "BCM2E9B", (long)&bcm43430_device_data },
-	{ "BCM2E9C" },
-	{ "BCM2E9D" },
-	{ "BCM2E9F", (long)&bcm43430_device_data },
-	{ "BCM2EA0" },
-	{ "BCM2EA1" },
-	{ "BCM2EA2", (long)&bcm43430_device_data },
-	{ "BCM2EA3", (long)&bcm43430_device_data },
-	{ "BCM2EA4", (long)&bcm43430_device_data }, /* bcm43455 */
-	{ "BCM2EA5" },
-	{ "BCM2EA6" },
-	{ "BCM2EA7" },
-	{ "BCM2EA8" },
-	{ "BCM2EA9" },
-	{ "BCM2EAA", (long)&bcm43430_device_data },
-	{ "BCM2EAB", (long)&bcm43430_device_data },
-	{ "BCM2EAC", (long)&bcm43430_device_data },
-	{ },
+	{ .id = "BCM2E00" },
+	{ .id = "BCM2E01" },
+	{ .id = "BCM2E02" },
+	{ .id = "BCM2E03" },
+	{ .id = "BCM2E04" },
+	{ .id = "BCM2E05" },
+	{ .id = "BCM2E06" },
+	{ .id = "BCM2E07" },
+	{ .id = "BCM2E08" },
+	{ .id = "BCM2E09" },
+	{ .id = "BCM2E0A" },
+	{ .id = "BCM2E0B" },
+	{ .id = "BCM2E0C" },
+	{ .id = "BCM2E0D" },
+	{ .id = "BCM2E0E" },
+	{ .id = "BCM2E0F" },
+	{ .id = "BCM2E10" },
+	{ .id = "BCM2E11" },
+	{ .id = "BCM2E12" },
+	{ .id = "BCM2E13" },
+	{ .id = "BCM2E14" },
+	{ .id = "BCM2E15" },
+	{ .id = "BCM2E16" },
+	{ .id = "BCM2E17" },
+	{ .id = "BCM2E18" },
+	{ .id = "BCM2E19" },
+	{ .id = "BCM2E1A" },
+	{ .id = "BCM2E1B" },
+	{ .id = "BCM2E1C" },
+	{ .id = "BCM2E1D" },
+	{ .id = "BCM2E1F" },
+	{ .id = "BCM2E20" },
+	{ .id = "BCM2E21" },
+	{ .id = "BCM2E22" },
+	{ .id = "BCM2E23" },
+	{ .id = "BCM2E24" },
+	{ .id = "BCM2E25" },
+	{ .id = "BCM2E26" },
+	{ .id = "BCM2E27" },
+	{ .id = "BCM2E28" },
+	{ .id = "BCM2E29" },
+	{ .id = "BCM2E2A" },
+	{ .id = "BCM2E2B" },
+	{ .id = "BCM2E2C" },
+	{ .id = "BCM2E2D" },
+	{ .id = "BCM2E2E" },
+	{ .id = "BCM2E2F" },
+	{ .id = "BCM2E30" },
+	{ .id = "BCM2E31" },
+	{ .id = "BCM2E32" },
+	{ .id = "BCM2E33" },
+	{ .id = "BCM2E34" },
+	{ .id = "BCM2E35" },
+	{ .id = "BCM2E36" },
+	{ .id = "BCM2E37" },
+	{ .id = "BCM2E38" },
+	{ .id = "BCM2E39" },
+	{ .id = "BCM2E3A" },
+	{ .id = "BCM2E3B" },
+	{ .id = "BCM2E3C" },
+	{ .id = "BCM2E3D" },
+	{ .id = "BCM2E3E" },
+	{ .id = "BCM2E3F" },
+	{ .id = "BCM2E40" },
+	{ .id = "BCM2E41" },
+	{ .id = "BCM2E42" },
+	{ .id = "BCM2E43" },
+	{ .id = "BCM2E44" },
+	{ .id = "BCM2E45" },
+	{ .id = "BCM2E46" },
+	{ .id = "BCM2E47" },
+	{ .id = "BCM2E48" },
+	{ .id = "BCM2E49" },
+	{ .id = "BCM2E4A" },
+	{ .id = "BCM2E4B" },
+	{ .id = "BCM2E4C" },
+	{ .id = "BCM2E4D" },
+	{ .id = "BCM2E4E" },
+	{ .id = "BCM2E4F" },
+	{ .id = "BCM2E50" },
+	{ .id = "BCM2E51" },
+	{ .id = "BCM2E52" },
+	{ .id = "BCM2E53" },
+	{ .id = "BCM2E54" },
+	{ .id = "BCM2E55" },
+	{ .id = "BCM2E56" },
+	{ .id = "BCM2E57" },
+	{ .id = "BCM2E58" },
+	{ .id = "BCM2E59" },
+	{ .id = "BCM2E5A" },
+	{ .id = "BCM2E5B" },
+	{ .id = "BCM2E5C" },
+	{ .id = "BCM2E5D" },
+	{ .id = "BCM2E5E" },
+	{ .id = "BCM2E5F" },
+	{ .id = "BCM2E60" },
+	{ .id = "BCM2E61" },
+	{ .id = "BCM2E62" },
+	{ .id = "BCM2E63" },
+	{ .id = "BCM2E64" },
+	{ .id = "BCM2E65" },
+	{ .id = "BCM2E66" },
+	{ .id = "BCM2E67" },
+	{ .id = "BCM2E68" },
+	{ .id = "BCM2E69" },
+	{ .id = "BCM2E6B" },
+	{ .id = "BCM2E6D" },
+	{ .id = "BCM2E6E" },
+	{ .id = "BCM2E6F" },
+	{ .id = "BCM2E70" },
+	{ .id = "BCM2E71" },
+	{ .id = "BCM2E72" },
+	{ .id = "BCM2E73" },
+	{ .id = "BCM2E74", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2E75", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2E76" },
+	{ .id = "BCM2E77" },
+	{ .id = "BCM2E78" },
+	{ .id = "BCM2E79" },
+	{ .id = "BCM2E7A" },
+	{ .id = "BCM2E7B", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2E7C" },
+	{ .id = "BCM2E7D" },
+	{ .id = "BCM2E7E" },
+	{ .id = "BCM2E7F" },
+	{ .id = "BCM2E80", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2E81" },
+	{ .id = "BCM2E82" },
+	{ .id = "BCM2E83" },
+	{ .id = "BCM2E84" },
+	{ .id = "BCM2E85" },
+	{ .id = "BCM2E86" },
+	{ .id = "BCM2E87" },
+	{ .id = "BCM2E88" },
+	{ .id = "BCM2E89", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2E8A" },
+	{ .id = "BCM2E8B" },
+	{ .id = "BCM2E8C" },
+	{ .id = "BCM2E8D" },
+	{ .id = "BCM2E8E" },
+	{ .id = "BCM2E90" },
+	{ .id = "BCM2E92" },
+	{ .id = "BCM2E93" },
+	{ .id = "BCM2E94", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2E95" },
+	{ .id = "BCM2E96" },
+	{ .id = "BCM2E97" },
+	{ .id = "BCM2E98" },
+	{ .id = "BCM2E99", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2E9A" },
+	{ .id = "BCM2E9B", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2E9C" },
+	{ .id = "BCM2E9D" },
+	{ .id = "BCM2E9F", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2EA0" },
+	{ .id = "BCM2EA1" },
+	{ .id = "BCM2EA2", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2EA3", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2EA4", .driver_data = (long)&bcm43430_device_data }, /* bcm43455 */
+	{ .id = "BCM2EA5" },
+	{ .id = "BCM2EA6" },
+	{ .id = "BCM2EA7" },
+	{ .id = "BCM2EA8" },
+	{ .id = "BCM2EA9" },
+	{ .id = "BCM2EAA", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2EAB", .driver_data = (long)&bcm43430_device_data },
+	{ .id = "BCM2EAC", .driver_data = (long)&bcm43430_device_data },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
 #endif
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 93cdde981840..60b90f1e11fc 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -1124,10 +1124,10 @@ static const struct h5_device_data h5_data_rtl8723bs = {
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id h5_acpi_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
-	{ "OBDA0623", (kernel_ulong_t)&h5_data_rtl8723bs },
-	{ "OBDA8723", (kernel_ulong_t)&h5_data_rtl8723bs },
+	{ .id = "OBDA0623", .driver_data = (kernel_ulong_t)&h5_data_rtl8723bs },
+	{ .id = "OBDA8723", .driver_data = (kernel_ulong_t)&h5_data_rtl8723bs },
 #endif
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
 #endif
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1222f97800f4..a6827300812f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2792,12 +2792,12 @@ MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id qca_bluetooth_acpi_match[] = {
-	{ "QCOM2066", (kernel_ulong_t)&qca_soc_data_qca2066 },
-	{ "QCOM6390", (kernel_ulong_t)&qca_soc_data_qca6390 },
-	{ "DLA16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
-	{ "DLB16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
-	{ "DLB26390", (kernel_ulong_t)&qca_soc_data_qca6390 },
-	{ },
+	{ .id = "QCOM2066", .driver_data = (kernel_ulong_t)&qca_soc_data_qca2066 },
+	{ .id = "QCOM6390", .driver_data = (kernel_ulong_t)&qca_soc_data_qca6390 },
+	{ .id = "DLA16390", .driver_data = (kernel_ulong_t)&qca_soc_data_qca6390 },
+	{ .id = "DLB16390", .driver_data = (kernel_ulong_t)&qca_soc_data_qca6390 },
+	{ .id = "DLB26390", .driver_data = (kernel_ulong_t)&qca_soc_data_qca6390 },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, qca_bluetooth_acpi_match);
 #endif

-- 
2.43.0

