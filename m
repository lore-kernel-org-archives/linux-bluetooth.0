Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008A36C;
	Thu,  9 May 2024 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213504; cv=none; b=Ek7cPpMyhKXIVXO2nFdxdlFUkGYLfv38lFLNlPb9oOoY5FaQJdiYjS2aHpeKywnZNNyIlwl2HMkMWRMBSKVy6UpPHfGvEEWNSKQHzMdFrh+vsvjEy9Slu+blvaPtWfGUY0AEQ7q0EOOJzH6RqjaH4LDFB9dMs5+NJHiKGk+wZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213504; c=relaxed/simple;
	bh=+KPhFjLngoYnYZyMFLCInl0AWsMSJZc/VrdY+nzvKnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IE2Co794TbZvYDqnVmvTeUoakkQnKtddKehpCTE6/XfF26gZJEYmCwACzRNBOjvq5vacfHee+PslauXw6rTrLvj1u8gUa9oKXAPl0meas/FZZuXpirRVhUgrmav2OlUsd+TvGJjJVEJkVsemwM7LPmHIDcfQYV8ON4AwrYVrpNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=PdYVeo7h; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="PdYVeo7h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=T0KfQdeJdUtDz1RkJ9GIAZyjFD1/YLa59kctlv5ebos=; b=PdYVeo7hcVJjaTya
	7fWFVguYsCPthqheYzy7e1CohSRCSyBpgB0xOazXiRaPPRLJwXccEk7dejXVj3O1wimqVlMLPK79t
	9NZeGH+IgzUALyzy2kCd0a4UKtJoHy7A2LVdC1riAXAj1wDRV00cwL0xYKs0LMNcVUjtmiIFT2szO
	5hUD8YYV66Q51flu9MW4DLyI9uaalk19azT9Xvl+RdN5w0klkYxsgUlT71XvTWgMtbeK5zBzXwqQy
	vmxNCrZ9a+97V5G7JieFQ7ezntlWywDnWaYGn2XDQ6hvEK0q4G40/F4FRGBWYFI7u3rPw4eke0Wd9
	pgfj+14GQydcSQ0KvQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s4rNr-00071m-2I;
	Thu, 09 May 2024 00:11:40 +0000
From: linux@treblig.org
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	sre@kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] Bluetooth/nokia: Remove unused struct 'hci_nokia_radio_hdr'
Date: Thu,  9 May 2024 01:11:38 +0100
Message-ID: <20240509001138.204427-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'hci_nokia_radio_hdr' looks like it was unused since it's
initial commit.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/bluetooth/hci_nokia.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 97da0b2bfd17e..62633d9ba7c43 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -116,11 +116,6 @@ struct hci_nokia_neg_evt {
 #define SETUP_BAUD_RATE		921600
 #define INIT_BAUD_RATE		120000
 
-struct hci_nokia_radio_hdr {
-	u8	evt;
-	u8	dlen;
-} __packed;
-
 struct nokia_bt_dev {
 	struct hci_uart hu;
 	struct serdev_device *serdev;
-- 
2.45.0

