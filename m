Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCAD566A
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640434; cv=fail; b=TDnHkJgntj8VTXcsJJh14Nt366FkKWuCEAkOYGAt8T0BWOpRAQN6Q8A/fF6aKJF3ZIew0R8SgjtJEvgy74+62IeDuojZ6HNluwqeqhBCH4Uci3sak7WLaihc8kU4CYMjenPrwq5FEaTUO/XUU2syqMATiLJJtk/cZpnDheRvOJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640434; c=relaxed/simple;
	bh=bfTe9Qyl2WmdBgFDUg0tsksWo/KmHhwQLko3X+aqqLs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=bU+8iJAFuLjDiJzF/bi3CSxEQEBQK6GHqnHRu6grsUPVlF19eIQcNaL4KhXvbyqAypB3acy1AlcXquePGscPAEhOb0NfTx69zdwmyzK4fWTSH2CFR//LmajKDUjulhau3yYJn/EW72X0d0ISXfrKxgUyacBZkJiQhsso0g/rUss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=fail (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=k4TED5V1 reason="signature verification failed"; arc=fail smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="k4TED5V1"
ARC-Seal: i=1; a=rsa-sha256; t=1723640423; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dIjS4FxyIAuPAHK4ULPxQOMj93vJkL/sSEj6RpW6mXmtoBKELHlGL1R7IxEQj5vv+KQmMEi+wsDm2Z9tRXo1F4HwsiiWgapmj9IRI/SZxK580970dmcrgZ10VI/GGPixE0aX+mKq1+ip7yGliEmbmBzonuKIeLvPvYELtIt9hSE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723640423; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=yYLaUjXOhM7MTLzEg+6IPJ/rR+eApspry9A81h6P76s=; 
	b=PZeQlb6QFn4qpVe//c8WwuKl6OtAsWg8SisbBf4CYV10AroUR9g/1zYtXqPb3gHBKeEpdYtwGwxK8xzbEQPfA+8Lo7QeKv5ttorUKY84+fGEVi4rye3kFNzFrwBdc33lI38F0Mzx6TztZG7z8hJ0PYfqB300WWOzLI3K9KIfJ5s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723640423;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Reply-To:Cc;
	bh=yYLaUjXOhM7MTLzEg+6IPJ/rR+eApspry9A81h6P76s=;
	b=k4TED5V1K/3eSebvXw5Jw+nWy52yUIIrHJ1NCHy8lUY36XmOWm8gNamKJLCgDw4j
	GWmSej8iVMV142gNOxQdg5KbMC1RBx/73rubCFSZpIS2FkQZB5iqQm6rbvkuIuXPhFv
	/j2xLIKjexNpUqDAnxbyhlzl1zDoi65yQbpu1Af0=
Received: by mx.zohomail.com with SMTPS id 1723640421653657.3434175554619;
	Wed, 14 Aug 2024 06:00:21 -0700 (PDT)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Use speed set by btattach as oper_speed
Date: Wed, 14 Aug 2024 15:00:18 +0200
Message-Id: <20240814130018.263129-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Starting a BCM UART controller not defined as a platform device or
a serdev with "btattach -B /dev/ttyS1 -P bcm -S 3000000" works fine
but the serial port remains at the init_speed, i.e. 115200.

The oper_speed is only set if a device is declared in ACPI, device
tree or as a platform device.

When no registered device has been found this commit will use the
current tty speed set by btattach as the oper_speed.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---

This has been tested with 5.4 kernel only.
Afaict there's no change in this driver which should be impacted by
this commit in latest kernel.

 drivers/bluetooth/hci_bcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 89d4c2224546..57cacf63ae12 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -508,6 +508,11 @@ static int bcm_open(struct hci_uart *hu)
 
 		if (err)
 			goto err_unset_hu;
+	} else {
+		/* This is not a serdev or platform device, it should have been started by
+		 * btattach, in this case use the tty speed set by btattach as oper_speed
+		 */
+		hu->oper_speed = hu->tty->termios.c_ospeed;
 	}
 
 	mutex_unlock(&bcm_device_lock);
-- 
2.34.1

