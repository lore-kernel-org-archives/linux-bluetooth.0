Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19333B811F
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292092; cv=none; b=j7dCXcDuMW7gHwQQVPblM9CCH3SCLE2kO78aJ3WKGvwhGnXri3Xd2AKeGjPs1ww9j2DjYfhlURL/eWsWLsTZsUOlHcCLz4fAdA9NkO3TvFG9GABBhY1+IkvbRzD7B5Dqzvi1D2oENEjk6rJ/lmOTZjvoQJiolceVj48CJGVArC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292092; c=relaxed/simple;
	bh=kMnidcTrqaztahT2JmUfS7eE30BSvHXj6MUKmQU0J0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sFGifZoxJ4njclE3FLUIU7Ca9esP16gC21F8geVlFEPNlXzRgyzMkVro7+ALQrXpypyrlLHisZZQ6E4o8V0w6H2bt7mnM6PH5LghVLXcRMCvXxcn8wj0gowcFTtPgP2Qa+PZF1rEgIzZMth/lZ8CXnU6E+EU96vp9m8ZmlYcNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TJYHDs4Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aS70UVqe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TJYHDs4Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aS70UVqe"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCTEKV2903250
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wAPXwbPcio7
	qPU8CQrPaujcrguQe/r3V+YL3HEQzqO8=; b=TJYHDs4YI5glKJURkfv/uI45ToV
	zOwSJeu5R3X+WCb65hmY7GqszEhU7h32p8oiRc7X01gzCj1W1DAzD3E/y/0ecP/H
	8Bb+EDADEQ9RwvWIxcr2wrmRTeeqTWe+WMQ713c3pwI06EhXVQrDsV9fgafFXM95
	/jyxoLjidBtEDaeKLygus5Lymp1UJgS7kYVE9DaKNon3tj8o4MVxgQu+aLN5k0bw
	DDUvkA4DtjsGCF8DAWOYRlwfFB9yyXgxzjK3rUQQqAtiLTIG7B0ess+gXV90hKd2
	k50szkojr9sh/DG57O+kxvxtia1kHD5zmXCXLZ6eEV4r76MAov5kRM5ojEQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6kqny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:41:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso12078420a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784292089; x=1784896889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAPXwbPcio7qPU8CQrPaujcrguQe/r3V+YL3HEQzqO8=;
        b=aS70UVqeNMmo7r3qAEZR6rgWEdzY7BEh0Cl/uVjwDrMHZMuF+kA/9uE02FBKpyoSZ8
         HiUidypTHu931dh8zN7xTQkOMJAFIhCROsVgbWRdpF583FsRTNfm1lDMRcwaV5N0cQ85
         8XTV/RhBh6YG6u2UdQqCZobWh9zKQu5tkSRYR9Lzw4JqEBSOttBQHGmwp+gQKhVYOAuC
         xspn+b71E+eXtgApOZSYqqrbJ16cmjnzvC3iA0LPcbZ1nMnxOb8EezJNbEbmuVW7NnoV
         EjE2tcy9GEM7pb7Q8sgsJXIisHKm/SEAB7KYr59WFUX3XeycKr+yqlVNh8dxwaWP1aI2
         Qg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784292089; x=1784896889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wAPXwbPcio7qPU8CQrPaujcrguQe/r3V+YL3HEQzqO8=;
        b=sow1RjpV38pxdrNADVBMuCfucjLor/s/WhH+HU0n+AYcKKilG7q5kGUg+xv7wv2K9H
         pmUMcdn4qWO7RfXzJuk9dVlvtlfQ1c4j1t/oGE00vilEr6tQPZcxEw56tHKKYlE+oM0K
         gS3IQ9YvCvwRpzqLMiBPiDnNf5eVkFPWYLd+eh4Le6bSCR12TO4zKq8jmauL/srsLzMf
         LLkcbJlQcK68iU62C48WG8ID94L8rNxsRgZjXFWeKasEGco3s+fnVkd0i9fzSUamZRBj
         GIVat4C05YaU79vOEAb4LEMvX3veq5KPCvfNxu/anodBQ/pX6Ynd3GgQg2Wk8wU1VSMl
         bTrA==
X-Gm-Message-State: AOJu0YwZd9nIQK70HKQ5a3MzXJNwgq5m4huB/tvPBuLZrb/qsry2MCqh
	GBmOzG0Z9AVG0tV41err5HN50H1EQ7Tz0tnUaYr4apn4NbWknjq8DoLiIEOjz7C8gTtGMYsWixp
	0rhhIbxqM5dNHDT3OCdKpCE11tSPS/sD94uMxOPImkzM146HmXvUcqvKbQjxFmI9F8wDOnqpINF
	RbSt8=
X-Gm-Gg: AfdE7ckZoxvGSXNO9DLoDjAiUp1vGZFWt5fCCGF5XosyQJDktxRzKMvwizmqpNEtWOQ
	3sgc8DXllHbRpkh0N7BbNdp0IFzvnmrchYrDMafOHiKk01YuaD3Vx4eQAOuM0hGuEetvin8vlzz
	yiWOOJgSQPFwB87yiBFUgErV1iYR4hIU/Fn88BluUB6H/h1XSsN6NF/IQtx5G5GSP/OGu2EMbVF
	NBUNUEXmGgNi5va9vnobBhfTNerd7HTL2O6AKq0KJXk4qrC0zVRbjaUSd2XmBsSUjgYRZGBzlzl
	RNXb1dO0wMEouO+VRbGXTWbbT1a4dc5OjgJt3Y/R7CeV94MXxLaW2LPoiXHUcAOmLP3yA6YkhTI
	V6pV0ffsNVjNCtRtHo8Z3bwDB8NGKjA==
X-Received: by 2002:a05:6a21:9206:b0:3c3:9993:d5c3 with SMTP id adf61e73a8af0-3c3ad665cdcmr2743124637.9.1784292089465;
        Fri, 17 Jul 2026 05:41:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:9206:b0:3c3:9993:d5c3 with SMTP id adf61e73a8af0-3c3ad665cdcmr2743084637.9.1784292089010;
        Fri, 17 Jul 2026 05:41:29 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cd6e6esm5262562c88.13.2026.07.17.05.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 05:41:28 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v4 2/2] profiles: Register RAS UUID reactively instead of probing
Date: Fri, 17 Jul 2026 18:11:11 +0530
Message-Id: <20260717124111.3296537-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717124111.3296537-1-naga.akella@oss.qualcomm.com>
References: <20260717124111.3296537-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfX4bIXh/2z57Ui
 CfrRSxqgp1o2SNSH4HWSfELrPvw1qiuY0M3PvnpkAsejGn8TZvqpeCTMzoy3U8j7nTY9SXm5zab
 L67PXH8x+DJ4pDrAHNelWFeJCOS/yH9Dr4koPYBCazUj64ZO9GAVMOx/RnwTwdL1Snui2pSFg2/
 INgku2T753bmUD+wOH+EE+jL2s3WD80yH3c1cDeDw3rm5AWePRR347xuG3FO3YNl7gh+1Onpv67
 3jbVqQivoZGTPJHAnO5a+nClL0OzLW80SNdUTIZ7VjJZrIMbDV5xMxVEF7T4emtluGAmzVus++l
 u7aMDMpUfMSnxe3M9psXN4WNjspl8MwDuNUSSIHU5EpFTqGeRlVzNQJD9gmMbXUwoveqBM22v/t
 4Sh7yY463sG50ADlzkb6RCfxOFL8EZ8JCyXvEn3S1HOZ4DpgHQZxMAgICHNoM0D+R22ZydqI3nh
 eccSiGsPgjxGJ3Q2zCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyOSBTYWx0ZWRfXzq8YT6lN/oFB
 mbZoQcqFYNX2yUPGlHJ1DuLUnbmRfLFdGyKnz20mD0dw53Nd7p7oMjyS4Cgyj+Ehf6JBFEMEm1o
 rhEV0tqpz0S3Pt7RoDbORXbIpuWmxn8=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a5a22fa cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=QJKIhARjhYvHIN7GN7gA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: hEPBRgHqWFi7a9yE3ZcN7l7MRc5V3VV8
X-Proofpoint-ORIG-GUID: hEPBRgHqWFi7a9yE3ZcN7l7MRc5V3VV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170129

Replace the unconditional reflector-role GATT_UUID probe in
gatt_client_init() with a reactive registration driven by actual
remote RAS access, using the notification API added in shared/rap.
---
 profiles/ranging/rap.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index 3ffc0da76..4f6d7f2db 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -308,6 +308,27 @@ static void rap_attached(struct bt_rap *rap, void *user_data)
 	rap_data_add(data);
 }
 
+static void rap_ras_accessed(struct bt_att *att, void *user_data)
+{
+	struct btd_device *device;
+	struct btd_service *service;
+
+	device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
+	if (!device) {
+		error("unable to find device for RAS access");
+		return;
+	}
+
+	service = btd_device_get_service(device, GATT_UUID);
+	if (!service) {
+		btd_device_add_uuid(device, GATT_UUID);
+		service = btd_device_get_service(device, GATT_UUID);
+	}
+
+	if (service)
+		service_accept(service, btd_device_is_initiator(device));
+}
+
 enum cs_dict_target {
 	CS_TARGET_SETTINGS,
 	CS_TARGET_CFG,
@@ -830,6 +851,7 @@ static struct btd_profile rap_profile = {
 };
 
 static unsigned int rap_id;
+static unsigned int rap_ras_accessed_id;
 
 static int rap_init(void)
 {
@@ -840,6 +862,8 @@ static int rap_init(void)
 		return err;
 
 	rap_id = bt_rap_register(rap_attached, rap_detached, NULL);
+	rap_ras_accessed_id = bt_rap_ras_accessed_register(rap_ras_accessed,
+									NULL);
 
 	return 0;
 }
@@ -848,6 +872,7 @@ static void rap_exit(void)
 {
 	btd_profile_unregister(&rap_profile);
 	bt_rap_unregister(rap_id);
+	bt_rap_ras_accessed_unregister(rap_ras_accessed_id);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(rap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 

