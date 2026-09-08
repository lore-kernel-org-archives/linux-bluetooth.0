Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8932E13B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 04:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841680; cv=none; b=vFKrGnxM3U3HOrTP9AVXBoT1ofFPU/sJDl7jC5o8VfT/ev5kpLgzkiqWtl83AQHB2R14vIa7JFqU+nFAOIt84DXrm4vn6/ogt1R9+pif9qwq6Uyk2/khEpv2JH/0My+549UtBmZ+kuwbZL61heHTfwKlr1JQ60sJUrSSJ0OEQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841680; c=relaxed/simple;
	bh=zsZrlQmHUpCelFB23WdYSX+OsI3J2ojSA9e5YhIvi0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJekJPkxeI1klWOhFWk233imiaF/2BEJhXyCAsBqYit1gBPdLKx+8h+N5HqK2OyIg+fSoWLAiDdrLz8w3LGWAC0L2NPjLqOdBmQf3M4iX0Xwra8JrQ4ldiVseBaL+nPbMlI33TI1lzYGKRB0Eh1XygDhhHoBSqg2AOLnbWVs+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VugUx5uF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dBKHCGtw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VugUx5uF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dBKHCGtw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6883U23x1988892
	for <linux-bluetooth@vger.kernel.org>; Tue, 8 Sep 2026 04:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eKy9WeqTx4x
	G/4DiiCOF+X82FoSQVbn3J099IlqrBYs=; b=VugUx5uFwh+Xq7X91UA1mAHQgbN
	PMHEcbx2gSDZHBHCR0QFwAsRPxaOEqes2jozNU9tyLIFpkXXQT0BLk3BjsUZM/8y
	dsnXqF7cBk2sa9ieoTTLIAv6vNybfp5FoEV8BrXlVHmHKr278U4UnRTJDDNfQYzC
	iMyI2Se18WZAfxH2lGASPy0DjTsFa6yerH89KnNumCSNcoh/o4NFzLUI2gN0i1dh
	WIxV9ue4EFGH4nl0tvbFVbkFqlaQOri3o8mniiBEhKyKfnnAZztUD3s+SeuUTWmO
	BO2VGakbKZhwnweo+jEmTQCxAwT2ICaBhMH3KWcskpeGIiw1NDuZmdTj77A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjagug5je-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 04:27:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so6810082a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 21:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788841677; x=1789446477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eKy9WeqTx4xG/4DiiCOF+X82FoSQVbn3J099IlqrBYs=;
        b=dBKHCGtwVK/al6SRjRy/S7iu5zy72Z8EaAUuG/bjQP3Qs395RopoDwQZuzmcJIlGH5
         xw7xsJTnSJhDel8fjy7B1EY7bkhEZW/ggxlPTD69zins5hxa8gM3YPq5/2o8CZHa1O9N
         ii5cQ8HtXoGhj24L5M4NhStULGoVbs0wd8//8GT78RI76piCsPzHqC88HVu1qI8Ye+oI
         zzKJcCOexZNZhr3zOceSf/NeOxVgn0Jsp2nIVQsgtW9l7Q2OLCs3aSMTiZ1fV/dz4b62
         tRAKH9hCArNfd2+CVF9bviJ4rS9SOFPPG7/AKHo43nBd4Qh7ZBHVYl1oRrxI2oY03uSf
         FzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788841677; x=1789446477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eKy9WeqTx4xG/4DiiCOF+X82FoSQVbn3J099IlqrBYs=;
        b=r4uUSbY0NJQOyvYveEguHtuX1/ZPEJS3xWMmRNu2wjxwPNDC6tzDWaxj+OpiaxO3ZL
         6C7ucQDl5X9EHKT4mPy/rBwZoGxobq3U8Ooe94Db2utO3Cg+kYh/pIguAMmLYNz90nFC
         wuOBUg5sNzI3RnTs6JpKUFBYK8RoOHFs0noOgkChRnTMfQX2FoacSBGDE8vj7IuslVd9
         URNbYQwnqPOOjm1FcufAIl4CTw3HBKACVGK6q8MwL+khAoekk6p/Af8DH10kjASIyyXT
         yUgdR7lqTo/9pMrTc2ThRFApW292KkkC7rDAnvx6Es06DWLy/uG+1mKo91ibkWpZnyHy
         BJTg==
X-Gm-Message-State: AFuF++m+t6hmnmettqlqSecC/+yY0P3YOvTGbmsu6GfRJuSvTR2YjfIA
	lkwccvekeJQuAsPF08GCTNuHVQWlK//K7W4cc0lphHGRLS3LxYBCf0n7eg6o6jdHSTOS5goGRn1
	VcK3oah+NOYcNTFDmeE84OnpD5P+zHQez8V30WHIPYbuOQU6cM/igCfXbcoav4xwbFpUyDEH7UT
	YmCXw=
X-Gm-Gg: AYBFou2K5Z72/r3a1mm3RIdft6xWsj1Zw2JYEKE+1Pzsl9O8ax6yDr4/NOiJvQV1mcA
	2TZ6J9rmeU28mgKW5fknYd7hmdhngKMzj/Ab5GF3LsTywSxabfs/GT09iV7FFGQTRPpXbgds47a
	DAfHyaO3pKSZViTADCxPEisqRGUC5lEbOn1Dwh4vrdk3nuONKEkkMuztsKZx3ukmM47ue53ZlcG
	5Bnn0jQLO7umVWB3Gamvc9pZLI3wyzsCvUHygksrUI54c8OoUOFBA+yKChSuKiniLGhU58SQixD
	F1oEXgl1l1Z7/aAAKvNAeT+fTeaqyYMUbLW4xLDuq7v1XqKe+cP7KC/ZrzDNImrj6J5zvuFvRzf
	KOFkNuUvi1drDs7UG5N7XWBtl39Gv2w==
X-Received: by 2002:a17:90b:268f:b0:398:c3a3:dbd0 with SMTP id 98e67ed59e1d1-39b2612eb96mr42056855a91.8.1788841677191;
        Mon, 07 Sep 2026 21:27:57 -0700 (PDT)
X-Received: by 2002:a17:90b:268f:b0:398:c3a3:dbd0 with SMTP id 98e67ed59e1d1-39b2612eb96mr42056794a91.8.1788841676723;
        Mon, 07 Sep 2026 21:27:56 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f44d7sm31577301eec.22.2026.09.07.21.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 21:27:56 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 3/3] profiles: honor OndemandRanging config for RAS Initiator
Date: Tue,  8 Sep 2026 09:57:27 +0530
Message-Id: <20260908042727.1677501-4-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908042727.1677501-1-naga.akella@oss.qualcomm.com>
References: <20260908042727.1677501-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqLWQjXh c=1 sm=1 tr=0 ts=6a9f8ece cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=jk3f06rm_vXkH0prXC8A:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: TYzCbt6DLwMdRlY7TeRk_Be9aCq8LNp4
X-Proofpoint-ORIG-GUID: TYzCbt6DLwMdRlY7TeRk_Be9aCq8LNp4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA0NiBTYWx0ZWRfX2FxYwsNLLof0
 jDyMEI/15QQOlS4wUM3r9Cvg/u6aHnb2UcRZemmvAkIfRvO2G/HyOKMJJbYHmuk8g5m0LNxZ2zh
 qDTyihTqc2wpmr1tpIoWkg44CZMQC3o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA0NiBTYWx0ZWRfX8K83OTf0A7XL
 TOjJ6J5qy2neCtKg+M0bFQRe3bXKfTIcGscuS2kQDh13DlATIJ8jqOU+aEQAC3sk4Optqo0DglA
 yLfecUesFyq9e5pP4zYTF3vDwPu0QoFLomS46sZD6HB3w+mdAFwylpSRRRdyhQ0WrNmnUghp5sH
 qAc00XFKunfTDAMC8bRulSyQ8JDj5nFyZMT12V/sIW84ni5y+Jz719wbgCeW9eAgHkrj6ddxhtd
 URRCxL+PngKke3if+BBUCbhQuYwD4CwBG0qxOGZycIHE/mW1yVH/WJJKzHVJ6l/ZB/DQTxN0xCL
 GLFfaVxrkDmL76RswYWrKUqQydGD7GorjGJZOz4UhJOHYKXcbbKGU230bBzeNmk1RalSaHBHgd0
 YDZ1gfW+xChL43sicSsBO6XFSrhHmwErtUXFaO69TVYcRjdUIeREnPzru216yJO4i3eoX3IyQRW
 fwtCDd2v4s6T/llrQfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_07,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080046

In rap_accept(), call bt_rap_set_ondemand_ranging(data->rap, true)
before bt_rap_attach() when btd_opts.defaults.bcs.ondemand_ranging is
set, so the initiator uses on-demand ranging data delivery instead of
the default real-time stream.
---
 profiles/ranging/rap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index cabf8a5de..b494d188c 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -1105,6 +1105,9 @@ static int rap_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	if (btd_opts.defaults.bcs.ondemand_ranging)
+		bt_rap_set_ondemand_ranging(data->rap, true);
+
 	if (!bt_rap_attach(data->rap, client)) {
 		error("RAP unable to attach");
 		return -EINVAL;
-- 

