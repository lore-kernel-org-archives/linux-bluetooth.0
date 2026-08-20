Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36025B0BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248173; cv=none; b=meIiBJ6cTopWju4SD5fA1Qw5C3+NWl7PT35IkyKOxtIA2dQvh4V6G7dEePJRW47snzNHAPgNX/IdvOMuLltfIM+2RnEiWbrEraC3+UpQjGRmIMzVJyn0Lq0i1Sf0+Dk9P4iaxtRey9A0W2Dbq8t8uJBoaElc0SfvQyPoknxM8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248173; c=relaxed/simple;
	bh=eB3hKwQvUqAUgbnhhcTjFw92S2Uk7F0757PybvBg6eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pspqc74TBzNYRRChZCWaMZkGpBdBBw+pBp0bNnl6j/BieyqBRvSkmG+d9HcTLVwd01lKbcdbJCbjhzOW95WcWFAIyVxEPMtluJR4cHBmUHFgbM7i3WmnhJaIt4C+sQVmw3jDVBtD/K1HArvFGLPbvroyiDqACyKahHubvDFQNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxih0tiA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q2j1xckx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxih0tiA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q2j1xckx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KG6ohw3828331
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JpzM0F9YrsD
	rJpIAR1gCQIFPV2+MQjF32wp7dKIoKRs=; b=nxih0tiAn7sxY4NlWuLjEDdrYq6
	cREkhqdce/lRgjE7xJhvk8AKqpHWlHmRIMclsy/lQM8fOmEovwftXNm+mBIRz5sK
	tYSzlrQ86+7JlpzNUMSdp7jppySfTfSvSeFPKlnXnKPqguQyFrJVoZUW/mfpgNOR
	3kvJlWgOtHIyKW2Fu9WxIeDp7+bYHRB4o25PRGcrQilyZU8fw7Kgxl81Q3ROm57J
	Hem4Ku+i+0AGLBs5ICpFKjypjQiOyZd/K/MmS+Hz+lk8YwMEXHKi2KTYoPVgOL9S
	QCTBV/dsQqxfwlV/Y3ojFoXhMSnEWGHPoTB4ktnBxNezow5XPFd4Ercmx9A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk285f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:49:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfc52ddc55so1973015ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787248170; x=1787852970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JpzM0F9YrsDrJpIAR1gCQIFPV2+MQjF32wp7dKIoKRs=;
        b=Q2j1xckxmznqa0qZAqHKhbVEG2gqiR/QZ3WZlIF835wLYZm4zFmy1/eo0Bdm2FLA+6
         ZfW6D6IS2Yq76Y5a/hi7WtZflAeiPL8couwDRJVatCxxod41c9SNtUFHq0/c+RAK/NG7
         OrFmRLSvaRuz8rnR4N86vrAVHAIDsbo7H1/O+tn817/Eai1t4vcMAIjhkHVoZNP7Gop4
         HWQhIhMLm6zB9SvxAVA8JlC4cBFpjPuilgeoWk6BfDFppRDb+QriTEMAp3/7O8UpfLTE
         mdPtfAKTfG6L97nI1vmoiakUoS+iYDlQfGFixJ/vpVfLgOzfLdnq4b+1c2DgdGuhx3Tz
         4CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248170; x=1787852970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JpzM0F9YrsDrJpIAR1gCQIFPV2+MQjF32wp7dKIoKRs=;
        b=FvfKtSkzQ6czbRV1EprTrdGBKlG3C+R6bJQy+OR2jsd60eiOYaqJuBMACKGjuh4hlj
         5CLmHf3AK6o+r60Wyfba7t5HLP8plE8IX0Vig1lWbzGGKomS5onkid0OnYSfkXnuYmBh
         9AubXEh7Bo8PYkODu55cCPSPo6FFUEVUT4rmYjhz7SBXDwqEFEGEkojiCYyn8EtnnT+1
         KYR9JuvZUJTyVDYxlQPXtKwKzr11A7t1hmFguXFuV1tpmxckZ747FRFhKJ9Q4o5PuoKv
         0MZjhv7i4r7UXkUBml77DoRALkePy25V03R4L2kKdCDOSD6gdLGA++QhFDmF0OHcHxhx
         y9Sw==
X-Gm-Message-State: AFuF++lB3ZjdpDVSLht+3fhe7lkvvCHH4huUfIGuGOBa1MsonNxDCdeD
	3UoaXeF5LY11DtEqHS51Rh0OX76qTDGDaNcNpy8yRyx6MeeML+LsJor9irUxs6wv8cgaoVmBVwr
	yTmBGT2rFkFARTO/sZ6RW0bLurW/JL8VQVrOX7ca+KlG+LPJeNZv84mYP5zWaQCdK9m4fpyh7HJ
	K1wSY=
X-Gm-Gg: AR+sD12ptGrzXZRPlWySepZdgLf7+McaC3a+qnbEDGhPea7ae/7vh/9BZ970Tj7i27a
	AqKNGSyMSlBPNfgfKbUqse4M9fTO5QfzQmRuhRVzlM+R90AtERk1coO2m6PA4X6R55PW4YNYIyQ
	IzcX6nGF6Ve4aYF8S+BL6GlBPRBtKxFc12iTCgSFwgMM51uHq1VfGxsHsN1TwJtrtGzhVeL7x19
	JqBFTwobZEE6mni2m+mEmcHEH94dgt6n12wIiaFUrNLBWYJr8w/ZqMNzhhd3LkFo5Kpy4TTSYw1
	w729UqVLopnAi2GLRJTXsSDkxHaKiojqtGOSIBY9xzzStESOUX10sInrG330uGMZ20kI5BytmQh
	6DX3jYR6xAg8POZfOnHjLOgUR0g8b+A==
X-Received: by 2002:a17:902:f70f:b0:2c9:8f4a:90b with SMTP id d9443c01a7336-2d64ada4464mr8068195ad.3.1787248170149;
        Thu, 20 Aug 2026 10:49:30 -0700 (PDT)
X-Received: by 2002:a17:902:f70f:b0:2c9:8f4a:90b with SMTP id d9443c01a7336-2d64ada4464mr8067375ad.3.1787248169670;
        Thu, 20 Aug 2026 10:49:29 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf15ff5dsm18641072eec.25.2026.08.20.10.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:49:29 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 2/2] client: Enforce Valid Main Mode and Sub Mode Combinations
Date: Thu, 20 Aug 2026 23:19:10 +0530
Message-Id: <20260820174910.559116-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820174910.559116-1-naga.akella@oss.qualcomm.com>
References: <20260820174910.559116-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vJJYOXVwJH_mXD3NDbAygyXDRI7Y9fPN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEzNCBTYWx0ZWRfXx2uQqkljFbcj
 xNloVbHyvfngW0PcC+piQvWU3V4PHFF0OzSxjljlOjQN0bGEHZRYxCEwzd8A+V3Pxzxe/oB/ZMO
 mpkQFttgwoPN+DiixySObV0XOBwelqA=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a873e2b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=7OXvLrOdm_FIif2h3TAA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEzNCBTYWx0ZWRfXzLcSDKmfYE1R
 DLG0jqSWsWa9Lf6kJSJnvhYGE6Vnm+2L5Pj0vLF7PyNb0JYkdqqQwfq6lndcwbc7bNtlxcsZbGw
 yDIOONotd5+4TrBIskfvU8YLSAKFYaiLmLCJ7Q8cjUlda+DSAnLjsAMQwBlv9VO8nETWI+yz2WT
 nPqx3fqdShCFAZ/1eZ8GbGwNO2MK98ZKI8pt7ghKcHrGt2XBZYBMbA3ynEst2ErANz+Ko34CM4G
 17vAz/I4eCggHbgjY4r2qRutnFyGBepMubvJJ8Ch0vptoem89OHxXuRi0+386A7FA7HXfLxz60/
 x9UBXexx+N5j15GiDRpnUnsP1gaD/UBeMfFGDhAvrrSsHI/lUM9ytHo3ea8uVrNjX2Ru1wpn77h
 9zK3GnVxLkgBuS15EBb82DuLAn1Mye+Qk5y65axi5Ej1jVRuL0wM9CbWAhM3XqatXRvrCgbulN9
 dOVoAhk7hDq0cl4aUSg==
X-Proofpoint-ORIG-GUID: vJJYOXVwJH_mXD3NDbAygyXDRI7Y9fPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200134

Introduce validation for main_mode_type and sub_mode_type combinations as
specified in the protocol requirements.
Reject invalid combinations and guide the user by displaying
the acceptable mode pairings.
---
 client/cs.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/client/cs.c b/client/cs.c
index 9f069589d..64eeb212b 100644
--- a/client/cs.c
+++ b/client/cs.c
@@ -644,22 +644,96 @@ static void cs_print_role_hint(uint8_t role)
 				" procedure.\n");
 }
 
+/* Core CS mode combinations: sub_mode_type == 0xFF means "None". */
+static const struct {
+	uint8_t main_mode_type;
+	uint8_t sub_mode_type;
+} cs_valid_mode_combos[] = {
+	{ 0x01, 0xFF },
+	{ 0x02, 0xFF },
+	{ 0x03, 0xFF },
+	{ 0x02, 0x01 },
+	{ 0x02, 0x03 },
+	{ 0x03, 0x02 },
+};
+
+static bool cs_mode_combo_is_valid(uint8_t main_mode_type,
+					uint8_t sub_mode_type)
+{
+	unsigned int i;
+
+	for (i = 0; i < G_N_ELEMENTS(cs_valid_mode_combos); i++) {
+		if (cs_valid_mode_combos[i].main_mode_type == main_mode_type &&
+				cs_valid_mode_combos[i].sub_mode_type ==
+							sub_mode_type)
+			return true;
+	}
+
+	return false;
+}
+
+static void cs_print_valid_mode_combos(void)
+{
+	bt_shell_printf("Valid combinations:\n"
+			"  main_mode_type - sub_mode_type\n"
+			"  Main(0x01) - Sub(0xff)\n"
+			"  Main(0x02) - Sub(0xff)\n"
+			"  Main(0x03) - Sub(0xff)\n"
+			"  Main(0x02) - Sub(0x01)\n"
+			"  Main(0x02) - Sub(0x03)\n"
+			"  Main(0x03) - Sub(0x02)\n");
+}
+
+/* Rejects the just-applied main_mode_type/sub_mode_type change by
+ * restoring the previous values if the resulting combination is not
+ * one of cs_valid_mode_combos.
+ */
+static void cs_enforce_mode_combo(uint8_t old_main_mode_type,
+					uint8_t old_sub_mode_type)
+{
+	if (cs_mode_combo_is_valid(cs_cfg.main_mode_type, cs_cfg.sub_mode_type))
+		return;
+
+	bt_shell_printf("Error: main_mode_type=0x%02x sub_mode_type=0x%02x is "
+			"not a valid combination. Rejecting change.\n",
+			cs_cfg.main_mode_type, cs_cfg.sub_mode_type);
+	cs_print_valid_mode_combos();
+
+	cs_cfg.main_mode_type = old_main_mode_type;
+	cs_cfg.sub_mode_type = old_sub_mode_type;
+
+	bt_shell_printf("Keeping main_mode_type=0x%02x sub_mode_type=0x%02x\n",
+			cs_cfg.main_mode_type, cs_cfg.sub_mode_type);
+}
+
 /* Generic handler for the per-parameter set commands (cs.role,
  * cs.main_mode_type, ...); argv[0] is the parameter name (the command
  * itself), argv[1] is the value.
  */
 static void cmd_cs_set(int argc, char *argv[])
 {
+	uint8_t old_main_mode_type = cs_cfg.main_mode_type;
+	uint8_t old_sub_mode_type = cs_cfg.sub_mode_type;
+	bool is_mode_param;
+
 	if (argc < 2) {
 		bt_shell_printf("Usage: %s <value>\n", argv[0]);
 		return;
 	}
 
+	is_mode_param = !strcmp(argv[0], "main_mode_type") ||
+				!strcmp(argv[0], "sub_mode_type");
+
 	if (!cs_set_param(argv[0], argv[1]))
 		return;
 
-	if (!strcmp(argv[0], "role"))
+	if (!strcmp(argv[0], "role")) {
 		cs_print_role_hint(cs_role);
+		return;
+	}
+
+	if (is_mode_param)
+		cs_enforce_mode_combo(old_main_mode_type, old_sub_mode_type);
 }
 
 /* Tab completion for params whose only legal values are a small fixed
-- 

