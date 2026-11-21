Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231926;
	b=hYXyKs7dM6bwMHasFdOu88n0w5lEHlBMkDQgkwwEt0+BRG8cH2In1y2fsepV72w5wt4B
	 SYXrnCTlA2r81RwkHUios2mRVKpWrDofTkHxHSbR+iTs8fqwt1xgu6e/Hg/suS1mOqwNk
	 NI9p8v737Aq6q6FE8ebQ9Pfv+3gLBlveHYRrSE9sgnO5HaLsNCY4v8q+hFvjC8q00+brw
	 c2Ks7R7Z++jcE2j1XlTYGBS5mYzeZoG4MM6+3eavud09yaeKohbFAUnU5BN2N5JRnsw3/
	 sZcriW/fOtSjgWmRUDGOhTMPBsnrpktp5/KMRzd4BjefbhwjN14MKiFgZlwTZ7tu8Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dzWuG6elwKYIyR9wRkORUHH+YbmAZopYlbWmaOd8JNo=;
	b=q13gNrD1LxWNh9BHJDc3Hp87jJCnAEEjQ43CdqGG3IvyAdGFoAJxtIH5uwi1AqCOuW8W
	 ONtmORHhZivOikVwVkNlHwmiZQ27HKRHovsjlB7nAMxtQwKsbdwQpP+L8zMcA1L6hLubP
	 YIz5MZ/OWSTn472ErcZCTTWq+WLNoRARC8sntkjxBZht4JKFQ4VEHI8qgPre7aUhuDbLR
	 Uo+PA6nqGQ33uhswXcoQoPBu9PTiqj+w9H2VKGASuS0n/jaoVW9uHmMUwnSVu24YE7is2
	 sFtf/wiZxXp439gaWE5CenFb5kuqGmbKy7TnpPRiDMTM1cy1F2gzlFnJZbT2pE+ysMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9SuaIVz;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7C606A68B
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 03:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16B7C606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9SuaIVz
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ee27c9eec0so474801e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 19:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795231925; x=1795836725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dzWuG6elwKYIyR9wRkORUHH+YbmAZopYlbWmaOd8JNo=;
        b=S9SuaIVzCYiKD90jD7PQ6ZrHG11/xh1E3qFOAg6JWmhjAnH5BNq2uLnNHSK1DUJEqF
         HzrQPaR2It0olkcGNuV0Y4Lv3iRHKqIIKMKnvPZ5dnaM9XM/KKQX3CJvK6xa9x+/W1Ub
         VMjQefjHQX5iwvtdlNwaYjwyZrGLm/cQ8vWZJTeKQZbBJTL/tFS2Ws/Dm6Rq8LNZIvKy
         7XdOh7dbqgSNpX+XIHmnce5cUcH2HSn93/Rtfqr68Qs0VTThNLxU2iyNjZfLPw91QDw2
         MlQX/+m1XtPPwra22MV16Xa2JnbQqtsuxCGc6R+HGiELG09dn5fLA/5bHKKHGyKiLAt6
         rbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795231925; x=1795836725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dzWuG6elwKYIyR9wRkORUHH+YbmAZopYlbWmaOd8JNo=;
        b=kFEhX9aR5td+/ZSbu+AHk0CrNgv6c5KrK91i0a116acGyrtmfxnBXP4aHpt5Lburtl
         uzTnYwTHtrgAlqDCMe2gkgCbE4/ePvgTcD01/AN57jHuLiKoYTG/sjw9yXTZh9GAeS1D
         JsHgUksoW/GvKfK5umiv2SV0hzk4BjsukNAVI8clsLaFFYwRan/saooB6zXSur2uvraw
         pWgpedhfD2os7aLRVBi7egC8e1SjwymZL3nAVSxWUn01KsW6Z2o5z1+/3RvWM99pFt7P
         3uajrFPVlMGw6p7RGARaqS95cUQ+XBu+IfNAF0STHPGW+BVBfBR5yIs5xpotg36Rl0RT
         RD7Q==
X-Gm-Message-State: APuU4Z9+6Jbe6FRPaaQ+NDhkIUn1ClkWTocTAdvcSkPWkhJeiMRo8e/Z
	D9jt/ywqV2ybDNPiFUv016raPFPa/Pfnh3VXch0TwAbcTFBLKuKzL1f3TJyGQSHe3pQ=
X-Gm-Gg: AZFdTZd5+XLjgt15gPpCt5BZilmHGo9qHBYktBgUUv/iF/5EEk7OVJnPlbZgPERsRZG
	WMtER1ZRuZY7HPk9oZcoWVoUN7DYb7VEGiYW/KWGga6Ed4LV1BXV91fWEFgpB5Z8clvT1A8zJyr
	frkkAqZBuGXLgp+uO8ldzhVpYVf3CRmy7R+ln9guO9Q9FZ8M4hT1iHsa6SO0Nkc2QPvqcKz9J8I
	pldoKDA1OY6bJuQux6rlG6DfTHqtQzsaFO+R0JFH2RDKyfst/cc9dI2O0HCdawr/wH620KZf7Ak
	Pvk82tFUj2muyjA5xcrEAVGIzEC7FB1xt7Bhv+5EFEXC7AKQ/bC1UnrYrfCjWwExzxqfg0MPSZn
	dsbVJzj4BVA+9NrmQbcvLs+kyvVDntfMgQopTV3XGXbh2BY6ybeBumPxuAcHLt5E+D69jPGpQWO
	uKkgyFcDdg7gov1QL65nxTtVSodqyvEf5vXTLmrnnbE60Tsy0XNdcuTzsMe52gJmZWXWtNiSWaH
	CaTwwiXBdtQA/2t4slkSK9wkZQWAppS4SXn9PGDYfgijHonxe9qty8b99uoJIW4EFzRgnqQt/5k
	yoSjTsfwxeyL8W0i6aFnhYc5mNMWdURU7A==
X-Received: by 2002:a05:6102:6f06:b0:7d2:8e49:f90e with SMTP id ada2fe7eead31-7d7395fe209mr1549680137.27.1795231924815;
        Fri, 20 Nov 2026 19:32:04 -0800 (PST)
Received: from shine.local ([168.196.221.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f3d7bcsm4871081137.4.2026.11.20.19.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 19:32:04 -0800 (PST)
From: "Andrei A. Bykov" <andreiab9019@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_event: keep event waiters pending on unrelated replies
Date: Sat, 21 Nov 2026 00:31:03 -0300
Message-ID: <20261121033104.441146-2-andreiab9019@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121033104.441146-1-andreiab9019@gmail.com>
References: <20261121033104.441146-1-andreiab9019@gmail.com>
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

An incoming bonded LE connection may issue LE Read Remote Features and
wait for its terminal event while responding to an LTK Request with an
asynchronous LTK Request Reply.

hci_req_cmd_complete() accepts the reply as a valid sent command but
selects the completion callback from req_skb. If req_skb still belongs to
Remote Features, the LTK reply completes that request before its terminal
event arrives. This releases the feature hold while the connection is
still in BT_CONFIG and can immediately disconnect it.

Keep an active request with a terminal event pending when a valid reply
belongs to a different opcode. Apply the guard to Command Complete and
Command Status after command-specific handling and command-credit
updates, and continue scheduling queued commands.

Limit the guard to an active waiter. Replies following cancellation or
timeout retain the existing pending-flag cleanup. Unmatched replies still
reach the spontaneous Reset recovery path, and matching replies retain
their existing completion semantics.

Observed with an Intel AX210 peripheral, BlueZ 5.88 and a bonded Windows
central. Three unpatched attempts disconnected immediately after LTK
Reply completion, before Remote Features completion.

Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Signed-off-by: Andrei A. Bykov <andreiab9019@gmail.com>
---
 net/bluetooth/hci_event.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ab875b9..5281551 100644
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
