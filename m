Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793688934;
	b=wuvyZkyYvwk+3m2ObL7kdyjXfB2t8zwZqjKtYUx/djOY3MVRKWBHC2iKVke9jEc6S2ki
	 sVgtNJpagmFbOnPj7JpZZkdqYK1lmGYfRYg99PjXDGOYqkv0rXLVabAJRRoVcVyIXrSbP
	 zgJZciMJOGAxyaAVX6mZEY+DlrLey0GXu9Q209Suvt1grwjKFdmoLCIIuy4DhK/AyULk2
	 IrucgzinPUvXEYNor3uxKOpxQRS8lDui1SHHeSeBT+9zI3UCWQPEjt8PxTQl33ybzTQqW
	 ArJqmTHJWEKOpKQOTluuwVOyx4c1R6Ovf6Kh1scvz2ldKdTHysVdTkDtav5BOVskaEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793688934;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jg8NEK3ZW1ubDPMf7drkDVCuPq6ogQM+ofkG9ZyFXQE=;
	b=PhhXp7QSASgWteKo1QFFCJ6X5jYFNsu+dkpVsOR1vilmV0z6UW0QinGwMReQGM8EYIl4
	 Ew+VGPgXmHMg0Gl9zDL8x+ruQX9RxNzwik3RU3spFIOGj9dUmX0302JSzcL5hqGF1EyDr
	 ph7nKVWQBC9OHDf50D9JSlyzhTvnC5/Er3twqTxJnAQUvuS93oryDDRuj2YzdandCxnZz
	 sU91COeg++oAjUrcSkMNZQWaZ/AOlXuvEjbisfmzX0MtIeXXYAz2MksTdPnAlVSxGzW7z
	 GAMQZLXt0zHUCv8hdnpNKtR3DZDLwR7Fjxlz0fy8FkmWas/s33G8AMA7OTMYwzkolDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l5TRNqzI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KbM6sVC3;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59B606A330
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 06:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF59B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l5TRNqzI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KbM6sVC3
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31eMg31431334
	for <linux-bluetooth@vger.kernel.org>; Tue, 3 Nov 2026 06:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jg8NEK3ZW1ubDPMf7drkDVCuPq6ogQM+ofkG9ZyFXQE=; b=l5TRNqzIbTQl2soi
	UhAorkwSPLzlVsJhsGz2MK8lVVssIdBqBZsrZl0fOK/o4G11lnxym6XCFCt/VjEf
	7lzT0OfR+MGUgeAeGqd87+S2jcFgBCbJ7VKTbo4cnXgdCDFBlXm5AceV2xhriZk0
	raA6Zkdcyj0PDZY8vHDnhnSbMJt2Xdn+W1BLQLwNRdNzDseDvfS6PMNrvMSgqgMe
	wC8FII89ucdKCtN8Jt0cgak1km6XnVEN9zlKmOLl6odqCjo1gvNtC/25c30n1nKf
	onSWWhkCfKHqRJW7/emVvKF7NTamxZhqZ8XOFmoGFs2Bxj5xtztPqIPE72R1FTDc
	CwAmbw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq0872ctw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 06:55:32 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4c382ac3b8fso916473b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 22:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793688932; x=1794293732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jg8NEK3ZW1ubDPMf7drkDVCuPq6ogQM+ofkG9ZyFXQE=;
        b=KbM6sVC3z5eP0F96eopdkd9XhMozs69QCUAGA2FeyEYE/BHTf+z/ikIWktoFlT2q3b
         sQIrgC/thDseI/TYiU4YpAvxbgaoRZB7QSEcJC8D47cCrM3l+LCrjzokpMw2RBl9nMnH
         URqswjU8ZDq2RfuVDWo08jl26YjFJXPWLZKsuJ4fk08j3tCYMi1iG9KDb4+MtJ0yIoVi
         Uj9MYgCGAcqAAa/ws9m+ghMy5Ac1h6JQNoQZilfgZe+QVO5ksY1ZYZYlme0JO2bH3ZYt
         H/oWBwJtPkXkUFAfw7yULqQ9uu0AoJoamW2tlN4JMuU8SsQeQDCjHBR88vbAQ/vbpF7I
         i5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793688932; x=1794293732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jg8NEK3ZW1ubDPMf7drkDVCuPq6ogQM+ofkG9ZyFXQE=;
        b=hMpOD9rV584FUrQ0o+xjgBI3K1Pzk7obVAwXozWoCe3GjYdt5BRe2k6fIXszriXyqm
         P0kVW/C1B6/1kKpizPNe1SE8EmsuyYYNrnNrafh2/6byZfgIRFgWe82GMBuoTEaoRW8q
         NXnu7neu/nCdinSWQg979cZsXPy9vGSmaeD8OUfBPCQlNIP/oQXVxuJ2LH877wRbeG0D
         vE6M5bQMBi/LQmn8VmrnatM99S1bHjpKyVt6vqVpK6MdOHiQaJBZ54jS92EWG1goCQBN
         z2t4qyg3LQgVDDUYgAOmm6/790HV5CgXSsVZfthSAO5OZN5AyLxbFsrgX6W5b0zgHXnb
         Bavw==
X-Forwarded-Encrypted: i=1; AKwUvBy1I1HagXoZ62aq/YjLLgmq/FYPjWVoRMPb9GFzhF4SiEezcwlKV0EIN1dg0UBkbGrUw+ujsA++BLk3+Xb/kC0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7ePXJbSfaEFxkqm9RDhV40sFb07vSt71GtdZ9iyEtyGW7bill
	cOkezlAdKRpDLYrmzVdLm5Ixo7vg+9pqrAwzf7JKKECzMuBX0AhaxkqrtjxcxMxU8rCR1NYh4/W
	elFye40XNxoR0pNvQ9UI5fDGN1c+pdoFzkmJP/W3sM+C9p+CXPkhzLICnNSAdk7lRbOSt9gY=
X-Gm-Gg: AYBFou39G/N9NZJkdA5+14xnfIvO0Eddr98oA3CeZn0mROUj7zfhO4ZadheDH8UmWtf
	C5MN1KF7e7AJPTQvSPergYkJZYlRTKubCriXerESG4svXOFTSFY54nKWVcWq3D+c2RWLxipRO9d
	ViAkwyc0Y+/Fl2sBDVj4os8XsJd3EFbVjlPqQ2X9obYeYjIA5yq0HrqEVJEpOrOBTYMLdpzcaiZ
	OC4MlIvvn6Yv/TbiGn8f3O3xLafregFE61SP1hvmgrCLq+nU5dSCqx+GWS1sLRpLAnKJY07h/Jy
	14R8zW04mPf2dToEpw5KNSdxN6s0tePEviXDiQvwpg+wKa1lSUnE/P4ZyE03FuS+UfWyvPOHelq
	HwdWbSoHVrWHoANW0ltiKZgkZl1zJIb13MfZ/N6MhJ20UgTo1J3zhvc00+MnmOm/Plyz0SCZv53
	T9HK6miWm3rMjJJQoH80Y=
X-Received: by 2002:a05:6808:bd1:b0:55c:866:20de with SMTP id 5614622812f47-5640d9d5e9fmr12645144b6e.2.1793688932117;
        Mon, 02 Nov 2026 22:55:32 -0800 (PST)
X-Received: by 2002:a05:6808:bd1:b0:55c:866:20de with SMTP id 5614622812f47-5640d9d5e9fmr12645126b6e.2.1793688931721;
        Mon, 02 Nov 2026 22:55:31 -0800 (PST)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe423fasm10305974b6e.16.2026.11.02.22.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:55:30 -0800 (PST)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 22:55:20 -0800
Subject: [PATCH v2 1/2] Bluetooth: hci_conn: Fix SCO/eSCO
 Transport_Unit_Size for HCI data path
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-fix_kconf-v2-1-b4bd28de37b5@oss.qualcomm.com>
References: <20261102-fix_kconf-v2-0-b4bd28de37b5@oss.qualcomm.com>
In-Reply-To: <20261102-fix_kconf-v2-0-b4bd28de37b5@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>,
        Kiran K <kiran.k@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyNyBTYWx0ZWRfX6+9kgDiL4Dnn
 J9cvDo6+OIicttBoPIngHlsRLRcpELNk+XcIPC4+gpAgqx2XFIwYp45uaxsCT3lyvzaHHmVirlJ
 6vJZoG754F8pzfNGXxftf206iBHN7cw=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae98564 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=HEh3y00BNYiN-q-pdcgA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyNyBTYWx0ZWRfXwGrC2L0Ec+Ji
 51hgsuUvuKyiWaf4S9aM370cr5WAZZUvFDxtIVFzPV/bBbWgJlfZ80XlL7j0U/r+EULAt6ynQ2a
 KlCMMDabnlz4soqtuaNm/+QW1lp8nedXgF7vYtukGmNBA4XfhynYSZqHTsHYOW8vzAxkipZ9Tru
 PDdRPVkFRMRKDxU+jPQZJhUQKSLcs9Y79gegPURSxhoLzYICiQbJgAew6lf5HxFC+ZwoqyPPBQF
 pr8p7pHpjB/OwHa4DQlRRKk73/Wvgw39q4bkDiecJWrhqpO0SOae2YOwWamJuaH62byW+daOwG9
 a1FlBZfJxN7nJg/NA/0jmVKuOIJE3hp80UkqFWKScqVzWNnACPmF+v3DRGUMXhLzzQttDgG9zRm
 0JTa9aEz1Wxz6fhbCsmR4y7+hhdmR/+ihV1qRZQmwT+2jggzpu0mCR1y97B8U8XUZziePregToq
 L5o+bW7E0FMv1P55SuA==
X-Proofpoint-ORIG-GUID: fRpqg4C1RM-OQv1MhlSic35WIAG2llIk
X-Proofpoint-GUID: fRpqg4C1RM-OQv1MhlSic35WIAG2llIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030027

Correct (Input|Output)_Transport_Unit_Size based on Core spec v6.3,
Vol 4, Part E, 7.1.45:

  "The Host shall set the Input_Transport_Unit_Size and
   Output_Transport_Unit_Size to be equal. For HCI Host transport
   the Host shall set them to 0."

Fixes: b2af264ad3af ("Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_conn.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b007f623b2ec..eebd73988bf6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -322,18 +322,20 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 		cp.in_coded_data_size = __cpu_to_le16(16);
 		cp.out_coded_data_size = __cpu_to_le16(16);
 		cp.in_pcm_data_format = 2;
 		cp.out_pcm_data_format = 2;
 		cp.in_pcm_sample_payload_msb_pos = 0;
 		cp.out_pcm_sample_payload_msb_pos = 0;
 		cp.in_data_path = conn->codec.data_path;
 		cp.out_data_path = conn->codec.data_path;
-		cp.in_transport_unit_size = 1;
-		cp.out_transport_unit_size = 1;
+		if (conn->codec.data_path) {
+			cp.in_transport_unit_size = 1;
+			cp.out_transport_unit_size = 1;
+		}
 		break;
 
 	case BT_CODEC_TRANSPARENT:
 		if (!find_next_esco_param(conn, esco_param_msbc,
 					  ARRAY_SIZE(esco_param_msbc)))
 			goto unlock;
 
 		param = &esco_param_msbc[conn->attempt - 1];
@@ -348,18 +350,20 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 		cp.in_coded_data_size = __cpu_to_le16(16);
 		cp.out_coded_data_size = __cpu_to_le16(16);
 		cp.in_pcm_data_format = 2;
 		cp.out_pcm_data_format = 2;
 		cp.in_pcm_sample_payload_msb_pos = 0;
 		cp.out_pcm_sample_payload_msb_pos = 0;
 		cp.in_data_path = conn->codec.data_path;
 		cp.out_data_path = conn->codec.data_path;
-		cp.in_transport_unit_size = 1;
-		cp.out_transport_unit_size = 1;
+		if (conn->codec.data_path) {
+			cp.in_transport_unit_size = 1;
+			cp.out_transport_unit_size = 1;
+		}
 		break;
 
 	case BT_CODEC_CVSD:
 		if (conn->parent && lmp_esco_capable(conn->parent)) {
 			if (!find_next_esco_param(conn, esco_param_cvsd,
 						  ARRAY_SIZE(esco_param_cvsd)))
 				goto unlock;
 			param = &esco_param_cvsd[conn->attempt - 1];
@@ -379,18 +383,20 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 		cp.in_coded_data_size = __cpu_to_le16(16);
 		cp.out_coded_data_size = __cpu_to_le16(16);
 		cp.in_pcm_data_format = 2;
 		cp.out_pcm_data_format = 2;
 		cp.in_pcm_sample_payload_msb_pos = 0;
 		cp.out_pcm_sample_payload_msb_pos = 0;
 		cp.in_data_path = conn->codec.data_path;
 		cp.out_data_path = conn->codec.data_path;
-		cp.in_transport_unit_size = 16;
-		cp.out_transport_unit_size = 16;
+		if (conn->codec.data_path) {
+			cp.in_transport_unit_size = 16;
+			cp.out_transport_unit_size = 16;
+		}
 		break;
 	default:
 		goto unlock;
 	}
 
 	hci_dev_unlock(hdev);
 
 	cp.retrans_effort = param->retrans_effort;

-- 
2.34.1

