Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017915B97F
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802951; cv=none; b=mTfTJ6aANWSInLw6wPKv2rkM8TQkHK/0Asc6oOc0jNX09IDzD3qorqjS5G4e52laeOPgq5GbXPHiEx8Rq1j7S/wRqR4Jru3ksjRRCV+cFStX3+z9hTI6gQUC11Wb7xfad7sf7m4oChTpeImfP14bcJjAMsYKdm3Tpm3NSIJEF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802951; c=relaxed/simple;
	bh=2TB7G9586wBiGx6TP08ByJQQGcZ49ktk6A5S0Zz7eEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XO3olNJwhm9HBL5Eyc/u3NcULWJRxaUFR6oI8cHeJ6DVNa5bylcvAuxTYaz+WtpUn/sFZUm8/78jZQ9l1B3XD3EVAYNaQ4bdc9CWtn0x11SNOGBz1SpMo604m/zwViFQAeljRABbsfUuFKzmO4GBcAf1/3maZYGp1mNfotutfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=G9dsRo5m; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G9dsRo5m"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33929364bdaso662274f8f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706802947; x=1707407747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGIV5k0CAIkt4/Drq57Mr31uOV54nJUOwQSsCzcpX2k=;
        b=G9dsRo5mBndH0MSMW/uIl8ZTCJMpbP3e+U977Pmx50Reev4/hGbbKFGBEa9gOtTHJC
         ID5z1P9L5CvkQymS8iaQ+y/mzAlLqWcHlxeBqb4swkzauyAomfVjEnsGBnGPcvfx/wRz
         T4xlsYTOygksWhfjaDrC3geL8Opf4yoKTMAVbtW0vwOAQ/LrnYVrAaIoiVH+40XjsVxa
         6q3QPbK6LeclniG5WGwJriXZ7NIvToK/Jf1H5CZK3ZVJTqP/kqSETyyBJXa2PVpJkwtX
         XyaSOtzAXpSU0/UxVScVGyMhvyTr60EfXB15zko2cgLL0U6Vyv//EOZTvQbaEWkmTRAB
         zFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802947; x=1707407747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGIV5k0CAIkt4/Drq57Mr31uOV54nJUOwQSsCzcpX2k=;
        b=LXw1IZFt69mTWNL3XLBc6GVrZzRP0sJ1jeGVlI3ZA146DPoq2Fm23TOyi1OhTTtYh9
         zmTjWpS6SR/m464fGFgYAAwRboGGOgQ37m6s9hqEvNpeExjECjL1ut1dJAnUWA6+wGou
         A6NlwN0XJlSc5yV7vXclNWhK0FAtUNCi5iS5ZMiRxpM1aDA1MEWVBJzU+7ErC71GBO1U
         +prhsTXBbdgIqChunHsVtwVneybE6y1K6p0IJkYzHM8g134qiP4zTUW6OVUGWLG+SFEs
         TiuXm9SdFzQGhCpzA3s3zfmnCqil6sfrStlTBeHQTut/0TxcV2LdwDa861fB3yLs7hO4
         0loA==
X-Gm-Message-State: AOJu0YwPtCm4vmDNwuHvpdriDTQXG3Xq7N0sc43JQBE5S0YCVYwIsGCv
	atP2ERfLKnYSP+Q6Nu3ZXvqbzWwoogVB6lFOAWEwVefCAP7XZ2YHu9N7gRArjCc=
X-Google-Smtp-Source: AGHT+IHrIgtPBGOwwkToCnKJnB1aV9LD4TnNqN3x0TxT01CT3Pl7rZrWkB/WvconB244cLvA5Ru8sw==
X-Received: by 2002:a5d:5051:0:b0:33a:e8b7:14e6 with SMTP id h17-20020a5d5051000000b0033ae8b714e6mr3518028wrt.55.1706802947384;
        Thu, 01 Feb 2024 07:55:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXUMnyLPTzxs2SEFue0K3khL4YRX36+K6a24zNZtfHXX30QIy5AwLzkcOFoQSx9bYdOnjgFk7fGi0X9bf1oNY2Rzsr48eGGsQM0HqMrTVjODTok8uzFCEUfZMJ/z0yH2DMWVPkCgiO68mL/fAJoYRlh4Bht0FXuPud6GmRWwoHr5b0I5y7PiyFAHcZbs7jjbceC/CpoxGEKvsgtzrD7cBZyPq18HXGgzDlBxCaos0IFTiXOezjtX7SoBaSj7pgGXyNXnX/p9Wpc4F/rDMrXogWXuMF4jYSV9N3WATTc9bh9Ks9ibvnx+bPrvGdjN2q6VpaysNTaWNew82h33i/0/7b3DY3XG1/VBurZpJLKtQcBCiDZjKJGcUcOPEpcQ1UVzRy+qayZSl1ia/C2V8RhZ8LlWcHt49Zms7PtlFW1RbPzdG6u92Nyk8/WnpHoLTyTbZptchTnRl3JYj3PsW2XAXxiwB703s3Mvf8nGow5+gFM3Xhv3paQaGkxlIz3PZiwmP+Q2rRBdxhqLKPOcWNXxxB42qj5QBv5APxVn+nzH/EDWPc9WRVh/KcN0tf4zmDdNiOUnpSZBvkNAxjXh7EaukBQOjDrQyhBz2FmKdlD3UppVYUnQJdIR82XBPMlDYo6YG17TNElV7HBrLnk7AHx9sUICFEbIsJoNdLpDlrkadi6IWQJy3ycgqIukkp/LzSJyUvja3GPJN3+
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:dd01:5dec:43e3:b607])
        by smtp.gmail.com with ESMTPSA id ce2-20020a5d5e02000000b0033af4848124sm9650318wrb.109.2024.02.01.07.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:55:47 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 6/9] PCI: create platform devices for child OF nodes of the port node
Date: Thu,  1 Feb 2024 16:55:29 +0100
Message-Id: <20240201155532.49707-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201155532.49707-1-brgl@bgdev.pl>
References: <20240201155532.49707-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to introduce PCI power-sequencing, we need to create platform
devices for child nodes of the port node. They will get matched against
the pwrseq drivers (if one exists) and then the actual PCI device will
reuse the node once it's detected on the bus.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/bus.c    | 9 ++++++++-
 drivers/pci/remove.c | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..17ab41094c4e 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -342,8 +343,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 */
 	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
-	if (pci_is_bridge(dev))
+	if (pci_is_bridge(dev)) {
 		of_pci_make_dev_node(dev);
+		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
+					      &dev->dev);
+		if (retval)
+			pci_err(dev, "failed to populate child OF nodes (%d)\n",
+				retval);
+	}
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..fc9db2805888 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)
@@ -22,6 +23,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
+		of_platform_depopulate(&dev->dev);
 		of_pci_remove_node(dev);
 
 		pci_dev_assign_added(dev, false);
-- 
2.40.1

