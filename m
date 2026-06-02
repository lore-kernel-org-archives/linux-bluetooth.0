Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB5E2E173D
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434352; cv=pass; b=OQWLkqeavbUIGnJOAGj7UQfSl+u9MAzTH2DCdf27bogIpllrOZAOFR2fuxs1qUsig2Is4ZDH6Rfrj5YCjwfz1OOTtylhv7sW62AUMCKQZebMfewqlQRT3iAK0B47Bp99hrnjY3u2MQhG2t9vm2pjIVPv0GdSgBHb/mM7hFDrbZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434352; c=relaxed/simple;
	bh=IAWOulyn60q5CU5nFcEIg2txVq35DKFJNgeRnC6hixc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=d63VWNjC5rVcrY9oiNKm1gaVvBjADUuxqRol9aX4P7DEswFcp0+rRh6CFDZPE0Zq/sXOUp0ibsnl3BM2Z2oeHfHN2ly/tNABhx5JakqrS2uKi+cVjpuuxwT3QFugg3SfWoINNFqMcsBuDZcs12ALmdLZ4h1FA93A5zHK6OyQC00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIhc1Nj2; arc=pass smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIhc1Nj2"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7e636d1bedbso7218496a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 14:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780434350; cv=none;
        d=google.com; s=arc-20240605;
        b=lQDSAGuyhasWqAsOFL6V1odQllRzl7FvoRNXRqhL95N5laxXFiScrLLBM6IwwxZMFF
         CrxmNQilh9EAgBDNWWReTZa50nCIjVLSmedGrKpYwH4nnM5mrjMTRh3Ree/OYuqk36lo
         AvMQAxLosUOOfgyA5P9b6I186EDNFNChW/1pAG+/gEEU4eCr1xBSl7dg4jm4gcjwXT40
         Wa7sZQiEQLmOZWUHZ99zKGh+A8O53Ne8iEdceQmgt1OzxsdCfF6KDInBP4u0G/H7J4hJ
         N6ZUVluk/G9l8aMskG1qLLypCTEuspz4NO/5N02VynGIW1zxPChGIYhi4H2NlauAzjlh
         /HVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RkS7VxSSYQtTbcXAPMSGUiHQM/PKSapt1RSCo5tDvpc=;
        fh=eqw94iKt7cJM+7cVeUO1KlsatqJgVocc9Ewz52ske6k=;
        b=ZNeBEKHCofJHuYC++msrvxOQ9UWmnX3t0/md/gAezAZ8QJ5sH/y9ZP9nYBresldl5l
         a3Sc6+/8cbZGjOuPxv4cYqRFkj43Dc22roW79Lw8KGs++gmY844SxLlhyp/ENKAH/qoH
         WBfOJGnA+yuL+ylj8qk8RDHkBWuJd+MvxMB6KqIjysyjRNEEn8V0xDquRJLbLpCjXfU6
         3MgL1Oi6tL8YUDBtdFGWd3sD5ash4T4EWkzRKRy1hmtvO1AKQgugWlrBAHSVEnUFGdf7
         1MiVylH4B6vG5qIMcro2vXBFTCcUZ1Y4FT2zmucv2ixVeluUcF3d+oYeRYtNygPb/SC9
         jQ3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780434350; x=1781039150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RkS7VxSSYQtTbcXAPMSGUiHQM/PKSapt1RSCo5tDvpc=;
        b=qIhc1Nj2rz3LNxDrL/l8YlKa9KGLP85yo1tqfnBxnBF4oOGl6bXHa2A5TasoKKgZye
         AuuntS7CplBFr/YtxiervYhRkn1Rjj1Y4aUwqZgxwKoicc6vAlxZNYAyAboR482eXtwz
         D+IefB9x2Pjx2jbph2cbxLFqhFEjnY6Vv9jFhwrekBAHY+iMmB083Nw1czF4gWLHRZiU
         rK7e7LQT689ukX1PUMPXKr+tNZDs/5EH2ts+cBJewnW4RSCnSV3pPcoDYytoNewnkw/a
         /4f0UuwDXpOdE3n71YddArwEpiXGKESCv17gm5pArh3ENF1t0bMZoOCs/b215hncPYAz
         eMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780434350; x=1781039150;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RkS7VxSSYQtTbcXAPMSGUiHQM/PKSapt1RSCo5tDvpc=;
        b=TXD0twBKUrSpFbtPjKSa4GkysuBSQ+e3djiIyQWJ1O1g6DBEBebeSFuBWFncCjUkUT
         AuzbWXQJtnBYH2K3u9NixZ8qrWOslo1QDdHcOQ+N4P5gh5nseKtDZmqd/K7Qanw20CzQ
         1gvXU4WF6RDl4pkHcbV2DBs1hgbxX6rgFj8fsEYdcDQ+/43NNI2EuMe1vIF9XPM+gVQm
         n537ulYQmO4qJqjvRPodrjmx+oVWWun5+99286soao/QqG3QnUB5IE3ZUi7+ZOuKJ92H
         UjytikPqO+E2uyI35vU/YRaZoN9qtvszvWolU/R3IjC67W+Rbvlu+KKLVvICaRXph596
         daqA==
X-Gm-Message-State: AOJu0YwpsrKZsGw1UEKCiz69HhHrGQTu9SWkLlxmAY8V9/5a7WpEheTE
	l3heExqDWx/1AuG/pDCIcEmFiTmXRA1+Ks3+2HF6TH89cxPhuFej00Ktw5Rp4kTSQKPGZXDFQgF
	YwNi6V6k0sYoHJDyGAf+xtMj//6Ct6k9fIXvLXyRH
X-Gm-Gg: Acq92OFr/UvJmw8Qa7C1uX1DLLjfn4F6/y1QT5zNYVX9zbSzMfMGmcEZvrq+FPF1FUF
	jMDVziJ0CzEQS/W++ZMuaCXT5Azk+Y7kr8oA0HNn+2k9mKA90JutCmNEpSMI2wPnh64F36svm6f
	2ZGSg4tY4u7UQ4ru62qZOpIUV0h6/zEBSuRjjqSLLwf4YcoceGfP9mil2a0+TZ1TiuNdFtGYXbO
	FvqgunDjh3Nd738TtHlEkt1RU1200VucxTO/cuYdBI0DThZxqSX+cqlDiI2snO6+IRdNb37Is9W
	X3kFVhRan3oL6C/LrA==
X-Received: by 2002:a05:6830:f8e:b0:7dc:a256:5e2e with SMTP id
 46e09a7af769-7e6e94af477mr228793a34.1.1780434350148; Tue, 02 Jun 2026
 14:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jordan Walters <jaggyaur@gmail.com>
Date: Tue, 2 Jun 2026 17:05:39 -0400
X-Gm-Features: AVHnY4K7oA6BEZ_Ym4O5hEIJ1zsRXxq6kglDR-P_Jflai-pJpgb-pszJL1R19R0
Message-ID: <CACXZaU47FFpcucqfAsVz3nWQL8m6shuEav=bz4-8FL315fZDpA@mail.gmail.com>
Subject: [PATCH] Bluetooth: Fix Use-After-Free in hci_unregister_dev
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "marcel@holtmann.org" <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"

The hci_unregister_dev() function fails to disable the cmd_timer and ncmd_timer
before freeing the hci_dev structure. If an asynchronous event or timeout occurs
during device teardown, the timer callbacks may execute after the device has
been freed, leading to a KASAN slab-use-after-free panic.

This patch adds the necessary disable_delayed_work_sync() calls to
securely flush
the timers before the teardown sequence proceeds.

Signed-off-by: Jordan Walters <gloambit@gloam.sh>
---
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a1b2c3d4e..f5g6h7i8j 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2671,6 +2671,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
     hci_dev_do_close(hdev);

     hci_cancel_cmd_sync(hdev, -ENODEV);
+    disable_delayed_work_sync(&hdev->cmd_timer);
+    disable_delayed_work_sync(&hdev->ncmd_timer);

     /* Sync with hci_rx_work */
     cancel_work_sync(&hdev->rx_work);
