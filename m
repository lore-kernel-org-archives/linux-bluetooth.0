Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3B3AB466
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944075; cv=none; b=HJNCi0kfdPZJHsEfeZTay1CgQ/EBhAwKEVpIC0KxEMUKbL9ynH62ddHnxb/nlj0eVk6oENCkMgwB82EbD7CGHc3PfBUleGG+lokffaSoO6ww4O1EWQivld+WeZij549Lueljhwbqo29t7S2XJyYMVs6OXp32UKg0Swz3j6WxXwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944075; c=relaxed/simple;
	bh=tF9fd3UjK1PVSsOj/ohqWzHHVZn/JPV8yJ14lEpyf6g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i+bQAhyQeRXYYtNj96SF0+4t2kwV4JOLH+YYj/GtP0MKJ6127NX8U0/Ip8u071bNlu2sHjuU6Uf8iRwsR0NtcXMeVZzCHddJF1EZxRLj2BJLsSHPzpxO2ADvALfiT0yqmY0pw2uyryTuUfhDewSBDce6Ztu5MMJxMHm6X7XEmZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U9yAtphv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aef+TfTF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U9yAtphv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aef+TfTF"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DB81nb732256
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Mwv1SqRAcBEIvcDZDzz4XN
	2GOGxiSMVe+emapfWsTYU=; b=U9yAtphv2JTwBE/Tt8XdI/36KBbZfth/IHu3sf
	PB7piq6NANW6f/q0IAYB++ZVbysJcl9asjFqdyOCTozMBFIV7TrLCErsMOvpEHmm
	hD8ss+yUNUWFVzIJUIn99jmSH0XaQ3qfNgQ9vsoXBPeZTqzxl7HIwaDlbyxOug9X
	pLIdafppcKYoKlgrt2ooRkobYhkWYPIM2KHQsu2zUwooRfa/EjMVuzmGRQu5twtx
	k5F342Kxe1SzJ8Z7O1IE3xTUj3tUx4O1vfArhkDZZePwYl3sqcYOD4nmFxlbG5qY
	Wptz5oT0ZfYKCQ+D9MW5y2bwrmO/fLR2uOgqUl56MO3PLssQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn3acpq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:13 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9e5aba3d80so302146a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783944073; x=1784548873; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mwv1SqRAcBEIvcDZDzz4XN2GOGxiSMVe+emapfWsTYU=;
        b=aef+TfTFO3MuyKbavhBgFVOoDdm5OiXNbvi4ItyaFUoLhKT6WCR/UprMTanzcg0/pM
         DG1Nr2QomGmqwIHewm1Yl+rquMT2E8vY7G3fDTcPTX80vZXEmV3M4JYrNcgieB5+6CSh
         ZKRHyLgf4qcyhnT8T9yKAuNjMimN5cG1G6u7wW0vva9ncK74bkmepS1IIh0uVLRJmiYY
         YhKkVvEzfsPnBtqb6fUeUiWi72d+V/txO1C2nUIkj9vg96S5qaOhCN7DADtJyo/1Gn+/
         8f6r96YVJskiMV6vzQ9I1cUyM1S9TpCQXCBKMg3tYP8nSIYRhghVya5DKESlFUdP5XCg
         mcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944073; x=1784548873;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mwv1SqRAcBEIvcDZDzz4XN2GOGxiSMVe+emapfWsTYU=;
        b=BpJfGH26rLLdbKEFAR3BewSJt5E+mrJV7JOQ2lNL8e2QabHKtnUnGmdl1Wpv7jjNh2
         50EOr2C2tySsUJgb4l+hI3pOHIRVf9bHwHiNqXKUS+R+FZYLGXxdaxiQmo+WFVurC5CM
         Pgxuu9dXmwM0PjhEGFf1WHj0ViQg2XLY0jq7xAxaahmuONh+WDO2gqyOytbM2z0/G+vV
         vdAS8qDfvY1Rg3FuQL0HtrUOmszFDD56pnhiKWNaInesNLK4y8mvnUDvlqWMMiHuH8oD
         pdbwVctUErW2swAXDlLKNzWzWlQvmrxM9D2xd3JRElqwtuU4k2Vax6Y3VVGC+3fYPrX3
         PO1w==
X-Forwarded-Encrypted: i=1; AHgh+Rq/4cvpzpZtM1ZYL8KDTFaoVsF+vQZIWMvSEfBjbPTma4SUgm7MnOrJFXyBuRFBvzlO1PEwWH20UM9k3MRzbOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PNsBFPymbQOQ2eIbwvwyBznAZl/QqtB7vUPOlX1pr0qkkXuc
	b4w0LKMIjOD4wySW3L6nABGX3JJPX5RQL+1xhHooLvXkkedbuhHjNi9rI2Pgaahi0ttXD291x1f
	DfE6BS33HowGDJplkub8/AKJV8toqoH7Nn8dUiOlvOh8OlZUbEDfik1jAkKdMq9eR/OoCcsY/zB
	L5MSvDr3vr
X-Gm-Gg: AfdE7clcNgjo6HICOvYIwASQK4O5IqATtRq2np3wDu6d1dLDydHnQNQ7K7dVdANOMcO
	C4y1xK13x6UvEGb4rty8rC+wj1pxUW6nWSzrne8xwGz97aAuYP2Zms+ikeyZqV+W3QgsooxqDw0
	E+krqacqag7Qhi+qGVuj9ZlldZv3gdHZWKpTkZF4F8hQlysMUGmPsQ5hbWaSdUzTdIQn8LfR/mO
	QbqxPOCIAV3iTXL8T4oixKo1pueyA+tl91dEaCWU9Kbt4b7eKms8kufq5YnfFuumedqvGhAezZM
	1AFbQiVLMxLIFk/zl4XI3v10ha6RnZaVjLd9GxSsE8i/0dgGSTDQ8l4pOxDbew+lTUFVtOsaDu4
	WrooTwQtgKeDKCdR9nHLCLHPAhGZM5AORSggfVIs4Ai5uI5DJJwnzayyw0w==
X-Received: by 2002:a17:90b:2d4e:b0:368:b002:bdad with SMTP id 98e67ed59e1d1-38dc779df28mr6267149a91.5.1783944073100;
        Mon, 13 Jul 2026 05:01:13 -0700 (PDT)
X-Received: by 2002:a17:90b:2d4e:b0:368:b002:bdad with SMTP id 98e67ed59e1d1-38dc779df28mr6267126a91.5.1783944072575;
        Mon, 13 Jul 2026 05:01:12 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm74577772eec.31.2026.07.13.05.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:01:11 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v2 0/5] Bluetooth: btusb: Preparation for upcoming Qualcomm
 QCC2072 support
Date: Mon, 13 Jul 2026 05:01:10 -0700
Message-Id: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIbTVGoC/32NQQqDMBREryJ/3chPtBq66j2KiCaxBqrRfA0tk
 rs39QDdDLwZZuYAMt4aglt2gDfBknVzAnHJQI3d/DTM6sQgUFRYo2T9tlPfLt4s7aqUwFowUVR
 YdqWRXHNIxRQO9n2OPprEo6XN+c/5EfjP/TsXOEOmZXHtuawHjfzuiPJ1717KTVOeBJoY4xdVx
 lQzuwAAAA==
X-Change-ID: 20260708-btusb_prep_qcc2072-23604a4e81d1
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfXy/sOLGdXGRLH
 cEDEv/DyB2FsKI85peu5du1jRxADETsYgOtjdxnQar6JxE+/nM3DEeKDS+zpEFfb6q/o8Wwar/R
 F+iyZkuZE3ZnwgRhFD3a27L+BBdsQzh+DOVp3SwJntQG6zQpQfmkOJJpuv7VZqEfciRzxf1VZY4
 gcyJ7B9vYPZVi0IFMjI4GNseK+hVfFwuV7nprbClSXkN2Ssifxw/yLoxPGmifcpRoUblfe5OsIn
 WqzAsc13S9Kcn35Oc5Rry7F986Fntt6A7sTi/L7uXnTBvnVT5FUIyux8YSXRY9iZ5SUfMGKtnEn
 Wm7jpSUz+sVHtHXWb8+20Jsz+5ONJwqJBW3Hk0LFhqv11+8ZQGQ4mGcN+xlUekdW2nQNZXARQsp
 jOszt3qulFSH9/j7UsSIFSQz3OkVPdAv8amZe60AeBKoXIWm/Vtc5Qor07tZtyW1mF29Uf8600+
 mnOtzMNovdSSgvqqBTw==
X-Proofpoint-ORIG-GUID: Ak87UwvZb4yGyi43TwhqbWMfeJWwOjaA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX8ACrmr6xjY/6
 a98sym10ANwy4KpAIqni+an3on02HgIrtKMX5IDxihMwtJCD31kkO5k8ekFIWILrKyAYu0FUv05
 J160fg+o2jcLzi7BH8H1gLS5HsYaJGw=
X-Proofpoint-GUID: Ak87UwvZb4yGyi43TwhqbWMfeJWwOjaA
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a54d389 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fX2O4PyAtUFG-oHw_bcA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130125

This series collects the btusb and devcoredump changes required by the
upcoming Qualcomm QCC2072 support.

Posting them as a standalone series because the QCC2072 driver itself is
larger and will take longer to review. These prerequisites are small and
self-contained, so they can hopefully be reviewed and merged on their own
in the meantime.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Changes in v2:
- btusb: drop "Build the driver from multiple source files"; the split
  into btusb_main.c needs more discussion and will be sent separately
- coredump: implement hci_devcd_state_name() with a switch returning
  "Unknown" for out-of-range states, instead of an array lookup
- btusb: make btusb_recv_{event,acl}() take struct hci_dev * directly,
  instead of adding separate btusb_recv_{event,acl}_hdev() wrappers
- Link to v1: https://lore.kernel.org/r/20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com

---
Zijun Hu (5):
      Bluetooth: coredump: Introduce and apply hci_devcd_state_name()
      Bluetooth: coredump: Allow drivers to pad dump header to fixed size
      Bluetooth: btusb: Add an indirect recv_intr() hook to btusb_data
      Bluetooth: btusb: Make btusb_recv_{event,acl}() take struct hci_dev *
      Bluetooth: btusb: Add a simple static btusb_prepare_reset()

 drivers/bluetooth/btusb.c        | 33 +++++++++++++++++--------
 include/net/bluetooth/coredump.h | 11 +++++++++
 net/bluetooth/coredump.c         | 52 ++++++++++++++++++++++++++++++----------
 3 files changed, 74 insertions(+), 22 deletions(-)
---
base-commit: eab19cb7618e5c50fd1f8c1efdc4e66e16575975
change-id: 20260708-btusb_prep_qcc2072-23604a4e81d1

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

