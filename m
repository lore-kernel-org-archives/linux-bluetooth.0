Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA230E83B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570379; cv=pass; b=sG4ta/7eF8X9myBCeaCuqbLiJ/L0M/TVNKIn1w864j9GPJJiyFcAncW8iuisipQpJXhCWc2vtesI1OXZhnRRpgC0lw6djUw+c04+T73r/OkXHzO33980XH5YIioCBqIOYOmJLMq6AzyhhNYRhAsCh1QgaTV9BpmEgf3TPiNX2dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570379; c=relaxed/simple;
	bh=7ldandiW1MmSgbgddKXZnOmciDcIuW8+LUQh/JVb+Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3m8OdL8s7EkOj7yL3H8iKmblEuBs1DA4CgJpV8UmYTdQyKb249TW3x0kMMxcgFKwqGOg9xolM2zfgyEfIjQw7tzSqd49XRajEJCKzVOfpiSni4B6rRsNlzsbCdfo8C3tcMV6clwvNhRi7cX9YfH/EPIzYt0YXzDimo7zHYKxXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nK1pENhb; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nK1pENhb"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dSgcF2PR2z10JQ;
	Fri, 12 Dec 2025 22:12:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765570366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEGrywOCzn+5WgrxiSlX9U9bCSzZ3YCKNjoMJElxMKY=;
	b=nK1pENhb9bwxvuTojMVUrVejLg+5Mz18JMe+DJ/nE86qBGiIT7q1bAgxA2OMQEA8jJ72UJ
	a3PsXlfQTkAZjkjXnACoHcvq7VtMJkTBLhec5EdgC4Pae8FUn+fRRY6r4HH+e8CrCxBaMz
	x8dC13jlgi0v57RyAThIcSazy4v7714=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765570366;
	b=WB5A/nTCQHpDCL6/BG0y2HRGYSLqtnEA+FJs+oMBwXB0PIaUdsjs4odIrfijlakMSESNwV
	1EdNg/R0W8FSlNK4emFQCSEvTvix2uoI69Z44lBWfnVyGonY5LbPiowQTnZPL2WMJ56kyt
	opBbdzPD5vbvxqfH/+sf4snuK5o/0II=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765570366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEGrywOCzn+5WgrxiSlX9U9bCSzZ3YCKNjoMJElxMKY=;
	b=UUTLTLrCHz8dBDSrPCh/SHnWU12aWZcc41QKqJUDY9JAQuYHNgB6Tt+HI+Tx/eXAl+F0fV
	koGOOg6DCNK6+TF4Tlfs2NUupt5Z6FMqj/2Lr8vHbKusf5hYupB4e0t8NLqp0u0RAwoUNs
	PlgAzTTEcicmcxOhwcdlZtpRdieoXPU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 9/9] shared/mcp: complete CCID read before considering other attributes
Date: Fri, 12 Dec 2025 22:12:31 +0200
Message-ID: <c2f406bde783667cfef2740650dc978d0ecedd63.1765570334.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765570334.git.pav@iki.fi>
References: <cover.1765570334.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Service is shown ready to upper level when CCID is read, after which we
should notify upper level about current attribute values.

Make sure the values reach upper level, by reading them only after the
service is ready. Otherwise, the reads may complete in unspecified
order and upper level misses some events.
---
 src/shared/mcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/shared/mcp.c b/src/shared/mcp.c
index 4916289e1..910089f18 100644
--- a/src/shared/mcp.c
+++ b/src/shared/mcp.c
@@ -981,6 +981,7 @@ void bt_mcs_unregister_all(struct gatt_db *db)
 static void mcp_service_reread(struct bt_mcp_service *service,
 					struct gatt_db_attribute *attrib,
 					bool skip_notify);
+static void foreach_mcs_char(struct gatt_db_attribute *attr, void *user_data);
 
 static void mcp_debug_func(const char *str, void *user_data)
 {
@@ -1631,6 +1632,9 @@ static void update_ccid(bool success, uint8_t att_ecode,
 
 	service->rdb.ccid_value = v;
 
+	gatt_db_service_foreach_char(service->rdb.service, foreach_mcs_char,
+								service);
+
 	update_add_service(service, service->mcp);
 }
 
@@ -1917,8 +1921,6 @@ static void foreach_mcs_service(struct gatt_db_attribute *attr, void *user_data)
 	/* Find CCID first */
 	gatt_db_service_foreach_char(attr, foreach_mcs_ccid, service);
 
-	gatt_db_service_foreach_char(attr, foreach_mcs_char, service);
-
 	queue_push_tail(mcp->services, service);
 }
 
-- 
2.51.1

