Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080E4BD0EA
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446860; cv=none; b=ETwlPxrZyJDuHaOTFLwfR3E0PbylmVLhWfBJty1I+SeDVUlyVfL25qE5VAsWqDJsDJjelJTXBvvnICEJ7u561a/VH6RcxB6p/WBmhLX4zxDn4LUeYGnqPlnSnd9hO/1oHt9ZcKgqUUAivOo6ka/7jSGlM8WTwDe+tDxYqn6AIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446860; c=relaxed/simple;
	bh=sqW75DqQe6cS50dUtAMa+hqUW0hi/MzNQckd+wLmVXw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mN2UqQfbbGocQxL/E7CezjP7SSOGz63AAHChCr9pJi8EyRu+8UX0SasANum32oDby/rljaa3I2nzWq3vgpS8Nhw5jT+dHOfpJNUXSxDsVCiSBsDDSSjzuOrgvFjae5plOVXjV3vf+4K3f7yZa9SlMwZr4BghnpdByNDaiVt6X+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RIqMbTN+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TQPuOloy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RIqMbTN+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TQPuOloy"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DAPob1040602
	for <linux-bluetooth@vger.kernel.org>; Thu, 3 Sep 2026 14:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3N17qA18FgGW3zEmXJwdfd
	pABRJJiCXPz2tCM03URs8=; b=RIqMbTN+OYj2qG7t6Sq1Wdf4kFxOak7WoGPN4O
	V0pcQXyJZYJoHXsWq0/Z0Yf8sf346cyNyTl3sK3DaAseepOowCY7NCKpaQM8MsNe
	fYonduFOPFh2Zo3bV2Mop/U35GpLEBSJy06X1x4txrX7wGaAQYRwskcyv+S0JFze
	sWw4JyFW4vdiEYthWqJFchM44imCreu9C9KdXdOxAT0HU7k3Wdw1OcIG6dZfK2H6
	eO2ax+wKP5mp/pukUNfSzipkfo/xoItGRN6A8WhmfDYTwlVsMS180AAHwx/eXEIY
	q9uKR6cJxT3if4R9UzGkib3JQL/wHCayTsSlhWpcYQDZI91g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4japc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 14:47:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-399315379fcso518001a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788446856; x=1789051656; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3N17qA18FgGW3zEmXJwdfdpABRJJiCXPz2tCM03URs8=;
        b=TQPuOloyOXgYxx9XzhCllm8z5EuEU7Pz4UHd07w8d93Q05o+ug2NQjnkSxWfDrYiDO
         hDmfYA0NakJl4SK6GAVBMb7zBXg3+qfXTqBeB1MxA1Ni+nkjnBT1HX1bMZCsM6hOpFZY
         uIIJt8r9gFi/nA85vz4sZ01xE/xKMApFjkC7B2IedG7JKAzyHMLKWc0OKizUOawkVbP5
         dxxUVRFUIHiMYN0uDacTzaFs0LY65d2oJEaNO+kLK8QvrK3MRZ65jxS+PRA5//jYIk2V
         3s4cA7VP2OeiYtCajo74viVk8yO7095HS9BHuDyDTBvy996OcoU1DarK09sQqTIaCRYh
         UhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446856; x=1789051656;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3N17qA18FgGW3zEmXJwdfdpABRJJiCXPz2tCM03URs8=;
        b=OyTXHfDHau0T69PBNIlbP3ocZGX5/5HSqvsldsSepJhzFYkVxJzyrmqzsiby4f1OEG
         ldRDSvods5INt85GUEs6L8XwWvHc8Ff9E1o5UJqLMGxOMJ/2r40jI1uP8I1vA7Y/bL8J
         vuDnTsPpncEv4gg1iYXtMEz9QpKzVYdVUZfoHXlFJcJasHSNkuyfjiK+LhlG2x8UNpNB
         iTRDWeNc9RwWcXITja33mPdY9naFoGSbbBjrI+KccKrSjrltWqdAgtA6Zo4znji9ZygX
         SUAgqU4GGsTLRAk1I/0sgT2nBagwPR+6erejKp3gURgGrZhhADvnd2URjCrmn6xxq6Zo
         tAuQ==
X-Forwarded-Encrypted: i=1; AKwUvByxSnw8SJ8b7fL2HAq1BxE+MRs7jqzWcLImsM0OtEi0JPvQJWB+0pmg9TeEdRWPR2luFrOSDuZDKHRbF0xlCHo=@vger.kernel.org
X-Gm-Message-State: AFuF++k+3cc7Ma7pE3n48en4LEV8RCBPBiS0TBRa2P4cKynXBj5FRvfz
	TC2z+JU2CPJfjrOt/xOICW+90A7VBi0ktM2hPvbVU1TpKOg2tXcB0Vj8ZJxaBdZMgZGWiX5QMBK
	XjDbhEX029ylRopGzgYj0MIBZgAXnWPqQN0o0g3KkQfplw1GunkbTBbCDfvGupz6iUuuUYdk=
X-Gm-Gg: AYBFou0E9hIJxHaBPAnT75lHp+yUtbWnQpFHCpZFiixccAq3dfBbXTZu32bez/F7uTv
	Se9BP43p//TqSN5cQsnUaqtZl8/1Yxby5HH5yaRdu1Za2M66XgaQDbynHnsa19dbeESJUhsIhqk
	S7RwobElZRWiuqdHobjQJ632/lMd1FAPmEZwvwTjFiZMshWMN0tbXlEpHaSMvh0j6B9CCKBwUWO
	2WXyWfdPaYoSY4I4fHYZgwIYKjhpoJ/Zydkgu3E8wjINWo0Pl1K0YsYJRdO3soyIntLOTTgE4PM
	3gKzeIV+JAA+7Aq6Vlsb9w/mtFPL72IGuVaDTdkVQxv/NsVCypBEcPdyZDXltPaRLv27QzlbY4e
	QvAjrQQEhQKXybzZdJUeULnzWdIQNOUPHpcSt5tR46lcPRPs=
X-Received: by 2002:a17:90b:3841:b0:398:bac0:238e with SMTP id 98e67ed59e1d1-39aee24957amr12445025a91.6.1788446855950;
        Thu, 03 Sep 2026 07:47:35 -0700 (PDT)
X-Received: by 2002:a17:90b:3841:b0:398:bac0:238e with SMTP id 98e67ed59e1d1-39aee24957amr12444975a91.6.1788446855426;
        Thu, 03 Sep 2026 07:47:35 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm25794c88.11.2026.09.03.07.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:47:34 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 0/4] BlueZ: Support vendor packets
Date: Thu, 03 Sep 2026 07:47:12 -0700
Message-Id: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCImWoC/23N3wqCMBQG8FeRXTfZH3RbV9FjFBFzm7lQV5uOQ
 nz3pl1E4M2B7/Cd35lAMN6aAPbZBLyJNljXp0B3GVCN7G8GWp0yIIiUiGEBo+m189dGWYg5r1V
 BhWaSg3Tw8Ka2rxU7g2M7mhO4fNdhrO5GDQu0FBsbBuff69OI1/qWHzFEUNdEqkIWCGN2cCHkz
 1G2ynVdnsbqR/ITOEV/AkmCEIiyEomCyWpDmOf5A6tXH0UGAQAA
X-Change-ID: 20260719-vendor_hci-188fc539d7a8
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a998889 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=qgPclA31fA7-HnSu8dwA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: aO6y5R9nHCKl1EzKyiPYn0yTfP1kP330
X-Proofpoint-ORIG-GUID: aO6y5R9nHCKl1EzKyiPYn0yTfP1kP330
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyOCBTYWx0ZWRfX0LCsay7LD2rZ
 rmXdMFc0vIVSVx65/axn4HlrO+gEqhHhledps0pQ6rq4empu8nyo+JMQP6Cu2OgAhjjTNHTdwrY
 dxK3TAem0pjrMe9NenGVbHVu/pb1Kxw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyOCBTYWx0ZWRfX0P8mKjgjJczt
 9oL903L+xYgP9I/U+yFA+crFiruOqlkXtdRCAdG/mySkdGsfxqhRQutlhxlHd4tejTsmPrdSoZU
 dvFFYL4EyGbxd1yNI6elD7LDDkBJTqg/AoWL3R5d7PTAUCObmeveOPnFLNNwNKuAXeMafIQeIL/
 Zibci5PpembZqRoMjWOlHoAa0ff4dRpL39rjyoBEjPVmby/IQ5Me7yemfQ6FjYLGr7e+b+4YDvs
 Fc4a6yHJCQ2pvErQ0tUXko0mUEnRRyeIQhAT0qq8/Q2Ilml11ELZffy/zyFiPfSjcSosRavOe1f
 cYxl/ZXMgFY/iSb7J76mY4xQs+eVQDkG5a2QA+DKOMw/VKniWICw+W4W7qkzxHSlRMZ8+ogeD80
 wh81NZWqpLZODNPMPQkYFHIgkfxpDHySJ6YEREoir9VU1bPGGK88GSjqEL8qjEcJrWAuMK6uTlC
 v8pt4AzoHktWnVNKTIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030128

This series adds userspace support for vendor packets, which use
0xff as their packet type, complementing the kernel change here:

https://lore.kernel.org/all/20260830-btusb_qcc2072-v2-2-5c0e0c9dd98b@oss.qualcomm.com

All commits are straightforward.

---
Changes in v3:
- New patch: s/vendor_(evt|event)/\1_vendor/ for monitor
- Improve naming for consistency (no functional change)
- Improve the commit title and message
- Link to v2: https://patch.msgid.link/20260830-vendor_hci-v2-0-9903760957ab@oss.qualcomm.com

Changes in v2:
- Rename BT_RCV_VENDOR_PKT to BT_RECV_VENDOR_PKT
- Improve the commit title and message 
- Link to v1: https://patch.msgid.link/20260719-vendor_hci-v1-0-df2ac5a50117@oss.qualcomm.com

---
Zijun Hu (4):
      doc/hci-protocol: Fix missing & on mtu argument in BT_RCVMTU example
      monitor: s/vendor_(evt|event)/\1_vendor/
      doc/hci-protocol: Add BT_RECV_VENDOR_PKT socket option for HCI_CHANNEL_USER
      monitor: Support vendor packets

 doc/btsnoop-protocol.rst |  8 ++++++++
 doc/hci-protocol.rst     | 20 +++++++++++++++++++-
 monitor/analyze.c        | 23 +++++++++++++++++++++++
 monitor/broadcom.c       | 10 +++++-----
 monitor/broadcom.h       |  4 ++--
 monitor/intel.c          | 16 ++++++++--------
 monitor/intel.h          |  4 ++--
 monitor/msft.c           |  6 +++---
 monitor/msft.h           |  4 ++--
 monitor/packet.c         | 46 ++++++++++++++++++++++++++++++++++++----------
 monitor/packet.h         |  2 ++
 monitor/vendor.c         |  2 +-
 monitor/vendor.h         |  4 ++--
 src/shared/btsnoop.h     |  2 ++
 14 files changed, 115 insertions(+), 36 deletions(-)
---
base-commit: e8141342284be2a52e16565b96b513ebe1297d84
change-id: 20260719-vendor_hci-188fc539d7a8

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

