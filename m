Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C8383C8D
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777100789; cv=none; b=H9pPd3g9riPZ+AFa+MXP2oAyKlym76K6Fz8PEBPNKkhcInJd5vD66W8K3458xfVP89X5Hr4RxFcMhvzj2I9J2P09MwrN+Zh2EZHQzF+h7fg5sSuxS5ewaWiz17Yzrvioymai3tiUCcO5W5CjvonRUFvQoOoRDtPMjtl2tDYAOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777100789; c=relaxed/simple;
	bh=r5sl6ElDfZtcOwnpLGwQUtm/mybH7/tmptT89iXoxXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESMrjTSe5EDAhLLws0A6NU6VVcgpRRy96E8PGBJuCp5fP8tMI3iS4HKFQ05bi65PS1Geh/Qq9Aj8b3w9QPoInAB3wl1RGu5wMISYbDbHea5OOC+BlFx4TOf0cqG5yJE3BhfdbtrwUbhddr64NCFucAQngqOqOH7sllOsrsRmcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UPoHzMBY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CmvdwVfh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UPoHzMBY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CmvdwVfh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63P3jZmx1015872
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 07:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=j3nD4dT30RJWanDm3A+KKWIN9ndFnUsEl8B
	lxDhig74=; b=UPoHzMBYe53YvPHsBIpa33uqnNd+mdP5+b2c4EBs3gkqZT9K8rf
	wb19pg0MIE3n/hRgMnlrqdzgG2AE/+7bIMv2+tReV8w+rgFtQnJwDMxauTZt/s9T
	f3ie160aPPQmNmMCJcWbk6+936Iy8xuJyCyCh5k6Rnscr3A6lCnugWCKfuSEi2yc
	/KhcoUXgOBTcSIpfIq7fNSNRMsjJY5Hy/mLY7CjfhuZyClyUmkRSJkBKRtxPhEDU
	/QU2hjsl/QLePgckhhTUnAW3gvmHjDmcrVYlyLFOjSlCil/E4nprMWL8asmytI4K
	TN9aYq0p1pHYeOVUtpb4Px02Y4+cKIAxIIw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drp07gb6p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 07:06:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b24e9b4d82so83695535ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 00:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777100785; x=1777705585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3nD4dT30RJWanDm3A+KKWIN9ndFnUsEl8BlxDhig74=;
        b=CmvdwVfhTDUGMk0kSVlFVrh81ZbK6VLU+u36SmeT3Vk5bFXPNA0Jz58sERaQt5gUzG
         oESQ+Ed4duRB/jAsUqDd6piopRmgcxKdDor1jSok9wU6pTweyXNKDdv9sq5xZsmtctSg
         Ae7ScCvO8vX1LAXDaf32H3YIkWR+NYnH3xQ4CMSJhgQrL9BHDuzZVY8iAfVKJ4P779TX
         mIU0q6kpO9WN71UQ1q1hCZBo+M8J0+wWZyZ8ntWCoVUTr45/RuQoWJWtz6qn4z9vdISx
         drLDoQnavATZvZpwQJ82/08xQ5Cs0ksidZ8g6bParwVvSDRA58vBdu8+Nns7jdKxBrs0
         l83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777100785; x=1777705585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3nD4dT30RJWanDm3A+KKWIN9ndFnUsEl8BlxDhig74=;
        b=BKuJeDQLDS5idiFmEbyCc7SdfGeZdT0fdSqAaKaZqwZLzvN5N9ca71CPxGBepPp7xF
         KrEJnexE/WlLS7rUMkiGFZSHLA5+lDMFFZrTYU4YzTLrgBhon4gkMnVeH7MWzs4qppl8
         Dq7t4fLQOhMkN2KMHQwUdFZu8qID9swjOIkKuqXK4cxcYyM5GbZ4rYRmJ7nb2EK8zl1M
         dcf0Xbzg8N4y5PwiyWz7pMxOie/NXmAn3MW+7alcPdmYjs0LfkMOYDuN7v0h250PuiUA
         A0qqqx9W6Genuo+Yz9ITaH2wKmPsfl+za0V/EM/YN/F0G/Y+esgO0J2VrzzzimS1IqwP
         fN9Q==
X-Gm-Message-State: AOJu0Yy/OKQEW2ad5l/kjjDSzIHgiAjSMZZ78JUyIUJeizF16mIYhm5n
	6iDy5idF9RgKGHhjV1YeN2GnPE3dZ6WuCVmsxqbdGhRLt6g4dI6VOzWbhuNbT/La+lOaiOs362F
	6IYko7dlTcyJV0Gq0scGQqE2wXyPuso+BKBn6SbMEz3nlCWMmTOdjLUd/JQT9UQcSqVWtn5ma/m
	Pev1Q=
X-Gm-Gg: AeBDievpKxNoAwOASTzDw/bjJW+gc/7bL7H+/FRth4mLhirPozW1XoUzloLvupf+XZm
	mCTFjbGEyl7QUrdZAbwT0hzBMUrKZHSZESipRAu6Et7lOwt8lttkehTi40To4awNiN6JQ5ziNZG
	aSM9wcVobvR+GSWkTP1HYfmFXcJnlCA0jJlC735EgjMs0UwNAFOOpApZ8GG+yK1GBxLYPMFA5Ee
	D753hg8AXZT9SZCetH/EJXquHXmmxg+I1YDI/idDexjoruGBvpAEhg+HyA2K8aIpMdZAHmmV+p1
	Ae+xjZbz8o5sWxK2Ln28upQlT12aXszGw1ZsQ2QFE7YfaRTIvLBqN08xtEUk4b9hSNhYbse0Idk
	45qm7CL6P+wGh6euP62wD+/b7ugUDAP73MTJc2TzUqoai3tCW7vb9KQ==
X-Received: by 2002:a17:903:9cc:b0:2b0:4fb3:c771 with SMTP id d9443c01a7336-2b5f9dbcd70mr309861875ad.6.1777100784790;
        Sat, 25 Apr 2026 00:06:24 -0700 (PDT)
X-Received: by 2002:a17:903:9cc:b0:2b0:4fb3:c771 with SMTP id d9443c01a7336-2b5f9dbcd70mr309861615ad.6.1777100784304;
        Sat, 25 Apr 2026 00:06:24 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1763dsm226030275ad.23.2026.04.25.00.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 00:06:24 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH v2 0/2] Add RAS Packet format and Notification support
Date: Sat, 25 Apr 2026 12:36:18 +0530
Message-Id: <20260425070620.3381591-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=69ec67f1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Q1998vZ3izB8yRL-wHgA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: LfbslHuw4uuSvSKQgQgAUc-3Ybw7OvrA
X-Proofpoint-GUID: LfbslHuw4uuSvSKQgQgAUc-3Ybw7OvrA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDA2NyBTYWx0ZWRfX3sYCT+DDrGhE
 f4Sk79k80e6Hbyoph64C1YBFeZ7sZBsoSupIDOXORhVrpcG1UG1d++VlRf3WzPhJWO0mNbJWurc
 Wq1nv2fQzrAxSFVGwiFltz6D4Ur2kyd/IWPfzikzMF7bihszeU8RJb1BheLf6hnQl5IgcrAgWyp
 tZQAQNbsccGDcsoXzoMiBfkUA1k1x4B8SsSN92yJ+IBp6RP36eMmrzb6NWMaoGq1EyYqV2PO92c
 Ojx510Eowu4foChgUpltdjAqCAMUXOI/2wOHBYjxsIKTnHpy7CWlPRaESKc6ysj/WkBT0UHKR5V
 z4tdjX2J7b01Vib46h+9EsKHqyZ1VnOVWzi42XxdQ18LKNmdex/7QW0MsNUJFSQWKpx7zIgzdd9
 /AyPSA8BWN4B6Lgd4poi6Wt6oDx4NskMHxFzYGsARz11gLzhhL7O6lbh+WCAfReYRmsdi2fU4Ke
 nqQezLeQJ7sp/xinS0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250067

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Changes in v2:
Fixed missing declaration in src/shared/rap.c

Patch overview:
  1/2 src/shared: Add RAS packet format and sending notifications to client
  2/2 uint/test-rap : Add PTS tests for CS reflector


 src/shared/rap.c | 1142 +++++++++++++++++++++++++++++++++++++++++++++-
 unit/test-rap.c  |  264 ++++++++++-
 2 files changed, 1390 insertions(+), 16 deletions(-)

-- 
2.34.1

