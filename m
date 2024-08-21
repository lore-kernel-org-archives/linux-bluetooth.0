Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3D1B2ECD
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227042; cv=pass; b=oxVXn4PszRj5DEMCP6JDfzKrDKxxeqspShPLxGklylt1TXXfRDNBwSrP7ZIAsq/9K1IeHyXOR4w2KSm7BC/+qU3IllpkYVcyM2eQ/zZ5z4/owYwxfrgUZOLjh5bkmKwQOgZ/8+Woctsv2jCguKCQgqhESNrrdDdvlVFq5G8dSUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227042; c=relaxed/simple;
	bh=t6kW6RIqidjgPI/WJLdOaUsmooVmV3pYnVeaEADjAKM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eL8niYEORcuiaPVt2DJDYK4+o4SzCjzAbeuAG/iq+nlV73lZMDyoKo1WJTyiUFCBBYzy/G6+vylo1nD48dpjZWKxa6ATZccB/A4sGvpF80ba5nE40quvyPEUeqiIfFRM+zNOwc1ILiiAqb3HzC2pLb6PlVfsUDRF8EqTYPsXpGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=b5F74/R4; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="b5F74/R4"
ARC-Seal: i=1; a=rsa-sha256; t=1724227039; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fqfEe0HqiHwppEVh6OqFdUzdAxpTXw7L8+MhE18eysGZIbjkc16TRO3gioc5vxk8lNJpmyzALihq/EYdceGbMgV5Ck3yUBfpMX4/B9JGQ+CZQf22sMvoZ/jeZ3O/478vVyPxWwy/0KOzJHAdSuY1dT2BCDX0PXt0T+4rBNeSdBw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724227039; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=JRvqJE5MzporJLJ0B4JfRV2J3JLPD6o7g/sWAPG21ig=; 
	b=ikV2TA0ildwEceOFkmY2X29UwG0rCcKNPkXyPsXwuWZWDeMoqsKxxhx+gSlg++B5FzZm91rUU2iuDG2TxrX72bPUiUJd9ruXUmAkTU5tMkrJm2trOMFXkDVv0r7Zu728Z2HM8hmXsk11pC4/eWn8OXkVdboz1dB7CBAmDf8R0bA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724227039;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To:Cc;
	bh=JRvqJE5MzporJLJ0B4JfRV2J3JLPD6o7g/sWAPG21ig=;
	b=b5F74/R4b5zoUF9SrZ2H+sc0rmFsKc/poi85VEqSPuSes44jBdQvJGQ+Hf9+EHfe
	Ng8800d7ZDgl4XC7fmfRhiVq3CuwDX1vAXVUQiO0OReQ7xl5pFP0Slel3lEBGFohSwg
	cjZ4VClmrrZDNFzSgkXfhm9TzR7JpuUmDVhSu2XE=
Received: by mx.zohomail.com with SMTPS id 1724227038285921.820547618764;
	Wed, 21 Aug 2024 00:57:18 -0700 (PDT)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Fix connection error message
Date: Wed, 21 Aug 2024 09:57:14 +0200
Message-Id: <20240821075714.357691-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When trying to connect to a phone which has removed the pairing, the
DBus error message is:
- if A2DP only is supported: br-connection-key-missing (EBADE)
- if HFP only is supported: br-connection-refused (ECONNREFUSED)
- if both are supported: br-connection-unknown, while the trace shows
  ECONNREFUSED in avdtp_connect_cb()

This patch allows to return the correct error message.
---
 profiles/audio/a2dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 43da38051..a6489a763 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -326,6 +326,7 @@ static int error_to_errno(struct avdtp_error *err)
 	case EHOSTDOWN:
 	case ECONNABORTED:
 	case EBADE:
+	case ECONNREFUSED:
 		return -perr;
 	default:
 		/*
-- 
2.34.1

