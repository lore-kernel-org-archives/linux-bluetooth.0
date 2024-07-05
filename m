Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C9145FED
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169986; cv=none; b=kIxoVlMwwLH3TOKpdTkpYPr+YLnJoMkU//Cw8LUiLpK23j3Hx2OCNBBJ6qTVk+bfXFg1JuFQrPEQaEOvdch0UaE3TC7gsIfwXrE/oTpjDJOeVeeSh/V87o4RrNM4j6gSEgjOI+7kj1ebiqmdYR2pmpJe5c85pWNtmQ6vRvDY4rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169986; c=relaxed/simple;
	bh=gcgUu0Tuh8qeZ3Gh7h2fkiGCf8wsPAt8jwuDMZhbNS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ep6MEA6Y6naWRSlacjhsi38jqZDyECCAO3Z4uZBi0EK9iq/Wv+xs5pSBVi3HxBUGJHA4eoL0GY2357i/wIJU1tuoO9uklBnAqTBVZG9rDLPjwj4IYCmBMRMX5Q4mHGyDi72Yg1tUjfqa/GcJR1vjHf0Sujk4P6EBQ4NVM6pZx6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C9206000E;
	Fri,  5 Jul 2024 08:59:37 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 05/11] sdp: Fix possible null dereference
Date: Fri,  5 Jul 2024 10:57:33 +0200
Message-ID: <20240705085935.1255725-6-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705085935.1255725-1-hadess@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

From the BlueZ scanbot:
lib/sdp.c:586:12: warning: Access to field 'attrId' results in a dereference of a null pointer (loaded from variable 'd')
        d->attrId = attr;
        ~         ^
lib/sdp.c:967:10: warning: Access to field 'dtd' results in a dereference of a null pointer (loaded from variable 'd')
        switch (d->dtd) {
                ^~~~~~
---
 lib/sdp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/sdp.c b/lib/sdp.c
index b64245f668d3..e260a5a9663e 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -582,6 +582,8 @@ int sdp_attr_add(sdp_record_t *rec, uint16_t attr, sdp_data_t *d)
 
 	if (p)
 		return -1;
+	if (!d)
+		return -1;
 
 	d->attrId = attr;
 	rec->attrlist = sdp_list_insert_sorted(rec->attrlist, d, sdp_attrid_comp_func);
@@ -964,6 +966,8 @@ static void data_seq_free(sdp_data_t *seq)
 
 void sdp_data_free(sdp_data_t *d)
 {
+	if (!d)
+		return;
 	switch (d->dtd) {
 	case SDP_SEQ8:
 	case SDP_SEQ16:
-- 
2.45.2

