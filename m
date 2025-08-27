Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460242DECA1
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310772; cv=none; b=E6LAArVqcyDTgIlSML0zUO6nFMvCon0i0OePL/Z9hGbMpxh0fprquMcry9DMpzheqWRFiIF/qhXDOgKpIgX8Zp9gQD7Ge2SgPBRzrZWUdIlqIZ0i2yneljEaH7ZKSsAuzroQqb7DmH8k0mh1WoqiKqdlcGFIg2h+UrsSnbMe4sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310772; c=relaxed/simple;
	bh=i7xbEij02kUW+JOH787j4LwxxJYsvntx1JUDNrQL2sY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R75MPuykNSov5dXjEAXqQ0FvkXyEBy4e+0T4WCF4YiakNjgQRzQi+ZXd7QtYowPhBVR4HShpYj5OmEXFhXkewTsxEtMNOhZplW3Y/qq1fb5GCZbRF2T9kVoGphdAOhqHfB85fmXKECmPoMnXEBjWav13XxaairkhfWk6eTGmUsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUlEchmA; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUlEchmA"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5446e38eb64so56202e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310769; x=1756915569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8y59tFFO5Og/CcmX554lkn/JKpYsKp3dCTqKW0xDYc=;
        b=KUlEchmAI9Ks6aJteESX9REEIU6ItG9WXnEqMcYXqa0uZFFJDgpxrJZjYgSLcFr5hA
         zCh4mpuk/ijZgslFy4FgicpauWftdrs6kCWvKzo9S2a6d1M/vgtCECngI6pOQF/tvpgU
         KaFRPyFIH3evuqdPUxuKGkU0SimUSdk6SMub5app45xquncUYJ3DmBrEbFBEka6kLac+
         dqLlu6NnRSusc6pbqkD1qbPqTw5CCTfy8T5pOgTKUHuumtl9MuY07Ro5q8pWipAbJimL
         l79sOIwM3vJQyxu/epn8ZUa+DduCL425iormXyCkht8sIt9o2QumVBYe2tO1OfcwTap3
         xDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310769; x=1756915569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8y59tFFO5Og/CcmX554lkn/JKpYsKp3dCTqKW0xDYc=;
        b=rtOVfTmqFq9jM2uGmZj5Dam+pR9dybIvZLHUn0FJcYPSdGtmG3kPmyEzOXZbnWnD3X
         gChs3pJ5YcqX3/TJGsBuVBrzV7nG7xca8C5qmFubv264/SfpLl43l5ICHSn4pAeB9Rkz
         KIM/FafuLWW/NaQVr0EQGy6L3L5YrNL3Sdh5r8QiRccaZ2TcCbWpPGj3yKWkECueM5W8
         bKEI2h1A2xGBbm6Xjr9tgp6X+EB8IR8uFsvJURMDO1XA0tbsdHyhGQfVf3dwcttepK5j
         AaBQzvu9FkJ8swdsx2KgJKCFZaq+nCdsTEN4b5TVso8yuhTpx/dLrrrW9GstDNNTksu2
         hnyw==
X-Gm-Message-State: AOJu0YwuBMu3Auho/KaEqSin9Hg9JStDYLEB300q9z+FFydoZXwbX4H/
	zD+E12+8o+R6fzfikIxb1m6YecP7EVzOECH6+dSmoK0qmgOnpjOnYQh5sJ+trgcA
X-Gm-Gg: ASbGncuwyI5FaQ/IszQBjCckiMSW92b22Y4wRbKsPpGlkDqbGTLWPp9JxOb5ib5K0kt
	StIVAyeJC7WCvQNNBf40uXRvBdVgEbJduyAefgqwD9sME92vw3hnNJkDbY+8nMRJt3chiqrZEWT
	YO9DHodwv44rrXM3/eTsvtTTcfL63sYDBILB9BAOdtp5cGdXHlw6CH7E/lj2Crb1dVltOrt+aMD
	7gQU7a31g+pvyA+LJyq8XjdUUU4ttBwjuYlG1hfcrle2rlQG5lcIH6yWPNAWrixVTNlsjaUNDtF
	fqlfdOCWGg6SWWjsZpoQrBwpnd62jx/KdmdJem+yegWICeffFy4KGNxa50oJQ+bEi+0l+bBFuwB
	02eQWNJWFCckdufNGj1S8hXD53iC/XpzupxcUUFtc/uhA7UVoCwj0xbNTHdmGQep8SLesCZkQ/3
	vgpEyxQf/TsmiHGU7x+lS/qRwgyvl26b0aWACj+rA=
X-Google-Smtp-Source: AGHT+IGga+H5DjZpIQKMQXVIfB2/EqSJLM5M33dWNWG6TN6skhY4wkvc9XHMTjIX3NV/qIwRWM5YLg==
X-Received: by 2002:a05:6122:3c51:b0:53b:174d:98f2 with SMTP id 71dfb90a1353d-53c8a2afd87mr6036039e0c.3.1756310769160;
        Wed, 27 Aug 2025 09:06:09 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5442e4c4e3csm1060135e0c.14.2025.08.27.09.06.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:06:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/3] Bluetooth: hci_core: Print number of packets in conn->data_q
Date: Wed, 27 Aug 2025 12:05:54 -0400
Message-ID: <20250827160555.1446966-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827160555.1446966-1-luiz.dentz@gmail.com>
References: <20250827160555.1446966-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to print the number of packets pending to be transmitted
in the conn->data_q.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f91ead01f261..5078d7de6a7b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3267,6 +3267,8 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 
 		spin_unlock_bh(&queue->lock);
 	}
+
+	bt_dev_dbg(hdev, "chan %p queued %d", chan, skb_queue_len(queue));
 }
 
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
@@ -3298,6 +3300,10 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 	hci_skb_pkt_type(skb) = HCI_SCODATA_PKT;
 
 	skb_queue_tail(&conn->data_q, skb);
+
+	bt_dev_dbg(hdev, "hcon %p queued %d", conn,
+		   skb_queue_len(&conn->data_q));
+
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
@@ -3357,6 +3363,8 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 			__skb_queue_tail(queue, skb);
 		} while (list);
 	}
+
+	bt_dev_dbg(hdev, "hcon %p queued %d", conn, skb_queue_len(queue));
 }
 
 void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb)
-- 
2.50.1

