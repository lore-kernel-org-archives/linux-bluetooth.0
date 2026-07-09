Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA03AFD08
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577702; cv=none; b=OpPrrU080eD+unOx90kQTHPAWhWZta9l3i7BFElonSnLMSlFCgzVnWyGkeHFv1Kj09PAJpjRyZCaZ9Svr8QkdpvRrCt9c19Sb+bCMJJUYURcXxc0yIpRDAmiv0rZNPuTSHXGRLsNmMFYr2TpW8g5kFno9EJzVX9RqeNaZARfFNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577702; c=relaxed/simple;
	bh=VpdbSLGto+AyKsR2rqJ3dsyiHWiw1BGpcvRgUMcg1ms=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VCiIMWt1CNSE3CZZG4sAOQ9Cfepnc1qBNzirvck7AgJxqj6X6lyTsJmuLZjKJqh1R9+0GZoRiz6wiH3e8wx3bgUDVIlZba0WNAlZuVEwS+J0SCw/klBfdD8io7a6Dr+YrFxuW0U2SOkgCMR93Jteoo7NyuIlusHNH5QTa+onI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SopshEX8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UyS6I+FH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SopshEX8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UyS6I+FH"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960QSp784659
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 06:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jfDEccJk46xEXuUIsxw/cx
	8Y/sMZU0Bjb4ugXgO1lzM=; b=SopshEX8WgIandc6ABxk7/tg1yT8PbST8wR4y4
	u7z3fLa4mah0O8LLG6R7+z8N5SgqOSSIO6KuF4Bbnrx/3JXBj+CaDB/KY2nRV+iI
	XMCBwzZ3DYulQxnwItu91/hl7fwsvwoqBW+vrvoFmxDJra/kXSYYaLP1xOE5vxO+
	3hBatx/e+SXEbkEA4IhGfKEZHwZriR352y45xL1NYzW0Ul0U4sv8fJ6TxPT6xkEv
	oTcFeqwuwXj5gwhpAHWFTjWXlGsE6hb+jY5vyCmkZAQwln81ZvfVMl36MqXAyH9Q
	WAIF+jtdgoOT4TK/uXlEg+7yab3+Fvzuizkvmg9VxqAk5/ig==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u24ux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 06:15:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-847c049cdecso407151b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 23:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783577700; x=1784182500; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jfDEccJk46xEXuUIsxw/cx8Y/sMZU0Bjb4ugXgO1lzM=;
        b=UyS6I+FHfHtUasEsnWQ9MYIl11+EBdY1Ve9tdLLVIipz0B9tG3sd9UvUN2EWDcrdTu
         N5GDZhLDhZ8ppD9PojTu4kphonm/CvGMx0S7iTe0O4M0CPyOiF0r9eN5XkrsMk1FP4JX
         peAkldDuuurSSanaGSQT21SywT52JI2JWBcogVhs7t0Nb88VsHHLIag1Js6gwRU5bh24
         qpQKfMFtSzMb153CLlunLiGEfjkjjDZ1zuRd/T8GzLbWARk2MNR7t0mrDJvOz4zA278d
         ofMgwCOJjHkJjAxedYsOe2k93ZGsE0Y67qbmlTOIIyxB+aS8Q8onUa6wDwrnfRtRQb/3
         qphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577700; x=1784182500;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jfDEccJk46xEXuUIsxw/cx8Y/sMZU0Bjb4ugXgO1lzM=;
        b=bqjvlhTteuRVZZyCP41Ku9g6PbqKFHwchk36NKuJl5lLpCq67xbpldZ6lbMRn8oFIh
         k7j3kVRSN6Gt4kKqSN6pjnMmlONdi5ekt7NA+r2kDw1QOJgL9xcDCMXEdkkHntilbgs2
         u5z60wPcPwN6MG0rRyqgYzVSVMitlDxQBZkQs9bugJF3Fq4OE2ghcnE3NuTWe5dbglOS
         CEYwLhalLMxz7RaFuPMBoCFDs/UC4kbUwj4wdXSWb1KdP5Dk0wiQrOeZRyQ93/eoYZk+
         Ja0/u0jOBeBXyVDC8MTyvuj+qmEFW+lKp7/4mFN67dvCZ72u5EzlkqkgBnVR+g0Pneqk
         tC+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrPQY/ckNY4ennimiuCmxhfBGa8GGRyRVq4D2FRKbDtIcCXNC3kL92pYM3iSeX9Odaw1eva5FQUZp3hDNd2mdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxemyVyWngqa/YefTs0kTc1rU82lu4SBe36eoe5mxQurME8AjHl
	c+aQACdptJBWq8aULnrm8Q6jUTTgHJM+zuNEvFi0cL04RdpxAlMmUVMw5X5EesryQd8LEPjHmfV
	Zb6Ydn+wi5z08/m3wEPuTyhgNFd7KpecAOO64crfIXwW4BoM/cWkoDTL9EHj5RLIyZz+lTVsK8h
	lK0eg=
X-Gm-Gg: AfdE7cl96YJJK47/3dU6JtN/Vfy6ciJKN0aJJFuMg9Rd4vaRREBg6V2WoMkA2rg5rio
	gobp56NBogietxD4u1VXGurPMPVOHPLpKner1ICF4WEdATT2Xd0EvDOdC1D7XdO6wTUwsvOvRG1
	UA4/R3OiUOqoDQL2QSUrqKubyHKKaHgf20QyuyzOJ7RH/BVEiHWKQUXb0UUGn/dy4BIN2KynOy7
	ALMqi8J+TqgOZVMuj9tgmTt3Wp8l3EgSdrqt/cHRonAkt0vccycXY7ORpS4bMuaA2/NyFb+UL2M
	2hb+Ht1bAlWwsKLm+wNeNuaKg0ooASYbF1RbK0inGO9xBtoX04BdGKWVfAVy45JJqcCO+TUcIf3
	sFsmWV/nYLPcXeP3IZtgaTlwRCTrwxWhMVD9hMPl7ZKA0FGnUNTGyzXIxdg==
X-Received: by 2002:a05:6a00:4b16:b0:845:cb89:c1a3 with SMTP id d2e1a72fcca58-84855c3dd67mr1701670b3a.1.1783577699613;
        Wed, 08 Jul 2026 23:14:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b16:b0:845:cb89:c1a3 with SMTP id d2e1a72fcca58-84855c3dd67mr1701646b3a.1.1783577699139;
        Wed, 08 Jul 2026 23:14:59 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm8146032b3a.57.2026.07.08.23.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:14:58 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH 0/6] Bluetooth: btusb: Preparation for upcoming Qualcomm
 QCC2072 support
Date: Wed, 08 Jul 2026 23:14:57 -0700
Message-Id: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGE8T2oC/x2MSQqAMAwAvyI5W0hjUfErIsXWqLm4tCqC+HeLx
 2GYeSByEI7QZA8EviTKuiTQeQZ+7peJlQyJgZBKrLBW7jijs1vgze7eE1akqCjR9IZrPWhIYZK
 j3P+07d73A7xOMehkAAAA
X-Change-ID: 20260708-btusb_prep_qcc2072-23604a4e81d1
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfX6FneGKxdSnZw
 hpV8Ymv2Y28cmEQZIE6g/2SG1eU81t/5aSLu1TEN1vxlA/T4/KK7imJPFac+p1XeKybDXZ8wiel
 331Rpfd6APAwT3EURYrsE+BmAimWvmo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfX5S6eyLbP+O+H
 BGo5xG55kWyVuyCDIr9NDfzPJ+AZjD4ICbwyN9F3ql5qyU5I6iC3Ey+l8KamNmF4OwulkyI4fhs
 DvDigD7MMnIvGh0H7ZJAcsGsTtb4n5ypT80r/PXh71RFJ2vr5TYwHhx6s98NsBADAFeAm60UO4y
 3K3PrvhUkrdXct3MHCDkEURK7xzH9rbaAxGNdCPj9sD9WTYrmO0e9vEP5haWf9kvYYJEJOxA0sz
 jOEGyhm0kQ2hEf8dN10GQdVKmFqTBPRSR/tFHufEd7lNRkx/rv9+oFq1yx2ra3XG3Ht44k2xZDw
 prjKPHNgrsKLV/JZgR7U9uVacOZh2RqlB9bEwO/cqnWU0iQOR/pxXein+kSyE/RxFCEP6gfKbF0
 0u+Qshg2QCW1m4sedG2kc6Fyr7DcqOIdYNLh3CZsBYl7fudHOcUXgw9J01XsZmcCE6I8n17eQbM
 SfXSTdLCHLGyQTWO4ww==
X-Proofpoint-GUID: DCzz5Abg2G4dI4sPtnUXsQbnqgcrhP5l
X-Proofpoint-ORIG-GUID: DCzz5Abg2G4dI4sPtnUXsQbnqgcrhP5l
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4f3c64 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ufUqdrZNEWK7FkPXonEA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090055

This series collects the btusb and devcoredump changes required by the
upcoming Qualcomm QCC2072 Bluetooth driver. None of them are QCC2072-
specific: they refactor btusb into a shape that can host vendor-specific
source files, and make a few coredump helpers reusable.

Posting them as a standalone series because the QCC2072 driver itself is
larger and will take longer to review. These prerequisites are small and
self-contained, so they can hopefully be reviewed and merged on their own
in the meantime.

The series contains:
 - coredump: a readable state-name helper and a fixed-size dump header,
   both reused by the vendor driver
 - btusb: an indirect recv_intr() hook, hci_dev-based recv wrappers, a
   shared reset-prepare helper, and a split into btusb_main.c so vendor
   files can be added later

No functional change intended.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Zijun Hu (6):
      Bluetooth: coredump: Introduce and apply hci_devcd_state_name()
      Bluetooth: coredump: Allow drivers to pad dump header to fixed size
      Bluetooth: btusb: Add an indirect recv_intr() hook to btusb_data
      Bluetooth: btusb: Add wrappers btusb_recv_{event,acl}_hdev()
      Bluetooth: btusb: Add a simple static btusb_prepare_reset()
      Bluetooth: btusb: Build the driver from multiple source files

 drivers/bluetooth/Makefile                  |  2 ++
 drivers/bluetooth/{btusb.c => btusb_main.c} | 33 ++++++++++++++++++++++---
 include/net/bluetooth/coredump.h            | 11 +++++++++
 net/bluetooth/coredump.c                    | 38 ++++++++++++++++++++---------
 4 files changed, 68 insertions(+), 16 deletions(-)
---
base-commit: ca75417ab1793f23b3ddc91869f0809b593d6954
change-id: 20260708-btusb_prep_qcc2072-23604a4e81d1

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

