Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C319E819
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765572374; cv=pass; b=F7lknMCHicGCe/t6+z7bxWxaK3czOEkkRDjkJDlc5eHIxsBjk9TebvyVoLk8bZFYbObVWqCR/Pt+Loqxp4rrYhVvuYx3RMG0cfqdEaTvGvfCNaUeSU1vTSIXq17OYwxbnlA/46dY+1n+X/OC4eROxYBqdC0jhuYKvjvmJPs4CQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765572374; c=relaxed/simple;
	bh=7ldandiW1MmSgbgddKXZnOmciDcIuW8+LUQh/JVb+Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXxvdbVodJEvQvzkOSTdUBbDb2rmslCC+Cz+HwVNTRjT56Qm7EY6OkTa4X9/ze8/dH+b9/knDTbIC0QZToI+IWHYlzuMeDlSlEPGdlmpJBNvZt+aWORMFcs9WCYj4KMEPOmC3NkIOoseRGIKtwTUwgR/Jc0ZYLa2WEu9esRNH7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GdmOVak2; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GdmOVak2"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dShLn34Xnz1064;
	Fri, 12 Dec 2025 22:46:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765572369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEGrywOCzn+5WgrxiSlX9U9bCSzZ3YCKNjoMJElxMKY=;
	b=GdmOVak2IlAZTcehxJQ9YYWO6dUUNOpshWD4SXPu6oS8lracPp3jmuCKy2qAA1xi8VpD3+
	IJaErVMV51JymZ1U2eyfW+DddRaizRUmLQ6tKUMmLBpKJSbpkT8akL+tsUBWzdoVBWBeOT
	eyIthoMIqzlsPmtJcPDplizQIo4lPFQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765572369;
	b=hSUWaLGETFrhaIjm/0Nwp6jVAQ30VHAyHWx637eHwaBEb+R0BvnZx2DLIgTg1sLlqktHG9
	itrB7Y7TtXrX+s90G1o70zk9gUUBB37fe8qvtl/AOjf3S1NKNOZD7gbhAaD2OJA9Y+/9WB
	4MtEEktBoTJdklHw65jeBXC0cCejd6A=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765572369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEGrywOCzn+5WgrxiSlX9U9bCSzZ3YCKNjoMJElxMKY=;
	b=gaAUiihIUcA+XqL1SLRUd5ZywznguoG/EMuqsBvjyEJEofZ11UKNkTIBGdEp+/F/GOKUzg
	I4kzMSvLAtyHrwxOvTBT+FdJhR+MGYhXx+l7Qgiwc5x69ge83ZnhjMhjU/Wz9KRJ9XHfWP
	Bf62eAtL11GZuHpiMV0g+knDAZ5ARMc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 9/9] shared/mcp: complete CCID read before considering other attributes
Date: Fri, 12 Dec 2025 22:45:54 +0200
Message-ID: <e4fd3e085e04636b5ea6cd638dc6773d2e15e68b.1765572338.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765572338.git.pav@iki.fi>
References: <cover.1765572338.git.pav@iki.fi>
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

