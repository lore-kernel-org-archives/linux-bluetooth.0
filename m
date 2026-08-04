Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AD42E8F0
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836806; cv=none; b=CIYmcJqd/+wOxzaCzWytUBy1CaaqFhmSbPQ346o0brEbDFEp+ugSbJ6xO4kFryj1DtYVPD1+tqbdVZuVyPWvd6CH7uPS5Rt7Q2LX6s4kNtrfFYBq7a8kXf26SFg6CCmckPB9RKyp/dDDaeAEdKu+I8O5DGWBXf+7r5FNXVhugg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836806; c=relaxed/simple;
	bh=u/VDWkmfvhS+hKn8JOrgbjI7ADQl+ZKgaFuCuDpU3hU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=McwSc51kXxeK8+cUrAkhWjoSRjrDBDpFq233rxCyUFkwj521wXnMMbQq6MVXvapUIvXBtb2DNxvnw9J2YQqlFthndiHQTzGGSROi1I1E3Aww18FjP8CJ5+vGxV5iFu/bjr7ZY+ka9zCcvFTAts5HfaG3k9y4TCs3/0ACZIFWf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ERRY5NIA; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ERRY5NIA"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260804094640euoutp01af8ee5b9a7a388e4e489910a6aa55495~IkRvQVg-Y2809828098euoutp01_
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 09:46:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260804094640euoutp01af8ee5b9a7a388e4e489910a6aa55495~IkRvQVg-Y2809828098euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785836800;
	bh=+PGn2hkLkYMpcr3BBmIodIR1ATMEiKWgIGc3aHkOrjw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ERRY5NIA8shmyjsQSH14QZ4YpTxyiRHG72khm8BBEehFDNNSyNhcurzX4XcNu5gca
	 KTSMDlH9D9EPZFUn8kuzxm7RbF7cN/42JgEdZykbHahhmoh6ytaCAWM2VstYpDJnP8
	 WembULQB+xx6sNxg6v+lg697pRRJbYg79cDvuefQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260804094640eucas1p1697cf118046108ce0d9d24127f68af12~IkRu-2KJ81193611936eucas1p1X;
	Tue,  4 Aug 2026 09:46:40 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260804094640eusmtip2e74b53943acc246df7193206453efd76~IkRuqJUoU1942019420eusmtip2S;
	Tue,  4 Aug 2026 09:46:40 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Marcel Holtmann
	<marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Li
	Qiang <liqiang01@kylinos.cn>
Subject: [PATCH] Bluetooth: btmrvl: fix event packet length validation
Date: Tue,  4 Aug 2026 11:46:30 +0200
Message-ID: <20260804094632.87581-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260804094640eucas1p1697cf118046108ce0d9d24127f68af12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260804094640eucas1p1697cf118046108ce0d9d24127f68af12
X-EPHeader: CA
X-CMS-RootMailID: 20260804094640eucas1p1697cf118046108ce0d9d24127f68af12
References: <CGME20260804094640eucas1p1697cf118046108ce0d9d24127f68af12@eucas1p1.samsung.com>

The event length validation added by 75e574f6a212 commit used a single
check against sizeof(*event), which assumed every event type uses the
maximum payload size. Unfortunately event packet length depends on the
type of the received event, so it must be checked separately for each
event type to avoid rejecting some known well-formed events.

Fixes: 75e574f6a212 ("Bluetooth: btmrvl: validate event packet lengths")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/bluetooth/btmrvl_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index aaf1614ccfd7..e25930351f64 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -81,7 +81,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 	struct btmrvl_event *event;
 	int ret = 0;
 
-	if (skb->len < sizeof(*event))
+	if (skb->len <= offsetof(typeof(*event), data[0]))
 		return -EINVAL;
 
 	event = (struct btmrvl_event *) skb->data;
@@ -93,6 +93,8 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 
 	switch (event->data[0]) {
 	case BT_EVENT_AUTO_SLEEP_MODE:
+		if (skb->len <= offsetof(typeof(*event), data[2]))
+			return -EINVAL;
 		if (!event->data[2]) {
 			if (event->data[1] == BT_PS_ENABLE)
 				adapter->psmode = 1;
@@ -106,6 +108,8 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 		break;
 
 	case BT_EVENT_HOST_SLEEP_CONFIG:
+		if (skb->len <= offsetof(typeof(*event), data[3]))
+			return -EINVAL;
 		if (!event->data[3])
 			BT_DBG("gpio=%x, gap=%x", event->data[1],
 							event->data[2]);
@@ -114,6 +118,8 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 		break;
 
 	case BT_EVENT_HOST_SLEEP_ENABLE:
+		if (skb->len <= offsetof(typeof(*event), data[1]))
+			return -EINVAL;
 		if (!event->data[1]) {
 			adapter->hs_state = HS_ACTIVATED;
 			if (adapter->psmode)
@@ -126,6 +132,8 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 		break;
 
 	case BT_EVENT_MODULE_CFG_REQ:
+		if (skb->len <= offsetof(typeof(*event), data[2]))
+			return -EINVAL;
 		if (priv->btmrvl_dev.sendcmdflag &&
 				event->data[1] == MODULE_BRINGUP_REQ) {
 			BT_DBG("EVENT:%s",
@@ -143,6 +151,8 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 		break;
 
 	case BT_EVENT_POWER_STATE:
+		if (skb->len <= offsetof(typeof(*event), data[1]))
+			return -EINVAL;
 		if (event->data[1] == BT_PS_SLEEP)
 			adapter->ps_state = PS_SLEEP;
 		BT_DBG("EVENT:%s",
-- 
2.43.0

