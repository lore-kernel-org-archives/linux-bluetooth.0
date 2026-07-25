Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B8387581
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969696; cv=none; b=B3CtuP0hQ+/Vrn7StrmXncsw9hdJeQ+dXABIon6fL7xxJI+MSS4QVETrGMvbYSJMPVpIaFjVpOQMP+BLn9bDYXQe3RMVao1iTJfNiIKok7YReAoeGhSdROdjroDG0oSIPMhbeh8tBEwOwZfLStouTgXyYb+N8ocTZxanwjt1bE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969696; c=relaxed/simple;
	bh=fHTdD4eE1nNnV5jZEfv5bDRwVtEY/+eIY8ks+oeeCJg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ILNfYqtt45hrQ6KIYNFoLn1MrTPI7OHanttCBl9OVgBqlGicXbqevtjbq8Ra2LVyG34tFfaujjDnwa4PaklItQQspYzQmV0J4Qj+vwek9LylRB5lZeT3dKPZTTxrBSGRwAB0kxH7Df3MQa9EaiSmnsraZJc1t5TMZUM1m8arAo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OFSU/F/M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cih9eIgS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OFSU/F/M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cih9eIgS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4lkVh1260083
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7JY+EcQxZPVuUCu+yyKp1h
	d8FQ+WWih24LODXS2Xidc=; b=OFSU/F/Miqg9bgRWhAxsqtrwcO38jqG3XRNgCg
	gFZfKeB07otl38W90+JjNBHp7Z9X9jwRsouf8GNegs/oZ1Ozm1Pl44Gcs4gU+6tS
	91Hl9f71Zt0bHMIf20e6K0y+dZTXWoEEQL84ZguZcIgYLY4ceXflmGoRSllGb8WS
	8CvC+mJP2U2ojMR1a1o4kwStyvk6VWNx2HL1pWHYfq6A1n6yk18qO1+F3hCK3DyT
	VUjRSii+5uaJvDf3MA31N1KJVHMtEj3Am+nEN1h/Rkb1qgyTaxu2WW+OQyqImuZw
	jaXCNlj5FPfGOxpYxmlp1PhYaRJEfZCiNz3+eI5k7mTdtfXA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3s8pfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc98d6a88bso4190975ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969693; x=1785574493; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7JY+EcQxZPVuUCu+yyKp1hd8FQ+WWih24LODXS2Xidc=;
        b=Cih9eIgSVqAwkZ0pUyI9/yNshRDxBCvMnNJqK+lUOTbTzarqYof3u4iZ/+4phOYg71
         ZYnErGXChmYA9DWUxEJXb1rrnI4Lqra5xXiqAoE8zrXZ887HrpVuW+3PuzgW7zuSwG95
         x+E5eWEc1lMuXb+dkR67SXGuSbeBpLD1CyzUOBlHn6yDV3mZqPYcH33YB2GY3/b17OcF
         kKLK+YTNVPb6Wbj3IQKhr9CA9j84bW5ras+vV/ldIAz6EjtO6lrR/QMiD7cbxWFgOOPl
         B/iIrHsc88W1JUDfcF50Rl0Lej7e49vVVBJtWtC+M1HssGNdpJlSOqKqOx6ZSNkKkuUv
         u6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969693; x=1785574493;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7JY+EcQxZPVuUCu+yyKp1hd8FQ+WWih24LODXS2Xidc=;
        b=K3w/I0vZfSBzNBz8tc37mh7I68kN/Of13PU2DSOqg4LCLpiWhdlwR6tuFsyTFEDLd6
         aVYocrIYc9E+cILtz8brr0/WC3KgfksaNLyxfr+zv7dL8DY53G3WBXzLavlpd7HrIOKI
         JbOOvfZxBHghlRuBDtn4t2Zmuw5ujt0DIRSHmpNqqTBqMecFY0UEo8J8NrDwRL9lw1o7
         lExp7maHzWokf/bqKO7VgHan23PjRXK+sx5CI9MHFwIPSJOZ0aDi+9zYd3deBerWQflv
         zV1J2Z+SQRTG/d8Emj0tODs/cZwUIXAU3qXQ3P8D9yPjvBszqmHF+2Fy8+26uJWmqzeB
         AdHg==
X-Forwarded-Encrypted: i=1; AHgh+RpyQawfVVcr4ICbppKVXAyvnq8uQ9V6lNE+oiykH0D5yKFW0ZAtFDtiscESRtCm/wveTP0Fj6Gzss1pK2Us6K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSsG8ZEHVOVfljWNIW1X6uWCmITvc/aFxtTSJXb9Wzg0PYgvuQ
	IvLgWUU0brNEi2BWbsdlX1ZVzjZF0e+Hs7c4MZ0/VS2jb36AROvFcf0wCyicVBOdROBRWS00YjG
	r/5MmQeNtp2jIaINovL5Eqzw9IhANSGvXpzAKXWD1iEJvIqGSkjYBFpVsiRCdq0FVtBI85vw=
X-Gm-Gg: AR+sD13bIqqNZHg+q5HklL2KzhnqChVEHm8m4/wbOXS3EjrFZxOZQm331f34qpKqhIv
	A+5lP5sH4b4mmTKcrBR8KuENZqHm/T/pkHSBO3l35IAOtLTgLPUVPyephTzv21rD6JI/a/8Bb5u
	gM/Wv5HgDwzn2q112dNZs0eKRd6WSJyi/uJR/DndrDa27NSHLh3aqc/ZN2BTSHwgBZKqTbKmmyC
	hYl6EWmjL0OHOnD/7cICOM4Tay0kn5Z5Aq05YnTyUx/iGrR4I8hDSzyOBJOfjeoDCvLqf1TD4SJ
	oFK4684hjMHz8ZagZJl3J/QadnXEh3r7YAwyRSh/X+dBr0TSZUo66FQ22P8ttVP4sbmS2vIbRwW
	VxUFDepztrfZho16bWr+5njeJ6ZuMy4K2KFmP2l2dkpgeHeY=
X-Received: by 2002:a17:903:124d:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2cfde79047dmr12693215ad.1.1784969692793;
        Sat, 25 Jul 2026 01:54:52 -0700 (PDT)
X-Received: by 2002:a17:903:124d:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2cfde79047dmr12693105ad.1.1784969692378;
        Sat, 25 Jul 2026 01:54:52 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:54:51 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH 00/11] Bluetooth: Miscellaneous fixes and cleanups
Date: Sat, 25 Jul 2026 01:54:38 -0700
Message-Id: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM55ZGoC/yWM0QpAMBRAf0X32WobEb8iibmb62G0ISX/7uLxn
 DrngoiBMEKdXBDwoEiLZ1BpAmbqvUNBIzNoqQtZ6lw49FyYztIpCquyUsmh0tgDF2tA1t+taX+
 O+zCj2d4F3PcDAZjOTW8AAAA=
X-Change-ID: 20260724-generic_fix-6f13710b92ea
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Manish Mandlik <mmandlik@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfXwzBP4mWoZ8fc
 gS3fd5/P9Fsl2hqhiIwpL5WI47ssBXs/03FugS7X0crjyXXrgP+Bo1aiTpkVGE6a7nkqW+ypm+v
 rRygbhPmJNRmaDy0j8GBarKH2Zxs159KBO6YWQ3C1SJvLWyMnZ3fd0cZhKBWMcqcazVsRU2S3l1
 5sfYT2JOsL4pGo5B4Eqmr5z5Mplh4r//6yb0MIdvHQAWcoMf3jheFFM+xMLMQS1++JptH9Pyv7M
 Bicma65XtgavTFopD1ry19O5yGgYiZGfQTji4Dd1jL2M9NDShCskL7CtHHCtynmZnfopt6ixUuJ
 cF9KZzK6V2M8QJt1tJvUx5KUTvKyk4chtTxYTFOExX/abSGxAM54UAwQSz2h7uM2MW6jShpYTtW
 PGo0lMA2p92maNXi4YC7/JsJdw508uE9SdmAvqmozZPJ22esfWoFrQ50C7Dx6pbOW1IUdmJK+6i
 +TLdYq1tkpYuOsagg4A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX38Zz7ZWsUAxF
 hNfqgCGPghbrBQOqau6LJkOMEg2Q2tM19/7P9dK4i7iQmuWv54731v4djQAI1aMc6/JlwYAkpCT
 2mS2ZF8rVnWoPwm9fscU3KRyLN0rUG8=
X-Proofpoint-ORIG-GUID: micUL8iCv2Bc_L0uuQWbbS8R1aqARw4J
X-Proofpoint-GUID: micUL8iCv2Bc_L0uuQWbbS8R1aqARw4J
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a6479dd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=f3U0HR1bLDSqEOYX3XAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

This series collects simple, independent fixes and cleanups for the
Bluetooth core and USB/SDIO transport drivers.

Every patch is simple and self-contained: two bug fixes for btintel,
the rest are readability cleanups and two trivial ACL helpers
(hci_acl_handle()/hci_acl_dlen()) with their users.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Zijun Hu (11):
      Bluetooth: btintel: Fix diagnostics event detection
      Bluetooth: btintel: Validate length before parsing diagnostics TLV
      Bluetooth: coredump: Introduce and apply hci_devcd_state_name()
      Bluetooth: btusb: Make btusb_recv_{event,acl}() take struct hci_dev *
      Bluetooth: btusb: Add a simple static btusb_prepare_reset()
      Bluetooth: hci: Introduce hci_acl_handle() and hci_acl_dlen() helpers
      Bluetooth: hci_core: Simplify hci_recv_frame() by hci_acl_handle()
      Bluetooth: btusb: Simplify btusb_recv_bulk() by hci_acl_dlen()
      Bluetooth: btintel: Simplify btintel_classify_pkt_type() by hci_acl_handle()
      Bluetooth: btmrvl_sdio: Do not free HCI_VENDOR_PKT frame by hci_recv_frame()
      Bluetooth: hci_core: Don't treat HCI_DRV_PKT/HCI_DIAG_PKT as unknown type

 drivers/bluetooth/btintel.c      |  9 ++++----
 drivers/bluetooth/btmrvl_sdio.c  |  2 +-
 drivers/bluetooth/btusb.c        | 31 +++++++++++++++++----------
 include/net/bluetooth/coredump.h |  7 +++++++
 include/net/bluetooth/hci.h      | 10 +++++++++
 net/bluetooth/coredump.c         | 45 +++++++++++++++++++++++++++++++++-------
 net/bluetooth/hci_core.c         | 11 ++++++++--
 7 files changed, 90 insertions(+), 25 deletions(-)
---
base-commit: a3ad01d51d4be186484a9d8203e2e232f76326a9
change-id: 20260724-generic_fix-6f13710b92ea

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

