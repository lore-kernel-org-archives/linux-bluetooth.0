Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E82E3FCB18
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077885; cv=none; b=WmMsU6Jl/a4c9+bu5GizlDbSsK5m4vPuWfdYvliiw2YmJTdWlyKJMYMyC0Qd8uE/BVhTD3SvMpJIRiYhppSybjG49J7Y39PYESxBcnSwx1sbulROQjRo75pId5x52lOdIo8rjwYpgAVfnNyXkAeKIAMhBVSXOMqz8U2eUGyZ2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077885; c=relaxed/simple;
	bh=lX4Sa9Hub5ccbJEILPWfMBKlEwWav5LLLZScdiEwD+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uH7Ca1BFp4/DsZgSbowig4lDWaVIv56TMMRWLaiDAhmQ1oRkuuLAUf+gkc8E8g0XlxFoSdzRc7WEVczWSw71JhlqBDPS9uTQkXgiHrFhaFa7prgM9tUXmMn8yvdh9kVlfAZ0X5YiJTGX0Esb0KlJVaQgdNS4tMyz62UCqC3qLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gqfd3q5D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kYY0nSAn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gqfd3q5D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kYY0nSAn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2Fu5518305
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 18:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=dLYtPzjoXd6bGPMhoRcblXDrrkpbN7zbOxO
	Vq2Eu8+k=; b=gqfd3q5DHhQSc+QVmXnSG8Mw7vgGxvFpGgjj+VhcgpACiWpsZDV
	XfbLJ5Y6FUIt1eNNlKp3muZ+Krlw4VexZk/kEJAzVNPnw6ty+Jpxb+o0isCQ03UV
	oWUz70A0zD2Bk/mT7sG2joxZfq0OGS6S/lqNTTPTj1L6U26pO6LhTNd8qOlPKHvl
	/HmpFCRkXINOGb+BHzQj8aeV3+5sBa4IK2q1Yl41QvCdIbG+BV1Fu5AE4OOMsXzL
	5BZrGa24lgrCVMs41jevWYBaqE28rqX/Okk+Ywj34d6KEMmv99Jut6npmKMsqtDi
	0cKzeTHrTwbzpjcJdyONtTMa+rMBhtfPSUQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efechgn1a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 18:04:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba5f794825so113576845ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 11:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780077882; x=1780682682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLYtPzjoXd6bGPMhoRcblXDrrkpbN7zbOxOVq2Eu8+k=;
        b=kYY0nSAnVI5+g1jRdmjWj8P2lVv5/ryKtfsZbRBePMysVrsdf6EvJ2FVQAOF7K1RC9
         qzXUDq33m4zudMvxT4BC5gmcjr/ZBDG33mlLyvBc03zTfEK2jHDXWM5R2lfHWFOongCu
         o1ycSC3g1TdEbJBgnEF8zHYx2WAN0nWfbahsmbqgQt97ivgAN247MOhWLOc8bRtRVkrY
         /ZTgUmaFcqiBK9LaHokFKTkj3cgwzkpj5XQa4P/+V3T5NrqL7GYMYA9CyDbF9RpG0roq
         BO/oA6vR1lgle6jpzye0Vz40QcqTcUvivH8mx88yMZtQyjpHTfDMDIK/sa400U6LYQGw
         +kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780077882; x=1780682682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLYtPzjoXd6bGPMhoRcblXDrrkpbN7zbOxOVq2Eu8+k=;
        b=eOsyKRG/c8QCBwSjai9GAUEuci7yquOs2dnuslvg1Au4BodS7rXR13WW+YcXL6CB9O
         cv/3c0vvYLaPbP4QG2m5N2Z4vjQ0AQpYo67iS3d4m4zYOLHNL6LqUPBJE5oPswJIX8P7
         7x98kqBfUlMQGXFuOA+6PjG4aBUG0cWom90pxrC5wjDvrF473dr4dORP+7n9tkUvh2X5
         7DxgkTrIMQSoAfzLUQ4aDYw4GiyxEqgTnCVBeafOFxTVhb8Paw/w4Yr37u1NbNEzPCb8
         o2N3c5xM60Ik0wnJIN8cY6Gi2f7APWS9jBU400Svp9bt9yEw8TyTC5MCOPURaXKgMEkM
         D9sg==
X-Forwarded-Encrypted: i=1; AFNElJ/LsZDHpqUVD2M4zlQY5KsrqtBC4G87jGi+anZfX8N6Rb8oCAD963B0kS/zE5n4ypOzQbm+WAew/L4ht0LDL1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXq4c604Ya0QPxHUHWPzW71XZliSZt/09Jll1mZApU0Y9d4GPq
	5muFQcAq0mCR1hFpFjo8XOZ2nYH/ZOnSoNvmvlodL7SjRE5kSdrkpSH+VVZBNjpQrNTIfJGq+DL
	G+tDIJOcrRqxMaQGek05poXXQ8OJ3Dscnblvkkk1WVN7CxcvJpRUI8AxVGQs+TRMhhpP3ztM=
X-Gm-Gg: Acq92OGolq6dptIxbBbS7+YxgFqDZAR1T7uAe2FW6R2PHvzl/xwBsOQQk1NrcicXNf9
	8Kxo9Wgveaqj0ltGQCa21C/ErsF3m9dpeEYxSxL5t+aM3maJkh6+er5QV095A7XrxA7YyEGSd1L
	fajwoIUYZRsQUxV7zJLLknzhEo5tRuo1lgZqf7k783TCd0x+ZkanTjQilqmQleuChF/5ZvJud1L
	A6xIIBqEVKR+LiHzkznwljuoPnulJWMmLnTObCY1bucraTZriNLE+bHoathI2gFQ198jLK+b8OV
	ZDs/2Byc6wPm0a+1zFoN05gbK35LIgLREbRnTTIkQu18ragoyRGPoP2LZ+HWDdt/7OcKFsS+pa/
	snoSj6fDYXiyPViXLLcEKGEsekHG/0hqB/VmoOwv/6DnXo5tMnJdmTGLE74zHsA==
X-Received: by 2002:a17:902:f60d:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2bf3637f9bfmr11100015ad.0.1780077881834;
        Fri, 29 May 2026 11:04:41 -0700 (PDT)
X-Received: by 2002:a17:902:f60d:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2bf3637f9bfmr11099585ad.0.1780077881331;
        Fri, 29 May 2026 11:04:41 -0700 (PDT)
Received: from hu-ysiddu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd8dbsm29049425ad.21.2026.05.29.11.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:04:40 -0700 (PDT)
From: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        rahul.samana@oss.qualcomm.com, harshitha.reddy@oss.qualcomm.com,
        dishank.garg@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Subject: [PATCH 4/4] Bluetooth: qca: combine NVM and calibration data for QCC2072
Date: Fri, 29 May 2026 23:34:31 +0530
Message-Id: <20260529180431.3373856-1-yepuri.siddu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fJhOeUFN1-Ke1YToi7jszO9UkA-AQydk
X-Proofpoint-GUID: fJhOeUFN1-Ke1YToi7jszO9UkA-AQydk
X-Authority-Analysis: v=2.4 cv=U6Siy+ru c=1 sm=1 tr=0 ts=6a19d53b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=v3OVykGQXCv_UCWT3hsA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4MCBTYWx0ZWRfXwJ3f19621MlD
 S+KfTKADKijXlUQj4DoA/iqZGGb0ESBeNqRT2nApMbj6zEmisj3MCLWhrkI34Pfk48M7D/PFco8
 PZe+LhyecdmRkoDRJxoSQ/nBVaw1DCsmkcEBzH887gW2heRg28NEiR5V7s8OmDriVhYkIKmKEuD
 d1wnWcq+DWUVwWiUYsIgKPobf65ppC67NB0uLOF/iyOy3wjF1pbeTJIol23gQH4/ZECcpT95vTz
 VzrUe1rpa2gqibWktW750UHjBsPgcw7/q/JZEGOglNMQr/SveoJqjVnXVHcpfISipm8MqipKyBz
 ONKhJwdPKA/M0ds1S52hzahpuCy04Uk3ba0Y1BfWJ789/DdRvgpU6hcetzGXhHFG7CzcZON2UI3
 zsBJoA1qgwtfHdr8zGeNYpQvmj7B4rggpbdLAYIRYJ4vudddbdZaRLJKhkvBbt/zosrnuOPKjoQ
 xj5bT5m1mHO9cxTGwrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290180

QCC2072 requires the NVM and calibration data to be delivered to the
controller bundled together in an outer TLV of type 4. After loading
the NVM file, load the calibration file (qca/ornbcscal<ver>.bin) and
combine both into a single buffer with the outer TLV header before
passing it to qca_tlv_check_data().

The outer TLV header encodes the combined payload length in the high
24 bits and type 4 in the low 8 bits of the type_len field.

If the calibration file is unavailable, fall back to downloading the
NVM alone.

Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 0ef7546e7c7a..37db1cd9e8cf 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -612,6 +612,53 @@ static int qca_download_firmware(struct hci_dev *hdev,
 	memcpy(data, fw->data, size);
 	release_firmware(fw);
 
+	/* For QCC2072, combine the NVM (type 2) with the calibration file
+	 * into a single TLV of outer type 4.
+	 */
+	if (soc_type == QCA_QCC2072 && config->type == TLV_TYPE_NVM) {
+		const struct firmware *calib_fw = NULL;
+		char calib_name[32];
+		u8 *combined_data = NULL;
+		size_t inner_len, combined_size;
+		struct tlv_type_hdr *outer_hdr;
+		int err;
+
+		snprintf(calib_name, sizeof(calib_name),
+			 "qca/ornbcscal%02x.bin", rom_ver);
+		err = request_firmware(&calib_fw, calib_name, &hdev->dev);
+		if (err) {
+			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
+				   calib_name, err);
+			goto skip_combination;
+		}
+
+		bt_dev_info(hdev, "QCA Downloading %s", calib_name);
+
+		inner_len = size + calib_fw->size;
+		combined_size = sizeof(*outer_hdr) + inner_len;
+		combined_data = vmalloc(combined_size);
+		if (!combined_data) {
+			bt_dev_warn(hdev,
+				   "QCA Failed to allocate memory for file: %s",
+				   calib_name);
+			release_firmware(calib_fw);
+			goto skip_combination;
+		}
+
+		outer_hdr = (struct tlv_type_hdr *)combined_data;
+		/* high 24 bits = payload length, low 8 bits = type */
+		outer_hdr->type_len = cpu_to_le32((inner_len << 8) | 4);
+		memcpy(combined_data + sizeof(*outer_hdr), data, size);
+		memcpy(combined_data + sizeof(*outer_hdr) + size,
+		       calib_fw->data, calib_fw->size);
+		release_firmware(calib_fw);
+		vfree(data);
+		data = combined_data;
+		size = combined_size;
+skip_combination:
+		;
+	}
+
 	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
 	if (ret)
 		goto out;
-- 
2.34.1

