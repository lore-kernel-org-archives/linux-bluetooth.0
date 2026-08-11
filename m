Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8E41A90B
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437457; cv=none; b=RoE9Kcdap8qz4h8V1bnE/AKMdBPM2q25mgimVgLs2KCaYm3SZDjb1c3Q781MuKcyCKHjC5XRr9xZvZJMSjF9zyVbL1sZgfRPxite9UgZdcperPrt/Ar8mmT6znAo2T7AWIkbHOmKJNfbTofYgl2dVaxeKXQB2U8TRTvB60oBzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437457; c=relaxed/simple;
	bh=HgNAwmlfxpIb4zNgtMNr6khvXPPru1hyxswrQIaaiyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVTipvwunH4KCMKYHgQM85EegISpRz33yu+AGkgBoa0mbkbiiQo8O1wT5iSxftWCAN5mnqpDppYOKigevzNhK9W6ls/2gL0ztFCsndz+DpplkneJZVPwuybhPpRE8224sn4we9iVx1EJIm0Lk54zIg6rkHbIPeaIH3yvDc6ViFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SMWf6mi8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MROGgA9j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SMWf6mi8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MROGgA9j"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B70WrQ2997309
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 08:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZHM9GiemhQr
	n2VXgJufhHpHx2busk+G72paiSBc/dcg=; b=SMWf6mi8KlmthzTaDsgkre1QP0u
	5RdA1jXjoiI35g1voswEs2iwxi63iOnSGSdm/3y6itWXFjvYCfWFX4zY/ySGPOUy
	OO8royVMRVgihBaZN+R/NKiePhH+I+jk719AEm2SxJidz+9p56SnjxvYNOf1O9mS
	llpCiuhZ/AAAgC48Ji5juNd7hMHs/h7dZFQdnZwXuEoQpMhYfNyE5brsAAWRhG+Q
	p7Jpit0qP8wQzCE3t6LTcJqhjhZAosQlvS2UsJbZ9BIkWWLpbJCwIeLo/KGPb4Aj
	I/miirAIJyjDT0I+H5NEAnJYonm27A9XY/pCdKBh+MQf5dat8h2F7o9xarw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyf33re-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 08:37:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d28f8737eso53950741cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 01:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786437454; x=1787042254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZHM9GiemhQrn2VXgJufhHpHx2busk+G72paiSBc/dcg=;
        b=MROGgA9jwbKqDkzvO2cCatgMv3Px5OpoaUB5D2Pw0f6QI3Neibqf4Nb8x0ra39DHHK
         4CwiCsZ7GqjlPHAJiZGSe8xyB0TmZSc0L1Y+P6iO7UYfyCrikSr3yCx6n9lgiSJuIf5C
         CUt+2VIXGFj6BoNbsePxO3nktCVcmglxgXwuIbsVLxHocIwgTPxh2hifdILPLTgE+Gml
         ztn39y9c1ygJ/B/K5s7Xe3fvKKa3yZU3ZwHkvJ9pwwHNO0xCFgnQxW7BKiS1YVBw4d0X
         WXic8k84QJ0IVxhfhoal9XG195jRMY8scmVJuNiMFKHUkMqu/PLE7POfWIKAxxcKnr8e
         I6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437454; x=1787042254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZHM9GiemhQrn2VXgJufhHpHx2busk+G72paiSBc/dcg=;
        b=FidSUARsUrEKZ8akFEAaVQnHHsJLGD5j2Jo26FYy6R5vzbt6L/A0SMvnH/PCea8O/X
         2Gyiz2BWhtWQ1Q0UjRxmTZyI/8eHVCkpUIKbjhICwheL7kBTcXG3V5AhuxDdtpDaj1vU
         nbOAcZxWV9Gj+dAG6Of5rRWd3Qm3hlM+GAtVkSGajPUuRFvZbSNuwMf642tigDmmU+P+
         5pLOIyWqNQep9FNZOBym33bWylRO2aOYfu3EcUsSTKlUwL1ptf20bitgORPPwi4ErMgR
         hjHIOQ1XQeIhhh3jwPwRjGAe+l06URPR5x0AWtYZRCHjQhjUCf9JQpIXzJXZDilLEz56
         zujw==
X-Forwarded-Encrypted: i=1; AHgh+RrgFkUcgPaY4NfiAHuxjlEyfAOcpNHsbAQKHb+J1sRceZCR/dIDBCLsu7yC6VbjwJ1ED1mDHn5wmzx9qfnb3Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd6s1KeODFqvcZZHmi62HyPjBjlBxm5FELyQNEEPsOG3MPQeAo
	0EQi44r/q/TsvYQVtTkI3+B61dRu6caxX77t9ZxkGCyCs0vtNML8jZBC071X5YTayJCmtFT+FAu
	NaxiGOfR4ZGsYzLXdSYEbmtNY5hfreoaru/i0SzBuuyF+XecREx8e4XiCyZj8LmocUEJhb8g=
X-Gm-Gg: AR+sD11TR5ea88yh+U0jmM82D88iKQv0tSc/FSkGJIac4EuzQGSFQQ+764xr4Gsq5bl
	pNpsRb+MoGccFkGhJFjJEcMzLTPqG2+jkUsdxkTSGfuATkbcVhjlb5xp7TvcM/ciJS5BUeuSDWN
	pbr8Nw3PJ2Kqo+9J83XDgx/uu55/jZRv8N0vIP3sPXLobRu/56zmSf2rwlq90YtTMRlsPMgvzLe
	FCBP+MDrf7IEmwz0vs5swq/lqYthBKga9y8qg32OtWK9pyUIFfGc5ggVLVTUh/lQgjI1cnXU36Q
	k51Pqm/6csZmkji5nL07s067DyUYl7p2BTaqxLw33TRrnKcX1VxQ/9lXaDjBPoWQnRSFbbvsM2y
	hMXody/rTwaMO8KX0nMAw9Sl6xlEK66qLsoS83HV07z6CjlcwZZ9Z8iQBMOU4POWci5+iXCoIV3
	RquyRLasEH0qTl9wk=
X-Received: by 2002:ac8:6903:0:b0:51e:aa39:4fca with SMTP id d75a77b69052e-52d5867894amr12144381cf.34.1786437454520;
        Tue, 11 Aug 2026 01:37:34 -0700 (PDT)
X-Received: by 2002:ac8:6903:0:b0:51e:aa39:4fca with SMTP id d75a77b69052e-52d5867894amr12144191cf.34.1786437454066;
        Tue, 11 Aug 2026 01:37:34 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a362eeb727sm357208a12.24.2026.08.11.01.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:37:32 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_sync: Factor common cleanup code into a helper
Date: Tue, 11 Aug 2026 10:37:30 +0200
Message-ID: <20260811083730.71393-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
References: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: k0fu02Ku95NFiEy0QN9tY5E7qt58-_Gh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MCBTYWx0ZWRfXwrBaxqlcbw/V
 RoHXYmXUiYOnIWtq06aKvV9JmH9jvoozjL90DkM3VFcTmHsj8K4uyZ2yWnO19VStGOvYrhk3Ec4
 iMLbTVUCzXLRjw5NxSYs3msmt3Gr7DU=
X-Proofpoint-GUID: k0fu02Ku95NFiEy0QN9tY5E7qt58-_Gh
X-Authority-Analysis: v=2.4 cv=NqnhtcdJ c=1 sm=1 tr=0 ts=6a7adf4f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=dC77ymmRSLtzYx4gL30A:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MCBTYWx0ZWRfX5+5hrwdbHUor
 OeeIkJwjq0MUqWAwChtD5yAbkJOureQLZhdr6JU5FBQlCSh1bYyalsz/BwPLd1vMTOmcdxGOFGm
 ulm+6FQVsxMtILuF17PbZNgd7t3lNysZfBYgqpzIzU/NfTiENNHz6VTr1+ClxvmOQt/fcxx3FkG
 clIjmUkNUz0LGHilT+iftQXlgNWYMDl3JDvqMKCqVbOHak27QIrgZuS+ozFEIm7J6QAnxqHR/S8
 xJ9GAPqTicPmmcrFtFgvXaWGvgn/w4lu7GYMbDJUfr6FbtcY1qZgGAR9jIBf4Q2Sn8/9/u+li9w
 2RbwtYDwWDM33x1WU89DBAwUL7LueFijMQOou44NeYbjkIaAq1YYRp4z9Nuvo0qcMjrfR3pHeWr
 M76LBsQtqB33VVNPWZZ8gox9MtjUm26uWRZPq4qkiASlQH65tUrcp7YWDNsefnuXtVFjgZ1LhLd
 UnyhPR7OPpvns3708ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110070

The hci_dev_init_sync() failure path in hci_dev_open_sync() and the cleanup
code in hci_dev_close_sync() have a bunch of common code.

Factor this duplicate code out into a hci_dev_drop_last_cmd_req_and_close()
helper function.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 net/bluetooth/hci_sync.c | 64 +++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 33ee71c56480..9e62f1d392ce 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5207,6 +5207,30 @@ static int hci_dev_init_sync(struct hci_dev *hdev)
 	return ret;
 }
 
+static void hci_dev_drop_last_cmd_req_and_close(struct hci_dev *hdev)
+{
+	/* Drop last sent command */
+	if (hdev->sent_cmd) {
+		cancel_delayed_work_sync(&hdev->cmd_timer);
+		kfree_skb(hdev->sent_cmd);
+		hdev->sent_cmd = NULL;
+	}
+
+	/* Drop last request */
+	if (hdev->req_skb) {
+		kfree_skb(hdev->req_skb);
+		hdev->req_skb = NULL;
+		hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
+	}
+
+	clear_bit(HCI_RUNNING, &hdev->flags);
+	hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
+
+	/* After this point our queues are empty and no tasks are scheduled. */
+	hdev->close(hdev);
+	hdev->flags &= BIT(HCI_RAW);
+}
+
 int hci_dev_open_sync(struct hci_dev *hdev)
 {
 	int ret;
@@ -5293,23 +5317,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 		if (hdev->flush)
 			hdev->flush(hdev);
 
-		if (hdev->sent_cmd) {
-			cancel_delayed_work_sync(&hdev->cmd_timer);
-			kfree_skb(hdev->sent_cmd);
-			hdev->sent_cmd = NULL;
-		}
-
-		if (hdev->req_skb) {
-			kfree_skb(hdev->req_skb);
-			hdev->req_skb = NULL;
-			hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
-		}
-
-		clear_bit(HCI_RUNNING, &hdev->flags);
-		hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
-
-		hdev->close(hdev);
-		hdev->flags &= BIT(HCI_RAW);
+		hci_dev_drop_last_cmd_req_and_close(hdev);
 	}
 
 done:
@@ -5476,28 +5484,10 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	skb_queue_purge(&hdev->cmd_q);
 	skb_queue_purge(&hdev->raw_q);
 
-	/* Drop last sent command */
-	if (hdev->sent_cmd) {
-		cancel_delayed_work_sync(&hdev->cmd_timer);
-		kfree_skb(hdev->sent_cmd);
-		hdev->sent_cmd = NULL;
-	}
-
-	/* Drop last request */
-	if (hdev->req_skb) {
-		kfree_skb(hdev->req_skb);
-		hdev->req_skb = NULL;
-		hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
-	}
-
-	clear_bit(HCI_RUNNING, &hdev->flags);
-	hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
-
-	/* After this point our queues are empty and no tasks are scheduled. */
-	hdev->close(hdev);
+	/* Drop last sent command, last request and close */
+	hci_dev_drop_last_cmd_req_and_close(hdev);
 
 	/* Clear flags */
-	hdev->flags &= BIT(HCI_RAW);
 	hci_dev_clear_volatile_flags(hdev);
 	hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
 
-- 
2.55.0

