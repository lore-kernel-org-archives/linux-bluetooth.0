Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612154;
	b=nY8/GHQo3FFHsYeSwM+ykDBsrwzzJuggbwQAyxaCtuyr0pHBd9rbalTB57dd6QIIxW2q
	 rkWZCRSuy2JriCu1bPQcK9OUXAM4A8wJNK7G8hnrLnNKhg5sphGMT2PnnUBLH4v+ZVCx1
	 MOlxk2XsH6R2QrV6lTyNTsSnbjTGBoFURxL/oWoJDqAHnwj/csWWWllTnrNDI6R8mteH7
	 wb6ER52koeRIATW3hhc5K4eEo26dbYotbIwP8rZ0s0j4EVmzEKZFH/vkGqfA7MEVdWmO+
	 YJQQmtAkgEHNllPK6754uomdA+DFDaBB2iFP6Vk1m128ptJbicaiKuVYqPywfFI1fVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PHAySPim9C43/yZnOc3cvmysHiJR3smT0StLMumDRAI=;
	b=pVPjza7rjsqf2y+FKdB0dc6gZ0/8b5Se2ioS8ofPgCgegX0Oi3LMif+7e0wSW/CmNPFY
	 FkOkAL4Fu0c3Ys6C7BSzFG4X3X6Rc34G+xwN0CBSYfOradn3wo7arqHfv0eAj79fTAoVp
	 AZSdHqE4jxi2Hkko+f6JEfLgs3rvrID33/hTrggd4b+r1kXfYwoGVao88t2kgE4iSE13G
	 qCf+WaRWIqTWknZ71D6cVwJopIz6oSk/c7xnhr7O8BdGafa+5LVwPmt7cGppfVvjKTwGW
	 6wmlaNerta//fx5e3rXIyWQrLPzgh2nGHoMmIAPNpKLMpKuewNO5DXfVzSYMmf6Lerw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RxsJJchF;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67259606A338
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67259606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RxsJJchF
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eafaeb8684so1690707e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 05:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612153; x=1796216953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHAySPim9C43/yZnOc3cvmysHiJR3smT0StLMumDRAI=;
        b=RxsJJchFa6vwNKJ5kT7eX7qkOiUJtxEsvnKmz2KCQv7xtV4H+inaaf3uvySby+Yl+O
         s2tJnaeQBMj0IckjOmw3kf25yy++QnPlSZBmnea8u5Y0eKL8ZqzBZ/55XxRHb1v9+2PW
         CyUgTJtPqbykeIvbxG2QDipU4+Kkqu4xx8MTBBY/LK2bB6Xs9pCuF1QuK/LYdP63/yoS
         89dXoIKxASIECMp7rgQdEoK695sFT8+QVm82j6idoh0pwxETrkP8CoTZImoeYKhd+dCS
         aLenBsH6/fJd3QqX/zTces7ARUklHWkw+k2u/ny6SBoAajIVEuairxsEh8Rk4R/WKXTv
         AHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612153; x=1796216953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHAySPim9C43/yZnOc3cvmysHiJR3smT0StLMumDRAI=;
        b=v26OaMzuCdGWB1P/05Exf0jRm6+KqEQqNojOMA8hmprEW26Ya83+20TiAhQUh/FP9t
         Zb+oE0/yC2xvuam/9be9EJ0JjVM97MJxbLmAq83APq8SP7iXWncDtvdHn8+QgP694gYx
         E7eWhGiliBns8taO3IL7f5kN3OuY9n7Ml4oiYvgEovWafBUi+485AltE0MB6gt/RrdUR
         E7GR9p18jR+mA1wBhiPnOyjjBFaCAXWy4APHd/18Sau7HhAwOEqkxNAwDbCZaDzKTD/l
         TCzMRhUrdtzywTHFg+1qIjYS2V+yyFh1d5T51b7LJiO7+fMei389SlufYJosYo55p7A0
         rBtQ==
X-Gm-Message-State: APuU4Z/jIIf6qDOU2/XlrZxMyUi1labKd9Q2Wc1KDZ4/5hBkdrx9REWO
	mYP6ZJx7txbCaC7TIoeBCgDxmhJ0xCWmlFDDYvrfLY6jUwTVB3gu1zUcliT+efqA
X-Gm-Gg: AZFdTZfEBIm+WYqAYZixAAuYAzftfxSmqvyS+7idRNsqs+udMVWvm2dkCxy9AMwW+ZU
	IuyEMdn8UKOU5Ly22vsosbCF59gbLSN39OOETrX+89FNmnCZF78NoC0joYN05TPbz4G09Q4xbnh
	j4ap2VrkAJKIrdstxpjktK6Lnzn+seqEtORXS9Ub0P4NnQb4hCOM0TNzkR/ulzpuxobB/FKKv0e
	ewQQl1NJwgVJ7jKfhlLLzbX2WlZCMKH/dQ9blhMdhkiI5qxVN8obxlddHIKiCbBsoqSsTI8B0XR
	JTAMhhfViU/h6FEr7xU2dLTWmKpMyhmb7q83YBKBlPvYXyUrXwmG75deHS1yPWr+WinOnPOR9CY
	iyK2RYu5WMofFwUMN5o+29j4BRrE1Fje5SQmx5OrejC3n7bjsHrG6KxoCE9Xyj6YANkR5c7ByNV
	ZSypCsN3PlJROu45S24unBwfr/5+m76oEpgRB8vRSiW3w1NuiDID5CBTTyoWlbutW+gl983jg4z
	uX29/ZT2QFci1zukGH2HKUzKrL+15KDm1Lr0HxNanRavsTBrTgcXjlPlcpQ3w3l87cMnl8PfEZG
	z9VVr5hJ7ncZv8Z2zdEKjXWdmScua0oQBUTnbVI82Ta79S/K83aYBA==
X-Received: by 2002:a05:6122:310f:b0:5ee:13ad:6c8c with SMTP id 71dfb90a1353d-5ee8aeaadcfmr8794727e0c.7.1795612153064;
        Wed, 25 Nov 2026 05:09:13 -0800 (PST)
Received: from shine.local ([168.196.221.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b60b201sm17299447e0c.14.2026.11.25.05.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:09:12 -0800 (PST)
From: "Andrei A. Bykov" <andreiab9019@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: hci_sync: keep unrelated replies away from event waiters
Date: Wed, 25 Nov 2026 10:08:27 -0300
Message-ID: <20261125130828.18441-2-andreiab9019@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125130828.18441-1-andreiab9019@gmail.com>
References: <20261125130828.18441-1-andreiab9019@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An asynchronous command can finish while a synchronous request waits for
its terminal event. For example, an LE LTK Request Reply can complete
before LE Read Remote Features Complete arrives. Completing the waiter
with that reply releases the feature-discovery hold too early.

Keep valid unrelated Command Complete and Command Status replies away
from event waiters after processing their command handlers and credits.
Continue scheduling queued commands and preserve unmatched Reset recovery.

Do not identify the current waiter solely by HCI_CMD_PENDING: timeout
and cancellation can leave it set with an old req_skb. Capture the actual
synchronous command carrying HCI_REQ_SKB even when that flag is already
set. Callback-less commands must not replace the waiter. Drop the stale
socket reference when replacing the request, but preserve the same skb
backing storage and socket reference when Reset recovery resends it.
The request skb is still replaced on the ordered command/event workqueue.

This also lets the next synchronous command complete normally after an
event timeout, without waiting for the old terminal event to arrive.

Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Signed-off-by: Andrei A. Bykov <andreiab9019@gmail.com>
---
 net/bluetooth/hci_core.c  | 16 +++++++++++++++-
 net/bluetooth/hci_event.c | 26 ++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 024960e9a..072ab361f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4386,11 +4386,25 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		kfree_skb(skb);
 	}
 
+	/* A synchronous command starts a new waiter, even if an earlier
+	 * event waiter timed out without clearing HCI_CMD_PENDING. Commands
+	 * without a completion callback must not replace the waiter.
+	 */
 	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
-	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
+	    (bt_cb(hdev->sent_cmd)->hci.req_flags & HCI_REQ_SKB)) {
+		/* hci_resend_last() clones the same command during reset
+		 * recovery. It does not own another socket reference.
+		 */
+		if (hdev->req_skb &&
+		    hdev->req_skb->head == hdev->sent_cmd->head)
+			return err;
+
 		hci_dev_lock(hdev);
+		if (hdev->req_skb && hci_skb_sk(hdev->req_skb))
+			sock_put(hci_skb_sk(hdev->req_skb));
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_get(hdev->sent_cmd);
+		hci_dev_set_flag(hdev, HCI_CMD_PENDING);
 		hci_dev_unlock(hdev);
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a9b6a6cca..014207d2d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4862,6 +4862,18 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 
 	handle_cmd_cnt_and_timer(hdev, ev->ncmd);
 
+	/* An unrelated command may complete while a request waits for its
+	 * terminal event. Process the reply and command credits, but do not
+	 * complete the pending request with that command's response.
+	 * Unmatched replies must still reach hci_req_cmd_complete(), e.g.
+	 * for the spontaneous Reset workaround during initialization.
+	 */
+	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
+	    hdev->req_skb && hci_skb_event(hdev->req_skb) &&
+	    hci_skb_opcode(hdev->req_skb) != *opcode &&
+	    hci_sent_cmd_data(hdev, *opcode))
+		goto queue_next;
+
 	hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
 			     req_complete_skb);
 
@@ -4871,6 +4883,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 		return;
 	}
 
+queue_next:
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
 		queue_work(hdev->workqueue, &hdev->cmd_work);
 }
@@ -4982,6 +4995,18 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
 
 	handle_cmd_cnt_and_timer(hdev, ev->ncmd);
 
+	/* An unrelated command may complete while a request waits for its
+	 * terminal event. Process the reply and command credits, but do not
+	 * complete the pending request with that command's response.
+	 * Unmatched replies must still reach hci_req_cmd_complete(), e.g.
+	 * for the spontaneous Reset workaround during initialization.
+	 */
+	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
+	    hdev->req_skb && hci_skb_event(hdev->req_skb) &&
+	    hci_skb_opcode(hdev->req_skb) != *opcode &&
+	    hci_sent_cmd_data(hdev, *opcode))
+		goto queue_next;
+
 	/* Indicate request completion if the command failed. Also, if
 	 * we're not waiting for a special event and we get a success
 	 * command status we should try to flag the request as completed
@@ -4998,6 +5023,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
 		}
 	}
 
+queue_next:
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
 		queue_work(hdev->workqueue, &hdev->cmd_work);
 }
-- 
2.56.1

