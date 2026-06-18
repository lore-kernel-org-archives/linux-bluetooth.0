Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A933BE632
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769257; cv=none; b=n8IJDKCivetYk+6A+SZ35DMv+obszySCvrCZl7GyIg8KSnadTZXe5edlnE/mKwJnB/sdu7Xm8E4HjkMAPEc2mr0KIi+QELqkl+0QWAzPdATKtFnKXQYhMCBjb0zOKYM2ZVZBw+3yAiNXZvjvUJCWFeo9QCsxaKikVYkxPSt1jqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769257; c=relaxed/simple;
	bh=T2EeJYQc1AoTp6kz1EfordRu10yhYgjWCQm9ijwF2+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lguX7j2gBsM+T/z34M3/ThG0hHlhzoEJLghrUo1nTrDHOY1YELz/s9zUSkvZ0HIwmbdM+W7kIpMv5un/CZ1VToetpT2KotP3wh8zATAdd2QDbGwA9HziiZyepvGhSOmVLM/IAzEUjHCWRZkBnz3TCK0mw4P46Cv6ipfjoVqzAwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AlfJYkTb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HTU0xjb7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AlfJYkTb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HTU0xjb7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I7kRi81167480
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 07:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KmB7Y5ff8dV06gZVWn+gLAe91hTwSJeX5Ap
	ofYl547U=; b=AlfJYkTbnncnMVlryuhbbaDgtJAye9WssPy/azo1d/E/h79lEfM
	Her8eSzjE1OBYrf8pFIGxIOeIuFuAp6/lL3oJ9pMQLsZHcGRVpFr+rUqRnt8Fz+Q
	wat/ImCM/IKM9g2pM5g/HKn0JnHecTOkUv0+3HyM9C4V/XEZmMnPGr5BxQ8Nsn+O
	BhDboPAs81Gw0NtZDa5COY5ktKO22cji9Hq/WX/+A5QtMI9ocirW5KlbD23EgepT
	ONlzU2Kwj36DwDKbsV9c+b4EvgeqcF2ldEcBYdEkPniDJBiqPzhrLtJmSURM4YUG
	WzPpAmiuk17IbkqImVYUq7dKKyqA7zayCVQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jujvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 07:54:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c856470fe9fso538372a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 00:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781769254; x=1782374054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KmB7Y5ff8dV06gZVWn+gLAe91hTwSJeX5ApofYl547U=;
        b=HTU0xjb7+Elvyu2c522SBK2cuzOhFQm1aP3nfNTMeEo3RtcqUCbb1HcxwF/Wk6sMOR
         9gtOt/bfoOhWbcT2jBuddYSvyU20LnSrFKFrqSJkIGJVPeupJTmrPzF2tAYhB1irtKQy
         bNFLZ3Af57dzyMr5jYj48JOPtF/jFhy1cd9QYCwB/kLlt7lgYsgYlJPgyQQ5ljWbj4KG
         EvRkR5ZMZUsyGYQOBqWEf9yhCCgYokljXj5SwUWhS51qHhO5wBX7P9C3pgg/mxnilKaa
         f3UQ75hlPNovc41Cm58rGUb6aVp88BDwzJTMwRpv072mF9pq2h1ddDHzUWTxKqaQIMgM
         mOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781769254; x=1782374054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmB7Y5ff8dV06gZVWn+gLAe91hTwSJeX5ApofYl547U=;
        b=KADbP2JCQmKsvFuqfDhwlCxcRUmlMeUPdzfDOQzd50YZ98OvmWyfPhLUCWDpNpuSLz
         RkyqWsgkmTlgaSbHFDW+6RAuQO+3kiTvG8Z1vIdFTyKq4PEQeNcgev8V5xlxLL7ucBwf
         ADON8LE0vJyD5yjEwZhDd93Xag0Id96mfhezMjqotJRdt0SX3ah0tQoxMREBgO9xD2Zz
         /p3B6oBF1gYwPxuFKr60hCw69odpk0qTAYlMyxyMvdUFqlkPpooRixs/9Ibwd+BEHoTu
         RSulVRyR9IVXFJslquW/SBT2jKM+XdqodfDyhIE9dqNo1qO0nK5jtOzdEO8CS5i7BEjG
         yw3g==
X-Gm-Message-State: AOJu0YwTVokRkFVHGjdnR3XkETnb4f13oW0iVWtSbBkX5xFO4OhSps61
	hZce5fAl49JE6xOayjyRi1gbtkFqQgQQSDqMZopcClRZr/b0bIAi6dCvQBr6QyDfQGNg90ISz/l
	575XTgMlks8x7tO1TIuwnD1kU85dWJ60xjbquhomQ9sMh91ydjy4iw+56YPJK8PsnHLnoEaAZP/
	4ZKJo=
X-Gm-Gg: AfdE7ckav0kiYVtbiLnojtkyeV4tsvSKPcDjbPGpKhbzimRotf+TK1qZQ9XRupSMuUR
	tqA14Nwpus5XGyEpTFSxpHeEMtJbrw/5gNWhGUDaYKDM6Qki4Iz3P58PBxD7ix4iKVJNZMoSr01
	S/PxWsROceyLK/uiRlNSVS40ky7OnpmQK5eFgA45c8qDP7gxfstsV6x+mn6siWXMJukSZbl/sVA
	qU6gWA5MFEWb9RUcsCt8yl8vD8A+ROZNUU9Nb0bXHskgjDBsL3WgbLow2GW5zxBni7eNnHCyypQ
	E3MrYYKJKd/SkGGvqNF03iBT9GmrKgsKBZAWiBHrvA+F3yqeREBaC7WC9YjwrbWjAv/3QlyB9/U
	KBKeMpCz3f9lBtGYEM0XTrXGt7Wl/WkDl
X-Received: by 2002:a05:6a00:a25c:b0:836:5c3c:2054 with SMTP id d2e1a72fcca58-845245a3c71mr7631921b3a.37.1781769253956;
        Thu, 18 Jun 2026 00:54:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:a25c:b0:836:5c3c:2054 with SMTP id d2e1a72fcca58-845245a3c71mr7631891b3a.37.1781769253419;
        Thu, 18 Jun 2026 00:54:13 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b04808dsm18552670b3a.52.2026.06.18.00.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:54:13 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH v1] shared/rap: Fix Mode 0 step serialization
Date: Thu, 18 Jun 2026 13:24:08 +0530
Message-Id: <20260618075408.95364-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA3MSBTYWx0ZWRfX+TzLXhiADhYt
 yWTM1uj9vFNOFC72fhxglM0/CYqpbOQ3c10d+0tdr59L9JJ05quIAdZmg0TafvEmqy1hJtLxkEV
 Z83HfHiiNXwOgXUR+ciwbapWRxY5rGgbn7ZOpOtYUD6ude+7VkLli0JZnl22x8TqxYB2CzajQni
 QPlXtPG/tHup+jE1+lXEHwjyDqNCE7r3W8J9VzoFAXF66pnUovpOOl2zYDRJ35ECyhHtQcztFyq
 4/y1OBIlfxj7nHlHwk2xx3hWMiUB+zqpNuz6BxiDKEln5tTolwRCk3P1Xjxvz5G0MW2aTdjm9OS
 wk8nPEonOBla+mTyQEtYvD1S+hBqux/fU12Na1dux+X2MO3wR1rzirgSUl7PW6acpMzWHpd0J4K
 IyOC7kXY2HUIrbFvw9SbSS5zJAbEWGd4hfmvX2jIWFGEkzveM0chqecgqDvywk9HKWxlsdFq18D
 q6irKCCaHQYOUpuwh+Q==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33a427 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=AtKqa8B5-W2iMbd9070A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: lMn41oa51wqkB937n66260lifabYKC8Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA3MSBTYWx0ZWRfX/Mr6ICqVFrSR
 1e9lamzMijHXre8YUeo4CEF7eQHmyXc9eLj2E+JZT1JqkKNUCC4fnzpCookqadMagt6o8fnU0G8
 NvCayccDhbl1SNHsjHVNXI1w5+zyEdg=
X-Proofpoint-GUID: lMn41oa51wqkB937n66260lifabYKC8Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180071

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Replace raw struct byte dump with field-by-field serialization
that conditionally includes init_measured_freq_offset only for
the Initiator role, matching the RAS wire format (5 bytes for
Initiator, 3 bytes for Reflector)
---
 src/shared/rap.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index 390fd3080..ecf7df5a7 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -1307,15 +1307,40 @@ static void process_cs_mode_zero(struct bt_rap *rap,
 				const struct cs_step_data *step,
 				uint8_t idx, uint8_t mode_byte)
 {
-	const uint8_t *payload;
-	uint8_t plen;
+	const struct cs_mode_zero_data *m0 =
+		&step->step_mode_data.mode_zero_data;
+	struct cstracker *resptracker = rap->resptracker;
+	enum cs_role cs_role = resptracker->role;
+	struct iovec temp_iov = { 0 };
+
+	temp_iov.iov_base = malloc(8);
+	if (!temp_iov.iov_base) {
+		DBG(rap, "Mode0 ERROR: malloc failed!");
+		return;
+	}
+	temp_iov.iov_len = 0;
+
+	if (!util_iov_push_u8(&temp_iov, m0->packet_quality) ||
+	    !util_iov_push_u8(&temp_iov, m0->packet_rssi_dbm) ||
+	    !util_iov_push_u8(&temp_iov, m0->packet_ant))
+		goto done;
+
+	if (cs_role == CS_ROLE_INITIATOR) {
+		if (!util_iov_push_le16(&temp_iov,
+					m0->init_measured_freq_offset))
+			goto done;
+	}
 
-	/* Mode 0: use raw structure bytes */
-	payload = (const uint8_t *)&step->step_mode_data;
-	plen = step->step_data_length;
-	cs_pd_ras_append_subevent_bytes(proc, payload, plen);
-	DBG(rap, "step[%u]: mode=0x%02x Mode0 payload_len=%u sent",
-		idx, mode_byte, (unsigned int)plen);
+	cs_pd_ras_append_subevent_bytes(proc, temp_iov.iov_base,
+					temp_iov.iov_len);
+
+done:
+	free(temp_iov.iov_base);
+
+	DBG(rap, "step[%u]: mode=0x%02x Mode0 serialized payload_len=%zu "
+		"role=%s",
+		idx, mode_byte, temp_iov.iov_len,
+		cs_role == CS_ROLE_INITIATOR ? "INIT" : "REFL");
 }
 
 static void process_cs_mode_one(struct bt_rap *rap,
-- 
2.34.1

