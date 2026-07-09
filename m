Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF30288D0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783570497; cv=none; b=SsgGRmXJrGT0mR44q3x34KQZ7zvBxuXxLe9tQSNsaL5hp9s2MqgPXBTXv4vFS3+BxKDScPL9V0fJTclpXVmT8YZKIuHpcv1Qb67ElAN4NRdzZv6yVvqn71sweMDCN+ceb8eWyc9bu2jAjsb2xgG6INYy/MESMs1pBwz9cI2f1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783570497; c=relaxed/simple;
	bh=cajyW5v7w2//aTGRRn3afDuSIMjsoxyOGC4CUh0QgNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nI406MsRvYlUeq2YO+/6+HCG4dr5yz/OKN47+eL49jA7Ue4JBDfsqCsn+IIcoftGpiYBkJT/pitiYXDHqRupHJMU5WZQDMSMeYLJpbIbA8VvS8BOZDDcAePfPuQSPWy5NR8WoO23Ek7SS3+yKgGv28JA265rM0NhuELln/JArY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bRyKdhBZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hs/rfoJj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bRyKdhBZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hs/rfoJj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N8U5w024506
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 04:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tESaazAmAC3/7UHIJrVseF
	jWHzQg/FFGIHts0AhRnyE=; b=bRyKdhBZZm07WKWtxAYaRgGsa+8ynlhtzEbaTg
	3Aj8141kOAwRQP7rcENrvbLkMwOrDBRBLlqBBhVBcOlV0omgf+mcKGKNZsgKytoK
	bY8SquwbkTCoU508hcDS0pNrbUI22iQ+PPmQeLxtOnVklHJ8SmfGxiTWeFPal4bL
	rshHfj51081Eb88DatMmbz7XnrU8c/lIaBsoTiYQ4AHysYsrb72L9d1P8AfOY4XW
	yPVqOyu5G9yA/aJj0RGOlqCOLJ7d21P2DtNQztOGHe9Mer+Q/h1jlqMVn4zPS7hf
	k9qSZOWwzWbb+rRMauEjpSUle330yQk7A9S35x+0tUotd7FA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv4rtf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 04:14:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3883dc4ad23so337333a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 21:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783570494; x=1784175294; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tESaazAmAC3/7UHIJrVseFjWHzQg/FFGIHts0AhRnyE=;
        b=hs/rfoJjQxvGULXCkl6dxoGmC6Q+wXp07vdugrqIf8Rw7GOFjL1OJuk3M2hy7IC3SB
         CusZJTVcgtaY8FZieMLSnHvcxWr+sREytXXF6CGKu4QJ9R4E0FxvnHSRJtF9sh9GxEk+
         v9eq5VZq4V+TAofaWJYySg3lp8DkM/UtofXQPvVfAW15XT3y0xUoQIgPlz5vXJ1BvRyL
         XS3h4wPlW+aEDI+ZVPZObQwc93x+zL1gWBkCvl/FYGJ7Lt9Iqo+t0E/tH+ZLtxaa/yEj
         Z0p8yXcO22AhnrvmaZsLqob6kJ2yIj7cB0VCYBzjVT3YPWoiS8567ZWDxg2yAsjB/KNJ
         PFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783570494; x=1784175294;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tESaazAmAC3/7UHIJrVseFjWHzQg/FFGIHts0AhRnyE=;
        b=kBVjRWzNISd8Or/vcYrnLZ0FlwDCVXCO0oKN69U3F9Eush7COLSMMk6E6qxrbYpA1a
         R31wUEC3hDJji7WIuI0OkYAcTfVmiJjMnz5hFN57Wxf0Cj2A2TAijJkxDRaSquByaYuF
         n1Jr2DhaO6FRcbJhbfQ0hOUm9k6qe5uA5vQkDVETeTuW4mDsDSD2LBr3Ncr0c+mMSbKv
         AicClgNsj7R7NgAh5IHXc0ojlEwzdD2nhNk2/ElQQUb3uLmk2kRWTbU1vnk/XJ6re6JB
         A1oCmU4TV0dPCIxhz6FBuowjMRbbVQPJqvitTz4sPCDbUWn7fNaT3muIw5hINMUTawlV
         qWqg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5yvY1ZrHy4k3kkOOfc2QttHVxswUSVyT+WoTHYawVlcqJQ5cqtfUNIP9fSPI+tShO3IrnHz/5jJbGEoXc3d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVL2IkN3z7s0IqUHpUPmo1hbFdQjlF1FxBSsBfeMxnpk2ADfw1
	4HzoD0mAeyQsJ7fZaKz1jxikszBGyZCZMJChAX1EKE9ya4QsheimQ5BP4aabDl9VvYc0TjlTxA1
	e9up65hXIQQt0Iicx1fUb6m3/F6J6w4GiveAnh6JUwXnabQL/j7yENPgnj7J7bjdaVdqTAZMwjP
	qNPTk=
X-Gm-Gg: AfdE7cnoUhbz+NVIBqLWMRTLhPp5j4pUGunPCn2GawiFzZXQs5gOYCVRHhvG79DIp2V
	Gi7+KFvdegqvCKC3UGUxY/XyTcQF5vmWAcSbn6nyVg2ThjEzMILwrjkHOGCTIzdpHlran7uCX0l
	EmQjaeBohU65vSueFBgizjjbPnnPhj3NfFchlfIYxhYWo+S76XUnGXeX69vTigG16mbL+BEOHbd
	hZ6Gg1JQB7lU/5YJwwxQwySzFtgph+ibrHCEAy80bFpl7KmWAaX4DLSNPJ0SLfjJYE0HXlWgjVr
	iquStVhy/JVsdU1UHPdqMvTG6PJH6JOGe/OumUP5GjKWalwohl9WSd2pyop5lN8RI6iR/s3gjsD
	W3qQGS8lqzH7GRRDEWN401p1nDr+7y0kes3RL2btxR5QkF4jpUC/12L0qig==
X-Received: by 2002:a17:90b:4ad2:b0:381:16b0:55c5 with SMTP id 98e67ed59e1d1-38a1f1d49ecmr1869785a91.2.1783570494539;
        Wed, 08 Jul 2026 21:14:54 -0700 (PDT)
X-Received: by 2002:a17:90b:4ad2:b0:381:16b0:55c5 with SMTP id 98e67ed59e1d1-38a1f1d49ecmr1869765a91.2.1783570494087;
        Wed, 08 Jul 2026 21:14:54 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm26756837eec.16.2026.07.08.21.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:14:53 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 21:14:53 -0700
Subject: [PATCH] Bluetooth: coredump: Do not export hci_devcd_rx() and
 hci_devcd_timeout()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-unexport_symbol-v1-1-25c0f602a92b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADwgT2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3dK81IqC/KKS+OLK3KT8HF1zMxPLZJM0QwsTsxQloK6CotS0zAq
 widGxtbUASvw9UWEAAAA=
X-Change-ID: 20260708-unexport_symbol-7649c4f1846d
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4f203f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=M20hEUS8S0-SWzK_xzIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAzNiBTYWx0ZWRfXz3EuNqsE7mSY
 QdrhLP7F2xbXKtpM/nHW5oESg+2hr2zs4XEnMCblNqbGm2GtJM8JhzTJ9xGB3fLti2xuAOTzole
 v/JI6oA9qK1kJh+z5jUzwC+ses3nS44=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAzNiBTYWx0ZWRfXyaPi7fuHTGYk
 2PWo/no9oJpnrsjNvzca75ftnDjwawUobUKgYKeLvXWcCK3i6FsoaEBkpbgh/amj7yDZOXoqvuY
 AxT7CoU5merJ1C102uE8HJTCXuQlLaJRxDvllsvut3sOHoUf3S4HAp/k6tUXa5VQzl5XYFQDjOG
 0+VMP+Ws3ZcZzp2l8h3tQ9iUEfMHj73gZvOvZ6KT9n6UgTlWBGVTswRh5GUIyN1IIkttRmkGP8L
 FN46kCfKrN0DNSke/hB9AC3gHJKXnZ4a2Haq6LzVrGij14uPI0NvhdZ0fFOx4vlZmzcMZACfdLh
 lMU4fcYZikp8RF6mLO6O/DQzMXsLhob3cGh3mZfVYxc2UPZxNhPMZ1OtxgBHYaHM/3u3qA8h7y0
 2kx4yE/V1Jm8nPKD3AzQ5pnS2GcRbVyas1RVBPnQs+4GG4g3UudxkpO7U1GBu5Ax7gPgw9c0+bc
 Km0oUMYFvbWeR2nLS2g==
X-Proofpoint-ORIG-GUID: UHyJCWICSp_ymP26aNHaAa1SinSB8Tvg
X-Proofpoint-GUID: UHyJCWICSp_ymP26aNHaAa1SinSB8Tvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090036

Do not export both functions since they are only used internally
within the bluetooth module.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/coredump.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index 720cb79adf96..c0f027fab583 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -390,7 +390,6 @@ void hci_devcd_rx(struct work_struct *work)
 		hci_dev_unlock(hdev);
 	}
 }
-EXPORT_SYMBOL(hci_devcd_rx);
 
 void hci_devcd_timeout(struct work_struct *work)
 {
@@ -416,7 +415,6 @@ void hci_devcd_timeout(struct work_struct *work)
 
 	hci_dev_unlock(hdev);
 }
-EXPORT_SYMBOL(hci_devcd_timeout);
 
 int hci_devcd_register(struct hci_dev *hdev, coredump_t coredump,
 		       dmp_hdr_t dmp_hdr, notify_change_t notify_change)

---
base-commit: ca75417ab1793f23b3ddc91869f0809b593d6954
change-id: 20260708-unexport_symbol-7649c4f1846d

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

