Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF456B77
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193808; cv=none; b=V5Zio11iyczgYON9G9b33FJwem4Vyjqxqhph7tgOKQMdOqwcKcw2o07LNyptQ5XJmH0m7a+MElzV+qmYmNoTd+LvHTepUbUicYA/a90x8aUlfbQ49O58iexd7zR4xS0Rjx4GmZiCYPoH2prULEU8C8neDHly7DpX9EpO3Q4UuHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193808; c=relaxed/simple;
	bh=utqFOcp6ACV+cy8qTYsIXw7uFfcZt5FhhtAl/yvFyf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzhl3PggYjx0Lk6HKbaiSQ/p1FV8umLzM55wmAQbodlAVqadzps5hqHjEuP8mxWWcFfmznEWDtv4rHHnGo9Gt7A0MrWio0SY6NKNG7TJeRRXdhHO+tdE4GR65u+YcfOBlNSbYvJcy/AbarzIIWfFW5AogBTd4rCgujMonJj7Au8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjnX0-0003Eq-4R; Mon, 11 Mar 2024 22:50:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjnWz-005nDq-NO; Mon, 11 Mar 2024 22:50:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjnWz-004Ioe-24;
	Mon, 11 Mar 2024 22:50:01 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 3/3] Bluetooth: hci_intel: Convert to platform remove callback returning void
Date: Mon, 11 Mar 2024 22:49:54 +0100
Message-ID:  <c382b766a20b5213925c31fc34510166dd642b52.1710193561.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710193561.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710193561.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=utqFOcp6ACV+cy8qTYsIXw7uFfcZt5FhhtAl/yvFyf8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtT3NS0n/BX3X5/q5i1g4liWpbzlfm3lG3uG8MWvhZt1k wWjVF92MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCR33/Z/8e4qhRcMjsue165 d3HjlUm3rAMdft+MLfWrPsMqoVsRvekpR/w3S08xnrdBZw55zj+/2WNdTJ4Kc4fNIzH3S+m9j39 rzMjtcsie9s3F3sVvxo3zmpGVW180b+yw445MZj9q80d4Q7FQl8Hxhf+uHf7NVH/DMjxVS+9aBc crt9hvCt88bCveHAng0e1c+ccwUN/i2qK/G27kv1Z/c1dbL9PuGOfa/6//WS9yKY+8IKS2tXRTw bnmluTzB67MUmHZfbzG4PHun8ePb5sgm7D9nYhT+KFJlUqq7tevszXFMsZae8XK20VbqExeU7zP VFfa6NqFD+I5X9Xaq/Uz1jmJanZkbbOcd0xljk2Oe/huAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bluetooth/hci_intel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 78afb9a348e7..bd44d683b9be 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1190,7 +1190,7 @@ static int intel_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int intel_remove(struct platform_device *pdev)
+static void intel_remove(struct platform_device *pdev)
 {
 	struct intel_device *idev = platform_get_drvdata(pdev);
 
@@ -1201,13 +1201,11 @@ static int intel_remove(struct platform_device *pdev)
 	mutex_unlock(&intel_device_list_lock);
 
 	dev_info(&pdev->dev, "unregistered.\n");
-
-	return 0;
 }
 
 static struct platform_driver intel_driver = {
 	.probe = intel_probe,
-	.remove = intel_remove,
+	.remove_new = intel_remove,
 	.driver = {
 		.name = "hci_intel",
 		.acpi_match_table = ACPI_PTR(intel_acpi_match),
-- 
2.43.0

