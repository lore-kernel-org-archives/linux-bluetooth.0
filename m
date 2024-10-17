Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AE1D517D
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167607; cv=none; b=XXGN5oL3kRKSmgUYM7+LbSW1lDg/aDU7xMrP7U/J3+vVUQ3xEAw52yqP1B+nO5s/zNgfHDnZQPcfBBEPyHYvN+Q/7ZlZVBoTlT8++lZVEemIML5fwZykIOoS3ZKeBZ1+OQ0MTUnNTw6vkTrmdjsUinRy8At9FFkNVrBsjAA9v1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167607; c=relaxed/simple;
	bh=ZditjE1IcN0brx+ct3scfO3VvQYdwgSmVXseE2ZDkF8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ulc2EzcaR2cJ4gV2ck60xxvMIRcNy/yPDs/BOoHOfQfuVeiZGApw85QCpx74HMlS5XxHud29eI13iEQpbCK9z8Usf2Ohr/RZzAU5SE7pEbRujE8vewQDQJiH1iWSYwxnizlb7Qpbi7PEwBO2Hva7cwHpuhX/X6nWEY4ucEAqebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T64sVir9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T64sVir9"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HALllZ017422
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 12:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lH8GWn12HlqomvDTMWhuRU
	izTIbSBEnJMtjihHf3q4M=; b=T64sVir9TaUQ7HHoj7KBiXhVOuHpTALHpQKd75
	n90XlTbtP765tScIyDqLDtOgrSYQ/yNZJNHliGoXzsm6S1AA+gdylvoLJs0NUmxn
	xd5v+kvpvgt6clriOvCrgKK6nkch+IelO5SJpYOSsJjOes56xw2Qy/q3F+fhow9j
	Jn0VspUQPNpeMnnp8ztqfBk5TN1ZslaVXc/8cWIhbrNHsouWuUcBchD9xR7qP5vi
	mmSDm2FlyMp3SB1WpXrS/IU1Hn3AMhf2kIXfz+9tKA4YCyKdiO+lQ8+KBjGR3aJB
	czp3FH4k+aXWVmJ3EPjS4TLPc1Mn19cfS7LMJYToyQ3TaWUw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42b0rx0ahm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 12:20:05 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HCK4Dn028914
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 12:20:04 GMT
Received: from nasanex01c.na.qualcomm.com (10.45.79.139) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Oct 2024 05:20:04 -0700
Received: from nasanex01c.na.qualcomm.com ([fe80::cfa9:539b:fb6d:d257]) by
 nasanex01c.na.qualcomm.com ([fe80::cfa9:539b:fb6d:d257%13]) with mapi id
 15.02.1544.009; Thu, 17 Oct 2024 05:20:03 -0700
From: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>,
        "Harish Bandi
 (QUIC)" <quic_hbandi@quicinc.com>
Subject: Unable to send PBAP(PCE) pull request with specific parameters from
 obexctl tool
Thread-Topic: Unable to send PBAP(PCE) pull request with specific parameters
 from obexctl tool
Thread-Index: AdsgjnPROWqIhNUESK6xbaOCbQLofg==
Date: Thu, 17 Oct 2024 12:20:03 +0000
Message-ID: <e18457d80cbd4c6aa6136c12ebf1e444@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NfcUOhvuiL-mwPxFklTTgqKoLl0QWZkj
X-Proofpoint-ORIG-GUID: NfcUOhvuiL-mwPxFklTTgqKoLl0QWZkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170084

Hi,

We are trying to verify the below PTS testcases in PBAP Client profile, whe=
re DUT initiates the connection.=20

1. PBAP/PCE/PBB/BV-03-C   -   PBAB server(PTS) is expecting the PullvCardLi=
sting request with MaxListCount =3D 0 (can be variable).

 Description : Verify that the PCE can obtain at any time Phone Book size i=
nformation from the PSE.
 ((TSPC_PBAP_2_2 AND TSPC_PBAP_2_4) AND TSPC_PBAP_1_1) OR TSPC_ALL

User prompt:
Send a PullvCardListing request with MaxListCount =3D 0  for phonebook pb

Results:
Failed to receive the Get operation with correct parameters for x-bt/vcard-=
listing

Expectation:
Pass verdict
The IUT issues a PullvCardListing command with the MaxListCount header set =
to 0.

Behavior : Bydefault MaxListCount value will be set to 65535 for every pull=
 operation and we don't have the option in obexctl to modify the value, Hen=
ce testcase is failing.


2. PBAP/PCE/PBB/BV-05-C    -    PBAB server(PTS) is expecting the PullvCard=
Entry request with specific filters defined in Bluetooth spec.

Description : Verify that the PCE can retrieve a Phone Book entry from a PS=
E using the PullvCardEntry function with a simple filter.
((TSPC_PBAP_2_2 AND TSPC_PBAP_2_4) AND TSPC_PBAP_1_1) OR TSPC_ALL

User prompt:
Send a PullvCardEntry request which filter for Name (N) and Telephone (TEL)

Results:
Failed to receive the Get operation with correct parameters for x-bt/vcard

Expectation:
Pass verdict
The IUT receives the requested Phone Book entry. The received entry contain=
s only the VERSION, N, TEL, and for vCard, 3.0 FN.

Behavior : Bydefault no filters will be set for pull vcard operation and we=
 don't have the option in obexctl to add filters in the pull request, Hence=
 testcase is failing.


Is there any tool/fix to pass above testcases?
Bluez version: 5.65

Thanks,
Amisha
