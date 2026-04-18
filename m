Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183125771
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776470507; cv=none; b=RddeWl8sfDSMNlLMVzmzyTBU4ruEiiC22Wd8WyXBTmN47qEzmD97OpLmXYOaCQTJjyeCrCHsAx/TQEV5GiqJY6JCPReCC0N4Vu3aRAtVolF33cHGzfM5NlvaFc5vH4nzIbBvFKjIaGC+xiRBOSezUM01iMvoe4H6iqXpqrK6Xs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776470507; c=relaxed/simple;
	bh=aUw5Z9BShh7pPsO/YXyjGvI3vSM3MAsAxuOQ/UOswh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFBs94WXITkQg7qBi3rE41eqML3gRwuKdcLLHzGf/NTjnNa3lsGynBhYIyRRbjU4ZFi6QvVOgJyDq9y7ao7KN0wnAax3KJ0emR72BVZEvMPqlgZimA0O2laIWCh0taOx2KtRect92ajRltTJaT2rG38hspopkPmolGuAw6brA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2+UEI5C; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2+UEI5C"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfdac74050so139923985a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 17:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776470505; x=1777075305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R66LEpe02zTt9gVa2iVCV7h7l2cAvZnx/6Rq7QX2ojM=;
        b=X2+UEI5CjvoJNbB1WMIwj05a78DmxlxFx7spFtegQ+lpZZcyLsz+DJftz1hUOOKWNG
         KFaEg3kRFRX+TjtxoNJycatcpJ/aVjS9so4iDzssGuseJhNRS28JPdGaNbA3kmrgjYzj
         wKBbOYss+kiqFsrcxnoihBADSwfRoZ32MByXifgForTSKQjAQVjPPxa2+X3BIz4YhHi2
         AKAzuAs4CoVMy+RsDUSXovr1l7Y5Jde6H3DBwD0GUwGpMfs81s8z6NGvKo1tsrS2DrCs
         z5NZDtZNrK8bnDMhs4YTZaYLFh80gUZ01LA1xChFv7UtFKngy7msa0kvNK1ewtMhWr4z
         M1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776470505; x=1777075305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R66LEpe02zTt9gVa2iVCV7h7l2cAvZnx/6Rq7QX2ojM=;
        b=Ckh/CBrqkGfOw4OiQNjFJyQqgjzC3mw8HSeoWMkZAH0CqBB307YbBl/0epZgKyD8bV
         W8wZciPxJDNzJDdMJFqeXYYgcz5BnCXqPyW71+1htEYMhoIEhjQ3nBmqC4HzeTWDiUU+
         n1ayfOIjnDQtZPFr9YQu+BU6QRIwqutUoW9uIyGjcV+qCAygaAPJYPDGa65PrZ7tg5Dz
         +L7YkOza5g1+ln4G3YAkipcbBEkMmhbisDoreXm/uf6fCJAncAb4d7S7DRyN6/C1ErDE
         /QutlHH/HCYtY/aJ8JhzVrqq1wh+T4btSiZWKbQL08EsNesu8ovnBkTqywMic9qKxBpt
         wQ6w==
X-Forwarded-Encrypted: i=1; AFNElJ+QCk+NDH6cVUY9uMRgYOYZKz6sXT/aKYvQMNq3OGVM/7UA5DhJBfFh0jFivsDhM7D9mnlK1DrJQtgcslxGCpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoY1toGPHhD0G0Tc95MEZKOIYqUh6CV4iDw7sNWqxAdDinC6H
	ysd1Sjnnx2ay1mzYZ2zyKzM4LeeI3nWwlFwaRIotESBNn/btE6FKZMPs
X-Gm-Gg: AeBDieujD50CWAFfxLuIlZlngMEgdh9NaSJphlGmLsmmYgwb77iEskeuWdaai8tfsvo
	Sh5xdW9nG19jXK4esr6wnGDHxspPFzkZbEeyg2/3Ouff349j7KbJgMrHxjJCijAUiNzG4pBugBh
	jgYZ1freN+8MbbyyAt+jPsNCmKlHjRIWYBE5XIDa3PM9GWPpCHQCy/WGLzkdPFXYjoTHTds5gBh
	9TCKCMgmD4p34ml+7N3mGFIOXr8weQ0Rvl3D4gTgjt+8NJEn1lu/Crx6c9Rm9+J2ipCfPJVESDK
	AtPPhQKeJRc+TnzUcvuhE8SPtRRnRPBr0QtvHpxNNF8Xql2KzLQFF0+fTvPVxA1oy9qNrpkyKhe
	+V2u0RQ9XIgC9XNi5ghJsHlxqhIDWAz1UPROftkGumlQ3qbxJhs5KBTX3hh3HdhbAHrGfGi56uc
	frUUUMRlzfOSUkOPn4ZPsFBHbJNRQwlBEpoW5PHaEjfZHIgcCtudIY296RteMdKUegZr7kagLjq
	2e/hMPFVTCpHZ5MjwjQtdogI65qk/isj4PTgtvCaej9Fo6stLZEeA==
X-Received: by 2002:a05:620a:4101:b0:8cd:a3ab:352d with SMTP id af79cd13be357-8e792f433f6mr748234785a.61.1776470505139;
        Fri, 17 Apr 2026 17:01:45 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64cc559sm228562585a.13.2026.04.17.17.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:01:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Soenke Huster <soenke.huster@eknoes.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] Bluetooth: virtio_bt: clamp rx length before skb_put
Date: Fri, 17 Apr 2026 20:01:38 -0400
Message-ID: <20260418000138.1848813-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtbt_rx_work() calls skb_put(skb, len) where len comes directly
from virtqueue_get_buf() with no validation against the skb we
posted.  The RX skb is allocated as alloc_skb(1000) in
virtbt_add_inbuf().  A malicious or buggy virtio-bt backend that
reports used.len larger than the skb's tailroom causes skb_put() to
call skb_over_panic() in net/core/skbuff.c, which triggers
BUG() and panics the guest.

Reproduced on a QEMU 9.0 whose virtio-bt backend reports
used.len = 4096 into a 1000-byte rx skb:

  skbuff: skb_over_panic: text:ffffffff83958e84 len:4096 put:4096
      head:ffff88800c071000 data:ffff88800c071000 tail:0x1000
      end:0x6c0 dev:<NULL>
  ------------[ cut here ]------------
  kernel BUG at net/core/skbuff.c:214!
  Call Trace:
   skb_panic+0x160/0x162
   skb_put.cold+0x31/0x31
   virtbt_rx_work+0x94/0x250
   process_one_work+0x80d/0x1510
   worker_thread+0x4af/0xd20
   kthread+0x2cc/0x3a0

Reject any len that exceeds skb_tailroom().  Drop the skb on the
error path; virtbt_add_inbuf() reposts a fresh one for the next
iteration.  With the check in place the same harness runs without
BUG(); the driver logs "rx reply len %u exceeds skb tailroom %u"
and the device keeps running.

Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer overflow in USB transport layer"),
which hardened the USB 9p transport against unchecked device-reported length.

Fixes: 160fbcf3bfb9 ("Bluetooth: virtio_bt: Use skb_put to set length")
Cc: stable@vger.kernel.org
Cc: Soenke Huster <soenke.huster@eknoes.de>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/bluetooth/virtio_bt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 76d61af8a275..157e68b6e75f 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -227,8 +227,15 @@ static void virtbt_rx_work(struct work_struct *work)
 	if (!skb)
 		return;
 
-	skb_put(skb, len);
-	virtbt_rx_handle(vbt, skb);
+	if (len > skb_tailroom(skb)) {
+		bt_dev_err(vbt->hdev,
+			   "rx reply len %u exceeds skb tailroom %u\n",
+			   len, skb_tailroom(skb));
+		kfree_skb(skb);
+	} else {
+		skb_put(skb, len);
+		virtbt_rx_handle(vbt, skb);
+	}
 
 	if (virtbt_add_inbuf(vbt) < 0)
 		return;
-- 
2.53.0

