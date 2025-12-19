Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928CE2652AF
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131600; cv=none; b=T8pLxJiDcsylWDRUCUGc/6o37n5oXsCdJtW0ZnZPCqSd6zClV8NqXgKMZyjrgJf4n0yJmsg8N83B5dzi7WgaDOx/WFfWuSlg3a4FLyuynQf9CcfhHuDiUqDLoFd977MQGSJBOYj+BPATyiWYnCxISULd66Ji6GAVPy3PiKQhuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131600; c=relaxed/simple;
	bh=IOIjRP70Fvx2X20EkWz9hXPWPOJWT9+iOynbxCbfiCc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TjVKRJ+90JShTlGd+0o/z1Y9eu7SeXY+Sqgu+RKe7sO/cuSq09o0KMoXAbu+AwN2HwzkfNcpAi2/fJMnSXzVtO+hpqcHZZLE9gVQQKbekVX2xPJ8mdHEJbSCkiWeP43C8ptNtgsMhQ8wG7/I63+fO6xH6h5uEaEKZ7DxTQcOPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QyRpSkjL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bZU2+Wzl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QyRpSkjL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZU2+Wzl"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4buDa3975405
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 08:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sGg28o7i+lQC+5N+pOMrt48kHNHiaCOAvB1
	rjkc4huk=; b=QyRpSkjLJzapiPKV2c7hCGFaN016hTWRd3c/SpTVtZFUJJruNpA
	jLy/HrFHuSo97L5o6vKZSJi337nqYvUN9JpjqOW++MDTp6UVr5ecdCEWDYNfiZrj
	bwlRef8I7UXbagrT00H/NYjJ8NBI4q6cXUZgPkYYiBwCF4ZoJOiOHLyT4gAbXOVn
	j3CUut27x+620Da/s+9pbmoRe+kVmu5ajUHHAzOs1EYBAF3XfdyHtFUpn3YUpiw9
	vIj0ltN4AXk3mAku4v4gJizol4L/+tMtxppmgiz3gZYnZRomVv+2cdG6sC7pgUnx
	r3TlsMTjL0wgakKnge1BCk7C842ODDTCLFg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2fhrxe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 08:06:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b245c49d0cso328346285a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 00:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766131596; x=1766736396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGg28o7i+lQC+5N+pOMrt48kHNHiaCOAvB1rjkc4huk=;
        b=bZU2+WzlXQRDy86yLwDlrpKJz0ZyxDhwt5rGWh9Qbh5aduk75KuERP0geDTmlE2HF4
         /Lw8BAKMqqhbT7bBo9SzciQWit09I5DkloSJ5S27zZ67dH8ZY2ARU0Xt55Y9fT0Ex7xa
         EQg5UbBM1DwrUv1L+FoJJzpYizL5g1pKoeIGxi+jn0WNkGa3KQUKVn6C8k1iCCJ/1rYS
         LI+QHEBGdqre3RpIpy+0CEjsDRVEIBueL85x+FvgM2qiVe9sUVD43A3bgk+4RdHo2m2w
         zX9z02hIjD7K1clHOsEMaMoDzGqxh/je5jqVa6emp/0UY+oZk9YF5GeantjEGA1CeUEJ
         ciFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131596; x=1766736396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGg28o7i+lQC+5N+pOMrt48kHNHiaCOAvB1rjkc4huk=;
        b=siaokxX/goR6+uh8FIkw1WeOyVkci8aVeeNImtz5vClNc1hu7cvBlCjLmUJ7vXA2/Q
         rrrsGoC2UMimL4+aR1P4zrFdAUmG2rafLofSWC+hexyv1jRRCnbWlNGuAhZ8oKFX0Y+r
         Wi+gQXMkRYjXCceG6q9p5QT2pRPl5GLA3sntqxhBuSqlPzSyyLGe0EQcWY8lfKgC42T4
         gaKgcwDzTpw2jgsmgEDdtT71tLZL1QxjIAkqIhZWOYv2OluIgEdainNkksOLgUFoQdMO
         /s8U+w4Ct9Lx1jWrhE1wUbjsB5tPjK9gDxJGtF5jYSFU9FRgAj/YYpRXni7+MsuMpjz7
         IdgA==
X-Gm-Message-State: AOJu0YwSWx2nylqWHgyauEuqjXg7qhDxcKw7PPPY8mfbFZBKohRHvA+E
	706kFUa5UYdMbuPobjrxSvew14j/TlyKxNu7ZBE97Wwxh9vv0j0ZkpHkYk9IrvmAZ5TVZuBQH2j
	dek8mr4U4Ed4iG9xrRLEgMxc9Dve4mtxiFiWwZcdo6CMk8TTUHk2/ddBP+vJ5ap8z+z5ij5b1m+
	oCSY0=
X-Gm-Gg: AY/fxX49vpb/swSeHGh1x3MSDZ2N1jI5PT/qMDX1XV70JRYAXZVx3MQdebh/f/++vIg
	R9fODQtCQbjmz99gzxedaKz3l/4CFVuLdtbI05Ds+gXqcmiHbhD14Acc7QYG11Lp77plC6oAHAP
	Tnj9mFD2ELKyGRB9LoPOwwiOY3lS7UInq02FOx/w20x/ziL53l8qWSfIPJm+0tTcw3+kJaN4pG2
	ZYBasLUaM0Yv0QaVefRlG1Ussd/eGKFp19wu0odRcDR02BXFw+vIgglohiRmwHTgskVpVf3omTt
	dJExM8B/+tFNkfCmQbkjRtx8Mtxui7Kfiw6Ir6Fq+XhIovQeQaOrdCeEKfSsg2IJqInOSUjS85L
	eI8RMfo08jBPxvOIyqYx7SOrKzlKZIw+6M0/zLIHYPzP4WhHB3ED/7SGcO80=
X-Received: by 2002:a05:620a:46a6:b0:892:25d5:2ec with SMTP id af79cd13be357-8c08f668c10mr370332185a.27.1766131596462;
        Fri, 19 Dec 2025 00:06:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxsjSUyQJ4ER2UhCEWY6Kb8l4CorqbH9UDhvlQj4crpO0rArS8vN2/74H+o+rJAzN1/5kg8g==
X-Received: by 2002:a05:620a:46a6:b0:892:25d5:2ec with SMTP id af79cd13be357-8c08f668c10mr370329585a.27.1766131595917;
        Fri, 19 Dec 2025 00:06:35 -0800 (PST)
Received: from rohan.lan (82-128-196-119.bb.dnainternet.fi. [82.128.196.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-381224de761sm3966051fa.1.2025.12.19.00.06.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:06:35 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] shared/shell: Don't init input for non-interactive shells
Date: Fri, 19 Dec 2025 10:06:32 +0200
Message-ID: <20251219080633.394709-1-dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NODYOk6g c=1 sm=1 tr=0 ts=6945078d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=UP4AmmvVc3sGQHJQO2VA4Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0l35inbUAX9EAsY2NJIA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: BCtNMEZeL4DaIflseOlfhJgGkybGILRv
X-Proofpoint-GUID: BCtNMEZeL4DaIflseOlfhJgGkybGILRv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA2NiBTYWx0ZWRfX/Y6dBt1Kklbt
 SRZJB8jiocl4BjltQ/QRroZ1otJvlrRDgdULSx8UetEh1zUbEt1TzkOBu4mqX1+ZEIpqNFS9e3N
 D2I3OlcvB3m+jBrYD9wclMvXjDfgTePkK6XZ8jy7WHAI/9gqTmUapAgpzM9bfBULmunAEuzK4gq
 DRGvfk5nMamNj39L9EBKsctHWe+neJYOwMcNauebSp7Ns43yML6nTBNHKdWuHVZ/Zo9LaEAs0wN
 8Ka1C1VJxphSokseFN4eHlpPcUfNBeLab2843hR69Fypf8BN6dgAhd5xUvAWVr+CCiKACt00Kx4
 Et04AJ8PS4TCyHScdM3LYh1zITv7wiUtFESElD6Iwp5z0ovkyNgxcZ5VivJXVxyFCXgz9sg8SGl
 uI3d6G1QAUTG7VrIzvrxwfCl/kXHvjHwfOEhePK4DXG/AdPcSpzfVo5S3CwAmVbkUXOJovzN+E8
 7m0oCpSyP3zcIM1ZSDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190066

Only the interactive shell is supposed to read comments from the input
file descriptor. Rework bt_attach_shell() in order to stop calling
input_new() / io_new() in a non-interactive case.

Fixes #700
---
 src/shared/shell.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index ea285c72631d..aff5652e40fc 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1645,13 +1645,13 @@ static bool shell_quit(void *data)
 
 bool bt_shell_attach(int fd)
 {
-	struct input *input;
+	if (data.mode == MODE_INTERACTIVE) {
+		struct input *input;
 
-	input = input_new(fd);
-	if (!input)
-		return false;
+		input = input_new(fd);
+		if (!input)
+			return false;
 
-	if (data.mode == MODE_INTERACTIVE) {
 		io_set_read_handler(input->io, input_read, input, NULL);
 		io_set_disconnect_handler(input->io, input_hup, input, NULL);
 	}
-- 
2.51.0

