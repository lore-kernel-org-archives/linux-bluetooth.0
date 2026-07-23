Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F56A495515
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810204; cv=none; b=CkJO+TZRlUTBbjqPWi7kc2zL6HrTCmenSNWkAxrXiSug3NMemc0Vm1BrX9rUoR5uVH9KTeNVxK6++ghqeQ9aTV/tIcrkaeS3OG/7NjVEVBbKpUEReHBv+k7ijPWVKmGc1Rix9p9KOeY9V1PDrhx/ucCc1Esn/njxdHYt2ZECRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810204; c=relaxed/simple;
	bh=ZD+ycYNZR7+dxERdgOdimE2dn8185efkGSlgkCCELqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uL9QyMpV8pYY3pw6yVXwuPBZtMUES9UdWuvUmzRd/EfY0Ne78adgBYovKJrLoO1CdRb2aopFM1vPG5FKY2CvVtfASC4FpUgn4MVQ4RiSSxGFzAYfx2H/zD/PiVdLaFD8HtDssO+OAwRb4IrWwoghNodh1AgRX49XC0l+34VWCpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YuRmb+7r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V7bYBGl6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YuRmb+7r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V7bYBGl6"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8qb593606118
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cj2mWj1s6GFHWqMWFLzY4Iirhlp9UN4R3/IzGe53L/s=; b=YuRmb+7rNiLxyDP2
	NCGU8hJGFCy1J11203M43N7zrBJa5mPWSANCoB5oFqji208MjELzgvI9oqpvG7WI
	MRXc0QbYwGOniYHp73KcjKyZfmP7IB9d93/RH0TbV3l6XWZxhuRhzFAzBuoZcV7V
	iLhTCqsvGO5g+v1hDilf2oVL4lPQohf6qNSkUzX/+XWgchOco5ndOSCqoGSeGnhp
	1lRKCkYW5eRqtaZfDGH4CWj6k+pWyasmwzQyFjs4k1j2PyvJfujqAptJuga0lrtc
	Ca0Au7EjBT+eC9qSqwmBKuO36CxXr3dHqZNI4CzL1iG7qN9qMGi4Cii0jbKjaspI
	0kHtTQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke7qha2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 12:36:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cacf17c7e0so8229785ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784810201; x=1785415001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cj2mWj1s6GFHWqMWFLzY4Iirhlp9UN4R3/IzGe53L/s=;
        b=V7bYBGl6H70s6Wy1tuPD//V9nP513+Kgtxf0kl/9sHNxW8bgnfg0VW7lpJpfgpG8f2
         ud5uVotYHkH5FvhWdPMktr36Qu2vpFjyokDasu+lKVkLVzBymHXBkiido2jJ5g/cYLUt
         Otz4wVRlRvIytTqjsmK5oJ3ZF6cjuy47o7D60ur676+u951tqOu5TtKCpvE5TY2yb4ym
         cMDh5xA9KH/+i51im3ivZ6iPkeYy3Hb3pzIOOWQbWOIRo8eiDYEny/v5aJxR8TebP05f
         fVpbCLVjlYUkwpjewH2F4ea6fsI0a38MfAzcHes16OJdmMXGD73sa+0mUM8tpo84jQHh
         AQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784810201; x=1785415001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj2mWj1s6GFHWqMWFLzY4Iirhlp9UN4R3/IzGe53L/s=;
        b=BZxncBVWyFYCU7Pr1GUBUxI4LsNr7TWb7H59f0707ZSYiLsXAHGaUbYl0Znl5KL6NP
         VCyYTp2M8f/tIILX1OEH7YkJ0ZC0Dl7nTeQbwzddZfLxUdHv1OwWmhVocfdKUwNRRhOX
         i7twRmHXC/gqXAT2n1NdMxMij+XfoyMwqyVY1zUv8Ojm+nIf6ojqs2qOeJK9bwGZbKdE
         YjujK9StYlE6y0NafN/A1tqQorShySGA9kJr8T4fro2C6pNC7dyMD5VaBfB5jhxvH+hr
         xQ4ieStJI7glv9kEU2Af/iXIIfLecnknd0CW58S69CF5e526wWGo4CG9/IUSc4E+xSqv
         CB6g==
X-Forwarded-Encrypted: i=1; AHgh+Rpiymcsg9CDKrnAZPikp0Fu0xOvTYlizjRd1ksb+CL5kY1Zz+83gUXrlH/V+jlkqJRkhY8Gll+yncNFbVNLVY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHgQav/T1MjliqJFd9k4AzKcDit+RiUpiK5CcrHYjM+tMcTQR
	mTkNpo85tybvkgG6JfMlfHhw852UmOqJHREbDnm6kc/6trxgJzj0HK4jxj4qz1J8ISSJvI10A7M
	0M3a1+JM0BvJPmuAKG6Ii/loCD76TpLxWa2BpN3wSCOlMeRwBWNkIlQRfPdjb/FbcT3mXQIc=
X-Gm-Gg: AR+sD11hOrY0+bzf7Lu71stPge+n8jUdJZTDAan+TvDZ7D6hXPvtKDQ2Ll0I/Hz+3Im
	bEq1osbGyAzD55knQLoHhttcY1vp3t6Yet6ZG6HBxjtBNIDSAE2jxIfhVGb3sNtGI5/NHDLajUy
	pUaW2NUL3Gbl8H+9aZfos2YsJqZT9QCg/8tABv6FAgc4KlK3K5bswYZ3o2XsgR9miI0lY7vHW8f
	IEGZemlI/eBkaZVHgeQsp0ols3c45rW+w59aVzAkKe3fpM94xGHZCvR9ooaoZ6d96kPXs9NShDB
	SMGXDbuTlD35V/uYh2iCznFJUuB4TUdujy2XZLmkcWc0gVwisn97m4liMLESDFOD1bn9aOXGYs/
	KhJ6fZM5NdEpKvrIQZN4gdVsoHOqXdg==
X-Received: by 2002:a17:903:37c8:b0:2ca:bf8e:35fe with SMTP id d9443c01a7336-2cfa6b75512mr33224885ad.16.1784810200842;
        Thu, 23 Jul 2026 05:36:40 -0700 (PDT)
X-Received: by 2002:a17:903:37c8:b0:2ca:bf8e:35fe with SMTP id d9443c01a7336-2cfa6b75512mr33224415ad.16.1784810200339;
        Thu, 23 Jul 2026 05:36:40 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd76c4sm33851225ad.23.2026.07.23.05.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 05:36:40 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 18:01:07 +0530
Subject: [PATCH 1/3] Bluetooth: qca: add QCC2072 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-rb3-industrial-bt-uart-v1-1-3c8e580c09d1@oss.qualcomm.com>
References: <20260723-rb3-industrial-bt-uart-v1-0-3c8e580c09d1@oss.qualcomm.com>
In-Reply-To: <20260723-rb3-industrial-bt-uart-v1-0-3c8e580c09d1@oss.qualcomm.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_hbandi@quicinc.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_anubhavg@quicinc.com,
        quic_mohamull@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyNCBTYWx0ZWRfX7M1H/jUA74vq
 GJ7bO1jlNxvnOZgxFMYMxvd2NDQn6VEHj3T8atVBD6iEXo5ZhTFid0ebgDQPU47xUEUTHczsxMI
 9EfNvY7owyk/SsZ7twjsUFFSfkOobDA=
X-Authority-Analysis: v=2.4 cv=aYxRWxot c=1 sm=1 tr=0 ts=6a620ada cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=bBbZijagYEdtm7BDMOcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: YfP23xuHvn40ANDpGr68bVX_J70M639h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyNCBTYWx0ZWRfXw9v11zigiK8E
 pX/76St1W8GFVoVEmePuFu50JBiIXssI30+4/rx3gvxZb6jMJsT94R8D1XpJPmfZpDRBMSdXA+I
 6WmRODHLuK1BFJ87kyo8H4HWoX4m+YvQfI2qKe9SzwLzEszjn/2VV5ZB6RYeRGFY+hIVydjnJmL
 LWeh/NiAhQa8W+31pFCpEPspibCkzCXHZvpINQWqgAmQqhISN2NYM3riDL17oJXwQvBrqTDVss6
 MWIXhBywqyqJvAfIxBYxjIHEIZDfjCU1Qyal37J2+xXJBbyZe+U1oGf1QVedPExU22KejJDl8wK
 MxaK+wpPWrP+ZBjPtTafXe1/FfEpVEIuJEaaXeKdFJzrKFH7l/Aw19OR1y+0F/z/hjHB8okw2pV
 1xH6XcZEJLAbk5B34IFvOR0LaiWrWl6F4d4hDOzm0m+ntvVuyjv39Tgir87yvpDq0YdHrFQ3L/T
 JtnKJ5A1PolaRhjMq4Q==
X-Proofpoint-ORIG-GUID: YfP23xuHvn40ANDpGr68bVX_J70M639h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230124

Add QCC2072 as a supported Qualcomm Bluetooth controller.

QCC2072 uses the ORN firmware and NVM naming scheme. Select the NVM file
and BCS calibration file using the controller board ID when available,
with fallback to the default files.

Register the QCC2072 compatible with hci_qca and route it through the
same UART setup, speed switching and power-control paths as recent
Qualcomm Bluetooth controllers.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c   | 70 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btqca.h   |  2 ++
 drivers/bluetooth/hci_qca.c | 24 ++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 10c496eaea2c..69427cc7eb5a 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -569,6 +569,54 @@ static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
 	return hci_recv_frame(hdev, skb);
 }
 
+static void qca_combine_nvm_calib(struct hci_dev *hdev, u8 **data,
+				  int *size, char *calib_name,
+				  size_t max_size)
+{
+	const struct firmware *calib_fw;
+	struct tlv_type_hdr *outer_hdr;
+	size_t inner_len, combined_size;
+	u8 *combined_data;
+	int err;
+
+	err = request_firmware(&calib_fw, calib_name, &hdev->dev);
+	if (err) {
+		if (qca_get_alt_nvm_file(calib_name, max_size))
+			err = request_firmware(&calib_fw, calib_name, &hdev->dev);
+
+		if (err) {
+			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
+				   calib_name, err);
+			return;
+		}
+	}
+
+	bt_dev_info(hdev, "QCA Downloading %s", calib_name);
+
+	inner_len = *size + calib_fw->size;
+	combined_size = sizeof(*outer_hdr) + inner_len;
+	combined_data = vmalloc(combined_size);
+	if (!combined_data) {
+		bt_dev_warn(hdev,
+			    "QCA Failed to allocate memory for file: %s",
+			    calib_name);
+		release_firmware(calib_fw);
+		return;
+	}
+
+	outer_hdr = (struct tlv_type_hdr *)combined_data;
+	/* high 24 bits = payload length, low 8 bits = type */
+	outer_hdr->type_len = cpu_to_le32((inner_len << 8) | 4);
+	memcpy(combined_data + sizeof(*outer_hdr), *data, *size);
+	memcpy(combined_data + sizeof(*outer_hdr) + *size,
+	       calib_fw->data, calib_fw->size);
+	release_firmware(calib_fw);
+
+	vfree(*data);
+	*data = combined_data;
+	*size = combined_size;
+}
+
 static int qca_download_firmware(struct hci_dev *hdev,
 				 struct qca_fw_config *config,
 				 enum qca_btsoc_type soc_type,
@@ -614,6 +662,11 @@ static int qca_download_firmware(struct hci_dev *hdev,
 	memcpy(data, fw->data, size);
 	release_firmware(fw);
 
+	if (soc_type == QCA_QCC2072 && config->type == TLV_TYPE_NVM)
+		qca_combine_nvm_calib(hdev, &data, &size,
+				      config->calib_name,
+				      sizeof(config->calib_name));
+
 	ret = qca_tlv_check_data(hdev, config, data, size, soc_type);
 	if (ret)
 		goto out;
@@ -845,6 +898,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/hmtbtfw%02x.tlv", rom_ver);
 			break;
+		case QCA_QCC2072:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/ornbtfw%02x.tlv", rom_ver);
+			break;
 		default:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/rampatch_%08x.bin", soc_ver);
@@ -878,7 +935,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	/* Give the controller some time to get ready to receive the NVM */
 	msleep(10);
 
-	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
+	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850 ||
+	    soc_type == QCA_QCC2072)
 		qca_read_fw_board_id(hdev, &boardid);
 
 	/* Download NVM configuration */
@@ -939,6 +997,15 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
 				 "hmtnv", soc_type, ver, rom_ver, boardid);
 			break;
+		case QCA_QCC2072:
+			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
+						  "ornnv", soc_type, ver,
+						  rom_ver, boardid);
+			qca_get_nvm_name_by_board(config.calib_name,
+						  sizeof(config.calib_name),
+						  "ornbcscal", soc_type, ver,
+						  rom_ver, boardid);
+			break;
 		default:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/nvm_%08x.bin", soc_ver);
@@ -1001,6 +1068,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCC2072:
 		/* get fw build info */
 		err = qca_read_fw_build_info(hdev);
 		if (err < 0)
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 8f3c1b1c77b3..425133096eda 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -94,6 +94,7 @@ enum qca_tlv_type {
 struct qca_fw_config {
 	u8 type;
 	char fwname[64];
+	char calib_name[64];
 	uint8_t user_baud_rate;
 	enum qca_tlv_dnld_mode dnld_mode;
 	enum qca_tlv_dnld_mode dnld_type;
@@ -158,6 +159,7 @@ enum qca_btsoc_type {
 	QCA_WCN6750,
 	QCA_WCN6855,
 	QCA_WCN7850,
+	QCA_QCC2072,
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1222f97800f4..6fe3aab688e6 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1375,6 +1375,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	/* Give the controller time to process the request */
 	switch (qca_soc_type(hu)) {
+	case QCA_QCC2072:
 	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
@@ -1462,6 +1463,7 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
 static int qca_check_speeds(struct hci_uart *hu)
 {
 	switch (qca_soc_type(hu)) {
+	case QCA_QCC2072:
 	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
@@ -1513,6 +1515,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		case QCA_WCN6750:
 		case QCA_WCN6855:
 		case QCA_WCN7850:
+		case QCA_QCC2072:
 			hci_uart_set_flow_control(hu, true);
 			break;
 
@@ -1548,6 +1551,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		case QCA_WCN6750:
 		case QCA_WCN6855:
 		case QCA_WCN7850:
+		case QCA_QCC2072:
 			hci_uart_set_flow_control(hu, false);
 			break;
 
@@ -1864,6 +1868,7 @@ static int qca_power_on(struct hci_dev *hdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCC2072:
 		ret = qca_regulator_init(hu);
 		break;
 
@@ -1963,6 +1968,10 @@ static int qca_setup(struct hci_uart *hu)
 		soc_name = "wcn7850";
 		break;
 
+	case QCA_QCC2072:
+		soc_name = "qcc2072";
+		break;
+
 	default:
 		soc_name = "ROME/QCA6390";
 	}
@@ -1986,6 +1995,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCC2072:
 		if (qcadev && qcadev->bdaddr_property_broken)
 			hci_set_quirk(hdev, HCI_QUIRK_BDADDR_PROPERTY_BROKEN);
 
@@ -2019,6 +2029,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCC2072:
 		break;
 
 	default:
@@ -2172,6 +2183,12 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
 	.num_vregs = 4,
 };
 
+static const struct qca_device_data qca_soc_data_qcc2072 __maybe_unused = {
+	.soc_type = QCA_QCC2072,
+	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
+};
+
 static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
 	.soc_type = QCA_WCN6750,
 	.vregs = (struct qca_vreg []) {
@@ -2274,6 +2291,7 @@ static void qca_power_off(struct hci_uart *hu)
 
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_QCC2072:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 		msleep(100);
 		qca_regulator_disable(qcadev);
@@ -2429,6 +2447,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCC2072:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
@@ -2448,6 +2467,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCC2072:
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the
@@ -2490,6 +2510,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		if (!qcadev->bt_en &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
+		     data->soc_type == QCA_QCC2072 ||
 		     data->soc_type == QCA_WCN7850))
 			power_ctrl_enabled = false;
 
@@ -2498,6 +2519,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
+		     data->soc_type == QCA_QCC2072 ||
 		     data->soc_type == QCA_WCN7850)) {
 			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
 			return PTR_ERR(qcadev->sw_ctrl);
@@ -2576,6 +2598,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	struct qca_power *power = qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
+	case QCA_QCC2072:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -2785,6 +2808,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
 	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
 	{ .compatible = "qcom,wcn7850-bt", .data = &qca_soc_data_wcn7850},
+	{ .compatible = "qcom,qcc2072-bt", .data = &qca_soc_data_qcc2072},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);

-- 
2.34.1

