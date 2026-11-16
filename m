Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820018;
	b=PwwS89kjUyNk8+o8TT+Nof8DK1YZucHChZdlavLSVzADaTKvDsCQF5jfMY9a4s0/p65E
	 8BlhiOp2cLOI4znTZ1FwosEPXSQ+Gum0pjkmsUxiwkHQ2DPhp713UjNnbCJ/7QkpLLNIp
	 jIfne2Cjly1LovGkkqkKypjnQ4nvuvxDn25m8sAnCduQh/xPuToj/4VKyso9wR0aPGGso
	 zoxyhppFhLpFbXX2P+DXShZQJxFm6lEXMLoxggx752dTZLaIPVYAhrOAeBw21qphMiX6w
	 T26WOEHRqnH8Yu8pXDtEeI2iczj04rs5FSHcII2+vN1WuSu986u7H/pKp1jQ+ofmrdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820018;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kmoLCgntjBf7gEJUZMLXuEvaMeZQ8pxc44WcrtxcFU4=;
	b=4ZYMdfDiMVMHXo4Mf75jpfV3+dPsMSAt08NtTNBhy1HVsmESymfIfR98MlEX5DvvhulM
	 tua3Gj5A2BMrvM+J4pAe9ONtPfUbdQpI7HFIfM7wTNEaSpXhLiTGKApFKF4FDmuItODy+
	 2i608YzLxgCBQ/YTWuea2JgViRJJ2jS0xOSlhw/hQIIpogG9McJMShzL3nu7ug1UkTTnE
	 KVXbN5QWp7ENufyLzU8Uid1IotIybxXmUpEhm0Ong086ZECy8mYAf5TwQ4ufMbnQKMnLd
	 OdAn8yNJS28Smxs9P5t3Jjh7QT8ysfJ2vDXUgQZjmF2rcsipBdIycm9H74Fc9eKE15Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TnHivC2U;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358C606A330
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 09:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D358C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TnHivC2U
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7ewWZ3488779;
	Mon, 16 Nov 2026 09:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kmoLCgntjBf7gEJUZMLXuEvaMeZQ8pxc44W
	crtxcFU4=; b=TnHivC2Uj7rhKYLyugLkkVFldnzPBYg64OkwAPIzgnexs1WKkQT
	e+1Ri97ULiHjiWAPnKRGDWcCeo4LdPcIl8Kzy+JOMNwpg5JtM5lm1z1sq0nK+3W8
	kZ5SYnwl2vl5TzMOSJ6pC2d1lqpyNIacCS/Bd/Vd53m5HittefSVbMddPxAuHtR2
	b+uWQ5tiyi9HmzFefvcnI72/7RbD/K33WsUS7sf3MHEzP3yIdKyt7wJUkUarPO9O
	1Ote+yt72tKT8G/qGwuHeHFWUfTI0eR46UGnaWkJtBQvhvrK1UQ0u7nX2z/m0/CJ
	QaBanknLUcxnaDaFTNZqQVjDRxVHBreheJA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmcdmuq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:56 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG96sBC2942825;
	Mon, 16 Nov 2026 09:06:54 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AG96sMY2942794
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 09:06:54 +0000 (GMT)
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4467392)
	id 7FB92279EC; Mon, 16 Nov 2026 17:06:53 +0800 (CST)
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: cheng.jiang@oss.qualcomm.com, wei.deng@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: [PATCH BlueZ v3 00/20] obexd/pbap: Update PSE support from PBAP 1.1 to 1.2
Date: Mon, 16 Nov 2026 17:06:14 +0800
Message-Id: <20261116090634.1222593-1-jinwang.li@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfX1jAU4G4MyQzH
 ut7HslOEbAG2IR3CCHFaU9hsZk79CGZalZ+KF89btXQ01A/UNR4Oi41mjXgbrhqdkCyUXpcgAX/
 M3waTJfOcozt4QPklAHl3PdrFcSU0P8=
X-Proofpoint-ORIG-GUID: av9vzQHB7poi4Br1yX8b1Dkw5h3f07G1
X-Proofpoint-GUID: av9vzQHB7poi4Br1yX8b1Dkw5h3f07G1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNiBTYWx0ZWRfXwa6q1fgikDUV
 0o+BAX8IhBKsgBX6qNG5nqsSoKjM7zeWKHh1wp3nUVSmTIp24FgfW837vZ+PlOUd92i0Ao4JZ/T
 dgVjRqOFIqvxkBPc57KfMo++TnMwmwtOdydO6LmxUEK53lMMO+ifpO5FO0hrgabd21T+uEBRcxO
 JvX6rrorNfMN4J9e1bQQpP6DarWdvNzu7MC7DT34UrB3TXRQT07XDP67+EVyF+ZLcBGsnDJ4Lq5
 ycfaAHqDaNfKAk7KbhLuT4GeoQw/+HMNf7xfwtVz93jIA5YdM4BZiL5vP7LUFHUf7NpOp2OTzsr
 pSeCauouM3ED8XfGHKxcmwVJZtoLceBNPa1b/aFk5gvftzNsvHXu6U4KxL2uN/p2+enXmRZkZa9
 jNMKo9MogNoFBXAppMr92lKLsBKdw4KTWzF61g02xDyP2VuUooc4tJAf4EyDxXONcKx4quBqhMh
 NzUEDLfbkdK92D6NSxw==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6afac7b0 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=k9fiuOfwAg3HBWGyqiYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160036

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
together with prerequisite patches already merged upstream. The dummy,
ebook, and Tracker backends were all functionally tested. The dummy
backend was also tested against the PBAP PSE PTS test cases covered by
this series.

Changes in v3:
 - Rebased the series.
 - Patch 6: Shorten the subject without changing functionality.
 - Patch 7: Preserve quoted-printable PHOTO continuations and correctly
   parse quoted parameter values while filtering unselected photos.
 - Patch 16: Associate persisted metadata with each virtual phonebook
   folder and reject incomplete folder scans when computing digests.
 - Patch 17: Move folder-specific metadata handling into patch 16. Keep
   this response patch limited to emitting negotiated counters.
 - Patch 18: Apply vCardSelector when calculating a PullPhoneBook size
   response with MaxListCount set to zero.
 - Patch 19: Handle folded headers, quoted parameter values, and
   quoted-printable continuations when validating default-format photos.
   Clarify that returned photos must use the PBAP default image format.
 - V2 link:
   https://lore.kernel.org/all/20261111094425.1444893-1-jinwang.li@oss.qualcomm.com/

Changes in v2:
 - Rebased the patch.
 - Patches 1-2: Add the PRODID fixes.
 - Patch 7: Also remove the unindented BASE64 body of an unselected
   PHOTO property from dummy backend responses.
 - Patch 16: Do not refresh the folder version counters for
   PullvCardEntry.
 - Patch 18: Use PRODID in the vCardSelector property table.
 - Patch 19: Send only PHOTO properties that are BASE64 encoded JPEG
   images of at most 300x300 pixels and 50 KiB.
 - V1 link:
   https://lore.kernel.org/all/20261104083429.4111632-1-jinwang.li@oss.qualcomm.com/

Jinwang Li (20):
  obexd/pbap: Fix PRODID property name
  doc: Fix PRODID property name
  obexd/pbap: Fix crash counting vCards in dummy backend
  obexd/pbap: Fix Tracker contact grouping across requests
  obexd/pbap: Include directly bound Tracker telephone numbers
  obexd/pbap: Reject listing without Name in telecom folder
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
 obexd/plugins/pbap.c                   | 778 +++++++++++++++++++++++--
 obexd/plugins/phonebook-dummy.c        | 745 +++++++++++++++++++++--
 obexd/plugins/phonebook-ebook.c        |  88 ++-
 obexd/plugins/phonebook-metadata.c     | 257 ++++++++
 obexd/plugins/phonebook-metadata.h     |  52 ++
 obexd/plugins/phonebook-tracker.c      | 367 +++++++-----
 obexd/plugins/phonebook.c              |   8 +
 obexd/plugins/phonebook.h              |  84 ++-
 obexd/plugins/vcard.c                  |  71 ++-
 obexd/plugins/vcard.h                  |   2 +
 obexd/src/obex.c                       |  42 +-
 src/profile.c                          |   4 +-
 15 files changed, 2209 insertions(+), 295 deletions(-)
 create mode 100644 obexd/plugins/phonebook-metadata.c
 create mode 100644 obexd/plugins/phonebook-metadata.h

-- 
2.34.1

