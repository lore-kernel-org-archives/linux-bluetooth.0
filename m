Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEEB7603F
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737886980; cv=pass; b=i1410brxa+JOFsNi8DZtmnaINmG1NKv9EA2+hvgLsv0z87Ye5DRn3Lu7wt2aiAfos2lFtyNcrDNcnib5EiRWUsmAXKOjskBZvL8dWPnvjH2Ttbn5sz8kQ08bhMgCb6jic4KlyvcSC1WnW5qfkVHb42ib0UTCA8ntDU5/vIZQ6b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737886980; c=relaxed/simple;
	bh=UmDTgapJuEq6/nLyW2GWw+qTePqoio9rqIgSsGhlZKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=up6844aFO3raD0xUKJsjzkLTDpJAw+bvoqJfNHLswttUs2Gh4zAngOpKg8yBM/Qscd1Zu1f7b5mpOdGgfiTwv2eJJ2PpKFHtaO4REIJvNDgP8GXwRLd3TH10lIHhxkktl4J9UOIusYpKdUx4/iIKb4QCBkNNQcX6o7XjhKX2E88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=FKo86FXA; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="FKo86FXA"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YgngD0L2Vz49Pyv;
	Sun, 26 Jan 2025 12:22:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1737886968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W7npGcTa8LKmJ2YkAFdTZL7RJ3lMHF7fdVvGixu9EM8=;
	b=FKo86FXA4f73KSQ6/1jurX8lfciDl7y3d82qGggxSWjNnqppPS5ZNHsmBQu0fbyW4D8P2J
	jsIxE11a0C8cbTVDtoVAVOTY217Sj4uyoh84SQ/JwX6wARx7Ne4wCzRAaP11857tiH2Fb/
	bOPDwd5sUMTTWKYylB1Gm+44/M8lRPtB8IqtOtrsPwWtSZyH3whMlbwo7y4IAbPPJoD02x
	0NY61Qp5xrCcihzpO1BfZWRFJRA872YUetkxWuhAUP1mWJ/qNyoG7YcX+NO/fhJPZtCBff
	FdamAJIydFAJLjmlk7aBqCJeGfWXZYge7DlSKVbrrjirRaX1p+1Nn9LRxlTCPQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1737886968; a=rsa-sha256;
	cv=none;
	b=jFMDCm7GoCwPS6lXpfON5TChbi8cj6blTvUyoDNv76WGl/aMIoTZhZ7RJgpj/mHEl+qNt8
	iWZ+NKXOnmkBUgGAdAs5Cl4ieawqMYqBrmq8Y23XqUvq94K4CjIdCozjR0HHKpcSbpHNkU
	ThVS3QKEGOCxxh5y950aiLuK27c/kG8ecnG9yn6/6QQv1TUNO8YQfUGVry2kjlsklMi9vs
	5HPqSyLvy0r5nA1kkDg7/ics44KmDokHFNf/GqW8Uyd4nLSaC4n0C6GHHBsrrNtUe9jY6u
	fARGTR2BBAvzOXsceTq1rNM3JczqMUZBtdsoZqbi/hxSW52u3yJaebIT+LiurQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1737886968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W7npGcTa8LKmJ2YkAFdTZL7RJ3lMHF7fdVvGixu9EM8=;
	b=GcNIBLue74fX65sKjeq2wmJ/X8gy6nBtCA4AA4VCtSW3BX7iLB3xiYgGvzHRczhPEYGXko
	znlGJ0w9gqnKHYzrGGWhpJ8bP2DsYFjQgoroENU0UoUYFw3SQqhOLs5wVQoAk1BvGeI2Ew
	qSbktyOWmJzsJg3/DycioSkf/H1S5TrOEvLSDTgegS6Cs3Pt/di800IbI8k5XEJ140U5ii
	ExyFSI/iFYtSKbWL6OnjY2ka+ASHe7o0RRnP1+dW3K6+7arJlUT1INWnJiOgOWGGP7qjH1
	lpn/fs1V1h+51b6pUHzm2mQ7ta/vWVLOrfSpOJHyn8bpUIs8QUrv5bJOXlMNBA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/gatt-db: fix crash on bad attribute index
Date: Sun, 26 Jan 2025 12:22:44 +0200
Message-ID: <efe1351374fceccbe4f1392fddab0d75e128a510.1737886528.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In gatt_db_attribute_get_value(), avoid NULL pointer deref if attribute
or db is in unexpected state and attrib at index-1 is missing.

Fixes btmon -r crash, on a packet capture obtained with btmon -w after
clearing BlueZ attributes & cache for the device:

==208213==ERROR: AddressSanitizer: SEGV on unknown address 0x00000000000c
==208213==The signal is caused by a READ memory access.
==208213==Hint: address points to the zero page.
    #0 0x5af4a6 in bt_uuid_to_uuid128 lib/uuid.c:65
    #1 0x5afd54 in bt_uuid_cmp lib/uuid.c:118
    #2 0x5d0dd2 in gatt_db_attribute_get_value src/shared/gatt-db.c:1663
    #3 0x56aeab in print_value monitor/att.c:158
    #4 0x56b80f in print_attribute monitor/att.c:207
    #5 0x5982f7 in print_handle monitor/att.c:4417
    #6 0x59b1b8 in print_write monitor/att.c:4598
    #7 0x59b796 in att_write_req monitor/att.c:4627
    #8 0x59e91e in att_packet monitor/att.c:4918
    #9 0x4f4847 in l2cap_frame monitor/l2cap.c:2567
    #10 0x4f6022 in l2cap_packet monitor/l2cap.c:2708
    #11 0x4a48f6 in packet_hci_acldata monitor/packet.c:12606
    #12 0x43952a in packet_monitor monitor/packet.c:4247
    #13 0x4170c9 in control_reader monitor/control.c:1517
    #14 0x402f76 in main monitor/main.c:277
---
 src/shared/gatt-db.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 72254c7e4..fe272de34 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1660,6 +1660,8 @@ gatt_db_attribute_get_value(struct gatt_db_attribute *attrib)
 
 	if (!bt_uuid_cmp(&characteristic_uuid, &attrib->uuid))
 		return service->attributes[index + 1];
+	else if (service->attributes[index - 1] == NULL)
+		return NULL;
 	else if (!bt_uuid_cmp(&characteristic_uuid,
 				&service->attributes[index - 1]->uuid))
 		return service->attributes[index];
-- 
2.48.1

