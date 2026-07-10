Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25D3C09E8
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667323; cv=none; b=r9N7VPVNu0jRsxthJ5koPl337SKr/Zc87BV04iUIAsJZvo6Iz0Uo2DDS1vlnb2fN6HHOGbZ9g1P9SAsVcT7ZnUjjFDt7+Lf8MtNdu3AF7921roas3P9RMTUJ4IY7YSBklB8JRzaviKCi1Ub3we0k4d3Wt6XW5wayA9JQdMawtQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667323; c=relaxed/simple;
	bh=j3LduURT8rxCJTYKDubd5erHUPOZL38qD+c/lSTjo2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CoCEZ0R0ZdS5ZVq+9mvliW0kpbWXib+19eYfTSXre7m2bwRzt/OOu3WfYJZLD7lEeLTZ2mhD7+WVTVrrx8BGUq6N/A0zaX9DbZYL9CvaJkxFYqrGNEQIkPnnCPjtWnXGjA+NV3Ih1rH8esXuUcQvEd1K8qRfrGUylxP5hs1rFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kpc7yXQw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MaAD6YIa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kpc7yXQw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MaAD6YIa"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3n2x73661696
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=t+IPsUAtIa1
	TLrb+NRl9jeu80hXf3Er7HQgBYa3TXUE=; b=kpc7yXQwbGeaNXzv56hPAXM4sBp
	XhY3gVbawcEdQuTrLi2hIavnaeXeRFh5mi+QlXEY/n6uHER2JlI1M4sBx+O9q+Jq
	W2KG84hMEW31FvkkqrKXjtPd1lSFSWZpCcH9icd5s+n5zk7rpfYoLzG4wtJPIF7X
	d+E+mQgagL12nZdXuvDFrO6Nei6tOYrZ/y+pu65/AbfqhR8bVxa2t3iuox7LQms6
	/gUWNJ2LF14sYQ1x6OyvZhNige+SHsin3WP59VyjgLmKmf8f5ZSFt6vq0ENu1O9G
	KacvvuSFWy8WmywD0ZzRXr9IwTBbjX7H61KSNDNeOxhLwn9NGA2i2qqbjHQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24u2st-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:08:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-380a638fb5bso822361a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783667320; x=1784272120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t+IPsUAtIa1TLrb+NRl9jeu80hXf3Er7HQgBYa3TXUE=;
        b=MaAD6YIa7IN9/SKUDyrMXxU0JDb4MBjCui7Tv0Ly5R5PELZcTjhHuO1naLqY7coUxz
         Xb2V13FTN43OgxnWLOoNs1v49UVSsQfvN/gT4z934X2M4XuAa9/uG0JsGlPpZkesBFxM
         OpQTOOk0eVynVNAm0hgmvqy64MczF7p7JTDLQvsZwMZ12xEMkbWA0xpY1SSGPmike47c
         zMQsAItfRjk7MqB8SB2jfYo1JgDCBZZ+uz9vEBhMCnEMywlIz94oAMTrNL5Tt9s2oKzP
         fNxuRWX4jr/I//G+fOyi7F5rK96gHQS830l79nLqKc9CzB8udTWhzLqyyOApt5HzCGmJ
         n9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783667320; x=1784272120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t+IPsUAtIa1TLrb+NRl9jeu80hXf3Er7HQgBYa3TXUE=;
        b=F+kPT0JUKFEToWEbdWqxlf7yTV8VEsIXN0F2a0yhcSJ+S1BT5VNb1qsFhYyBxP0nRh
         d/dNDrjjq97nbjCiBPVK2uWnMNO5qBo4dHx3NBTU1L9MO7g+3kiPhTUnoxhDQS9t64Sx
         I8c9ltZXaolNlcOwb2OGJmBx3deJg/dzaJqvRT87prtZAOv4UGydfUms6EQKhdLqxE7U
         4IwU+5x5eu1s2S98jAehqkvx/NeM7YdLs//w+WfDfwKyIvmOP7P7CkVC+6md6qXQvrKv
         E3HKetNk+DFNtM60bXyJo5Q+TDCF3G3kITlCB5QBXdZ9q5/aLTK5DLpKygLKqEO4b6C6
         +nmA==
X-Gm-Message-State: AOJu0Yyf3sKQAfE3csi/Cbzni8ZPJtUy6hForhSHSiGMVqH6PW0enp6n
	ItuIUx5+lWRw2ydf+UUdAqcby7d+RVtuILrYgGvdPdIXGRVUnk0xm/jLc3QbU/RQDdWgHAAOmJh
	6F0jvXelQH38h5icpJXU0a3PFF/wLjf3M0nk4oAnLebfY2DCXuSKgPyNcI8Gxnr5VsbCF69xh4/
	yFIiA=
X-Gm-Gg: AfdE7ck4Ft/k96UgqBb8TB/41ixDEAtzqFtJRPG2ZDDdy0YdZbYHkgShjPKIJlFL4uQ
	92qR3pc62ymDWFQ0AALjlDPqJtHoliZudk1wY+h2LWP1+zg+Sd9sgVMAz/grYe22N2NiIg4LGeu
	Nf0j3DK+/hugMd/TlyBB9iPgvr9h8za5ILiZsQhsZSd0JZ7XKOYhYxJtwPaIPfZ96rNYeePVJ6g
	mFjNThdCCKzxam/OioK74Bw0qxs1ZjT2iyP3rVNNP5blh8nwqHsh8wHSN1Q0fvx85sz2fnoPEoK
	mLkCqgIjw3UzBgOrdOG1uANTFTUIiFjVXwOtXjdsNoXcSpzy9GkU4twioNrf17ytDv/MknhtCF6
	5hyKL+iSWMoS5csE164pwzO9lnxDySvDNIrYEcn3l
X-Received: by 2002:a17:90b:562d:b0:37d:7bb4:bffb with SMTP id 98e67ed59e1d1-3893fb6ffbbmr10527645a91.2.1783667320187;
        Fri, 10 Jul 2026 00:08:40 -0700 (PDT)
X-Received: by 2002:a17:90b:562d:b0:37d:7bb4:bffb with SMTP id 98e67ed59e1d1-3893fb6ffbbmr10527624a91.2.1783667319761;
        Fri, 10 Jul 2026 00:08:39 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm43082332eec.1.2026.07.10.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:08:39 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 2/2] src: Register GATT profiles for Channel Sounding reflector
Date: Fri, 10 Jul 2026 12:38:20 +0530
Message-Id: <20260710070820.3793624-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710070820.3793624-1-naga.akella@oss.qualcomm.com>
References: <20260710070820.3793624-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9fENVi2UjPPf1iiVUoeTl7MVCRQoos4g
X-Proofpoint-ORIG-GUID: 9fENVi2UjPPf1iiVUoeTl7MVCRQoos4g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2NyBTYWx0ZWRfXzTJ7YlVercdy
 lhOHZSQ8blfeYpCrCqOGKHH/DvRM4f10vI09dy79Lfbqj3Zs+yC3H1DpUnOAoCexalRzS/MI7K8
 ICTYaGMt0kKf6Jhqclr7qHfnPrNtIZo=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a509a79 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=mucxSH6ds5ffYonggmIA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2NyBTYWx0ZWRfX7wPDw9Kvt3lc
 EuMVgoNyPhc7z5sOrR8Xap4FTqs84aadHfpA3nfei5V28kCoyKwk4ec3rYp/ibFYYDNzFprypHt
 BhGhxZb58vOq4wzg8nbv1N1+yZMXm+XMx3x8uHTUo+p38Fpt+mhzWnYcbOmphw0cIVMhNa5YqH1
 uVF1IWEffvhi7YTu/17ph4ciNghawoSAkF2JxQi3eeDfKa1YMMQNFX9zyMxceUzFQA65AKIDtrK
 QHLMBCoNvO215WRTsJxTqXLGl99HrYR+vlc+81wu0BrgiMzbGszM6fh4WKsFgmmbcvCsUhwCm/d
 t7C9PJj9XjNjWbzRo67i7LMPz9Suseu3Tm4pM3YGuTaGzEXA4nL4mf8oU9lM1cSQiXldG5pH0SX
 WDk/U2ueBzTjSaUP39DwrcPB/yJ9Vskc05fqM4SXv9DgFEDuZ+b9AvThCEjdEb9TjSUoRj15z4V
 nAaBD5m3grf3WEklJVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100067

Probe and accept GATT_UUID profiles on non-initiator (reflector)
devices before gatt_client discovery checks,
ensuring RAP's org.bluez.ChannelSounding1 DBus interface is registered
even when GATT client discovery is skipped.
---
 src/device.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/src/device.c b/src/device.c
index 65d84be56..cedfe3a20 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6301,17 +6301,31 @@ static void gatt_debug(const char *str, void *user_data)
 static void gatt_client_init(struct btd_device *device)
 {
 	uint8_t features;
+	GSList *uuid_list;
 
 	gatt_client_cleanup(device);
 
-	if (!btd_device_is_initiator(device) && !btd_opts.reverse_discovery) {
-		DBG("Reverse service discovery disabled: skipping GATT client");
-		return;
-	}
+	if (!btd_device_is_initiator(device)) {
+		/*
+		 * For the reflector role GATT client discovery is skipped, but
+		 * profiles that match GATT_UUID still need to be probed and
+		 * accepted so they can register their D-Bus interfaces (e.g.
+		 * org.bluez.ChannelSounding1).
+		 */
+		uuid_list = g_slist_append(NULL, (char *)GATT_UUID);
+		device_probe_profiles(device, uuid_list);
+		g_slist_free(uuid_list);
+		device_accept_gatt_profiles(device);
 
-	if (!btd_device_is_initiator(device) && !btd_opts.gatt_client) {
-		DBG("GATT client disabled: skipping GATT client");
-		return;
+		if (!btd_opts.reverse_discovery) {
+			DBG("Reverse srvc disc disabled: skip GATT client");
+			return;
+		}
+
+		if (!btd_opts.gatt_client) {
+			DBG("GATT client disabled: skipping GATT client");
+			return;
+		}
 	}
 
 	features =  BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING
-- 

