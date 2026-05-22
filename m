Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B031330D34
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429800; cv=none; b=cCJUo+51Ek3uJLRortjwP5FMdVfr1zRgu9X2o18xWTke0IsR62tscbuf+sZjTQetTXtUEoPEJl0jJxCMyFiK6TU3x0Xq0EDCsxVpPmk5t8pw2WRC1Db3hokzMQk4xtkJCiDeY/b3jsU5qQbEJpHkcEA8ABNj3J1Z65dSzj4VHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429800; c=relaxed/simple;
	bh=7BAlVMBpWp3V1LLCxHf5eLS+UutRK5V0PxYJRRh3T7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eug1DWcSnI88hxmKhvRp38Paf3V53P5FS4sW5m7KIfh8JLxQqZ18l6giNMggfjq02FAH1Su1w2+qXrY7pav1AVg32yBQaKB7ZwraSBhbLV+ipThThxn2OoFJmjXV9jnZmm3XkOvP7CTT/K5TmnM6F4mIiHhshSHV1gTWK7eztv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PB9iLoZG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ODaOYJ0f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PB9iLoZG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ODaOYJ0f"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M41mNg3005135
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 06:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kJvwoCaRf/POt3YXzIDgSnInMgevQmCVink
	aFeP2tEs=; b=PB9iLoZGN6Y/GNOZlkc4yV58WmNU4q9sdyKT048bRTmmYOkZOvO
	OUJVeCFyBEoKUN0uUUnW1UtARUvRmjlljytSnrkd8MT7s1QOIC4186jfYGyzf2QM
	+4dHAxx+UdSzESGdmgynQDCXrkleSnAuxV5EjN/2N0W+BSopD41//EhlGwfNnbvO
	HEdeFCnY9pIDPrwMmJL2MQqpwG7jKsxdAylZOI+SUo7adnMabnU1/Gkdc/jb7n3m
	eDNpyHWWQb6OV7F+Pl6iz2EXPPgcaULZTaIW+PB+dym/lBnNzMPztQyRDr4ReGap
	htEhVmRFJb6y8yAQvFpCYVIr4T5wklifcgw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrt8axs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 06:03:18 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-836cfd84728so3624107b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 23:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779429798; x=1780034598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kJvwoCaRf/POt3YXzIDgSnInMgevQmCVinkaFeP2tEs=;
        b=ODaOYJ0fbcoco5Nl6QENFkCJSPz6a7vY41N1f7EEA9xUYRW2cXgfO59h3iVkx0dTKe
         6Ha5Ash4w3WOgde2iQYaftaZ8xqDfU7iGKTo1xApTKYtCv7mF+F0hqNtGFh11e2gteHe
         PRU7RatnFMlK1cimMi8TD4jW0W28z+f5sWtEV+Zyd27abFIrpn/yBnLqlDELsIT6FHnt
         aHp/DoKKmUnndyW8U+QXzCZ7PwhKZ3aPnSwNtLsm5n5txOCRi9XOqeE+3PYZCQW3/wdX
         tpmjhGoCANZ97KLZB0BPuqoST+3dRHT9+mw60UhRLk+dYmpuZgfPhBqUcYAqisbjdKaL
         7u0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779429798; x=1780034598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJvwoCaRf/POt3YXzIDgSnInMgevQmCVinkaFeP2tEs=;
        b=YWVIYp/BngLjZX/3DGXtivT0TabgzXBGexuL6gtqsFTV2ARbOw1E201DTJs5h2CmmA
         N11Tk1GL06zQYs6y2swlE2WFMQWsWoStFPTdyAlpAr2IDlwbUSPV1U7d3C95/KoBLQ0n
         zOXkKxik0xhXeAq7C9j6DpwP9IhtimwLGZZdvPRFaHHX9HqiN32SWLSefQdU4i0qX19Q
         VyBQVqFcRIoSitFOPrnOdi5EPl+0/eds+8VhRCBC0CTVMu3jhQRUYyGNKNf3sQMC4rez
         yftAVMj4zWbn7nLTHW8UubHPwb5ERkj8p3Gnwfpqa08fulLEz+yjMqnXOluQt6nUjKY2
         xBpg==
X-Gm-Message-State: AOJu0YwOMZPgXC8HWdM7zZFfhh4ARxrg4oWCp8uBxODQ0+aSqZThqYkD
	yfze+eT2sPWtAbsY9NjucD2251U6nDBpJqjBmHAt5BIkP86d8iA4ceXWvIj2+n4TGoar3tglK3e
	BYVIZEX3v+AlaGl2gvYOChb9IAYD+DxeN+5oKK+5fxfjTTUsv6e8Fv64V6L0w+ZdjFu5o8NAzMB
	ylkUU=
X-Gm-Gg: Acq92OGpFctqwOjucpwRjS4vnVtd7MGdQfoWIhvIR20QbNUWYfmqy1QGrUSrIPvCAwJ
	M6Y4YL8b4Cdos55dK6AWEmq08KYr/uKsv6AHLLTEYuUUMW0jBdAL3P0FNnNl+n/EBuvrk75gkPF
	jAp/C1N2Issm4kWCwPB+WIcttW0PsU7FgIoUbdOjowzI6nA9ygWxfcZ4ByGMyIIPBOx+NWjFEg2
	4+tM7sGCal19qrSV43ApAa28WwRG+XXjSwoyXi4habUtqeAGlQYmWFwtk7df/wiNSSuJWvuNzN+
	3UtnjUEkcHY5sKdah5mF/pKflwIdQTov9EsMY/L/XBBaCWpVCFfGa7D2Ohs2obpYmSci1B9xE9/
	54qnDqc/pfB+9CSvpEPGKYPWeGMRRRuGPcnLYfrUVrjFGVP8pzhCNEg==
X-Received: by 2002:a05:6a00:1308:b0:835:447b:a2ac with SMTP id d2e1a72fcca58-8414b3e18c2mr4801605b3a.5.1779429797688;
        Thu, 21 May 2026 23:03:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:1308:b0:835:447b:a2ac with SMTP id d2e1a72fcca58-8414b3e18c2mr4801566b3a.5.1779429797158;
        Thu, 21 May 2026 23:03:17 -0700 (PDT)
Received: from sdciot-sh01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fb28d5sm815141b3a.41.2026.05.21.23.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 23:03:16 -0700 (PDT)
From: Zhiyuan Sheng <zhiyuan.sheng@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com
Subject: [PATCH v1] obexd: fix PBAP PullPhoneBook failure with ebook backend
Date: Fri, 22 May 2026 14:03:12 +0800
Message-Id: <20260522060312.1503481-1-zhiyuan.sheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a0ff1a6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=kGcSZFgZilH6SPbTjzcA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1OCBTYWx0ZWRfX7WM3yO+y1Ftg
 aXvHFv4oPYZYGoyFTYL6LFe8N1dprusvfewCd4+JQpXAiagsUzf/aKeljmH2NwAA/QQbSnbGQhk
 xA1s1m2QH1VjjoLmTxaJwkhiiZdSPTXW+UCFl3l5M7nZY3JoXov5av3rykbdXKdfSPCBKPG9mqT
 r8COS9fJDhLOiStueavtjzYRgX5zKmUFURrD5le6p1OKUCUFVLOJVGQdIXaW5JztmJ8+7u454v2
 hGYvEiz1EdOSjSWOLrourUmz7t7ufDh5Lj98sxe425lgEO3CUOi7TlBA0vght8AteGsQeTN+O5c
 fEkzyEPpEpwbQ+SizCWWUQ+6MrJ+dzAxNCBiVtH96L1y5KudPHWCdboj5uJRiuoiitq8cDgIrBb
 NHDRgBlWz+Be3MoQYbX7Vr/KZJfdWsKkADpSwIoo95xDg4MuFZXoMxDUgUZc4JlyCngEgLP2zWW
 +jI7Eahd1rw+GbvhHhA==
X-Proofpoint-GUID: o47JVPMS_nKejXTBLTWgIAQGgtgAxzaa
X-Proofpoint-ORIG-GUID: o47JVPMS_nKejXTBLTWgIAQGgtgAxzaa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220058

phonebook_pull() in phonebook-ebook.c does not set *err = 0 on the
success path, unlike phonebook-tracker.c and phonebook-dummy.c. The
caller vobject_pull_open() in pbap.c declares 'ret' without
initialization and passes &ret to phonebook_pull(), so 'ret' retains
an indeterminate stack value when the ebook backend is in use. The
subsequent 'if (ret < 0)' check then incorrectly triggers and rejects
the request with Internal Server Error.

Fix this by setting *err = 0 on success in phonebook-ebook.c, and
initialize 'ret' to 0 in vobject_pull_open() as a defensive measure
to guard against any backend that omits this assignment.

Signed-off-by: Zhiyuan Sheng <zhiyuan.sheng@oss.qualcomm.com>
---
 obexd/plugins/pbap.c            | 2 +-
 obexd/plugins/phonebook-ebook.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index 74976890d..9f8684863 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -661,7 +661,7 @@ static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
 {
 	struct pbap_session *pbap = context;
 	phonebook_cb cb;
-	int ret;
+	int ret = 0;
 	void *request;
 
 	DBG("name %s context %p maxlistcount %d", name, context,
diff --git a/obexd/plugins/phonebook-ebook.c b/obexd/plugins/phonebook-ebook.c
index d772edca0..5fc0498c1 100644
--- a/obexd/plugins/phonebook-ebook.c
+++ b/obexd/plugins/phonebook-ebook.c
@@ -262,6 +262,9 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	data->query = e_book_query_to_string(query);
 	e_book_query_unref(query);
 
+	if (err)
+		*err = 0;
+
 	return data;
 }
 
-- 
2.34.1

