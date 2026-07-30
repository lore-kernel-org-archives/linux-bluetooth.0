Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F1C34A3C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393617; cv=none; b=EJD8j9ZY7AM8BvcUovfbT5V9RkiI2+rhmOMXJ0Qj2ez5lUEt3z5SHBsHJxvDnop7SA1LkKm2b+N/lE7Tb+qFQYbbb3kPCrWt8Jh+9EEyuyuuam31C6lOpW8U71XJBPk4lHOw3odW+9ToPWwmKsrq6ygdyIybml9zYP8Q7zhVTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393617; c=relaxed/simple;
	bh=3clSNhcS34I87EbPqfIew++dbasucjJyNd5B+EobeZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIjcph1SE5yDP2aSrgDHcpgCMk2GFss4UQrtfKOyeH4sjFnJulA+7PTiEiqvt6sLnMsua1UO2L3CYv6n4g3hFQyukJPNPOKEkpm8ZEhrJkbArLGEp5Wd6Fe2pGVSpnGRnp7Dm9rzL5QDUqDV5LD2DGKvbLzOA99A3Htw9pOCo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kGeD8dRc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RZjujFb0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kGeD8dRc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RZjujFb0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6agHa270609
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BzwYRL4YGbvGh/XB3dq3rJx6cvX2UMq9gRd
	Xx7rfCWk=; b=kGeD8dRcXEn/OqmjdkMEZTg5/vGLOXsXGfUryNU90LB3O+8Ougc
	lGj5Mkby7RkFIislBpJ2vgaV0DBZ9UZswVWNNFwzWSryb0RMyG501fCdKP1i2MJU
	KBq0pFcXlsICvSwW4QBxQEl70WVcQhHkzAl/Moz2W/Xcvt9W1u2J6eTWbSiTDDMu
	bIHpkh5sh5XeqJrtqwsY5DsgJHCzNCCpWB2nGRGGz/bWh/5JbmuXPXwBYA7ZWSp/
	s+AzXpyhtTnV8Z/Vwk3drZkwaoLVBN9sfj6qFYDsD8zbD6wzdRCBwYrUtAIHff+c
	cb/mdAcl+Pa6pcPROGP2/HuSdpjPOwMR6uA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr1c801u6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:40:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca8aee88725so2540636a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785393614; x=1785998414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzwYRL4YGbvGh/XB3dq3rJx6cvX2UMq9gRdXx7rfCWk=;
        b=RZjujFb0z/gmYrtlK31o7seM+wYg5lC0iDV0E2iy54bvN7zS6dAfBn8qbYSo4+Y7+h
         iPw/Lescqy18XQSgnZaxQMECoig9rSi8dhWRm/4BAxRmxhE3KxfcHIhBAHABdf2FprDK
         /JdsWiN+8/o4Bfw0hCgX/0tLmQmoLfS+qvSBlm041ezBR+ab6ylCVbSMSxh9kUXKeedK
         gcqlkk5ykWJc2FYRzcFx9hOsHmp5gm89Anf8aXiNULWV03jpz37f66pRo8jRlmuQMzom
         gHKUZ/bxr5Uk1CdZQToPv7sJf8EVIWittU+G+J1GXBDEbZF1oWODMtbowno8QaffxX5v
         v0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393614; x=1785998414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzwYRL4YGbvGh/XB3dq3rJx6cvX2UMq9gRdXx7rfCWk=;
        b=sjimh+eLdcT8FRadXkNX2z0cz9ex6b6thNH8F6JgqZ6OxVVi1VDy0XFWBIVJSumZaj
         oZzGbKsGmr0WlL7So1DfKamyIExWyC8NO1gPZpxexORAUsAhRpeHf01x5PCojEDeF24y
         CZRSv0HBegyednvMlJ/+YW9FJ/E8Fh4DbN11NPWBm0qRSM1aSNXAfvYEFfzmssLH2xLC
         OXlGzQCsdn7rGm5CgIQq0lhMKoXFwxxBi33Ec0wkZZuVn2wjdpxK+Ui9rFgXKrdS3pVQ
         zx+IfRZYHzUwZ2YtWcvxGjmDLz8gerpMaIzVgnzfCcvA83zCy83wH0USLv47qdMmBMFb
         jUXg==
X-Gm-Message-State: AOJu0YxsouoB/i1DnKcfdOdlEpDVtFbRD6daPLojxo9b9NdZfD/JNMGI
	yy4uUTdazzOnqVcHuVvqW12lSLsaQVziLOugf2VEc2S3vL8MTI3OFpZlU+WEA01IRxr41tw0Ylc
	LIztgpSs03Hg0iQdhiuj5xVeuVCpeDq/B8m8yUg4tuu4/jDjJPhmIVcxkafGPxc+lyVmU0Gs5v3
	rX48c=
X-Gm-Gg: AR+sD12RW9GXdHY6/KnuIApJ9uQlFLXE3ygKbWMWMz13ua1Fq/+gd6EljUQ+xqF3ZO0
	wqgM47Gcp3k76PWwY/eqefmK5qEmE1B0O816yF1UEE8YRSSecrQslnhAAvxm3NfveVN8YlwoBms
	yneGRUrrn9H5GJ3BWE6XowWsmcSHalHZ46cjefeCQKDPZMRZmxXEWOiPYbDNhnos/nKWgWJqPvK
	oK/33qaT4unxScl3FZmWpi0GWf7tHQ/waOSGiqC7pdabsGOBisbTaiCMmOrIEVybl51zZmj6FpG
	vUWW+NpBEDyLox/GVNjHOro8uZ/jdV64qaqH+JFcLZu07ta78Gvjsaoi53Tdu/1zZSrhueTbBWi
	T7BdDCKAiauFqI0s5w3c8EHS/gR6Fow==
X-Received: by 2002:a05:6a20:6a2c:b0:3aa:c964:3c27 with SMTP id adf61e73a8af0-3c900685421mr1225609637.46.1785393614160;
        Wed, 29 Jul 2026 23:40:14 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a2c:b0:3aa:c964:3c27 with SMTP id adf61e73a8af0-3c900685421mr1225584637.46.1785393613719;
        Wed, 29 Jul 2026 23:40:13 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72643a12sm26304321c88.5.2026.07.29.23.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:40:13 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 0/3] Add CS procedure data aggregation and D-Bus export
Date: Thu, 30 Jul 2026 12:10:04 +0530
Message-Id: <20260730064007.1229304-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UiOirC9Fso7v3-YkPcQsQKmkNgIao6d8
X-Proofpoint-ORIG-GUID: UiOirC9Fso7v3-YkPcQsQKmkNgIao6d8
X-Authority-Analysis: v=2.4 cv=EJU2FVZC c=1 sm=1 tr=0 ts=6a6af1cf cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=oIet3pLuq376Fm42oFoA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0NSBTYWx0ZWRfX0BTbJJM7tton
 +mAOKfQhKx6CdwK6CoIxSjHgCmP641BgILj0T/j7MbAxXW7lF9lYxRNEywQtjaQ4znDbQpkk9PI
 mevolTRqwxYVLhLV4pv6MvbQ8nFa43Qbg6veWdN+91qJOWeLDmR7gGgIwc2dF+k9fkc0auAl0S5
 m97oCwacCXIbrdY6NoG+/w7m2xT/alfzRAq7W8IOWsvHRNe2UsEi105P6KlpMEszBqQPhUwyqee
 tyBvm49yRw3CwVIAYmVbkoQkd+Jz1vUNgVegORmx8aszmNHRKWTI/ordZ5shUWG/bxmIPljrK3C
 TkCUP1xbnyrx2tm1Ev4LITUV2KdlL8mjGfBov4pKBATPwPUKHLtdrNEa0NpRlSQEr9zM5LdV6Bl
 fB3M+W55ZlPj7ZOPJK5PrWYRcOmks4HwntQjwITJYESkwcjeyZqtDhi309WfR4zwtvuvdxtwmEM
 Njzc7reChuNrpjqu5+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0NSBTYWx0ZWRfX0SlTrmwozlPF
 h+RUOQIuusGpgqmtzR7M+88PZB1uhjoYeNyfkwsOdvZ+y2JnD/akESNXl80gNA73P9Lcv4N28As
 17eE3fOTLTUJDlynKW//JIBf9RV8KYg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300045

This series adds support for collecting, aggregating, and exporting
Channel Sounding procedure data to userspace.

The first patch introduces a new procedure-data aggregation layer in
shared/rap. It tracks local initiator and remote reflector results for
each procedure, combines them once both sides are complete, and provides
a callback-based API for consumers.

The second patch builds on this infrastructure by serializing completed
CS procedure data into a binary blob and exposing it through a new
ProcedureData signal on the CS D-Bus interface. This allows external
ranging estimation daemons to consume raw controller measurement data
without requiring BlueZ to expose or maintain a fixed D-Bus structure
for evolving CS result formats.

The final patch updates the D-Bus API documentation to reflect the new
signal format

Changes in v3:
- Rebase the changes

Naga Bhavani Akella (3):
  shared: Add bcs_procedure_data aggregation and procedure data API
  profiles/ranging: Emit CS ProcedureData signal over D-Bus
  doc: Update ProcedureData signal doc for byte-blob format

 doc/org.bluez.ChannelSounding1.rst | 365 ++++++----------
 profiles/ranging/rap.c             | 292 ++++++++++++-
 profiles/ranging/rap_hci.c         |  59 +++
 src/shared/rap.c                   | 679 +++++++++++++++++++++++++++--
 src/shared/rap.h                   |  50 +++
 5 files changed, 1174 insertions(+), 271 deletions(-)

-- 

