Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCAE555
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904013; cv=none; b=A9EvTLFjeSbR/C+B+IHGbkdMjbnbGZoltvJhoWW+FTuiLbSL2NCKCPm2DuP0ynkSYqbwNq7Y2E2lsLnHHkkLKwGL9QGddZvwnAbr6ciYJ1lXrhLXuj0EmBya95sC4C8xQV04WhsDpEnSZx860xaruf9I6X6i2F1+MvAUyAfmDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904013; c=relaxed/simple;
	bh=GXBtoeC9LFNkJDZqdfR+vD7L3Zu5OIk5Rq74CjtI93k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHJiWIgSpim3xRNlwWkilpc55rpiktWLhy7P99vU5XWoW1vOwsEkyhZhtUiiWGoeeQGMMoSuczPeV9t9uvY35D16kU/jaXEAGE47NuoyB91P97eUSywa36qH+QHh1vNEx+T/HVz0vSoSX/bL8grjcsnuT8aC5RNGY9zulhiD+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=for6HFq7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j1G8ggVD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="for6HFq7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j1G8ggVD"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRfAu1580785
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 13:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5Zt3oDzbaCUjmPeRW0ThtNXN1XRzan/1m7Y
	DMt3CNgo=; b=for6HFq7LHRoo8LcMqcAKy5dxVPVidvVgmG6DwAnCDTQhk8//kT
	MiDPwLzJlHpl1q+d7e4GxvE9AI2/0hA7Aptr6qUHMYFubzuBKZz4OdEXQ2CqLDxp
	s4Fqxdz0QEtGpXhtLcDgJO8L2dr0kjArGvvblmnqFNW4UB6qFUjPX3ESpkb8EezQ
	zuZ/0pm/+gtceUQl6KBwsaNxKzMB0t5fl5RlPJzBJ4qYtLtDFonHYcgvCABh7ql1
	p0kibEcgOuhJLV6uR17kmaG9lqLMjDDOi9TKfE0UmZXeRCERUgGMWSuIhn/wgh20
	+a2Q8fI7QEL6/GStqYz571qiUwLtL7sXpOw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8y9bu5dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 13:46:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8ca3e7722f1so635957385a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 05:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770904009; x=1771508809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zt3oDzbaCUjmPeRW0ThtNXN1XRzan/1m7YDMt3CNgo=;
        b=j1G8ggVDtyNRq5Q5+QKyzK9Hf74hmQ5kJ788nfKi8FXUFMS2YAJSKIfT2pFmDvag3B
         hj5VuSw9rVhfMWx/8/D/z2aaAoX8My+zT6lsjgA90K7tt3Y6t+iafI4mKDZacyIFIEqr
         H5jcJONpIZsBjJuRcQoncM4gDG/TfCLvHP+GozY92AIxdCecs5o9al8z7WbRXFTuEgKy
         JGSUbST6JTn4gHa9UzRuAMzq5hDoioT8jdc/YVqASKPwAKgT8GwyscIj3ftV4L+dITxU
         1NTkqTmGLxVAXON/v/y88ygVsr27t2qwdJHspWdDni5h6ZuDFsFd9N0p6NJ/wkxXNRQs
         tPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770904009; x=1771508809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Zt3oDzbaCUjmPeRW0ThtNXN1XRzan/1m7YDMt3CNgo=;
        b=s61fPZmkr9/GeSsmTHT9g+UrpZP+pkBoJoGKHEYjdauBYzOpoVtZOF7L4Gf9kdTwRc
         PbYJdReEEnT10Q0ldnMkevrKuIBpQQ04VKEg8PHr1wSOevC1Ty09dahzOdE6y/aeGdiC
         FL97yi+VkJtHoxMxzempMs0Fkj2yNm/3Zu13Ws6YRD0+nCgKsGMoSAKOwiggquJDHG/A
         DluVO8kOlp9dME026uyopD6y9t/hzMB6AdR+9MrYAApzThdfMSeWhkxJ218z8IaFimfB
         2daDZxM0S+9TzzFybaecMse/NhHBFEX6irXD+1O8RLbnqd8KbYfAKQyskVy40asABF74
         78gA==
X-Forwarded-Encrypted: i=1; AJvYcCWACpBMwIyw8WsFVSPL1shWaHLBe+sTR3LHGgJd09F9mbbmhrGcm+LWzSpFn9/5WG+BW3cDmN3QYC4PEcSHTNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyELzvO0RF1fO8PBoXELSljC+40aK0gx4YkVJ0P37XEx3Y/LHo
	l1O111s9BjGY6+YCJCnChTyX4vTMyjbSPXJjigXOIcGzPsskWLM7GgZ1GDPWthbHE8KKyyeqkp6
	VU6LUHhVZsvAE/ck732F1Wi2UXw55XeyCkA4neFv+/qpzHYjqg51pHEhERCwoB81ZT20V2rM=
X-Gm-Gg: AZuq6aLmBhWxomQJz9acYhvDTMqd6xfPmjD+siPdauaszqidQgncD34GXZNPeEfhMYH
	dIqlZEJxyowuQK7wyua9sslwgxXgj+7Tb/Sv2CCvvNLD5ly0nX3EU/fJr05ObSwID6r7RjOjMAU
	XghX1w6J9o30b9NCr6hnp89yNv2B7MF2iABQwGheG/i9X13qX5l6hzDbwpFh9HPs5ZhC8m1qE0t
	9PEVahKdHBdp0ULxncxDLQtzdiYsNg1Ox14LmUYaHVEbgMYrp5pjW2T1HvNb9bbM9qTNfl9tjEg
	5i3PdUSaVrBZ7XhNbcxY75yBYlGhkzN4+h+0GURhkOuxgjOPJVRhvJw2zH7VVtYur7hf2LpLLhh
	gWvX96P8D6JAvdlkCZoJ7NmzkfBnG/3SL1V38w1Vv7oNAR14yaBRxaS9SR9NM1rmv+4FKYxKpNj
	vo1My9gv4wtV3mSHypIuXuUWBpEu1Fb5ZJ/uBq
X-Received: by 2002:a05:620a:450f:b0:8c6:df6b:93fa with SMTP id af79cd13be357-8cb33d8b4femr301847285a.43.1770904008919;
        Thu, 12 Feb 2026 05:46:48 -0800 (PST)
X-Received: by 2002:a05:620a:450f:b0:8c6:df6b:93fa with SMTP id af79cd13be357-8cb33d8b4femr301843785a.43.1770904008409;
        Thu, 12 Feb 2026 05:46:48 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f92b25476sm61948066b.35.2026.02.12.05.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 05:46:47 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH] driver core: Make deferred_probe_timeout default a Kconfig option
Date: Thu, 12 Feb 2026 14:46:46 +0100
Message-ID: <20260212134646.66433-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BbPVE7t2 c=1 sm=1 tr=0 ts=698dd9c9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8 a=TZbnZ9SDAF1jH3i77HIA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Tgth5mpemNxY4_WdtFFs6BpJmW436XDs
X-Proofpoint-ORIG-GUID: Tgth5mpemNxY4_WdtFFs6BpJmW436XDs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEwNCBTYWx0ZWRfXzhLOkFK3W7rj
 mGhWxicwt5rjnvxzuKACy94gRHdYng322p1RNTIEC/jf43px8/UKUnUPvcLi1ReCwiMqlNQJS1c
 r+NYLC49jy5RYabmgaY5LjI7baYzlgBljJ6kU1VmDtYdKlZRlGZDiXVgVxx6Jb1TekGmKrh3RKI
 vLmpH3ft8m7Cbth0AigJN0xxGPPYBuxhvLmuJ23et7X28qAmeRymyiii7Kw/or8ufnnSgYbtD/J
 ACZ5WVQSuv6/fn9ms1od3NB4T6eVUZoAzMjvGieQVqlkcUNJO6p3nTD2yM2MdcyTTGSWx8kTFDx
 bXg65nJ/a0ygik3FNT289bmf7qN9qiBDI0nItGs1xWLIeQ6mNQMBp7tN6HN1rRyeJff9vYZF2aE
 CPnne5rWld/8+B1x3uPWh6qHjKwK0en4JU8HxqkD7IWVFGKnGRsvOJkASKPdxonWAM2i41J3Rrh
 IbfxGJJ1sZ0IbeW31Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120104

Code using driver_deferred_probe_check_state() differs from most
EPROBE_DEFER handling in the kernel. Where other EPROBE_DEFER handling
(e.g. clks, gpios and regulators) waits indefinitely for suppliers to
show up, code using driver_deferred_probe_check_state() will fail
after the deferred_probe_timeout.

This is a problem for generic distro kernels which want to support many
boards using a single kernel build. These kernels want as much drivers to
be modular as possible. The initrd also should be as small as possible,
so the initrd will *not* have drivers not needing to get the rootfs.

Combine this with waiting for a full-disk encryption password in
the initrd and it is pretty much guaranteed that the default 10s timeout
will be hit, causing probe() failures when drivers on the rootfs happen
to get modprobe-d before other rootfs modules providing their suppliers.

Make the default timeout configurable from Kconfig to allow distro kernel
configs where many of the supplier drivers are modules to set the default
through Kconfig and allow using a value of -1 to disable the timeout
(wait indefinitely).

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 drivers/base/Kconfig                            | 9 +++++++++
 drivers/base/dd.c                               | 9 ++++-----
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1058f2a6d6a8..80d300c4e16b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1250,7 +1250,7 @@ Kernel parameters
 			out hasn't expired, it'll be restarted by each
 			successful driver registration. This option will also
 			dump out devices still on the deferred probe list after
-			retrying.
+			retrying. Set to -1 to wait indefinitely.
 
 	delayacct	[KNL] Enable per-task delay accounting
 
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 1786d87b29e2..f7d385cbd3ba 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -73,6 +73,15 @@ config DEVTMPFS_SAFE
 	  with the PROT_EXEC flag. This can break, for example, non-KMS
 	  video drivers.
 
+config DRIVER_DEFERRED_PROBE_TIMEOUT
+	int "Default value for deferred_probe_timeout"
+	default 0 if !MODULES
+	default 10 if MODULES
+	help
+	  Set the default value for the deferred_probe_timeout kernel parameter.
+	  See Documentation/admin-guide/kernel-parameters.txt for a description
+	  of the deferred_probe_timeout kernel parameter.
+
 config STANDALONE
 	bool "Select only drivers that don't need compile-time external firmware"
 	default y
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index bea8da5f8a3a..e57144aa168d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -257,11 +257,7 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
-#ifdef CONFIG_MODULES
-static int driver_deferred_probe_timeout = 10;
-#else
-static int driver_deferred_probe_timeout;
-#endif
+static int driver_deferred_probe_timeout = CONFIG_DRIVER_DEFERRED_PROBE_TIMEOUT;
 
 static int __init deferred_probe_timeout_setup(char *str)
 {
@@ -323,6 +319,9 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_
 
 void deferred_probe_extend_timeout(void)
 {
+	if (driver_deferred_probe_timeout < 0)
+		return;
+
 	/*
 	 * If the work hasn't been queued yet or if the work expired, don't
 	 * start a new one.
-- 
2.52.0

