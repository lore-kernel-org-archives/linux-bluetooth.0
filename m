Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47591AB91C
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088784; cv=none; b=EAZWTJxl+YtHF2s+Eqd7WhPFnj3mglcQyE5K/FLtlYbt3ww9ffDtGoQ/aKcSdp6vSWgUm6LWhHN2eUlSZHUS9RGN5swmfOglfGHR48sJjZoYaQphGxGGjbNGWwFB0o/4Sun6IbgXvy351mE8Sjvvge9yXwOvFil7RE/pj93vfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088784; c=relaxed/simple;
	bh=gcgUu0Tuh8qeZ3Gh7h2fkiGCf8wsPAt8jwuDMZhbNS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbbjiGmPfgbKyzyRTQjgD+j/Ah3KFCOXdvSDzwheRhHfgRNilV5ce55F9usIXh+OIgxB21kaoZn/EMw9gq3RmDznl9HkCQO9e1HFNE5wqQqXOlrTm68MhcSwXmI/GgEgJKmSvVlKtYO2y8/6NOIxr6N9m6RlwBJ7Cy8dMvgtdZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57BE524000B;
	Thu,  4 Jul 2024 10:26:21 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 06/12] sdp: Fix possible null dereference
Date: Thu,  4 Jul 2024 12:24:37 +0200
Message-ID: <20240704102617.1132337-7-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102617.1132337-1-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
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

