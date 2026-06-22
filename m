Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0C3148D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139947; cv=none; b=pt1usmXdLeQRrUt5mY33Xf0v12d3m2cBmyzEk5jk+j8NRu1YSAZ4UGwX/YuGYTOGeEsbBVshM5Dwws9Ywpmatx33hUb4p0/79l9iCsn4FBlgH0q9D3IgQqoWuwcm38BSU5uufr+ws84G9fth2T5hkU7T6An1LNaABXnxWfFLQbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139947; c=relaxed/simple;
	bh=BE4ypfeHsjBgQjbsJixHXPZKHbTF7YpSfUoFv/8oRvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhFJPwZyD6rxgjd6FB5w5Wk66EKdhY7rMDMhanaEInT7P9fzEJhekzaUDG7nYt1nJ8yn7Xl/NlReD3g2TQ6wPxzZbKuc2ynCIfZgAKwMir1B9S6OzacsSxMz+ytiQgUXXau+n+crR0iDl1TsmMPEAqc9kNWE6o0TFuuaxqopcoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P1whjjWy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UzE/asAO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P1whjjWy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UzE/asAO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDGAwH1062317
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bAGyxtUFV9OfbTbFgd0iuyiuv0DCnat+0LV9beFY0Rg=; b=P1whjjWyIcuYsXSg
	GpuweiNZQzxA1t/Tq9BTxYavie2BZ8zJU9YlebEK0mvNYnTTc5sMA9aEjM0EGhT9
	9mv+S2YhTCDO+ClHt7NJm67/iXtsVm0QYtNx2sj3ZBGDmNMrWiCMUNgxn4nC6YJn
	Zh7y8hoJNDotd1t9YUvAPoiECYtzUTr0ajM1PDl+v3eNmzsvss/MogCmSvLkEV3+
	H+hKf10236cUgGcS5v59m0OBInyDX+4Jk1NgaQhh5AhYpwV1MIA+9kRsUv4HtM88
	h7i+bryce+GCmYBZxOomHmWsW6WauAE3XUjL2elYhahsdzkAa40wTZzcuc7NqzvI
	pg1iAA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1t0t8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30beba84d2bso2686eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139942; x=1782744742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAGyxtUFV9OfbTbFgd0iuyiuv0DCnat+0LV9beFY0Rg=;
        b=UzE/asAOcPmV+ZMVhEFI5zNl/wRUa9MmhX/E6tRI4oZLvj3+/t/Wx3w7vS4CEkpL3r
         2NzsyqE5ZYqh+k6siXSGAiQzpmbou4a4WXZelZ+oLzHL4O6wRiGLMJcIr6EBibpgx+Ma
         4aXAr5lzHYinBBKT3QY4OUqWgduI9xs8OaJo/yRlXDmICPfwdpmTfgE65Fgnl5swBy5i
         HiIqDBlPzTDsJ8CSmHXtRyPbqPZ87qd8g0JxKZWfSFmEPfRXO8nTSMpKFvgu5dFMahSM
         0CilsbQNmRLwLtlz6FTvlY1ssQ64nsj8myEX+RzwXrIAviU5N//yJGJPXZ9LPaO4Ybzz
         IPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139942; x=1782744742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bAGyxtUFV9OfbTbFgd0iuyiuv0DCnat+0LV9beFY0Rg=;
        b=DiwDQbxAije1BryX1XBgzO0tc0rsmD7Ws+UR1Q6Jvv43/VvGEB64Be0gq9lLUdFkw4
         LbprI7aGhaHWDMk8tZCgJzOV3Uuj34PMpgcVvlmmEdmeLm7lBRQdwYp07QLivvzq8SMP
         PHa0OWJ2cAfIcetuRw8eYrSf9DAue3SChbN68j25iG/fMMX0HbkhBe9oVvvaWgwW/M5t
         iRgna4fhKnWLXeeZkhyJI4jYQ/ZvknhCwCgoHw+jMqAaqkkL738fp6KIn483Sun+jgrQ
         wevpNdq8By/we5sg9oRnVUluT3FlPn9Kox+NikEbtV98v/WRyK5mYuSxt1Leqjg58nQ1
         OaGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqWvIme9HYtlQCboCSRqFr2YS8sigvizkavTtZp8TmGmUtmsNZyAHnif0Q8TiZDwDaEzJvLMP4pum3LJkgoaxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJknMS9o9p6FzD0eFQhay1Gqt4xe5hphFLNN/r4mobyZWyAJ9C
	r+PdWo2GgJ13ICjXRlh43aEqK05Er+FEu/83+78ZzbYPA1fNtLO6gjFHILqeo5f5h74lP2+11OR
	Jl7B9u6CZuZijCJfmt/8LYhu+MNMt652bPL0uL1kLfruPIngERTWM/XRFK++iQ/GHWRANgWg=
X-Gm-Gg: AfdE7cmY3VB+Ziw9gZ8jpNfCNhLGyhmZs1C0FsYDPCwSTmje8Hhh0kqD5C4yklgzkkN
	pDdO4jLF+y4uk8Kh6Q4weoUyb+avvl+i8xajIp4LQEKq5jSbz4CgAnEfncKrz7sW/oiPPDITs2m
	pesGXL3wAXwGbBMxDgf6iuo2gOaFjEvUl8T6YrsRjIF0JTxwIvMla0ejsUeqJxUp+UnCv1gCndJ
	90AG2Y+uKJ0r1qoYYg/xCrepWa1xugkiEB7o3Y20iKKMsP2qQJIz2fWcdEpqo7MHecEQjDWxiuU
	oeXhexi/wB7/09ZCghRW3H94j5mFGlMyGUDrPD2upINJdIwX01gRku8bGAzq5Qw0nL4iy36FXzt
	6SjCvuV4NTHsuGJf3na8doH0yJP/oYxBA4UdOW3A0axHRO+0NZYAnPLMlxw==
X-Received: by 2002:a05:693c:25c8:b0:30c:496e:982e with SMTP id 5a478bee46e88-30c496ea017mr843559eec.6.1782139942340;
        Mon, 22 Jun 2026 07:52:22 -0700 (PDT)
X-Received: by 2002:a05:693c:25c8:b0:30c:496e:982e with SMTP id 5a478bee46e88-30c496ea017mr843553eec.6.1782139941820;
        Mon, 22 Jun 2026 07:52:21 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:21 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:20 -0700
Subject: [PATCH 07/13] Bluetooth: hci_sync: Simplify hci_reset_sync()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-7-11f936d84e72@oss.qualcomm.com>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
In-Reply-To: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: -_-KdQ8tXEN19iiIjdMqGD1aFEbNt8kO
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a394c27 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JW6sVIICzvLrt9BNRHgA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX5sFnb2mf2pHc
 8FTlaApVOr9L7/QQb1KzA6LDzLca9NBwnXvTsCS0kJH+fG/FLCa/YDHiKigxjAMMe8PzMvlknWW
 rSkE6d8rFHuQODmQcrNkZWZJdhl6Bpo=
X-Proofpoint-ORIG-GUID: -_-KdQ8tXEN19iiIjdMqGD1aFEbNt8kO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfXzrDOvimNEB/C
 0chZJ0wVW+GKUucGv4eaFYGfTgATNGN5uMTexpD/ZI913gEBssB07jh9RCBXKcF3d3xB7FfyPJs
 vKN89yRPzEn1JNEg94BALDiRYeKUA9zht0A+C2NkZnPTuCafR7JD5u5s+aLsS7Tq9dxaD/qQP27
 kxlU0VhhCrirgLjJviqpYjHSKj/4jcQ+7mInGlaaNZ8qkVU85LGIUPeySwbtb0T6WW3P5+OhXfI
 Nm4qkHQ0XwLdi4u+SKbTEMuxumNMPPGiEHSyoN4+kdALExvEv8n7pzW5CIoPf/x3j8B3zg8KC8I
 /p1RA4eo9p5W3+Yg0UryzWeSBKQ//5Sb4v+KZ7FTde6O4UX/P5jIyZncjeEEmG7ZeH2bT4NNIgs
 uBON39c+ioRlAA2Nc7ARP4FT3aH42fFEPUPRXvkLxZHlL8YUd7vE9UHCQjl3Xfn8nZt5aMaxlF7
 hanlW412zolR4Z9USpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

Return err directly instead of using an if/return pattern.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_sync.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3be8c3581c6c..fce9f9526cb5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3678,10 +3678,8 @@ int hci_reset_sync(struct hci_dev *hdev)
 
 	err = __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL,
 				    HCI_CMD_TIMEOUT);
-	if (err)
-		return err;
 
-	return 0;
+	return err;
 }
 
 static int hci_init0_sync(struct hci_dev *hdev)

-- 
2.34.1

