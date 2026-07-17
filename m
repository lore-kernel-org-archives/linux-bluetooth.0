Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFC83DD86F
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273216; cv=none; b=YoC2MPrYChDFz91ybqPy/SzcCf8NjcEOJ7410L9OMboHWCRBb8knp5iY/S+pRG6pojelwslrFipxkHUEEK8fd6oIONPj3aCXYCsB42ThuF5lC8c5FHVbzhuRIjJmi25KDDTj6NrLOPiN6b3q+YCGHbv2sVBfAvfjN3+qnVl9Tbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273216; c=relaxed/simple;
	bh=c7EAHZRAj5YRh7mZOzFYwRWAN3RP+m6JPcLy9q9UoTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h7hbXcgxYSUn+Z7DquDcAeQQ92SbiuDCmgzUTy1xhUHIwKtuw/iQHQEzwa0CrRQcv9+ZOxJ5jORW5u3zan0WF30GmLaD9+YFzKCH2yuUea+K+adxitIupVUgzTnK0o5OzAmNajEVZmKpNgbqSYPX9XeVZFg/Hwv82xNdiB6cd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W3xILJNk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f1SW9KKb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W3xILJNk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f1SW9KKb"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cI9K2098594
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 07:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=F6E3pp/7gM6l/G8cjMLXoWw/5+iyzwbFPah
	7GCvg2Qg=; b=W3xILJNkqANYd7tQISlp3x9RgoH+tDaDeesn45J8ZoqlNdlVYSE
	9S3pw2dUgudLJjQyqRbi6uzX1oa9u8ifvlAxk3YTEnXbq7b2Z8t6nWSvTJu4+wNA
	Ox200IC+7vmry4gh7m5eedHNGon+zJ+kisgPW0PMUdt8QHZy+oIB409Q76dGWhFP
	ixMl8ZOUKtRp5YvtbglwNosof+/Am18vbtLSN9GcZChFyddoYnt+HoeLlh9h7eqf
	bXd+ePnk0b9FvY1hNS6F2R25c/FJEM0d7SZ1WO6Bxui3ud5f+nr67g9aT/NJnosT
	bLGYDOpMIMdnuo11gvBbrBXY84m9wOA0KMw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6jjfd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 07:26:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88ad1558f4so4062571a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784273214; x=1784878014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F6E3pp/7gM6l/G8cjMLXoWw/5+iyzwbFPah7GCvg2Qg=;
        b=f1SW9KKbtdn29A5mM7hRVeO6nb9riDD1i8FZr1wxTIEeKlZHwifnuHbea8PDDeLv3+
         R4JeCF08Ah0WB4OOvNDveHISY9aiAMxajVDM9TQm97mfRCFAZw4W/d32SXlAI5dtFoTG
         76OQ3VMgQ86H80xGieyF54jVKGy6U2USH7So5hLpfjNxW1rUtyR1pHnqmIciuFUQO6qm
         HrzpV5gI8DR8ihSDB5R25GPeYQOskAe25S+oQigcTX0Hsk6wwaY+LyKdVGSIFQmGlUEN
         CvTiakIpEvFefI8gbmsDSwmAHjAO1fRMgo58oMCYDOip9rQylr3Zmv7hFugja6M8Ak/w
         nAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784273214; x=1784878014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F6E3pp/7gM6l/G8cjMLXoWw/5+iyzwbFPah7GCvg2Qg=;
        b=YnjdiFSjwWSbP6JK6EeLOrFRCkRtv1pkfuyhPoZknh4P7JUeJKsE8eFIGYZt2rzLnN
         ga25kvXnVRI8cUiN/P2Ytgk/108gBgnAK6kdtIKZGpuYHt/mfrYSkK73QjRthecgmON7
         oKsipM5TZCJIfcN3lw3/CvaOwWxQva4hxUnU6pA6W8yv27oAmRSmrrXSfLTr7eL5Iv1I
         902k8iiRufhVX6psxvhhmAxeXVX9lAvxlDaDRu4E//urcruCf8gJC0EyS905fkCYHVAb
         MTTkkdhpxXBeGj3NOVgNz9iEuQciuRMCm2mcmX/akubWcXP4rGNplLVNFoGieszxPLTE
         dmCA==
X-Gm-Message-State: AOJu0YwXq7sQemF0qCjIkvDteq83mJK+nnAHlXpSyj7jcjh6z2FuugVv
	Osewc7M0+50f68sEm8AIvcUsTrzgQ5T+FKYN6FU4MAApb79dmWMFCrIJEFMqwK3ao+CdVUlWkVK
	mkIODi1uyPrtfvcj/PNtade+rq1HUAa4GjEKP529N0/+4KUN430XdI/Rbo1EhDfxpF1w9A+Hfxd
	BYTGI=
X-Gm-Gg: AfdE7cl0KcX7YQ9i2zD9y8FV9kDMDklKUvwODaj3uCJYWoZa0NgGyE+wZ9lWMZ0yuub
	Yufcl7x/EjiW0IBB8o91EPVKJLfDj273Escpgj2QXcF7UZfAXwDU0I1Gfr2QaB8NGRNJcpS042z
	KL0NJctjT4NvkU3hV1LzHidQuBDqKj+LEj21xVESG6V5xojnB4FFWwpzSKt6Tqa9wPcY7i+/28V
	J/+bQtEe7Pmvh9ZnK5DFpRF9u9dld0LUgOjVI+nmmeC50myl9JFlmMcX58e+2dMRkJe0QinnC7t
	HCNceZPAZSEHUbyvDmXP5cbQQNPSAvEMLvsUUl3pKy6r9DIn6M0XbzRytWCDPVjAg0PdP5n1flW
	N58R88Od20XFC3iMtSOD9aQ==
X-Received: by 2002:a05:6a20:2446:b0:3c3:8c88:7b2a with SMTP id adf61e73a8af0-3c3ad975d6amr1545681637.58.1784273213664;
        Fri, 17 Jul 2026 00:26:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:2446:b0:3c3:8c88:7b2a with SMTP id adf61e73a8af0-3c3ad975d6amr1545656637.58.1784273213260;
        Fri, 17 Jul 2026 00:26:53 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de34d4sm455579a12.26.2026.07.17.00.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 00:26:52 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1 0/2] Channel Sounding: Aggregate procedure data and expose via D-Bus
Date: Fri, 17 Jul 2026 12:56:45 +0530
Message-Id: <20260717072647.255002-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA3MiBTYWx0ZWRfX1aiYKGqJZsrV
 4AmcoF4SsQuRXyZudWnQ2GqfKBiG+GR7TcMVk9At0bl6pNYbDgo5X1yaQRWxtK6Lln75v1bhUe6
 Kr9ZX7vP4dXx1aBWB0FKAGAT8g7jnoMRXgbCNkxB4+0SZb/CZ4rzAYhq6DNYtUOvCW2i3/1Irb/
 yUKQjjwA4Wuh2IPRwP1CJnxu+unRNjPDHkfcQNvPkRB/xQasmPlvebwvdODT+T2Pmgf27Ikm9dR
 t3nkwvl5E0zF5XuzxdW5z3I0/7P4MvfFxTdyFsv0BFoeBdIUgnOg3O0+TMYJkEHwO/G69qWEOET
 a6lJKhca6C9Ew0ZsJi22X4csx7ywxLoIQRPidGGtYGj8/DkChEmbj5JWzhiVOb/70fHVszW+vQm
 wUjKHWNXM8DIxD/YWrkcuh1VSGZCJLhxmMX2h+zkgWQ4jX/kPIKjNtgqv1zhe9Pigv9vvgQQdcO
 PIYGMITR7NzP/Kr5gJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA3MiBTYWx0ZWRfX0zD+bMOOJrOR
 L6XgUAUMm2ks6BhrSZmMz0dpeHYnIbRaGlmVsAhXjZ6J4jPP1whHLy8SsX2HHrLTWvK3J1RzfUf
 KhlP/3pRHpH7I3vDXhKbf/Xe55rX4/E=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a59d93e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=3z_Bp4W0iw3ipDWfmDAA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: --aFleXyiV6i2CdzyMY3eX6i82ZOrAqG
X-Proofpoint-ORIG-GUID: --aFleXyiV6i2CdzyMY3eX6i82ZOrAqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170072

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

This series adds infrastructure to aggregate Channel Sounding (CS)
procedure results from both the local initiator and remote reflector
into a single bcs_procedure_data structure, and exposes the completed
data over D-Bus for use by distance-calculation applications.

Patch overview:
  1/2 shared/rap: Add bcs_procedure_data aggregation and procedure data API
  2/2 profiles/ranging: Add D-Bus ProcedureData signal for Channel Sounding

Prathibha Madugonde (2):
  shared/rap: Add bcs_procedure_data aggregation and procedure data API
  profiles/ranging: Add D-Bus ProcedureData signal for Channel Sounding

 profiles/ranging/rap.c     | 497 ++++++++++++++++++++++++++-
 profiles/ranging/rap_hci.c |  59 ++++
 src/shared/rap.c           | 673 +++++++++++++++++++++++++++++++++++--
 src/shared/rap.h           |  50 +++
 4 files changed, 1242 insertions(+), 37 deletions(-)

-- 
2.34.1

