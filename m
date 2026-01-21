Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9059359F8F
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984693; cv=none; b=mIEcV+nIfWqOjvWvSPNJCPFyws3nc1pYnbszQ/mLA+HoRtmhr3qCEhpZmBitsktB2ymMYlIy/gHq859BibrXF+NNMYpm5haIXd2vHUX64YS/myvzlOM2pqR0bn385JACMboGcNfyG6Vbyt3vT5llhEK9iVSQqCcvFcKYo7SZCRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984693; c=relaxed/simple;
	bh=GexKHyTMeH0rTCmnDc5uwomhJWL0mn2C1WH6AvMBp+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nXg9N6oQDRONIRQv37i1GprdFuUzwnPy6FkCQQ/NVPZL0O8Fez6LOD54A0jkzKVXm+kA9+Fd6Ns1C9582FWXTmuDCahDn4gKqBp/2xC0xypMob1lLnyleveKcc99yahK+g73SPKWLz8SGxT+ED0shBm7+P8nDQZGj438MlTchnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RriS4Uyh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RriS4Uyh"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L8YZca2065826;
	Wed, 21 Jan 2026 08:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6+SGDw/cR3HQ/CMAT9C13G
	+lwBJrEgV60IX+06U+V5U=; b=RriS4UyhTogWztfyFxDBQOeERfsg5r/LV8SopN
	paCTRTuPPtbEL7xBXn38jH3y14c0N0477Q2JuTg4dA3Ksjb86NVYyaZCJMl3E4fK
	JwIgB07UWtD7p+mTe1av5n3hqUe/D3GKD5G1zikHqAXmVDVLnXMhnAzGQXhV4EMq
	LCUiImHRwWvBCGd4QBWJlNnZuyAE8pC9tRHdxKZD/Zy2MzEItgS7fZAcuE1kGW9K
	YSAHZwnQoRqXoqiKCiGt6jBztXyHa6gzMHSfxWl/Cn2krmVf51T8Fp6UhrHxDF8P
	nMtD7cmoWA8t3vqQFpKK9WXctmexFn8CwY+9eJWtZJ2WAf/Q==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btudp00cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:38:10 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60L8c7jH029066;
	Wed, 21 Jan 2026 08:38:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4br3gms2rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:38:07 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60L8c7Ld029061;
	Wed, 21 Jan 2026 08:38:07 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 60L8c6K1029060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:38:07 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4766378)
	id F267B23791; Wed, 21 Jan 2026 16:38:05 +0800 (CST)
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: [PATCH v3 0/2] gatt-client:Implement error handling for DB_OUT_OF_SYNC in GATT caching.
Date: Wed, 21 Jan 2026 16:38:02 +0800
Message-Id: <20260121083804.4010106-1-mengshi.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VStaM11G5G4BpubGk_V8jeecWOxEnvXh
X-Authority-Analysis: v=2.4 cv=DJyCIiNb c=1 sm=1 tr=0 ts=69709072 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Zg2JX6FJNO39zCPd_ggA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA3MCBTYWx0ZWRfX5rOOuMK/5TmL
 Op/j05+ATC0LxvZnKJCg45VhxIntQ+CdfVh70OthJjKX5b+snszZKLAVJo0oX0De4IzUhRqwBE6
 Ti5PqjgsjI8gCISLZWue+4GRrThymAlaHAXFNhPxFfhD6LoQRYemeP2eqCifEdSVQbps0hty/HA
 L1gCeM6Ku3zkEnriNU3d7eE0dv5FzHniCOY/xX/q0Jo/Otz0MHIWxgUypLUG6IhWkz7BebNlWWC
 BCaIXSgK/7K6oqKi9CXP6ZxLrGpkqIRDgmJGsrbQFkO64s3MYgydiObn0sQUW0vqtc6Tq9CbAMY
 Rr7BiFD6xdDWvXaawEnFY4DfdnS6dhFgko7Zu5HN7s1TAOBFhciZ8J/SroGG6O4F2NfgqWfioy4
 XwPvH7IEzuAAumynsjk7a3ZWaHZnVDx/DQ78Z0XYjHdQ1KsFYpixsvr6uvLptFSiLeRbdqFqx/C
 PcVN5dUQMxIi9AuPDCQ==
X-Proofpoint-GUID: VStaM11G5G4BpubGk_V8jeecWOxEnvXh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601210070

shared/att: Implement ATT error retry mechanism with callback support
gatt-client: Add DB_OUT_OF_SYNC error handling with retry mechanism

Here are the btmon logs showing the automatic recovery of a failed
ATT request caused by a database out‑of‑sync error, when recovery
is possible:

bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 7       #1 [hci1] 3.4439
      ATT: Read Request (0x0a) len 2
        Handle: 0x000b
> HCI Event: Number of Completed Packets (0x13) plen 5           #2 [hci1] 3.4588                              
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 6                        #3 [hci1] 3.4948
      ATT: Read Response (0x0b) len 1
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 7       #4 [hci1] 23.7473
      ATT: Read Request (0x0a) len 2
        Handle: 0x000b
> HCI Event: Number of Completed Packets (0x13) plen 5           #5 [hci1] 23.7722
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                        #6 [hci1] 23.8068
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x000b
        Error: Database Out of Sync (0x12)
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11      #7 [hci1] 23.8093
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5           #8 [hci1] 23.8297
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 24                       #9 [hci1] 23.8668
      ATT: Read By Type Response (0x09) len 19
        Attribute data length: 18
        Attribute data list: 1 entry
        Handle: 0x000d
        Value: a01f96d239c187f8ba218f084501dad9
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11      #10 [hci1] 23.8693
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000e-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5           #11 [hci1] 23.8914
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                        #12 [hci1] 23.9268
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000e
        Error: Attribute Not Found (0x0a)
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 7       #13 [hci1] 23.9293
      ATT: Read Request (0x0a) len 2
        Handle: 0x000b
> HCI Event: Number of Completed Packets (0x13) plen 5           #14 [hci1] 23.9497
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 6                        #15 [hci1] 23.9908
      ATT: Read Response (0x0b) len 1


Here are the btmon logs showing the automatic rediscovery triggered by
a database out‑of‑sync error:

bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 7       #22 [hci1] 114.579 784
      ATT: Read Request (0x0a) len 2
        Handle: 0x000b
> HCI Event: Number of Completed Packets (0x13) plen 5           #23 [hci1] 114.610 893
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                        #24 [hci1] 114.646 637
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x000b
        Error: Database Out of Sync (0x12)
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11      #25 [hci1] 114.647 233
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5           #26 [hci1] 114.670 946
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 24                       #27 [hci1] 114.706 865
      ATT: Read By Type Response (0x09) len 19
        Attribute data length: 18
        Attribute data list: 1 entry
        Handle: 0x000d
        Value: 9eada072929f475ffa51d09c55f5e178
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11      #28 [hci1] 114.709 230
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000e-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5           #29 [hci1] 114.730 974
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                        #30 [hci1] 114.766 849
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000e
        Error: Attribute Not Found (0x0a)
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11      #31 [hci1] 114.769 215
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5           #32 [hci1] 114.791 091
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 24                       #33 [hci1] 114.826 851
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x000f
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0010-0x0012
        UUID: Device Information (0x180a)
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11     #34 [hci1] 114.829 308
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0013-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5          #35 [hci1] 114.850 958
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 26                      #36 [hci1] 114.886 942
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x0027-0x002a
        UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef0)
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11     #37 [hci1] 114.887 480
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x002b-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5          #38 [hci1] 114.910 960
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                       #39 [hci1] 114.946 605
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x002b
        Error: Attribute Not Found (0x0a)
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11     #40 [hci1] 114.949 145
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Secondary Service (0x2801)
> HCI Event: Number of Completed Packets (0x13) plen 5          #41 [hci1] 114.970 937
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                       #42 [hci1] 115.006 864
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11    #43 [hci1] 115.007 315
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0013-0x002a
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5         #44 [hci1] 115.031 117
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      #45 [hci1] 115.066 838
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0013
        Error: Attribute Not Found (0x0a)
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11    #46 [hci1] 115.067 316
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0013-0x002a
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         #47 [hci1] 115.092 808
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 27                     #48 [hci1] 115.126 872
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 21
        Attribute data list: 1 entry
        Handle: 0x0028
        Value: 1a2900f1debc9a785634127856341278563412
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11    #49 [hci1] 115.127 341
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0029-0x002a
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5         #50 [hci1] 115.150 892
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      #51 [hci1] 115.186 863
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0029
        Error: Attribute Not Found (0x0a)
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11    #52 [hci1] 115.238 433
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5         #53 [hci1] 115.270 923
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 24                     #54 [hci1] 115.310 644
      ATT: Read By Type Response (0x09) len 19
        Attribute data length: 18
        Attribute data list: 1 entry
        Handle: 0x000d
        Value: 9eada072929f475ffa51d09c55f5e178
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 11    #55 [hci1] 115.311 066
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000e-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5         #56 [hci1] 115.332 821
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 9                      #57 [hci1] 115.366 878
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000e
        Error: Attribute Not Found (0x0a)
bluetoothd[650]: < ACL Data TX: Handle 1 flags 0x00 dlen 9    #58 [hci1] 115.367 532
      ATT: Write Request (0x12) len 4
        Handle: 0x0009
          Data: 0200
> HCI Event: Number of Completed Packets (0x13) plen 5        #59 [hci1] 115.392 826
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 5                     #60 [hci1] 115.426 845
      ATT: Write Response (0x13) len 0
> HCI Event: LE Meta Event (0x3e) plen 6                      #61 [hci1] 123.431 741
      LE PHY Update Complete (0x0c)
        Status: Success (0x00)
        Handle: 1
        TX PHY: LE 1M (0x01)
        RX PHY: LE 2M (0x02)


Changes from v2:
 - Detects DB_OUT_OF_SYNC errors during GATT operations
 - Extracts affected handles from the original request PDU
 - Checks if Service Changed indications overlap with those handles
 - Verifies database consistency using Database Hash characteristic
 - Automatically retries the original request if DB is consistent
 - Automatically retries the original request if handle is not affected
 - Link to v2
   https://lore.kernel.org/all/20260105103828.105346-1-mengshi.wu@oss.qualcomm.com/

Changes from v1:
 - Implement automatic recovery when ATT_ECODE_DB_OUT_OF_SYNC error is
   received from the remote device.
 - Link to v1
   https://lore.kernel.org/all/20251208101915.247459-1-mengshi.wu@oss.qualcomm.com/

Mengshi Wu (2):
  shared/att: Implement ATT error retry mechanism with callback support
  gatt-client: Add DB_OUT_OF_SYNC error handling with retry mechanism

 src/shared/att.c          | 182 ++++++++++++++++++++++++++++++++++++--
 src/shared/att.h          |  16 ++++
 src/shared/gatt-client.c  | 168 +++++++++++++++++++++++++++++++++++
 src/shared/gatt-helpers.c |  16 ++++
 src/shared/gatt-helpers.h |   3 +
 5 files changed, 378 insertions(+), 7 deletions(-)

-- 
2.34.1

