Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE37A15530C;
	Sun,  2 Nov 2025 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100588; cv=pass; b=bov15vB5urmAG1eZOo8biWecJ015/MBYIhNuhqPVT09ftGE+tU8hzX+vRAotjmiQUP3se/TYpikbIOl0ttna9oJNxdjk89gp1fNf7zpQTzjnnqXRsqA8t8AU6DPuNcn3I7fTRqLH43rRqt0RHHI5j7yB1S9ChxKGu00fr3lYRXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100588; c=relaxed/simple;
	bh=oKLjK/NSBdKcNwwSIYxIn5RHUqqNednNrnl22/bEtE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOLdaqH+YlrjLqQ44iLkf6xRJSehom6+DeG1kwJC1sAR/iDC9YTXwdMZkx7VwkQYui4u8dJJqUjITwarMTNVIv39KfuVCOWeXNT81pCJolQkokYBtaaf62cgTTiC4l4v5PoKFixn5WhW9CEYIzRwZLAk2wRtdvXMGv4gXFb2+N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=h3Kecrkk; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="h3Kecrkk"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d00PY1cK8z1035;
	Sun,  2 Nov 2025 18:22:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762100578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9U/BbAjh/xn6PO3Jg0qRnrKxB7kTBCZUsPfq6R8y6zg=;
	b=h3KecrkkrkYJNilgncwKlqpFrnPBPYW7etgSm2ilKPg/N/G/RfWaeRMrK2i4kQ/I4Mfbi9
	5y2+AOsySKb0n6uiuQGtIfm7IS5aQXCFAMJUap1lE4Jy1kxDE7JjUCojp1NnIaYe8n02LO
	2vPHFB8bukmDZf13yFMw+zpxzfaBdgE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762100578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9U/BbAjh/xn6PO3Jg0qRnrKxB7kTBCZUsPfq6R8y6zg=;
	b=ODVtqh5dlPWkrTxnI9yr44mUlkIPUyS8o6eoN5w93U0l4vdUrQGpXogNwx1pQ2Uz1XM+mX
	R1y8F03PB4NL9r45TIZEo018nlzSzF+WbW8B4oNUes8yu+F6vD0nl+Q221sU26PBVL/Kp2
	xFRMZIEI2Rk82cimdLC6hcgY6eHSHN4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762100578; a=rsa-sha256; cv=none;
	b=xsQDXlcF1OK532y0mfpHrBhr82MRqfeaWAzem4fCLEI0OPLzo9+d2YpWwSHQGDRhOJrI5t
	yBbjUphtAkQucNXHGi7LcJpMexRWo/oxG8TSRV9LgY8kmpnS4jlQkBeFgWdrztKvhhuhgc
	BQvpLuXaAbngnymC+xV+XrApPqwRIj0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] Bluetooth: hci_conn: take hdev lock in set_cig_params_sync
Date: Sun,  2 Nov 2025 18:19:34 +0200
Message-ID: <e3b024f672732a8b244022f7c9ac23826a130d2a.1762100290.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1762100290.git.pav@iki.fi>
References: <cover.1762100290.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take hdev lock to prevent hci_conn from being deleted or modified
concurrently.

Fixes: a091289218202 ("Bluetooth: hci_conn: Fix hci_le_set_cig_params")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - no change

 net/bluetooth/hci_conn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d6162a95048e..d140e5740f92 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1825,9 +1825,13 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	u8 aux_num_cis = 0;
 	u8 cis_id;
 
+	hci_dev_lock(hdev);
+
 	conn = hci_conn_hash_lookup_cig(hdev, cig_id);
-	if (!conn)
+	if (!conn) {
+		hci_dev_unlock(hdev);
 		return 0;
+	}
 
 	qos = &conn->iso_qos;
 	pdu->cig_id = cig_id;
@@ -1866,6 +1870,8 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	}
 	pdu->num_cis = aux_num_cis;
 
+	hci_dev_unlock(hdev);
+
 	if (!pdu->num_cis)
 		return 0;
 
-- 
2.51.1

