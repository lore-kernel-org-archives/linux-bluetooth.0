Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CEC3FBB9
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140725; cv=none; b=NZYCXaLncotwJ3rf2gz7eH3fW8bx+J1nvaZJ+wLRCcWiG3UyQjJCq+ZWK9kR8csQIOVUBhD4RY+UQq2GVltZl32pswvdENSVNs8wpuWzMAQlOOLeIgSCGCkRNGJwki2B7ljviBfxxgGZoEVIbByswib7+FQIwA5STUhY0NzD4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140725; c=relaxed/simple;
	bh=DDJTxigrYJNe+hvasrncv7SuwYqHmPzvt3OB4e1CUSE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUtjyq0uC3Scg+bjR577tcNJu9eQE/5GbppUri632UZVB6M5KwgxEdfozgpndGgvHgT5iaZiOniOdt+lJiLM8nd3RKGvuYa8U5wfuBM7NAXnBBCHdto9JMLIItkDOK0m850NkN5vm/L60S8AJTOMEbP4oDKh6SaQMk9TJ0XdIZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0OSCyiP; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0OSCyiP"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-471e18cd6e3so1105514137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 09:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709140722; x=1709745522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkEQHRvIHSxiCUEkiY2X+Bz0cgrubH+U32WUM2dI5yc=;
        b=K0OSCyiPAVzKC63V2C3nhHITq46rRZOQlGOz9JROo500r9Z/ANU1JKuA5/PesdPDrT
         g4IwjTQdcVlNZt7nGCqNdzjR4VumUJovlaUcq11JP3dfgiijGuZp/KwM8mPz89ONe7pc
         Wq/cAw0Z++6+HcMZ7Q8oO2Ho+oDQBe0eNvwTtDbcT+jvNAiFjqAfi1ke8fR5g/C6cZBU
         sk6ztBJPpUgOKr3WoCiQYqkgGdNZba/NxdD8l0Eu8u0ROX6lgy1OcDldQRVrD42VXoXx
         8YBJCS9RSjABphF0AkQiRRsojDbcSf4k4A5bAz8k66iuwBJV+UEP3/laSySCmrQDnan7
         RCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709140722; x=1709745522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkEQHRvIHSxiCUEkiY2X+Bz0cgrubH+U32WUM2dI5yc=;
        b=vZriETPqSgH9p+1PRfpYuGU8xShUYgDg0F8GJUd3bak6j4E9v8KIj6cVdPIlPR+KDL
         68hKGJiKqdwa/FArFjaEPC0i8nf7coqpBhn6xUzWLO346s2jFAw9WkrXWXRukkBnrA7G
         JMaOJMxKZNmQXYRfxply6j3uUWtqmPybhk5lH8DRoGmT7jdwh4+FPRXkTMh0TuVNavHz
         FuChm3ZA9t0CfkP7L8u8vriob7vZCLM7qz7za5Vw6VvJ9GCuX71avpG7op9U74jXypDO
         eB0c9xmCdK/BkbuK7yynn7tmiQl7TDU+EAxF9suBIjTgNk0G5bG7bYpsh5NGDbD+z48K
         4uFQ==
X-Gm-Message-State: AOJu0Yx3+w4ggLHOhOU7Elg1hKSKm8Bhtq2CkZjvyJCnXBIsMa+aE4CG
	bhnHzB07EcL0xmKevBreTeplqx3gW7juewOcw709jsDOymys4otOnuF0BuWq
X-Google-Smtp-Source: AGHT+IHSh8oA+5/9sgD6UV6k/yoDb0cEogBBEYkW145G/m8aCtmrDnXzJpxF0z3akhXLLhKZIrEhWA==
X-Received: by 2002:a05:6102:954:b0:472:71a3:6071 with SMTP id a20-20020a056102095400b0047271a36071mr210706vsi.3.1709140722294;
        Wed, 28 Feb 2024 09:18:42 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id q15-20020a056130028f00b007da5ea1638asm1488240uac.1.2024.02.28.09.18.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:18:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/4] Bluetooth: msft: Fix memory leak
Date: Wed, 28 Feb 2024 12:18:36 -0500
Message-ID: <20240228171838.2414532-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228171838.2414532-1-luiz.dentz@gmail.com>
References: <20240228171838.2414532-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix leaking buffer allocated to send MSFT_OP_LE_MONITOR_ADVERTISEMENT.

Fixes: 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by address filter")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/msft.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 630e3023273b..9612c5d1b13f 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -875,6 +875,7 @@ static int msft_add_address_filter_sync(struct hci_dev *hdev, void *data)
 		remove = true;
 		goto done;
 	}
+
 	cp->sub_opcode           = MSFT_OP_LE_MONITOR_ADVERTISEMENT;
 	cp->rssi_high		 = address_filter->rssi_high;
 	cp->rssi_low		 = address_filter->rssi_low;
@@ -887,6 +888,8 @@ static int msft_add_address_filter_sync(struct hci_dev *hdev, void *data)
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, size, cp,
 			     HCI_CMD_TIMEOUT);
+	kfree(cp);
+
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to enable address %pMR filter",
 			   &address_filter->bdaddr);
-- 
2.43.0

