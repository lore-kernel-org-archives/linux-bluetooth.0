Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B97275870
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646341; cv=none; b=LTojFUnef6Ef8EhdgKIUju1hHzgRebxU9YG783sXdJDEJhPPhOnIvbbY+iOnnpAlciOvrEWtIC/IlVuZfag8XwnUorbQMGty6RX8DL/f614JUlpsm9jEyOd+OiehVf78D9fT3yLZUEXwZl9hq8wxr+pofVqkj/0wDcm68uCOd9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646341; c=relaxed/simple;
	bh=l9W2wL9n1BnbNB9e+Pd9HayxGawVzMrl1//pFSzsERs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c5sCaV/aclra8jbkglOwQVwtR4vsAbdJA4C/GWGbJVYygBYZQkRwXrh9nE31i24PXbXcSXesm320fIIwu+Fq2G8MQL42TSPAR4C7X3MCNksf72gFftY0hIKVNvkDENmVqIr5p6D64qdE+BKpRBM2pBn2NV94mEJRdBYYth/xQEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTK4at9g; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTK4at9g"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56a9076813bso831413e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2026 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777646338; x=1778251138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOCTQsLc7aZtkFgQC+bhYtKzA1I1EcWEyXZ/7l19w+U=;
        b=jTK4at9gJkgRvTh1jpviu111k6WlpsDVRk8pCMLHp1E01KzlQKJ8YewHzU49CNzxd8
         wzwsg4lVhTorn5E+hZWLkunaZJIlitwvjnwHUYwZ7SXFSYPmQW3Iap5apZ9DHlgVIKO4
         54PMUPJAGYIBPoO26fTtJEgZjmiU8YuwtosEHOiqscg99a8jWNBRpAAA+jme799aj1l1
         xc3cXhiwXx2wV+JqTGxboVLMOwl6N4qBakdZ5U0ahWqESGUkomK8LxzNwz4rSClEXgfH
         FjxtjPxA6b52hmZfsDxz0qnQkiZ7CY9TriAsXndFbKn6eIAASOFoAPXS1nVyMAPVDn2g
         iqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646338; x=1778251138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOCTQsLc7aZtkFgQC+bhYtKzA1I1EcWEyXZ/7l19w+U=;
        b=sG+nM+YoRZ8awAJJTUHl8yNHyNLEJmLxtm/02Gh6SXQ5SS0dlkXgc4pwI+6WPOqcM4
         lebjk4L9a8Mj9Xz+0ba4VWH16qcGy578FTo5sEWaCsDf3dhmPCih+4MvQIor/Q+qXKs8
         1u4OjITm0x901kkUFBMS43c3OEro9bkAKNUr6PAGC/NxmJhb12Kkn5dsa+qf/HZU5QSc
         z7cd+mXMFvCWMwEKOmiWzGCzwA9PsRLzx421rNyHA+FQGppGHNxaOaiCx5+x5vuk5WM5
         Nue96epe8C8ZSGMe/ldoXmcDqoYsw19QLGQmE/3mHbEQC8EfYfgyUaqzbLqiIoZ7lWaI
         YMFg==
X-Gm-Message-State: AOJu0YwBppM5ID/T10O6boVOZq9UeNj2L21gpMcmXX+RCU0q6riRfABF
	hPgKS49Gjd5LMHhKChsutPJRSv3o/O87Gx2ANODB00gfrZI0S7iHnci9vfD7DazL
X-Gm-Gg: AeBDiesToAYZrWnSWL1gmnVmKClS1cJPrCdAi22NjYx1GHlYjdrnSrfMB032Oy3LKpp
	1mNd9mTn5mKckd8aJli5eA2pxeI6kDu2f2qk86EeZuWa5nnXPo0sqLN3+hxKp/hun2Xq5UUazGM
	wy3gQ8X7EFucB9J30k/vByhmmcZ7IzSm8voiXqpCBv1iqp4lbDc6cYSXw5phvLZBVCxyhJ8sMOE
	U1w9An2E7G5mUxQUNTEBx0nnWhatScXOBCgLH8WT81kXnqiTvRdIlHPwZisNJxMZXe1cOCncBn6
	LBgs5dHkk2iLNPGF3EAjUenCJAB5KIOV5fPHxtXTsN7fwJEmb/ufsLeCqZ9hRl+tvlv/bvT2l/k
	hp3hOEvI9dutNuQI+xW0eYA63FPFX2B1TqGxK/LkswzJISF4OUadA6rQnHMyrE1jFeHdDWSw/Lm
	32DTtXS8NZs7wy/3IitajBn7ildkXNAp8K974J7k8LtXw1jFPNtxp9kz5Ae3sse07orKDo9wY6o
	nwWYNHub8ovpp2+qh9dOZKKr8t2
X-Received: by 2002:a05:6122:d26:b0:56f:2aaa:450c with SMTP id 71dfb90a1353d-573c961c24amr4479724e0c.1.1777646337871;
        Fri, 01 May 2026 07:38:57 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6dc7dd4sm1531895e0c.14.2026.05.01.07.38.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:38:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/4] shared/hci: Add BPF filter for registered events
Date: Fri,  1 May 2026 10:38:44 -0400
Message-ID: <20260501143847.724150-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Implement a BPF socket filter in bt_hci_register/bt_hci_unregister that
uses setsockopt(SO_ATTACH_FILTER) to only accept HCI events that have
been registered, plus BT_HCI_EVT_CMD_COMPLETE and BT_HCI_EVT_CMD_STATUS
which are always needed for command response processing.

The filter is rebuilt each time an event is registered or unregistered,
and only applies to non-stream (raw socket) connections.

Assisted-by: Claude:claude-opus-4.6
---
 src/shared/hci.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 0faa6dea555d..5105b0b2f320 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -23,6 +23,7 @@
 #include <sys/ioctl.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <linux/filter.h>
 
 #include "bluetooth/hci.h"
 #include "monitor/bt.h"
@@ -565,6 +566,85 @@ bool bt_hci_flush(struct bt_hci *hci)
 	return true;
 }
 
+static void update_evt_filter(struct bt_hci *hci)
+{
+	const struct queue_entry *entry;
+	struct sock_filter *filters;
+	struct sock_fprog fprog;
+	unsigned int count, i;
+	int fd;
+
+	fd = io_get_fd(hci->io);
+	if (fd < 0)
+		return;
+
+	/* If stream-based (not a raw socket), no BPF filtering needed */
+	if (hci->is_stream)
+		return;
+
+	count = queue_length(hci->evt_list);
+
+	/* Build filter: load event code, check defaults + registered events.
+	 * Packet layout for HCI_CHANNEL_RAW: [H4 type (1 byte)][evt code (1)]
+	 * So event code is at offset 1.
+	 *
+	 * Filter structure:
+	 *   [0] Load byte at offset 1 (event code)
+	 *   [1] JEQ BT_HCI_EVT_CMD_COMPLETE -> accept
+	 *   [2] JEQ BT_HCI_EVT_CMD_STATUS -> accept
+	 *   [3..3+count-1] JEQ registered_event -> accept
+	 *   [3+count] reject
+	 *   [4+count] accept
+	 */
+	filters = malloc(sizeof(*filters) * (count + 5));
+	if (!filters)
+		return;
+
+	i = 0;
+
+	/* Load event code byte */
+	filters[i++] = (struct sock_filter)
+		BPF_STMT(BPF_LD + BPF_B + BPF_ABS, 1);
+
+	/* Check BT_HCI_EVT_CMD_COMPLETE (0x0e) */
+	filters[i++] = (struct sock_filter)
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, BT_HCI_EVT_CMD_COMPLETE,
+			 count + 2, 0);
+
+	/* Check BT_HCI_EVT_CMD_STATUS (0x0f) */
+	filters[i++] = (struct sock_filter)
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, BT_HCI_EVT_CMD_STATUS,
+			 count + 1, 0);
+
+	/* Check each registered event */
+	entry = queue_get_entries(hci->evt_list);
+	while (entry) {
+		const struct evt *evt = entry->data;
+		unsigned int jump = count - (i - 3);
+
+		filters[i] = (struct sock_filter)
+			BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, evt->event,
+				 jump, 0);
+		i++;
+		entry = entry->next;
+	}
+
+	/* Reject */
+	filters[i++] = (struct sock_filter)
+		BPF_STMT(BPF_RET | BPF_K, 0);
+
+	/* Accept */
+	filters[i++] = (struct sock_filter)
+		BPF_STMT(BPF_RET | BPF_K, 0x0fffffff);
+
+	fprog.len = i;
+	fprog.filter = filters;
+
+	setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &fprog, sizeof(fprog));
+
+	free(filters);
+}
+
 unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 				bt_hci_callback_func_t callback,
 				void *user_data, bt_hci_destroy_func_t destroy)
@@ -591,6 +671,8 @@ unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
 		return 0;
 	}
 
+	update_evt_filter(hci);
+
 	return evt->id;
 }
 
@@ -657,6 +739,8 @@ bool bt_hci_unregister(struct bt_hci *hci, unsigned int id)
 
 	evt_free(evt);
 
+	update_evt_filter(hci);
+
 	return true;
 }
 
-- 
2.53.0

