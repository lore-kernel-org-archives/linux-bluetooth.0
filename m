Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193B1439F8B
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737476; cv=none; b=GBAiBVw49PEOvE5N+6AI/1kpahpKWEQ+zQzBedicXCQtP5AgD/9GqRoex26VhhnlIOU+3daUOMjyJUL8hESpmAs5u21R3gGjWzHvcELQbEs3UWiitX0e5iGtPE5W8LfqGlgyWt1Qe/wimrXBQYtT0WprhKayMvb44FqENRCOxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737476; c=relaxed/simple;
	bh=5cIVrihx7euKot3Q7K/5/3gv7tcNv8bV/p5MlAFoBFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=db5qEvOaiFxhShw9gHncSheLAmDvNiPjel78jnpIt9MpXt+Sb/Vp22MiT5DbUbzU2yo9QRtfNHoMs1PMjI+FLeACFep0zUM/JNaq881sgHTgTBgQjxEP9KgQJFN6CWExlcd2keKC/GHv+aU6bxVIhiAXP+HJSJvHKfULza91/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GcwDpGTb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fBOohFgv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GcwDpGTb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fBOohFgv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFY1fA1176150
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cHA/EFB8clJCKscXcpvXdt
	OqD1pZyt7d3DX3Z268AxE=; b=GcwDpGTbx+K9ge5XFMiaG3kdTevZQsOXL1XEt7
	/GM01H6UCT3mxuV6408GjbLE7Uta1qaD1GKv6yOBoK0yEwGIk3SZL4hC+E6kv6TW
	alwo7mRkqdYNGkcGxv1JP7687e3T5fqMIE/xKo1YzW2ZqbQyP7VnHVVC3ArW9m/d
	oYrvYH39lIZeKWlK3Q2KDb8aFeHD3/wZsLRQ9C/DdcuabcK7HmdloznE1o30WMBz
	ZhXA4CNxWPZ8knQ5+fKXjWnKT3WJlC7ICZoc+eFNU4OLKHNF4Gao/6/MhB8s/rBO
	hcoav7kvR1Qnudoeokm4UuLocFo1GY/3r2/HPjwQXzrdxg8g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxm10veb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc98d6a88bso111795ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784737472; x=1785342272; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cHA/EFB8clJCKscXcpvXdtOqD1pZyt7d3DX3Z268AxE=;
        b=fBOohFgvk6Wmzn49uQlKJlT7415CUJLLhbH7o8N57c7atz5EaIktASU5zPeQvdVbF7
         rzXjtQpwosGTfyq85X6CSjxMwjIyTkE56RxEodJY8fKbmQ8v1xtiFk7TIre5luc66X6y
         0nYpgi9mGir4EDAAT50OU9LprlQ2iPuIJSA5Vx0wkOvjoqgfLh5Whq/oQGE1ciyjmAsN
         g+o9szXmFJ1Z7/sHPvHjG6L/WsJO7/+URmzGw8oW+Cv219//ppFyZ1nFBzL/ck+JnKwE
         QpUWNECU90fGYeCWj065SDpQI33lgY5J5e97H/V4LjJWU+zrsXgXTU0Og7xAcr3mrwbd
         jBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737472; x=1785342272;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cHA/EFB8clJCKscXcpvXdtOqD1pZyt7d3DX3Z268AxE=;
        b=qwbfmmjYDcfDjTNrfKyBmB8sYxAMN0LeJertH1lyC0xsMx2AeKtJOWoi+whI8QVAt1
         buIfHiPCLiAoSpVP4aRcxG/qYg/IU/JsIN74CLbevsgvauPHFnGNM4aWzxttBdoYaO2U
         utxV2M5DqT1iTv8plQf9FJwmrtrwCjRsB79PgPaHRI5dZ24reegU2hGlddI11NdKTVjC
         w4evooYwYmDPoDwm6QzKkJkkrYcfoFpBFlodqN4s048dcRP29TkxDrBrkVC4DW8MSLU4
         9V1pV899RqsOm3Qe/QabYPC+roPpzdwffLDTXc5vVLa/bJ7iOc+qvsxJTl+Z8X/MVV+d
         5Q3g==
X-Forwarded-Encrypted: i=1; AHgh+RpUTJGxxMAMfxJEjpimMokqYhqwlCT4BXhaPrdtW9/y8gKNSJR6uI0dQno3zJpl7HbBiBZH46W47beSRK4BTrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+kWDVRRwmLHpqVr04I1Hiut07nI9MtfAtFXeVvg57PkeBuxLt
	/odddB1Vrdf//PE7Oj8AxR1fRx9KZwcVnDO44aRC24gnvUXV5IN/rQ/4ti2Ib4kYoUC7rPWMbq5
	Ztn0Wb8HC7AiEhvructtNeGEYA/hTNk5odsymsAbolfaueRclQrde0N6xUH8x6Y5TajLu+KI=
X-Gm-Gg: AR+sD10IDDGu/sLWLjqJHVP63H+3BccqCmxMFCIuOzJ1gMV9NZzE0m3TmI7DE1K3VRS
	C5O1G5RpoOmt5JVqJU6Cls7VEnNEgKnYcE7CiXMYe8UNEF9JEDtKHkEEp37sZd/X9biEvumcwd3
	pH7abBRP/lp6BYobajAtqsW53b3ApWr/YcA4IibHIB/u3bTG/5nQHNiFGy35LyWOt7rR0RAf+W7
	gTnM1oSqLTM9pVNttqv4ZImY88wvb0465HEVX9PyWDnBpwF5QlEiptEwa/DM+RdHoXvEldrmT31
	5KetM+IO27fEIY6nZWohFiIbjxQQUNkSt1KO5L7qA5iDKRACUrEGyBORdB7lySYliZ0DDWyoa+W
	nbMJrYmds3zH7G1G6vRTt97bvvGs6Af3ih8KCWXt32DSnXNQ=
X-Received: by 2002:a17:903:910:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2cf802b31e1mr73357275ad.1.1784737472609;
        Wed, 22 Jul 2026 09:24:32 -0700 (PDT)
X-Received: by 2002:a17:903:910:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2cf802b31e1mr73357035ad.1.1784737472225;
        Wed, 22 Jul 2026 09:24:32 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc9d932sm10569970eec.12.2026.07.22.09.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:24:31 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH RFC v2 0/3] Bluetooth: Add generic support for vendor HCI
 frames
Date: Wed, 22 Jul 2026 09:24:19 -0700
Message-Id: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALPuYGoC/31QTW+EIBD9K4Zz2YiggKcmTfYH7LUxBmSobLvig
 tptNv73otsmPfUyyZu8eR9zRxGCg4jq7I4CLC46PyRQPGWo69XwBtiZhFGRF1XOicRxHkcfpna
 BwfjQ9p3DxGrNGJNKC0DpcAxg3W0XfUWn4wtqHss46zN00ya30XoXJx++duuF7OT/XBaCCeYVK
 wuqWKeoefYxHq6z+uj85XJIAzXrwyjAdU5Npp8IWkXAG8lNdaaN0ABcArFKGF2YUnBOqRW6ska
 WkuucmQoo+vuB9JDfZKnZFqcNt/bTh3dsc2oMk0aAFXWq0azrNz+Z50xVAQAA
X-Change-ID: 20260719-support_vendor_hci-1fbb4449ab8e
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2MSBTYWx0ZWRfX31uHpt/a3hly
 v7HCyPY/akO21w8c37T72nuSoxpxVNiXzpjQfupUs85QTKURQTE157fRHNN4vKWrabFZZHD5avh
 FYiMm9Q+qn79oKKresK5B1TKCcrZLG0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2MSBTYWx0ZWRfX5y3xe6TNkXmA
 LIJOtF1nH2KgRIezL0+naDVS9Ni432xT1zxSbRFPVNRJr3Z1wwxX2TNfn1C+++UFwaMn6549N6v
 YnRpW8Omf3McIsw8OvaOYRX1nOI3bcI12i0QBXmHadcoCw9byRkkCMpoeaRo7HQFSlBl26o+DVV
 fYHDBJuAIK8x6PT1M0xHy6fk3cc3pZOZW45/FW7RlvSUXW0wCs3GY0rHC7ZYPfuIeIa21DhS7mT
 wxl4DgH9t0TM4K7Ebf2bTJS96Jxp/1CONDFLvMkAVttGs44IwRp+6n+k2DvK0MDj3WlRS0Cvq9m
 7pkSt1cTdW78ZvfJA18eHLSRSgb7MaNbs0YUSSXWxPO2TWHZ4BuIA/96fFkye3L9QxLF149F/hZ
 KGiTK5K3FCo4aHiEVHcephjVPqQ6CJj7FKUvuPWrb45V/GJ3pwM6IH+B93oeMJZP7+Bcyky/BXX
 Hp9HwXEZlyn2Ar1nXCA==
X-Authority-Analysis: v=2.4 cv=Rsv16imK c=1 sm=1 tr=0 ts=6a60eec1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=bC-a23v3AAAA:8
 a=Dei6p5SHAAAA:8 a=v3ZZPjhaAAAA:8 a=a_YJ_5-yhVYmTuO7ZFQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22 a=M-Yerj1wOn-OpK7r_3ei:22
X-Proofpoint-GUID: I6o6s3t0YNrof5LYPbrO-D5buEDhMZR5
X-Proofpoint-ORIG-GUID: I6o6s3t0YNrof5LYPbrO-D5buEDhMZR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220161

Hi Luiz
To address the below concerns you raised on previous
discussion.

- Not use safer skb helper like skb_pull_data()
- It will skip sending to the monitor, making debugging much harder

Looking forward to your further comments.

Previous discussion link:
https://lore.kernel.org/all/f9bbf92f-d617-468b-a5b4-2367a1d9a751@oss.qualcomm.com
https://lore.kernel.org/all/CABBYNZJpdeoZ16bObLRPhng2dfyNeK9ix9_-z_hMZhJ0QxTxGg@mail.gmail.com
https://lore.kernel.org/all/CABBYNZJ0zoVVVxuM48L=Km==gnrQuskrbjB6q_aNV0KEEY3+5w@mail.gmail.com

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Changes in v2:
- Implement vendor HCI frames using HCI_VENDOR_PKT (Option A)
- Add recv_vendor_pkt() hook for drivers to handle vendor frames
- Link to v1: https://patch.msgid.link/20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com

To: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Zijun Hu (3):
      Bluetooth: btmrvl_sdio: Do not free HCI_VENDOR_PKT frame by hci_recv_frame()
      Bluetooth: Add generic support for vendor HCI frames using HCI_VENDOR_PKT
      Bluetooth: Add hdev->recv_bt_vendor() to handle BT vendor frames

 drivers/bluetooth/btmrvl_sdio.c   |  2 +-
 include/net/bluetooth/bluetooth.h |  2 ++
 include/net/bluetooth/hci.h       |  1 +
 include/net/bluetooth/hci_core.h  |  7 ++++
 include/net/bluetooth/hci_mon.h   |  2 ++
 net/bluetooth/hci_core.c          | 71 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c         |  5 +++
 net/bluetooth/hci_sock.c          | 53 ++++++++++++++++++++++++++---
 8 files changed, 137 insertions(+), 6 deletions(-)
---
base-commit: bd8bee79e1fa8db2d587733f8b6fd9597b04d6e3
change-id: 20260719-support_vendor_hci-1fbb4449ab8e
prerequisite-change-id: 20260719-fix_hci_rx_work-f03dd49d8ef8:v1
prerequisite-patch-id: cdf6a14522201fa54cbe21392b7445544c24a977

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>

