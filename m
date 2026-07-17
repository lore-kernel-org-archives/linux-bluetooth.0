Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392E3BBFBA
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784326141; cv=none; b=XHUp0DL3GuXOuP8GwGRrLJkS+SgCxLW2Tg9z+pQb3UzKO2JlRAAI6ZyH4NRif7YibgrGlZbEjAVhRDVZMPxmgPpwyH2cGXsM1XBTbjZsO/5lVtCCJYVFw6laJF5Gd2Bxdz5XxdYyNVu36TDIyR8BPGbNA+2MdLt0u2VYatjs4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784326141; c=relaxed/simple;
	bh=8+GouPMF1VDvlAiTeKof0cun9qWLvAKw0z7JbnmEluU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HtCbwQfJ4Z+TbvJZQ41OsD3m5laawv9A1usxhJU0JY/FQpD1ToshcqfJ5tAwJAXP42xkziT1AvewjNaQHrWpzDR1XSovHlqLECf2Asy4dFxZSh3tDIXyjIwpcibGMZOO/1ncR08tZXm/zZ4zAPnWkb/NIBrQhH8wyGXTTM/RhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oECs7WE6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FfCtt+U/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oECs7WE6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FfCtt+U/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HJtLFQ2906068
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TUcfPg8Tf9XpNRoTHdVDgS
	INxpS92Ay1taGECboM5Ik=; b=oECs7WE6hvbNUsGkWq480sBarF2PxFNlBMURug
	m7tJUUvBDBpoxR48GqFabLK+Zyti4nYEsNjEL47oCITfUW1oU6LsJPRMFZlNUCOy
	Zf2Z41i4ld54va6KSeSyp4PdROyOUjSX3V61UIo4xSHUX8e5NQ1ihy2aVACtyfJG
	35EizBEXWJaGuFgD/O/UZ2fgEpppMN3Zjfmh16sV4yziCPeBHoC0xwMP7OCXtn9c
	78W57Y/6unRJo5b2KX14PvIbmWq/XYreTZqv3fX7METtIkeDckLxgKxlDiCbQE16
	z320r/YGLbtqX0ymg1HKJbuC+CRYtlcJGGrOY0n+zEYHidcQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrsq90dw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 22:08:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce756aa72eso38031905ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784326137; x=1784930937; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TUcfPg8Tf9XpNRoTHdVDgSINxpS92Ay1taGECboM5Ik=;
        b=FfCtt+U/1bdYu7r+xgprVC/IDHs8q069z6NR0taHOT0gWvYDwD3BfZl1eSBwAK27Fu
         NdUiFmtEQLN36ljGpWLiRS7YJqtjSq1NkQKycxhp0nXawSkRN5uKH3Mi6VggKII0EB/Z
         sd1mME39hGLWMKL5v44tlTjQiJ1ayF3Im/hGC/ENkJFlNBGsbCcrAZdElfoTeGLMmIsW
         iSOp6u0tTEljcRse08/2VrMvgNDHHaxin2dsQCR0uZS08QL5olwhmdn1S/YRKqJfgk0u
         7yOKujyrJTmYq0F7aGfUdJLhk84O+rRFOz2DdenjdCgUpju1fyj/w5ap9fIcfuWe7RmN
         5SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784326137; x=1784930937;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TUcfPg8Tf9XpNRoTHdVDgSINxpS92Ay1taGECboM5Ik=;
        b=spUMrxkVKisf70nklzbEDVVZ3hbOcifiacXTRglhKeW3oGP84xfsju8mVNV+K3rbX4
         8dLqH6hkhMqCQARGTtST6q3RJ1E4ZJZvfCmqLFH6ls/nJXzMdh/iBPt1uud8kd5PDl+0
         G8GhLfyoBWaHxzI+Rzwz5oZ2kgBpqiPNmxOBEzBJjQkttPbFmThFjoWPAexvopCtcQLa
         CzJ+dRuIezSUrYFJOWsXXJIk0WiiCa3i0np1KEXJ+XPnzlsmM/EqGpqZLhr82un6uOeq
         kcOwBchHOixeYUF1dLJ6JX6yWnz34xgKzziqcS3ozMdM0iDzLQ0HYyn2YkLHhAWLPDPT
         DgXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+MkczBdXNdL4aNwpMo2uiR+rRt8fIml9bisWlLfuajTEKI+ehfltMuUQdUbl9LxcqSJOB5xkFbKK/22eUrKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9F937gZ32ukj95XUBsYURTh5QNegJuGa/Pm2cYRuXU1khcNMu
	Le0oRhXG+zhN60QabNIgTcmHHocktUZSki+vfIPghAgJP5ZbQ8W5ERFEBMoNrnqer8IQIyfRT77
	zruebvfmW2/yylEFJy2CGEDVa6FRchfhKaVGVXZNHLU2MB1yTgsSrspzs638bumsNPQxU+UA=
X-Gm-Gg: AfdE7ckVwnW7qU4rscDsH+ttibijoqfNJa0f3bMGrWSte8zXANRn1dUUrIPvGCwcE+U
	Cn0tbdlXqytiz7uiiIctkGRTIjzepXgzV12kqK0pfFaKr6dktPGJOXd6ZBkxEeo5HfoT8chdHET
	aJ/R6FZrkuhgtVE4VbVgLXxH6jP6Td2QwRmRRh1KRBh5+c0aMJ7kMctRaUhduyhAAMQs5l36a6c
	Q6bpd2W3pwRm4ugTIzwodKByqvqpdmGHSiUKXW9oSF10xO5bZagswfAHzPgMB6+ofFVBH3bmfct
	FExanBJ3C98H8YPezsk2ScxfYatDi8bsvuvRs9gc3R9zRT376LvbAUm5cWhg8AseyAHTTblAz+F
	8K4DeWpLGRdRAPN3LM+6osL0DQG/tLYhWI4Fvn3w5M/1unfY=
X-Received: by 2002:a17:902:d58a:b0:2ca:d344:7752 with SMTP id d9443c01a7336-2cf34a8e0f8mr43219855ad.8.1784326137100;
        Fri, 17 Jul 2026 15:08:57 -0700 (PDT)
X-Received: by 2002:a17:902:d58a:b0:2ca:d344:7752 with SMTP id d9443c01a7336-2cf34a8e0f8mr43219665ad.8.1784326136659;
        Fri, 17 Jul 2026 15:08:56 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29c2dcdsm7668667c88.1.2026.07.17.15.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:08:56 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH 0/3] Bluetooth: Replace HCI_VENDOR_PKT usages with
 HCI_EV_VENDOR
Date: Fri, 17 Jul 2026 15:08:52 -0700
Message-Id: <20260717-fix_vendor-v1-0-f22263c1175b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPSnWmoC/x2MQQqAIBAAvxJ7TlARpb4SEaZr7UVDQQLx70nHY
 ZhpUDATFlinBhkrFUpxgJgncLeNFzLyg0FyqbkRhgV6j4rRp8x0UNwGdQq3CBjBk3HYf7btvX8
 Bsu0UXAAAAA==
X-Change-ID: 20260717-fix_vendor-6f40af4b1c91
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIyOSBTYWx0ZWRfXz3i/gqa4lUQq
 KDOxh5LMN7oqckRRNW1Wo/nYznauFEV84MTWGXnr+ofXLy3YnyzbWnsJKMqRGBi17XIsojXnl/r
 PRA+FYIcbwy7qmXLaR9JRxuXCRJaRY4=
X-Proofpoint-ORIG-GUID: U2agpGcJcT64tsFtjZxYdeQv2tYPvN6F
X-Proofpoint-GUID: U2agpGcJcT64tsFtjZxYdeQv2tYPvN6F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIyOSBTYWx0ZWRfX+8HCfz7Qr6Mf
 dqcgb0uNHyljgGAo0pMFIrwujrNDvC3/milrtm+C/U/zb7B12wbwfhc0TK3bSyaMRlJx6AmnazD
 Ti2vs5GWwAVKuC4+X4Fuc82jZk/lKUj9pVFc/lKJTvk1HUZRz2Q6JlsboPykyq0quXC8yaU/6bD
 aZZHT0d06Zgu5XVXC4rnTknYP2ds9Jk9bQDxYbRIsmLGNdliGywm15tDyeVRySkpPlA/nQHE2Cz
 P6xh6uuwbKURcg8FxTtYfxV4CzdQydC+pBVUoUTKxXdd8s6FGUtRTAsc0BfO2Kl6Xmg32pJTKmC
 ioZgD06QA/vBMHDXRbLTxkA4WAKNnBSEWKJgXW/GuoqT9vPhh4j7Gd7rm0Xmp5MlSiQc9UnbX+9
 EBaZdRR+3dBvEkgR8bjXYKUYVObKFbFmcFTVoRkLGCk2r3weXAafZYJk3DMurMsX+qOfglnxKfe
 BrvAflt/xNxydZMvgFw==
X-Authority-Analysis: v=2.4 cv=OJIXGyaB c=1 sm=1 tr=0 ts=6a5aa7fa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=CZ8YEtngXVOhdemIcwQA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170229

The macros below have different meanings even though they share the
same value 0xff:

 HCI_VENDOR_PKT: HCI packet indicator or type
 HCI_EV_VENDOR:  event code of a VSE

several usage of HCI_VENDOR_PKT is wrongly checking an event code.

Fix by using HCI_EV_VENDOR for event code.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Zijun Hu (3):
      Bluetooth: hci_qca: Replace HCI_VENDOR_PKT usage with HCI_EV_VENDOR
      Bluetooth: btusb: QCA: Replace HCI_VENDOR_PKT usages with HCI_EV_VENDOR
      Bluetooth: btusb: Realtek: Replace HCI_VENDOR_PKT usage with HCI_EV_VENDOR

 drivers/bluetooth/btusb.c   | 6 +++---
 drivers/bluetooth/hci_qca.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: bd8bee79e1fa8db2d587733f8b6fd9597b04d6e3
change-id: 20260717-fix_vendor-6f40af4b1c91

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

