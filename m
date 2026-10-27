Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085075;
	b=IR6R9Ql+m3gCMbnB4mCIoU4FTCa8IkVh9vIt7/WprjYiC5T/1XyK9MdFenlCIESwZQkF
	 7VfG4HP/OZGWaTqNAdgkrLrIGAQVVs9mKKemhC5dNT2WEMZLHrJdqFtSeIQRsxHN7EV17
	 1gRRfRoXb/hWNDo4wRmbkwYH1qTnHvLmS3PvPNb4Qxlp9d/YIOZxBvQXhK+PknX0QTV6H
	 e/n91QXT1usCvs6OihK6fVGj63tRbCMcTRdO3VBjhuvR7w111qAcUuoOouzlRM3Q/ZDd5
	 5c6qj8q8orGn7UX/Uj7mBF8CeowNQwiCreN+Wlg0IqKqtv65qeorr8Fg1XpQbxModig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085075;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WSCHjsifJRpNZK1rYg2aybqA5LzG+thsVnEQPkiOZXM=;
	b=lQGKHftZeU9khN3g6DXEeeLDo6AsAKE8FgQrG1AOKzzBqhhYiAM4rOe+xaM5JbHIssDH
	 ggVZ/p23YG/xeUaE93BQabH/O4e7wZvop+G1wKUR9KQAhOZZ580pXRaw5MAcKYscLpsdN
	 r2caDhSC4x86vqhyT2/RhUmYaBrmUoxxPN6QZBA+B9ZzkwQPjdC+8xF95DkygC0Vmqw1i
	 zQSkAv3T+aK8pQYpj9fNrp9SBwRywquz9Dk7aGmbM9wJWVDQsGkKRaw46ODuTXRUBP9Rq
	 nxMJx4FeTEok98B/LTOhS16RyZAS9SmbZBS9vR+sGcN4viRqfPQ6SERT6SAxntpEDvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cc1Y6RNb;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C317606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 07:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C317606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cc1Y6RNb
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R5YtN82349818
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 07:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WSCHjsifJRpNZK1rYg2aybqA5LzG+thsVnE
	QPkiOZXM=; b=Cc1Y6RNbZsIP4zpzzbSXkfB0CMyTg8VtmQ0BL7OJQwHua9gjhJB
	BBDpFDq5s0YIYW28UnGbJPuQ2WQcsovNzmVO6VSe7bX4r8LMBPZ1DxWi6T0KWS9L
	xDb46OKv1/mfR2X93nBk/LFYku4ig0X3fag1XJ3G9itKNhf8pVYSOWkqcvE0XUg5
	0w1crhGVItSifXDu3j6Peg8xJdK/5X3MTb30eoKNJcGJ9SN7ifnKmCY0wFP18cAq
	YFYTRDSyY6+/QdQYuBeBoljH7QqjXuBNbBCjGdhhHVb9YWjbRT0xtE9NOCbw1ddb
	9671sFvJ5+FPsP18tIKIoM80CxliERMdkEg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh9197tj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 07:11:14 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69R7BCEE1202838;
	Tue, 27 Oct 2026 07:11:12 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 69R7BCN31202826
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 07:11:12 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 42340243AB; Tue, 27 Oct 2026 15:11:11 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v2 0/2] obexd/pbap: Fix NewMissedCalls reporting
Date: Tue, 27 Oct 2026 15:10:44 +0800
Message-Id: <20261027071046.2272116-1-jinwang.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: knx7yxqwchKmukeqpHN6EVGCaouakhcb
X-Proofpoint-GUID: knx7yxqwchKmukeqpHN6EVGCaouakhcb
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae04e92 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=l_hNLHxUIP7MVZf_x6sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyOCBTYWx0ZWRfX/zK+GgrO4NcJ
 GxaRPcp6tKFgqaJ28xPYhSQWhzn7mbFTtV6qIZRHfgvys6rti77y56MoEKPXh/MjzKLZZUGpbJQ
 z+LDssKwO7OmziBarexAJUIcm+F7fq9BNi8nQ9lHL+kMzwLxDnkt3F6JxVlG5Em7UMT7GRSMZTd
 XSCmzuoOGidAqNq8vcKXicVa/wSOKue/kO/OOlgJi9+zDYePts7lD4G11AUxfqk3aHW59eopoA+
 KbtmhqA/bBAH73Ct2p2KBoJ1+eUKNFj93IFAlE95owK3Tt9loNuisTldbrZxov+xsVsRXyYKaaI
 GaAF/CR5HUxbU8GRHmk9LzCzLk4N8j+3IeXrOTSctrKCkwYJk9AHQJcBBztFsdQRX1rBW50LqE9
 1tO7pktq+CTHui2V5sBvCSFu3Q+SbJfrnB62QSkDUpXsoUvvV8qpFsdwr7L6jReg04FEXrdU8vK
 mZy0DFQPMwpzTFEBecg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyOCBTYWx0ZWRfX5SHtSIpWLJwx
 q8Q3C5uKzjIqU1GLuKGzk1dKA7xfk13PQWoKdjRG49NSoBcy4R2QOnnuA02zIkypjrR+qAlMg/4
 Gd5C6Pbq6gA8pgzqQExgXzwYfyfkJOA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270028

This series fixes NewMissedCalls reporting in obexd PBAP.

The first patch fixes the apparam encoding: NewMissedCalls is a
one-byte value but was encoded as uint16. The second patch makes the
dummy backend report the actual missed-call count for the mch folder
instead of always zero, which is required by PTS PBAP/PSE/PBD/BV-05-C.

Changes in v2:
- Fix checkpatch LONG_LINE warning.
- Link to v1:
https://lore.kernel.org/all/20261026131504.1016687-1-jinwang.li@oss.qualcomm.com/

Jinwang Li (2):
  obexd/pbap: Fix NewMissedCalls parameter size
  obexd/pbap: Report NewMissedCalls for mch

 obexd/plugins/irmc.c              |  4 ++--
 obexd/plugins/pbap.c              |  8 ++++----
 obexd/plugins/phonebook-dummy.c   | 23 ++++++++++++++++++++++-
 obexd/plugins/phonebook-tracker.c |  2 +-
 obexd/plugins/phonebook.h         |  2 +-
 5 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.34.1

