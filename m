Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86A43CEEE
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564248; cv=none; b=OBCYrrRmoBairZjX787LTBCmUeqMG/564balptpjeiG8dkLXchI0+tRHbmnI80pVE1HNr5nFi/oHztc/PjCMLaDnZWJh3HjHqZXjJwY05JzeG4V2FYpRvbkQj1a1P1yS4ZtcMzwcXAzYLvDenoUWripKgQVtrto6rfwfEDmWeRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564248; c=relaxed/simple;
	bh=l9W2wL9n1BnbNB9e+Pd9HayxGawVzMrl1//pFSzsERs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XvBYT7dwdDkHvRKYqXNLaRogPX4rQuQqwgAY5ouYTH5x2hp5yyJ3hD6vVUxAN9pxCBXk4FI/9rpV9sHEq6U5hCKWJNdzGS75tEbN8KgSWIuM80nXWmMFNmkoA4b1JaO1QdhJ44OIQ0TUg9aT/T747M5uFrxglSL6C92ZJaMJwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0EAv0Er; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0EAv0Er"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56f3e6bbecdso396144e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777564246; x=1778169046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOCTQsLc7aZtkFgQC+bhYtKzA1I1EcWEyXZ/7l19w+U=;
        b=P0EAv0ErkSxy4CHv/BSsQrVMGdrMJhWVB4QAzaXyAveu2hBn6mCA4ffdK5ycgguUVP
         RiiUsoCWq46gsDA8NDIEDxZNQjK8sQxb3CIBEjKhg2OC5EHZlRtB7VoAEMdn/mLRTV0p
         7tySDO8iIfdagFuVx3aUFFcNtqm9BaOtIYct6kL8EedaJelobNDo6IQH/16Q9juFWz3y
         tkUOGE9ny6J8rBM6fn+Ra0A2T9mZGhCK+PuJPGyAQ7mEVRVoCKaOPEypl88Rm6gc+3Tw
         2T886R0IQDC6WaFwLeJDNuV7ymJ45UE2nbeuAS1Flzx+ilHKxw5FWpLc7jYFM0/a2UED
         CN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564246; x=1778169046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOCTQsLc7aZtkFgQC+bhYtKzA1I1EcWEyXZ/7l19w+U=;
        b=UU3TQIgtTD8c5W4YZN9tJCZ7xKjO2xer2P2C4horcmKzwzSixDWLN90MtO6hkb6J+g
         GHKizTaVONkr1aSny6y3bX5WEjrqN1IXFIqvyBXYUJG4Vl0mHQoUflRuEcrd7RPdKy1a
         h4S4ICmAN4ZKRPsO42MHhfUrWKIQOiKGRf5DdaExpxukN81TKZ6xy5tZwX/2LYVFp2Me
         wdd+WPBwyvDr16fHN1guFEw7IdHlLPgEvsbhtxmpv8QqCB2m97HDO1WlsMVyhubK2QLl
         GUKo8HqIAMG2h1JKp08ic5qB4pAuRUeutY7f5HmMEdlzR9SdbnnIhP4AdeF26G7MXdkF
         rcog==
X-Gm-Message-State: AOJu0YxEwnJ+FIPubump6Jf9G8alkKHNhUnFrlfxsZtSxOXGPU+q6PKg
	kHuF20c0ovlhPfeTijdUX0uLpn+tE/zMJvcjVVaP/y60M8m5NXY1/jityiVi2w==
X-Gm-Gg: AeBDiet/2T5NTTuDGe3N0osWPAhoQUXbNxLsFQ7udxK7xJLphCyuv1Z6aKpF+WnSqNu
	DzndlVPrZyV5bc8xM1r50hfEQR00fy3VLbH1Rp1Oef5lNQ/uKbsuOU/cdYrwGby4SOzxUB+chCu
	o/SWwKHR1klt1SCTYdHNtoSbucgw1QDkXGjR7dE8Dd5UW+x1SqTHCkgmfIHGFfdMC6KE4EofdCs
	z1Yq+ojHrjedx0lZGSUqipZl1EjF2Kh7gPYzOHGpA3In0z3ejwCW+DEjxqjWa9j7zFf1KBNGy01
	oSLadzNzSrIGZraI62R619EdLurIIEJH0bZCZ7OrZ/V0pC4/GEJGVnqVQE9NiwmXKuLdyQgw44M
	9qSPYn4G3X4A7sq+sXXaTKdhOPcQh5FS5vA8GEJ0BsnEOnGOn4iu4C2CmK+phEpRt3k3XYLHgrA
	d0tZqw/vvS2bpcX20RcqHMFGwAm6OGppb547J2x3wa5nCCWgwWz9hq8EGQQi0FXZGvYkDbjFmdB
	N3Ir/Ze9t0kYpKtq465UktSloU3
X-Received: by 2002:a05:6122:4f8a:b0:56e:ded3:98eb with SMTP id 71dfb90a1353d-573c95d7b93mr1599452e0c.6.1777564245779;
        Thu, 30 Apr 2026 08:50:45 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6dfa5b4sm3199545e0c.16.2026.04.30.08.50.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 08:50:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH BlueZ 1/3] shared/hci: Add BPF filter for registered events
Date: Thu, 30 Apr 2026 11:50:36 -0400
Message-ID: <20260430155038.426968-1-luiz.dentz@gmail.com>
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

