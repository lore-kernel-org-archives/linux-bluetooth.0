Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529438;
	b=YTpfOF5qTH5A/3Xg/ZQHHo0nGPoHoFHon053K1UYtBdK/GmLnRdmfnZVUsYF1Dn40K45
	 Sr7AOqKekGLFIpRSmXKzbDf+BgF251O41iWVqxGRCBfGFbcQKMqeQxmlnq+7r35WwpeC9
	 py3FNNS2Iwa23A4sJzUNWQGVdml/HK0WDNDlDosHjWKRNNFy4uny4Orb2Z6ovevepla5c
	 1Q+0cYg+KvgCL0G3rIbA/7/Zkr/QP+c52YshMOa882AR5xJHNWYrFXgWnlwBE0haXyXxm
	 2KAI4MpgdcGfMvPt7WGYsbJFeCz1csbknH2z155LxQ1T0OV6sdhTTo7XHkkXvzZkVbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=usmzJFstSB4DaIIYnuydnpavcKscN4qLr3YgErVbc3U=;
	b=yIrM4pr4D/Vy6xTIRkk3fYSxbROMgeFAkX+xo7c7umxCt3cftP8TraBFHLWBhud2rLd6
	 13lVSQT5XAEXO78cfj3wcacPMdNYefiCB9FxCAREETEbamkE9X9P3+1rBQOc5u0/03Hrl
	 AbsNB2fZNtN5idjUjlh6YfDViF4Eh1mQwXYkQPP3CItPv1InoWw0XNiqVXCDDBcqvizIs
	 +UmSe/mp+wJ2tb7HaPiLmC7r8SaZOn6WjPQ7lAui3IdFsV4D9PNBWAagcd7klD/jaDbUa
	 GxwLPsN7KV2O794x0g6BWH56djjJwwd10lReq67Yp7D4/OoZHcqXjuFCnF1nzaCZ41g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J9xxH0Dy;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123A606A695
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C123A606A695
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J9xxH0Dy
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so2391226241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795529437; x=1796134237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=usmzJFstSB4DaIIYnuydnpavcKscN4qLr3YgErVbc3U=;
        b=J9xxH0DyVAEP6rqizec2uRhXIk6WsXIIIydwKq9un+IGnZ/tNvdJ8AAH5iBjjvg0IN
         2/+VamcKewv8Wr4uvNlCHEsY3jQIMV/MUZKA7eoNHgVN/Glqog7Ai5TbDMysKq4gGxPd
         4/apyJp72vyLpTWnDjvzequRa2brK/kF3zEJa+avxORP09Z+zJ5RfsoCyeB1QQ18+EMJ
         BWZblITOHAaLFcIFw3bcjo53LbP7JnUZo9FGrxJ1ghPha3VcxIaZ821dUBkQayWQC7+R
         pbRW96CNMpyn+eLn+b6SkryUZYD1KEMjRQIvC0JqaWzufKmX/VF6NqgBO3jyaANJ+eMB
         +e1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529437; x=1796134237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=usmzJFstSB4DaIIYnuydnpavcKscN4qLr3YgErVbc3U=;
        b=RT5rQAlmFWjc+9VZBCJPzNh0DYtscmYpE4USj8qjrQ1AXSLl8TquqSQV4iOGnfZYkZ
         6XHNo4TneYQLz1J/XxnujtvN5yMyG99/RXcPSF1YdCTAh9X56zcJRVwfMnIctU0SNcmi
         TZ2A/Y26GxyjFKJoy2MOT/17JbYSv/L81veSYNcgSYN/A+zq06WBtyT++f+fjXmQpvbO
         bYoI7xG1tBn0yRPIbiTyP+gr3x3mv45G/W2CvNdaFWxwt9KswaVFmi4hmGduiEarlZRR
         6k2SwFs2xPEwHhW14XNJuet6ke3sxGzithvOAuXcc9lI2PEmqNI+F8QR70XDNdkINu05
         JURg==
X-Gm-Message-State: APuU4Z/inrCBkpe20BP4TaL2/0176n3GOdicQ+rS+MW4KHHkZY0MXvAn
	OkQBuE8dHkOh+BpqnlUZjX1IeujVGEbNHEgDyrPfdZ20f7CtUHgcPuw8ZUlYbH47nPQ=
X-Gm-Gg: AZFdTZccWNzU/qn62yvUibxZiIlv0ijH6PLW/8UfAoJS34onqVHH+tB2XrBKHS6evag
	psX401AJy5aczj7Iwspc49/ogBDJpIaD7robDwTv16kuex3eQ/WcTy5fWlqeXWkWP3KR8TADyAC
	yGmRY3CYb3+mjvNca3c3jRoOCi+CXHQYmJsWJZUxZ++572jjZh54KxwUGWB89WlzgxRJ/zJtUKL
	PFJ94PDyEbnxeN1uUYbbRbje2SODUFJ3N30iIZjNukrO/pQrBxR7XtBiP8SA6jGjnJDqv5eAGDo
	LgJydLYlqYm0GLfoVraCvl2rJTC8031BHxOQJ6ymEtg+s6DGYQW6qea8bot659Fi/Sunuzo2elS
	Nb3GwwAin2DdcOyppSj6jE+Gu95c96EE6BANPdpKsMkgyP5YFnYeWt7+87Qs6Dfmx05ji+ULSAe
	lgLxLYsoKlX7hOhOkBSELOTQ8bCKz89oYR0nOSqm/z6dPZrs/0bgN7oxHJiYtg1ecXs9rpo18T7
	JYdHR32oG/4qsIZXrP8YwiepZCCqUOPDU7DAhexjGXWMtzrUd04/A9JCxKmGSY6j0GSrS50wxEr
	fcIGwpO+cj46YU/QmQ==
X-Received: by 2002:a05:6122:6162:b0:5c9:a60c:273d with SMTP id 71dfb90a1353d-5ee8af7629cmr8104492e0c.21.1795529436577;
        Tue, 24 Nov 2026 06:10:36 -0800 (PST)
Received: from shine.local ([168.196.221.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b555137sm14056121e0c.3.2026.11.24.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:10:36 -0800 (PST)
From: "Andrei A. Bykov" <andreiab9019@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_sync: keep unrelated replies away from event waiters
Date: Tue, 24 Nov 2026 11:09:55 -0300
Message-ID: <20261124140956.15296-2-andreiab9019@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124140956.15296-1-andreiab9019@gmail.com>
References: <20261124140956.15296-1-andreiab9019@gmail.com>
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
index 255005916..ae0773a81 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4284,11 +4284,25 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
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
index 039bcea98..477b876fd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4487,6 +4487,18 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 
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
 
@@ -4496,6 +4508,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
 		return;
 	}
 
+queue_next:
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
 		queue_work(hdev->workqueue, &hdev->cmd_work);
 }
@@ -4606,6 +4619,18 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
 
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
@@ -4622,6 +4647,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
 		}
 	}
 
+queue_next:
 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
 		queue_work(hdev->workqueue, &hdev->cmd_work);
 }
-- 
2.56.1

