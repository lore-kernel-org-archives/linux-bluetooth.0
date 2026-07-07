Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B13AC0C1
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461944; cv=none; b=dvm0RMOXH3zTDv1/qKon2NebZESMdHgpsW13/TQLNu6Mwq9R5uXi2ElMWcKB/oK8cjvm/ULIeynPFAKpcnPnewB48E3VH3Xw8kOakCJPPB+HH06qTenaZeJENEFo3FAQNd5PRtWUhIKrQzAXLr2AUl48myCAL5I1HLo29AJOAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461944; c=relaxed/simple;
	bh=pBjlrX7yc7iWSMsIP+cQ2j6MxLyzrTuCrJliZbSWiho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE9wwvKUe5YyYSli9/phZxEhe09dY+xcVoTtxFtbtci97gOkxSOs9nG9zeKi7rNztup38ewtUNBPOfcbTctQ1mBgZpQo7sW0bWDlnNxUP1NVom+Mm3aDLyvwVt1yYRBbHYaNigX8+6YRE/aRkhaw6FOc73raC0/6Mnz7o9RVv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxJkIbSX; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxJkIbSX"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e54f8c051so228189385a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783461940; x=1784066740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuDSN5qpWrmOuyqcOwJR50zBGcAs40Wq+fAb7qOT/cs=;
        b=KxJkIbSX8hkbHeMzYUlgvQX9KEq3BLSNSOGkQZvlWkSpEYIDRJ12xD3f+/PtQPR5NI
         4q6167+1Bo5X2SiU/Znmcj+CunMc1Uh9kXzrR5D0NbO7J2OfNoheB3jQOfICZYqAJ4qC
         T5SbIx7TcPhvtlLjoh3OyS0zPwL0+6M5TIXIZZW1S4n3QspRz32Dc1tEpOYnTx0T87lg
         PncKYfeUPDFZ0+nceV59ZdKwEnRr7Eqn8Nh7jVoEW9Eb/cD/ucZApDJZQW4S60WL/jge
         0oXZ5c2MX9RgriMQqs80sROgRVKZDdl6tBS3uNWWfeKHuX2BxqsWvbzZPTWtFyRe7/tU
         VPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461940; x=1784066740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuDSN5qpWrmOuyqcOwJR50zBGcAs40Wq+fAb7qOT/cs=;
        b=NC83kwu5RGiTcbh+3BF+BC0Y9A3lOEjdfgCOMpqqVZNQ3RojHbulquFXDs897TjdWv
         ldnRwb4mjQOOhC8pm6cINz00NAW3n/qHCnUrJysUhJ5FJEDwGx+zwBdlshHEXq6FWsp7
         Jdd3SDxKmowFJrduvjGHzl5ZBwRXlVeBhNBS71XdEB0Rcz6WiO8TlN6D+TJtOYW27g82
         ZTTKqf1sDWENA7NHgwYwBtVzov1P4g1wa635Ko8sz9EDetHvfWP9+iJl+QIsibwfJ9x2
         GRzTViVEw6bEBGU+183FMNeXaRbOn9KMqp7vtx6+pMiAS9r/i06Jq1vpdWi4JPutZCY1
         GmMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrG0aOM6sPwajVfK5s/aj/7c7iPY5yGgZrBWkzEm1PdkNBEGbCP61N/nYDrNQO5MWH7PK6aq/aeKGstNgJaAU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOyHWll3kQbkdhP8WjQ7WfYeSkdC/L2QEmfZ/5kjw7kaRUl9u
	cpdKYHilhE9ityaNIn+rx2UxxGQc9p3Eppm0fBreuw2ZmIY5WxbQ0htc
X-Gm-Gg: AfdE7cn+bg0dNUk4r7kCfUs/X8OUMUNlLE+7E+ukcoW7rT9OG1qzlW/osP+/yvPYl9R
	gKlcbBMT11ONJmNPlfHM4H++pp/oRmLziVM0t2bBYIXyr1U6MU+VYHLOp+x90TJdXNVEewxTM6Q
	GUSN6HwE3Zk7T0mcuAahWgdzKT/WqtNlYLPSiiZM7PxHq9BbN14uiXpDI3l1oPfqDAdGbSGvUvP
	U+6i5htj5lyp+8lgIQHLwGqTNYxBy7+FkvOWaa0g2SPxn2TNf7SI3qZqH7ZxC/j4/ltrdyZKP3C
	Qpy4IUcUYWdD/rIoXWBXHtPRTQyjLApw/xC2Whwkf9yc44Y03A5Qa3tR+Fry9rQ+h+7WqixT6Nm
	cR97CgCG8UkXokxGWOXaS2c0uMgJvYgDEhgDjkj6lTn9mM0e69lWoULW4TuEEAGqC4RYiBNW/e8
	YTUdhO38m1mv3/Ssv+gb6MnAnLJQFJ9tWYA36i/Oz0V3oW5R+YQoX37O129d9PmzqnOYrRdCjlp
	sgoeK4aQEGiFmrkSm6M9Nq+7NWpWTA6Yxsc
X-Received: by 2002:a05:620a:4009:b0:915:a6ca:f12a with SMTP id af79cd13be357-92ebb58fed2mr863565585a.54.1783461935481;
        Tue, 07 Jul 2026 15:05:35 -0700 (PDT)
Received: from jeremy.kali (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cc18f1sm1250745685a.40.2026.07.07.15.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:05:34 -0700 (PDT)
From: "Jeremy Erazo (Devel Group)" <mendozayt13@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Claudia Draghicescu <claudia.rosu@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2 6.6.y] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
Date: Tue,  7 Jul 2026 22:05:25 +0000
Message-ID: <20260707220526.271712-2-mendozayt13@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707220526.271712-1-mendozayt13@gmail.com>
References: <20260702144207.320421-1-mendozayt13@gmail.com>
 <20260707220526.271712-1-mendozayt13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeremy Erazo <mendozayt13@gmail.com>

commit f4da3ee15de9944482382181329bb6d7335ca003 upstream.

Copy the content of a Periodic Advertisement Report to BASE only if
the service UUID is Basic Audio Announcement Service UUID.

[Stable backport rationale]

This fix landed in mainline v6.7 without a Fixes: tag, so the stable
autoselect bot never picked it up.  linux-6.6.y HEAD (v6.6.143) still
carries the pre-fix code at net/bluetooth/iso.c:1935:

	if (sk) {
		memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
		iso_pi(sk)->base_len = ev3->length;
	}

ev3->length is __u8 and iso_pi(sk)->base is __u8[BASE_MAX_LENGTH] where
BASE_MAX_LENGTH is HCI_MAX_PER_AD_LENGTH(252) - EIR_SERVICE_DATA_LENGTH(4)
= 248.  When an attacker within BLE radio range sends an HCI_EV_LE_PER_ADV_REPORT
with ev3->length in [249, 255], the memcpy writes 1 to 7 bytes past the
buffer into the trailing fields of struct iso_pinfo, including the low
bytes of the iso_pi(sk)->conn pointer.  FORTIFY_SOURCE flags the write
with "memcpy: detected field-spanning write" but does not block it.

The upstream refactor addresses this by:
  1. Filtering via eir_get_service_data() so only the BASE portion of
     the PA payload is copied.
  2. Bounding the copy with base_len <= sizeof(iso_pi(sk)->base).

Backport notes for 6.6.y:
  * eir_get_service_data() is already declared in net/bluetooth/eir.h.
  * The header include for eir.h and the EIR_BAA_SERVICE_UUID define
    are added here, matching the upstream commit.
  * The put_user() addition in iso_sock_getsockopt() that was part of
    the same upstream commit is not included; that hunk is a separate
    getsockopt correctness fix and is not required for the OOB write
    fix (getsockopt(BT_ISO_BASE) is a controlled path that already
    validates optlen against sizeof(iso_pi(sk)->base)).  Applying the
    getsockopt hunk here would risk a user-visible ABI change on a
    stable branch.

Reachability: any host with an ISO listening socket bound as a
broadcast sink (LE Audio / Auracast).  No pairing required.

Fixes: 9c0826310bfb ("Bluetooth: ISO: Add support for periodic adv reports processing")
Cc: stable@vger.kernel.org # 6.6.y
Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[jerazo: backport to 6.6.y; add #include "eir.h" and EIR_BAA_SERVICE_UUID define; drop unrelated getsockopt hunk]
Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>
---
 net/bluetooth/iso.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 011b2187b..3259c9c1e 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -15,6 +15,8 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/iso.h>
 
+#include "eir.h"
+
 static const struct proto_ops iso_sock_ops;
 
 static struct bt_sock_list iso_sk_list = {
@@ -47,6 +49,7 @@ static void iso_sock_kill(struct sock *sk);
 
 #define EIR_SERVICE_DATA_LENGTH 4
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
+#define EIR_BAA_SERVICE_UUID	0x1851
 
 /* iso_pinfo flags values */
 enum {
@@ -1928,12 +1931,16 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
 	if (ev3) {
+		size_t base_len = ev3->length;
+		u8 *base;
+
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 					 iso_match_sync_handle_pa_report, ev3);
-
-		if (sk) {
-			memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
-			iso_pi(sk)->base_len = ev3->length;
+		base = eir_get_service_data(ev3->data, ev3->length,
+					    EIR_BAA_SERVICE_UUID, &base_len);
+		if (base && sk && base_len <= sizeof(iso_pi(sk)->base)) {
+			memcpy(iso_pi(sk)->base, base, base_len);
+			iso_pi(sk)->base_len = base_len;
 		}
 	} else {
 		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
-- 
2.53.0

