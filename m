Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736932459EA
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691556; cv=pass; b=XvWlLjS3fhUvRIKsqgyyPcSy2rOy6/xaT8g4BHc4U/h+nYdBj4LLv6nbDWgA6A2Azjw1dZFUSicyz7JU6UTMbxkZ4nNBX6EEjgK/eFvhRtdQ1X4jQDVOHpCbZZ+SA3zg/1FmCQ17cQqsENLf/I7jCoNhqslqKlCEcs0CcWSatUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691556; c=relaxed/simple;
	bh=N1BIRg63oVIswMIfs1eSDHkGZ8poQ9bcUTHdZ2TfQFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Enr6rukMg49e8MTWs+9r64Nj/4Bw3xr6qgDmLhNK34T9/N5fOuReAl3wvy8FZbI6AdydZJolUKV2Pn6Ss/AM2dHdQvTeXfMFUgSQJQlY0OeHUfrKxkBufSG+uZ1hHSHcgcN2BL7v6l8Y6Ok4QAawDS4Hpf6cRmgbcs0UJq5bLCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=iCux8eAN; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="iCux8eAN"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d4ByP5Z9LzyQC;
	Sun,  9 Nov 2025 14:32:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762691550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ej7vSib6G0YHdsNVHVvp4k6r1cm6LZztoTxTxSyi+rM=;
	b=iCux8eANFkwWDwTlxsXDHtkofRO9EkwsE1tARxXyM5aBFcL164zzKnU0C2FuPLllsmQLXz
	oMfiCz7Pu8iF2kflvWva8C+i3pTnI6EFvU4EHQH3fjsPmRzfcuIS0MHmDwyzCxBFClg1sZ
	OiZrLT4h+eii7xIt+c8DBlLGKS5o+EQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762691550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ej7vSib6G0YHdsNVHVvp4k6r1cm6LZztoTxTxSyi+rM=;
	b=y4gQFPTBydKX9chtrbTrV4HRoRF6dREgkBKkMQ9gqzk9iN0ffkSQCsA0hheh8ovEB8kWo4
	B8omUGu+RbtisBoM00Uw3xNisPq6mCbjZAboRJXa1ANFgsVVsGzFOGXMQa4WwqppYLAghd
	XamecWfCiyikPIAE8WqWF1urRFVJjps=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762691550; a=rsa-sha256; cv=none;
	b=INptn30nDE+HV8EWz9pTNBHtnCrBUtaQz8xvPnrKe7rB+65LVcnwZeZlk68DOG7rxPaBnn
	HFp0f8bw3OBOdvSXBDgiaq/usc6PE6eQj2k1BkttmvxqvqeAy7vhIqTh8n5Z0v2xLHqlA/
	lZ1eKfc3K61slU4SHLdzkhfQ/lhAp9s=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: fix keeping PAC caps <-> metadata correspondence
Date: Sun,  9 Nov 2025 14:32:26 +0200
Message-ID: <ca208acb9133b0bae7b2134313a05d68036e6ef9.1762691320.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In PACS, Metadata is associated with a specific PAC.  bap_pac_merge()
mixes up metadatas from different PACs if some PAC has no metadata.

Fix caps<->metadata correspondence by explicitly storing 0-length entry,
instead of skipping it altogether, if metadata (or caps) is missing.
---
 src/shared/bap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 427d18627..a18f393f7 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3840,11 +3840,11 @@ static void *ltv_merge(struct iovec *data, struct iovec *cont)
 	if (!data)
 		return NULL;
 
+	util_iov_append(data, &delimiter, sizeof(delimiter));
+
 	if (!cont || !cont->iov_len || !cont->iov_base)
 		return data->iov_base;
 
-	util_iov_append(data, &delimiter, sizeof(delimiter));
-
 	return util_iov_append(data, cont->iov_base, cont->iov_len);
 }
 
-- 
2.51.1

