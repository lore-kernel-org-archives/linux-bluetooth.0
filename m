Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390279;
	b=W9CItLB6SpMVQV0dg9dkatdFpG4WrqlgSpg8btb175++onzMuxD4UV/1dglVeHZmOxMa
	 uiAlbqdtBKlQpH7zTyzTqDa0D9VmuPs8DAVLPRFwHR7SJpRktC+16fP7wti/d55uSZ4Hm
	 Un9WZAjwF1tEjsEnpSHjPIuhpUhL2p/GFtM/E9IeAMu2DdzrWs+nqCRYhpLXviIfRDsKK
	 tCX7iDtPXArKgLU9+qFMW+5SG7A/xsy5O8y+9oJrWb11OemZSEPhwCizjvVepJou2xb95
	 SavS61Pr5AquLMfqTefjKvKROkl303A6VpgIL5AjGhXV8mhOpYOPFRHmIgsvKG5VgkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rYSuKeiCStVsCVU/rD8Cshbnx4v9waEQXgv6XGbtFzE=;
	b=O5yGSXH3O2O0amDkdwWza5yRfho2aRzfEHCdZgfXLUhC+xJtISn1Fb8gkZHjO8BuT+QS
	 5FUmP5Jcqm72fmB7LBzee0gRDCsSMNoXXtoJQA1J7QMVvAp1jGbdebU6bPb4LPrss8Nkp
	 ohDMb4dpWtot3URKjtoWogE4Ur3/FCySTtQajb5rZeeewX58UyZEICJzuZCyMd6KbrBlh
	 ro0pAkOCh+dI+c+Oud7K40mpjl1Ohoz3L/jDdVUbhFSyzkUHdCYui5s+gAHLmjqOwErfp
	 14LJUIzBTMbYPCiKyyuDvDgQHGpIFNyZ+Sdn7wTM6HB9DJbfdwM49NE8cyq98MIU8jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=osdObhhQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD74606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 09:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD74606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=osdObhhQ
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB6Z8gB580831;
	Wed, 11 Nov 2026 09:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=rYSuKeiCStVsCVU/rD8Cshbnx4v9waEQXgv
	6XGbtFzE=; b=osdObhhQRN6JhXTnbV+AbrjxjeeEuRQndVQ2xiTw3QR75gjw2JH
	epdLMzmlL0B1cawwe8r+P7/3soCLPcL+O82VABlGHLJ/+eiXy/99gipmCO2kS4ur
	jKSccMRJ4vIpk5MgE8L36xvuBQxi7CT+F9TqBFHONsjSX6RrL3yuPvrVQ7GZ6an+
	ym4TbiOZ2YiKIYYiduH1nr6qs3bJO+JTYy413ZCnkAW2mpD1N+yeeMwrImNyl2fO
	N1TmBIF2e+9tUzj0ZTY8SuU/x24vu0crVGZSASGCQf7T3kKkBJTk+W55BS9ayKQr
	GYtY0oOG7eELAzDwknrwdJNtiUxcxTxVT/A==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7prq3y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:36 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB9iYpK2424154;
	Wed, 11 Nov 2026 09:44:34 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AB9iYRo2424140
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 09:44:34 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 2AD37243B8; Wed, 11 Nov 2026 17:44:33 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v2 00/20] obexd/pbap: Update PSE support from PBAP 1.1 to 1.2
Date: Wed, 11 Nov 2026 17:44:05 +0800
Message-Id: <20261111094425.1444893-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfXwfWPTVqwpjsE
 1D+x+5y4YdtJUztVOGjWPEW2ImDpV8ADp212BKok1JHnKjq+7PBB6zeZnDwOuGLbRY6JQiChLYQ
 LOL5qy5vhdfP2Y6gDYKyiK0/EZFb3vw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOCBTYWx0ZWRfX9QzPCXGdosNl
 DByM6+C7qT0bz/aLeGmu626NSJcc9aGxTHdGOsdwEeInOIfNnTDMlQeHS8Fvdantt5ulyb7+SB9
 PrcBku/z+XttH2Prk0qlkwwyUINEkDaMkc8RY/k9r9UKxoUrwMAGeDNxM/SzHhDgbhTNNvRrp2v
 CcbwlzIheenGOrDBYwRNprCKXoLz+7FIRZaTwLaU/g6WHJI8zY2oTnVp2A+f/7IwbYt4EqMV1Pi
 KjPbmAbE/TXLgE7JzzTyUQ4UmOpHADFdom/TpSL0d0bAQJHjTXbCv/x1UkU1FV0dZKko81BGeV1
 7KHd2OrGzq5JDFmteVkZvGHmFu79g05RlMmJ+yIqEh0RQAo4J7HVx9eUBpnfnyBpA0cSZy4K6kV
 7IvqIMQ8wzBQoKUfOw5YqS2qgT9XZ9ehTha+dgwpIyv2jS8rRthGQV5x2oLIL/S12z4KJ1+srQS
 zrI0mENnS17qLMY6dfw==
X-Proofpoint-GUID: emLbnqAYHP6kPPeJhwP37f542hvkXd8V
X-Proofpoint-ORIG-GUID: emLbnqAYHP6kPPeJhwP37f542hvkXd8V
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af43905 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mTiQUQRXCwSfp57dlPwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110038

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

 1. Fix the PRODID property name in the PBAP property tables and mask.
 2. Fix the PRODID property name in the PhonebookAccess documentation.
 3. Skip a missing dummy vCard callback when counting missed calls.
 4. Keep Tracker contact grouping state within each request.
 5. Include Tracker telephone numbers bound directly to contacts.
 6. Reject an empty PullvCardListing Name in the telecom folder.
 7. Omit PHOTO from dummy responses when PropertySelector excludes it.
 8. Rebuild the cache for each vCard listing request.
 9. Restrict NewMissedCalls to the first packet of mch responses.
10. Pass backend missed call counts to vCard listing responses.
11. Separate vCard entry response handling from phonebook responses.
12. Make CONNECT application parameters available to service plugins.
13. Parse and negotiate PbapSupportedFeatures during CONNECT.
14. Generate and persist the dummy Database Identifier.
15. Include Database Identifier in phonebook, listing and entry
    responses.
16. Maintain primary and secondary folder version counters in dummy.
17. Include negotiated folder version counters in phonebook and listing
    responses.
18. Apply vCardSelector filtering, counting and pagination in all
    backends.
19. Send only PHOTO properties in the Contact Image Default Format and
    advertise it in the PSE feature mask.
20. Update the SDP supported features and PBAP profile version.

Changes for V2
 - Rebased the patch.
 - Patches 1-2: Add the PRODID fixes.
 - Patch 7: Also remove the unindented BASE64 body of an unselected
   PHOTO property from the dummy backend responses.
 - Patch 16: Do not refresh the folder version counters for
   PullvCardEntry.
 - Patch 18: Use PRODID in the vCardSelector property table.
 - Patch 19: Send only PHOTO properties that are BASE64 encoded JPEG
   images of at most 300x300 pixels and 50 KiB.
 - V1 link
   https://lore.kernel.org/all/20261104083429.4111632-1-jinwang.li@oss.qualcomm.com/

Jinwang Li (20):
  obexd/pbap: Fix PRODID property name
  doc: Fix PRODID property name
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
  obexd/pbap: Support Contact Image Default Format
  profile: Update PBAP PSE version and features

 Makefile.obexd                         |   2 +
 doc/org.bluez.obex.PhonebookAccess.rst |   2 +-
 obexd/client/pbap.c                    |   2 +-
 obexd/plugins/pbap.c                   | 565 ++++++++++++++++++++++---
 obexd/plugins/phonebook-dummy.c        | 548 ++++++++++++++++++++++--
 obexd/plugins/phonebook-ebook.c        |  88 +++-
 obexd/plugins/phonebook-metadata.c     | 257 +++++++++++
 obexd/plugins/phonebook-metadata.h     |  52 +++
 obexd/plugins/phonebook-tracker.c      | 367 +++++++++-------
 obexd/plugins/phonebook.c              |   8 +
 obexd/plugins/phonebook.h              |  84 +++-
 obexd/plugins/vcard.c                  |  71 +++-
 obexd/plugins/vcard.h                  |   2 +
 obexd/src/obex.c                       |  42 +-
 src/profile.c                          |   4 +-
 15 files changed, 1808 insertions(+), 286 deletions(-)
 create mode 100644 obexd/plugins/phonebook-metadata.c
 create mode 100644 obexd/plugins/phonebook-metadata.h

-- 
2.34.1

