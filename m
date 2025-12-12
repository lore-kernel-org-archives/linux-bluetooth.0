Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5D30F93D
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765526975; cv=none; b=ohy3OQRjIlJJsArUNG9gqIx4pIiJ/Mv30Qdq+nFsAtd4GpOZMka9AYTdIgsMjGsgMdgMbzEgl8ySKyNSt3bh2A6J2vVZw9XoJUXuW+KYI5iDW9zCzaWFMM5rs8NcoOsE1U7AqTlWE/tMqaN9T4O53SKXWKQCy15JTk7bLZmdUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765526975; c=relaxed/simple;
	bh=vGCqn150HxJ8MtUS82THFrl3poKgmAltPNTl+cDcUXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QoW8okUdblNdYRENMKS0qYN7J9Q5W78N8oDH97ElJ4Ao27KnBc0Gf2gajLiNWFPmPW6OIY+16CDBUiu2bZ7qjXXQNRk90aQQoyZ8c6DrH3GMWoUjbaq3v2GTCyFJDp/5CRrAUOBOX381Y/yjN2ubDR39EdnYPRpqKbm1fwj5mi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R0hUYoJA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R0hUYoJA"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7277324054so182176766b.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 00:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765526972; x=1766131772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y/WEFvgJT6eEHgu+k37sR9i/F7SLQirVFkB830SU88=;
        b=R0hUYoJAVQB/gwRtuYrNlc52M9GwgKaKWUu5W6wngJjA2mlCirwQ7gZXbKGG8FH8uj
         wPe5yigR15O7qcEvaB109fMKlU8XdRPMQWx2y4O9rzzv6/csg0wu9JoC4SwwMSSVpKen
         AoP0owNeUelFOqlpytEgc9ux4heexokA8kRObfoJsIzv/6IB7cYVSSJTEXjrZ2ubXma0
         n4BekFOXY46m4H4iR2TZdkeOQRtn0l0f9gQoHwTl3nwJHgO1mlCmmyYfJjzc6CNjz+Of
         m1Vlo9vIJDUcHtS/LvlZeP/mWFq2ZQCeQOtgy12oF9htsQt5/RpW8BrL4mJmYM9dEx0p
         OD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765526972; x=1766131772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8y/WEFvgJT6eEHgu+k37sR9i/F7SLQirVFkB830SU88=;
        b=apdiUQOdcL/bzHn6fC0PugluBxbEzx7qp12oU9NNs0tVq7QlQWT1i/m4AscC0bwg47
         B+6HPAj5/v5viUaDuWGlD4+Tlp8rAdHerDVQPzGoQzL4zc/9Jiu05pRZdw8odop3APJM
         4s1A1rKUBOGzMcwEbxRhsr7zIOqBrxEnpBqGoQUsjboA3CvIWRnX9zUAmClLif+qE5I+
         JLZms0ZU4NmZqL/L/u+eUTrOMJmxyk70kdqEnZ+1cnMs3xPxMhvIzeo84pu5E6lGrI+S
         2v3jD/JzqtR29dEfAnLhM8CSRQSF5PK+3968sJ+6Jb3SUDbc031zPDF1GeNjI0QYr+2y
         8xMA==
X-Forwarded-Encrypted: i=1; AJvYcCUecno0kosIGOgLcB7b43E4EFWp7XE+Wdm0yqXsr+k3DsvA1khwY2Q56ULhDuPXwPQB92kArJxrTi2f38mrEnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/kEAwqD/C52PvsvANHkczGNc/6uqh10+9x+rWlzDn43Ehm/i
	8C0z9be11fqeK7ab1lw3QeBtHKdbEmNb9puStDnz+gmq1LWBBNfXSsBlNhkT6zRRJKg=
X-Gm-Gg: AY/fxX5z7GUJj0NzwkWbHxYLkxJD1Vc98lwR+OlVpKvNOc1hpV6nDpqyQ/SzSDIggUd
	2eJmdrUHXYXXtLekwxS1n9/R93jyznbtTh1cB4mQ096VswZQywspZxo7CEdsFzw3Dms/qfFnGZq
	Z6kc887NvQnEohOB2MS7TRrX+uRAej7jdp+oRbcM8kHn+sf0qFWRKAOEGyJvuh7T8cXL0IiK0Jh
	Qe81BFQxz9Ypaxx5P9Ijuhrc/0tZxMtt99kzTVeDcDji1LTixWn3X04lG4beDTj0K5Ctv9G8GWz
	hb2nYHKlMnzgpI8CCpCv/lYPlk6fTpZEvDhZ1A7kQAJH2X0wBjbLRaOUm3cL7NWKhhHwTb+KYqX
	7pbLpTzpJzYm/mLiBpXBmgl3tQnZFk8eclRjP0aDzYG3BYCJR+8vzxtYgFN1RH37IY4zocnmBp3
	LG8LKhec3TDJ4eWijiVh80WJcj99ohRr4Sso3J7txTAj7SI9v+AjWb9wLRWHYNBxubm6ctFG7gX
	38=
X-Google-Smtp-Source: AGHT+IEohkTFv9UGpNtY2ozJvK2nVZCaxRUfnkar2d2p6ZOEFnhYgp34EQJbKoIx1beUIjQCif+2vg==
X-Received: by 2002:a17:906:c116:b0:b79:ff35:660d with SMTP id a640c23a62f3a-b7d2366fa8cmr104151166b.26.1765526972273;
        Fri, 12 Dec 2025 00:09:32 -0800 (PST)
Received: from localhost (p200300f65f0066082ad4229ee042f7ed.dip0.t-ipconnect.de. [2003:f6:5f00:6608:2ad4:229e:e042:f7ed])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa51701csm495212666b.39.2025.12.12.00.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:09:31 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-serial@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/4] Bluetooth: hci_qca: Migrate to serdev specific shutdown function
Date: Fri, 12 Dec 2025 09:09:08 +0100
Message-ID:  <261a3384e25c4837d4efee87958805f15d7d4e3c.1765526117.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765526117.git.u.kleine-koenig@baylibre.com>
References: <cover.1765526117.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vGCqn150HxJ8MtUS82THFrl3poKgmAltPNTl+cDcUXM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpO82sxCSR+zwaL8wDmy0pjGy+036YQlzwewAee +DNGGdXGWKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTvNrAAKCRCPgPtYfRL+ TsKtB/9EXul1lR98OzVC2zAr/SX+GDH8vkOKTQisjlrgA5rSXHSYHpcVKRVU/9TI9aLBqaXcFRb 61y68nDql3f4Enbd32XDWeAcVznqAVWmV5II4OzWWgbty2AxYtJ7h5FnhQVUFtCLEYhEj/n+Dc1 FtXygeQbTWZy4VTu7CkOZGHrQ9icdxPke57nWuuCsJ7rM6UVpOueeyoy0rXIFwSZoTQKXLuoZBh M13nOyd+FDb2FXWo4voHpGMHzZIfUlHMS05kJP1jYHbQyA4GdYVA0epVDvPhJg7oiVZcuJ/nS1+ gqi9HeXXW/dpxJSfwKt63ZDGK2QP3VfYdf2MX74n4n2LdYtm
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This saves a cast in the driver. The motivation is stop using the callback
.shutdown in qca_serdev_driver.driver to make it possible to drop that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/bluetooth/hci_qca.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 888176b0faa9..6d54f747fde4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2530,11 +2530,10 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	hci_uart_unregister_device(&qcadev->serdev_hu);
 }
 
-static void qca_serdev_shutdown(struct device *dev)
+static void qca_serdev_shutdown(struct serdev_device *serdev)
 {
 	int ret;
 	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
-	struct serdev_device *serdev = to_serdev_device(dev);
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct hci_dev *hdev = hu->hdev;
@@ -2756,11 +2755,11 @@ static void hciqca_coredump(struct device *dev)
 static struct serdev_device_driver qca_serdev_driver = {
 	.probe = qca_serdev_probe,
 	.remove = qca_serdev_remove,
+	.shutdown = qca_serdev_shutdown,
 	.driver = {
 		.name = "hci_uart_qca",
 		.of_match_table = of_match_ptr(qca_bluetooth_of_match),
 		.acpi_match_table = ACPI_PTR(qca_bluetooth_acpi_match),
-		.shutdown = qca_serdev_shutdown,
 		.pm = &qca_pm_ops,
 #ifdef CONFIG_DEV_COREDUMP
 		.coredump = hciqca_coredump,
-- 
2.47.3

