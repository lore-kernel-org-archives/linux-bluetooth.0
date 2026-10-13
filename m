Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA33480DD8
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862958; cv=none; b=rr4SQHwC2W1bAC303eVq85lBBF5N91aqxJ56Az7+O4Rz7DThl+XVeG9HKjYD9hGFeWVjvaqi425Rv6U+goth2Gwi1xsDub9BHIO5pD7CYU0IU1PGQvvT2EZswNn/7V5Hkt3HKEqNw6im+BogWameS/WcovykysCznVJEJOnSQOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862958; c=relaxed/simple;
	bh=9lnw1Fa7+1ai8yMi6EJQc7Ex1qH5GtxsH56m2SS0SDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwIyfIsmdkiz0JeOdBBcjMaSGLQqlFuR14e1WK6lkQ8sSmD+cuNfX0xJ/fQPxe3ZQnpLN6v7maC6chjr/M+0pmOPlCULFOEQ5J4USPpzfbybs0gxyIICOprE/Zj73Md6DYZR/gOqy1/p4YnMWzJHtVUo3YXBbplVwG5wtaNYeLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEOJX5bP; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEOJX5bP"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso6308812eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 20:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862956; x=1792467756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HPW6ypWLxPBPK/wnHCdzFVOHN9Lae0KKKozgNa5aJtQ=;
        b=sEOJX5bPJ9wDOYSoik+8biy/9ObTKHxxJJQq9BkWc+xvM2/zNZ454I3ak2+xEWj+0X
         LtK8dIO2iOuBgtdEAAks+rB+wAn1GkpedyTyDjcm4KguhUAL0dSPfNrIIrLH7mG1QZU/
         ux9xrkPs0RVsh3ASzK7/l4TlMEH35d1VFMwJOO4/rJFg77k5flyAhQsBVoAdLOdtRzIY
         MMfUou6bhKLl2ASG6G0pwcAe2met/6tMJKw3j4R0wglQmszeRxhJSt+vwugbL/e3bRHG
         1B8sDHnLf1F+LRO2vS55P9h8wa9Doui5dm4q469HjmyxLdgXVhwbw9NMcQGF/AO9bDDQ
         wU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862956; x=1792467756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HPW6ypWLxPBPK/wnHCdzFVOHN9Lae0KKKozgNa5aJtQ=;
        b=zOMRPYd8vK5CNPxuhDOvr1N2paSf+ZGAHD8RhlBbED8B+nKIUErOkBX+5aDBpSTjIK
         MnprMuzqd2Q+2xTL8GZ3J2RaPNTWDMeQPHyXBKiVtzGm9rW9ixfTYMoWskwjSW/1OWPx
         oux7pDM/OaXxS+1Jj4745bPLGPrnwgM3qlo/Lf48dX6H1Q2/94xXto4t5GpZArKgK/PQ
         sJOZh5AQbpGxqC9H/02X1rjJdHfnRfaXLY8Rl7qCYkF0Q72zrFlz/6nfXTfHHi0VV1p8
         SFaJ+m1281hMofuelepB3MauxMGPNUfrf7uO+PLAH+9uF6iOvBxn8Z2exzIJ0BzdjSrr
         2yjA==
X-Gm-Message-State: AFq9FYInanYIeCiw5qIrtbtbFmqycVFqM1TrcoyASzgilKxO3zNBsFgX
	E0fRCQY7+J4Gd2ODRTyVEr94BcODSOBn+Ijuc5E6NnImDH6RDlVcwpNV
X-Gm-Gg: AYBFou2SmyiWebm/m0NOCyCr7kn/ezXGEAscKiI1lHypWxZSlxBLngotOpUh5KDaotE
	W8jAeovuuT0AWB0FWR0prgijKAZNZ6/nSNYRd3kZyD/l7Ep1WAW7GhAWlbhsPqytPHetjmKoQnA
	TbtAptlVrjWxzUp+bSgM4BWCQWPQUXyHuZijyRvs14oJeqpAn5+FHXMS6V84a14Sg2iigJsd0rM
	PorDsaaxwGQS6WWxkYLZSgA1xx9d2roqPPFYZJfaZS+FY8c2p/t04fpbsmdrpz925YOaJ207yAB
	2uvB9fKGPAKh73tziFjYoSe8WXOFs9NVYrT4w6UHc73AbsQJNfTMcAVXP2Dt8i1kjgTmZRfDaiu
	BfcF9f6l3Suej9uSJW3JE/Yjzf8H9ch3bSaih7LxHJd1XBc9G2exiB/4nLMqU0Ck8aoB0Sr8kA2
	zCvahpfaY/7J5DZMS/EFrZKBW9Hr75oACWRaJr8uto8vEnkfJfOihgs9tlA9C7dxA7+Vgqg3eyN
	Yh5pa5RtOicEK+uqg049+eLbBwLn1Eqv106Cgl9dLl125N+C15U3/+ny092kq0=
X-Received: by 2002:a05:7300:f582:b0:34c:5831:8a19 with SMTP id 5a478bee46e88-3537e0493a0mr15617210eec.40.1791862955569;
        Mon, 12 Oct 2026 20:42:35 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:34 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 12 Oct 2026 20:42:23 -0700
Subject: [PATCH 7/9] HID: intel-thc-hid: Drop redundant report ID
 validation in quicki2c
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-hid-core-report-validation-v1-7-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
In-Reply-To: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, 
 Frank Praznik <frank.praznik@oh.rr.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Even Xu <even.xu@intel.com>, 
 Xinpeng Sun <xinpeng.sun@intel.com>, 
 Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Shashikirana H K <shashikiranah@chromium.org>
X-Mailer: b4 0.17-dev-e56a4

Now that the core HID request handling validates returned report IDs
for report retrieval requests centrally, the report ID check in the
Intel QuickI2C driver is redundant. Drop it while retaining packet
length validation.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
index 41271301215a..7a362a2ebe2b 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
@@ -160,9 +160,9 @@ int quicki2c_get_report(struct quicki2c_device *qcdev, u8 report_type,
 		return ret;
 	}
 
-	if (HIDI2C_DATA_LEN(le16_to_cpu(rpt->len)) != buf_len || rpt->data[0] != reportnum) {
-		dev_err_once(qcdev->dev, "Invalid packet, len (%d vs %zu) report id (%d vs %d)\n",
-			     le16_to_cpu(rpt->len), buf_len, rpt->data[0], reportnum);
+	if (HIDI2C_DATA_LEN(le16_to_cpu(rpt->len)) != buf_len) {
+		dev_err_once(qcdev->dev, "Invalid packet length (%d vs %zu)\n",
+			     le16_to_cpu(rpt->len), buf_len);
 		return -EINVAL;
 	}
 

-- 
2.56.0.385.gd3acb90ef8-goog

