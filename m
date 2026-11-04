Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781285;
	b=0BNoP8R8J/fUUwuIow0219EXakAeX9IGdsNF+QcG+hxD+r6AMmTaGkKdNx9qiIkbM7AS
	 A+Yg3WOHRdvuSeWjfOzCLWxOtBSZlqlxuUKzf13kXeQAqSbl6B28sp0nJwdTbfl2HkwAI
	 FcdUhg3gya8A/hXd4VitK1ednPLnggTrr1Zx4P5uOzt4ihPi6Cw0uKlluyjIstgJ4sCJX
	 BR0iD+up8r3Hv5WKAqCuu4RG7yhp2RlFYsytZf5Ne8qO57FaeNDtIIE7FLFU4/Jt4Efne
	 tr6MRfA0i29kD5uLi5yDR/QwbBL4C7KOHEG+TWfCAO9dkEIG5N5OMmegfXjtqYFyr8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781285;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yPKUd8Zt8khtlGQwM3Ge7EdZa9P8zl9xv4FVabn3x1M=;
	b=gPwgAbgpfv4xv7zhKOM4lJL0CCIvNA6fpDuF5+0Yzbj4T18INsm8HLxChYTN5Mj9OEBN
	 3S9q/4viib0RcUNAtzGFd1B5E6CjzrZFUGSRofuy5/7HTAE0J29CkLvyqi3yMWaEatssI
	 HsNQ5CczDTT0c8XLNtwnTwteVhbhl1zRTpyEAtPBGNzjXsmVBY/qw89v9PuydLnJbdyTp
	 4w4WmXkz1zuexGT+XcXOfgviw6oLD7+XBgScbPZTbWwH2tasfDJecpFW4sgxm5no31Zvf
	 iK+8qknY8fKcjVu9ZWUJTF/NoTexnoWEBBkVCu6F9NDpmCt4GT7Jnb4qZ6X4xb7VeOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fSDsqPvQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B73606A33A
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25B73606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fSDsqPvQ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48OnWu309863
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 08:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yPKUd8Zt8khtlGQwM3Ge7EdZa9P8zl9xv4F
	Vabn3x1M=; b=fSDsqPvQvbNYxx6RMYHs2QLfPtjDfwyvCDkPA3YfJbVSYzpK2bB
	imXnIuKwhv+F53r+XbbO2BdD4F/5gAD+mlzax4tOwn9Lc7cP9PtFj+6EzwF2X1VP
	ID0qKPrmkdyA0ZR4yQ3ZwtKo/s27Hpi+adc6GLT5K6GF0xQ7XUcObqCCdIowHnus
	sLCRx6t61ZrJNYxcJFn4OmbnAS60211+gu+bY928QHcIFt2J7xasrL2L5da5icsT
	KskeBx72bdos9RJl1ec8E3FnrSP2faYqZzOAnUybEwuM7BEBP5Mm4esh1Qpi/VtA
	DHtdCq9g/Bdm4Ps2gOxILRjv0g7UMaNN+NA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr163g17h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:38 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A48YZbN2687994;
	Wed, 4 Nov 2026 08:34:35 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A48YZM72687984
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:34:35 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 4CF2E279B1; Wed,  4 Nov 2026 16:34:34 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH v1 00/18] obexd/pbap: Update PSE support from PBAP 1.1 to 1.2
Date: Wed,  4 Nov 2026 16:34:11 +0800
Message-Id: <20261104083429.4111632-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: pNkRCJZdOF476XpPMkGO23Guz2lDpnOt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfX3s2H9tP8sFda
 f4kREEHiXdQztvZ3yR4l/pysbbU6wfc3tZQV0UDUudEll+GvuCJ01pOo2+7M7+SwLdR8q+VG2hF
 BIpcmQ1rtNw9vFA5omwx+IE7xIaZNss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMyBTYWx0ZWRfXxvWW4fnx4DEN
 /6+CaHQi7sDvbiJRnQ3hgAYCHvntS0Thx1aEmOh7IrbF+NptOAWaIJnxAYdGQYTfwVD16cmfY6N
 RbmPILECPo3ePbTamH3hJNFAfKcD5G5rON7jGzx/UipDovTlZBDdU+o4X+3jOELXI0j7XeInlWz
 fccWzFqOBHhax6I/rWBWn66Z9lqGsCVcYjjsJZFRKIDp4Lv59Nbi0ky5Id7RtoWkHBfkvERhWjq
 TJeFkXjcSulIcrs1KZnUibGJ66cBaaOrawGlWfnfIGJFmXfi2gbz8Tm3QG20gIJSS10Ys0Js1xt
 tZLW3eiIPvt03NR3ypHFoE9EfiDhmIW9ERpavedUq8lpFvIdv8aGYE/QuX7RJcX9noiQ2r5adSH
 +wlhNfObFWyYvuXruBOC3XQ6wnmA3LmKCPGfLnGyF7vYopHasSkKFL1ZsbxDq2sQVOvo6eh5rRQ
 F+Bu5NpT112wlZcnN2g==
X-Proofpoint-GUID: pNkRCJZdOF476XpPMkGO23Guz2lDpnOt
X-Authority-Analysis: v=2.4 cv=O5OsLx9W c=1 sm=1 tr=0 ts=6aeaee1e cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=k9fiuOfwAg3HBWGyqiYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040033

This series updates the obexd PBAP Phone Book Server Equipment (PSE)
from PBAP 1.1 to PBAP 1.2, following the PBAP 1.2.3 specification.

It adds PbapSupportedFeatures negotiation, Database Identifier and
primary and secondary Folder Version Counter response parameters, and
vCardSelector filtering for phonebook and vCard listing requests. It
also advertises Contact Image Default Format and updates the SDP profile
version to 0x0102.

The dummy backend persists the Database Identifier and folder counters.
The ebook and Tracker backends report zero values to indicate that these
values are not persistent. vCardSelector is implemented in all three
backends.

The series also fixes phonebook backend and request handling issues,
refreshes the listing cache for each request, and adds NewMissedCalls to
vCard listing responses. NewMissedCalls is limited to mch responses.

Testing was performed on the OE-Core wrynose branch (Yocto Project 6.0),
together with prerequisite patches that have already been merged
upstream. The dummy, ebook, and Tracker backends were all functionally
tested. The dummy backend was also tested against the PBAP PSE PTS test
cases covered by this series.

Patch overview:

 1. Skip a missing dummy vCard callback when counting missed calls.
 2. Keep Tracker contact grouping state within each request.
 3. Include Tracker telephone numbers bound directly to contacts.
 4. Reject an empty PullvCardListing Name in the telecom folder.
 5. Omit PHOTO from dummy responses when PropertySelector excludes it.
 6. Rebuild the cache for each vCard listing request.
 7. Restrict NewMissedCalls to the first packet of mch responses.
 8. Pass backend missed call counts to vCard listing responses.
 9. Separate vCard entry response handling from phonebook responses.
10. Make CONNECT application parameters available to service plugins.
11. Parse and negotiate PbapSupportedFeatures during CONNECT.
12. Generate and persist the dummy Database Identifier.
13. Include Database Identifier in phonebook, listing and entry
    responses.
14. Maintain primary and secondary folder version counters in dummy.
15. Include negotiated folder version counters in phonebook and listing
    responses.
16. Apply vCardSelector filtering, counting and pagination in all
    backends.
17. Advertise Contact Image Default Format in the PSE feature mask.
18. Update the SDP supported features and PBAP profile version.

Jinwang Li (18):
  obexd/pbap: Fix crash counting vCards in dummy backend
  obexd/pbap: Fix Tracker contact grouping across requests
  obexd/pbap: Include directly bound Tracker telephone numbers
  obexd/pbap: Reject PullvCardListing without Name in telecom folder
  obexd/pbap: Fix unselected PHOTO in dummy responses
  obexd/pbap: Refresh cache for each vCard listing
  obexd/pbap: Limit NewMissedCalls to mch responses
  obexd/pbap: Add NewMissedCalls to vCard listing responses
  obexd/pbap: Separate vCard entry response handling
  obexd: Parse application parameters in CONNECT request
  obexd/pbap: Parse PbapSupportedFeatures in connect request
  obexd/pbap: Add persistent database identifier
  obexd/pbap: Include database identifier in responses
  obexd/pbap: Add folder version counters
  obexd/pbap: Include folder version counters in responses
  obexd/pbap: Add vCardSelector support
  obexd/pbap: Advertise Contact Image Default Format
  obexd/pbap: Update SDP and PBAP version

 Makefile.obexd                     |   2 +
 obexd/plugins/pbap.c               | 289 ++++++++++++----
 obexd/plugins/phonebook-dummy.c    | 529 +++++++++++++++++++++++++++--
 obexd/plugins/phonebook-ebook.c    |  86 +++--
 obexd/plugins/phonebook-metadata.c | 257 ++++++++++++++
 obexd/plugins/phonebook-metadata.h |  52 +++
 obexd/plugins/phonebook-tracker.c  | 367 ++++++++++++--------
 obexd/plugins/phonebook.c          |   8 +
 obexd/plugins/phonebook.h          |  84 ++++-
 obexd/plugins/vcard.c              |  69 ++++
 obexd/plugins/vcard.h              |   2 +
 obexd/src/obex.c                   |  42 ++-
 src/profile.c                      |   4 +-
 13 files changed, 1509 insertions(+), 282 deletions(-)
 create mode 100644 obexd/plugins/phonebook-metadata.c
 create mode 100644 obexd/plugins/phonebook-metadata.h


base-commit: 7a713dc0c1b7550bb16b67a7b0f8298e04a807b8
-- 
2.34.1

