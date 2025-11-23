Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD9B2D9494
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763914656; cv=pass; b=KqkE0tl4cK/Z0H+3fJlN1dMzrQcmxEhgArwKNr3u0I8ldFqeWhkDr2/SQsDy7RVtqsqL7Yme4na5dixYV+j4YmoArFE9B5ZW3cxtgDRUaEO62e7WdfdNw73TApxThFa1m7SBzHsE7sAHp4DrCl6aUVyOvglu0W8llCE6nyQU/x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763914656; c=relaxed/simple;
	bh=uaGzC/0sNrqKKTAHNzCfLKApuKUiGA8BxQP0c3H6f5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaQxN8t+TedolTRvTN5lbi2OvZbSkwTpVz1O40b5P+W74svjFjGUYk3jF1gjevH2ovUqAdSRtT8BXiA5n20eImxOZIuEOxhQOqzoj4lBbIe+4cBSbi6Kzy5w6yawXny0q0swufifpbtiLt9rbtvK56vRNdez3Ov7Nag2IDccXfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=lJJjsY7P; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="lJJjsY7P"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dDvHY0bPRz10HY;
	Sun, 23 Nov 2025 18:17:28 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763914649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VNUjSRNHtfnCLdTt9ar4v3ct0BojFsZu/7DZq5nxms=;
	b=lJJjsY7PSjibqKYet4xxTde3ePAx1j80eDApq49MwQGbPASloHN6K+onYxGuJONMHegJgo
	6sZseMSCWXyD1aH5UPIo8pyZvbaQcGpkMvhduNnaMlcYZFngR+w7UGfj+bHTP2VYeupNYU
	Oz+37kR6gUTHwdU0eSheMdxJGLFXIoA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763914649;
	b=nDg/x+lnzYorAI5PyTEhUUfrzZ0eW/phqxd+pffNzIEXBnJAO+aCqWnL4iDPJXLpZDxUle
	XnABSSte8WgtM5WYuUUBdzKstx6x0MAZWHLNZd4NNsJqrdw5kDVlnOQ0GxPuLxDTp1nO3Y
	1cKVZCEfYra2gHLRVMG1/GlQjzR5upk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763914649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VNUjSRNHtfnCLdTt9ar4v3ct0BojFsZu/7DZq5nxms=;
	b=AkQulpKruM7Hh5MBoQO0JLkV8fF0g+cguIziDC2M0VE/c5IM2Lf34IvyOMx1pLW45KE75N
	QFRTo9FBiBl2XlN2KcXIqVTZVE1r3Dy6Ea3xMJokb6/aIkiOZpNraQQTSIoYCosSfPNj0q
	AEMEXnSLv0QMFA270CLqlaiR/8VPz8Y=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 08/10] bap: unicast client wait for GMAP service
Date: Sun, 23 Nov 2025 18:17:13 +0200
Message-ID: <ff501455f8b6df9e6a118e2664f87b150853531e.1763914558.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763914558.git.pav@iki.fi>
References: <cover.1763914558.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wait until GMAP properties (if any) are read before configuring
endpoints and transports as BAP Client.
---
 profiles/audio/bap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 73c5cfc74..17a040a71 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3821,6 +3821,7 @@ static int bap_accept(struct btd_service *service)
 
 	queue_push_tail(data->wait_services, NULL);
 	wait_service_add(data, TMAS_UUID);
+	wait_service_add(data, GMAS_UUID);
 	wait_service_add(data, VCS_UUID);
 
 	btd_service_connecting_complete(service, 0);
-- 
2.51.1

