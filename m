Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD8383C66
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969702; cv=none; b=QcbeSEfNs+T7DoQrCBCrVUYhg/SDBPbe9yu8qq17/TIO0CuE6wbIr20/+/j46xu85vgBOK1BWainmCAGeipuRUd+Ee7ZujTgdtF1x4C8r4NArkp9Sl6EFeF70Cop4DJdL4JFsf6OiQrec+J7KiolAicPk/mdo7cDdRQyWJkWKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969702; c=relaxed/simple;
	bh=3HhW+X87WLA27yqNV1POuTpXrsjhwxJo6NlWVjQqmN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daoS8+s3PxNbYuGyMbuaeUrCuZM8lrGLj15h0WjcQs3Emt7B8lwfSRtm6vWZGkfOkdL5S+XvKLYRJcZ1E5p/AN2StBlpkpDn0sOaX4ix74wMggTAE6T9eVWgn6VgZnPCLkQ6mifWXfBLy4A2Sa2S9hGF7oPBXYvRsOrWbmkR56c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dLGWjxBN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ka0PFJ93; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dLGWjxBN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ka0PFJ93"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4lL8J863515
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ByGhfLSofYeDgpvJ0Y4Eh5IP36QScJBgpQhFdOR4/BA=; b=dLGWjxBNRJ03gz1y
	e+/fOW3aNiVi1rRnFKVSA5tJ66ORHkFgl/HASpc/UquBXYJKcJskKIHbDV4YL4BV
	l7cdUjK6sutAvhJKXC/JN+BgVhZmkCzZOa7DtGJWOFuWywJxzDTmE+sOFEllhRP6
	whXjA/TCyVYhnoUWIGI8i61WuSORUBVc4o16hsR7MyP4GcI322sx675w5LDXNy8o
	wjHGdqbvdkEnZ0e/GGT/f1hVChIFJuoqcIeLVJ3zOmXv/8vf4ezhLQWeiW1tV05g
	zPtnCFj2FQ03kW9EBiYkGHIsCxPl2Eip2WzNxYWTlziY5W8Pkry8DqL0JizD9esy
	Qw+aJQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmnwerf52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38105cc58e1so307593a91.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969696; x=1785574496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ByGhfLSofYeDgpvJ0Y4Eh5IP36QScJBgpQhFdOR4/BA=;
        b=Ka0PFJ93OLIhSIUW42lY7Fx5dBJrpOFMl3oj0lrOgefX2SIFq4ACk644CVSGyEIAwL
         d1vsoaDnuzlXbNu3upaUl0FT8S87LhEQ+1FjY31mI5yNwoUP+Ca5H2RAjUN+CuiBefQC
         luLtGrrVE0NeJOM8dab6UP/RNYOtAZuMtAFJhkoP5zQw8NLitOq0+aE45VgYoCepB3/h
         JNJRqo1GEeTDNv4lX/W9mp6EqwU5czoevRaWMQOimqVh6Y6iPA52IT3bjVZhPq5YXc0H
         krqF2go7fxegxPuBpIodcXNLtHZdPb8drWAuAWlbTTSyiQX1QXv18Kiz/N+zr+q/utUh
         WuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969696; x=1785574496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ByGhfLSofYeDgpvJ0Y4Eh5IP36QScJBgpQhFdOR4/BA=;
        b=XDHsXN8tyF8TfL3NtbtTNYv86B32pRZ9GhU1Fo+IenDtqVZvFRhU6PgXBqoujb8DjG
         KdyJmX0LAyiPHJUGpuwcaxgjIaYg8bt3oRDKeXNKzUZFygHYZpZjjQPtgf5JXkuqslN0
         XDMVxqr/9ex5fwi7SqMtYUOFfyhF8+YtJClRrWK+vB8J5W9z40GGlJAcap0dIKoC72v3
         4mpHccOvFmpUl01HWpfzx25ZbwChE1R6Y0/FTc9Zq9B2fsEqCbRrOFaINh8FSIvCTTgR
         6dnPSrgByEff8LA1i4DQa7vvGjDHpTUJn01UNtiySP7z6e5Fwgv7upy5fuUgpdF/bcqK
         Xu/A==
X-Forwarded-Encrypted: i=1; AHgh+Rp6xq7ImTxmB1Sv1pg05Jrt7XG/OW+nEiwPUNL8/uHYYXzTlLZgmzT3wfVeHMLUJeQ0KjOWUZqZTh5Z7PP/hCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAVd7AcsrPfDC6ckoYj83DnBeyknDELFLkWJRdrHKK6AtifqxK
	77Du/FF5LpAGdkAd6g8JSQNmyfRBNXlMHDzWOWzz5JdZPgkcP4mOmIqUFP5yqNoh9Js3nY9Rc3v
	7pJLUvnlEKNDi7AKp8m+FetDyTeB2nONjQJ/N0FuK4BBlgX2CkwB1j6HeHDDBQoRiQoEl/c0=
X-Gm-Gg: AR+sD12+FGv92aQ51Idrel5AvDEK5lg+fiPnlhqLHaKE6xs7+afRbc7NMG9WjFJLU3j
	2k8p6xCurkzvFW59k+DS2jFsZ3MCLrZSjVexq+MOvnZseRZbGX8qdsNizOB6e62bPdsQH5hrg1q
	9WoWc05cbi3yQNCY1YRt5QMphMVwMXczaSNUpCG4nuJGxDgUCRHtqDBD4LaH9H3trYJBB62u46r
	SjKH87DLH4hEkAOFVRt1yPGOxT+Mij5yFP0h9981r+l2NT8cToF6GkS/cS51vijNvhUytpzHNKL
	ohxHGbdfn+ZBD2D82WEipyTcjmKBA+H74ohWMSvUcANk2XFh9wyWZwULhPdax2/o4WhQ/3DidkH
	k67VW6hwTt9YfkTuKb4f9s6en0aqCxYQq61/g0xkVeO6Ht/I=
X-Received: by 2002:a17:90b:590d:b0:380:9cd1:d985 with SMTP id 98e67ed59e1d1-38f2966162fmr1280947a91.6.1784969696472;
        Sat, 25 Jul 2026 01:54:56 -0700 (PDT)
X-Received: by 2002:a17:90b:590d:b0:380:9cd1:d985 with SMTP id 98e67ed59e1d1-38f2966162fmr1280934a91.6.1784969696029;
        Sat, 25 Jul 2026 01:54:56 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:54:55 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 01:54:42 -0700
Subject: [PATCH 04/11] Bluetooth: btusb: Make btusb_recv_{event,acl}() take
 struct hci_dev *
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-generic_fix-v1-4-305aec261a19@oss.qualcomm.com>
References: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
In-Reply-To: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Manish Mandlik <mmandlik@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX2+1iuLDSU49D
 cU+oJbjf0kqujNBnWmhAvRkLfI4iFSnTd2yjeJYLDHrli6qqbHPgOq37p08jYGyJd6PohOKkERr
 DLkhppdIgphgXcG2uBGbZKH1hJkRfS6likWMtSuAmB3sm2W+VIEqHqSq7nTestbXC71ISARZssK
 tyKyYwmcHsU0SBvmsgCXXCPhtNujOHPqPnnZy7ELmevBffYT4tJVno0bTXSyS6ahwRc5RHbro4F
 JSZIaPNX/DK8iHi3pOdzyJdnBcvPC4Vm4XX0Bfp144k+yv++KVMH+QTi4uBDbtQ7a+t9BWrlAyp
 vulBOOV9Wx+mVlT/2zdHJwhYtqM19U31cAcM+xdGkfYBJ2SyulsXrzqe0k/fKCEf6pDKsl7eJ86
 WMc9wj0kzHJECWZ44n7CiGOoNkkWpkf3OMUxqmpj2qIPISVByyZrLR767fsrtpyPJJv/ipm5jKm
 0bGVDUfFnwFGfZz2Yhg==
X-Proofpoint-GUID: eAU7h8PwHkfK7Os1h1hOBrI9igID8pKy
X-Authority-Analysis: v=2.4 cv=S77pBosP c=1 sm=1 tr=0 ts=6a6479e1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BxL98BHv038Cxk8TUOEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: eAU7h8PwHkfK7Os1h1hOBrI9igID8pKy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX3h/UEDdzhUzS
 KM8xsJtknNzWckQWhrYA/waCfI7vlqiR+3YNtZ+UDknsuDM+Jfm/a5x4I9h5wc3lxXoKcDuv+1t
 vt9x74KhHYc5iU2dYsNMRI78ce5xg44=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

Both helpers currently take struct btusb_data *, which is private to
btusb.c, as parameter type as below:

  int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
  int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)

To allow vendor USB-transport-specific source files to share them as
well, change the type to struct hci_dev *.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous version:
https://lore.kernel.org/all/20260713-btusb_prep_qcc2072-v2-4-bbcb651285f2@oss.qualcomm.com

Changes since previous version:
- Improve commit title and message.
---
 drivers/bluetooth/btusb.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4d59b28ab30f..2ea1d6bbea39 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1247,24 +1247,26 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	data->acl_skb = NULL;
 
 	dev_kfree_skb_irq(data->sco_skb);
 	data->sco_skb = NULL;
 
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
-static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
+static int btusb_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
 	if (data->intr_interval) {
 		/* Trigger dequeue immediately if an event is received */
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
-	return data->recv_event(data->hdev, skb);
+	return data->recv_event(hdev, skb);
 }
 
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 {
 	struct sk_buff *skb;
 	unsigned long flags;
 	int err = 0;
 
@@ -1314,34 +1316,36 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 			if (count && count < HCI_EVENT_HDR_SIZE) {
 				bt_dev_warn(data->hdev,
 					"Unexpected continuation: %d bytes",
 					count);
 				count = 0;
 			}
 
 			/* Complete frame */
-			btusb_recv_event(data, skb);
+			btusb_recv_event(data->hdev, skb);
 			skb = NULL;
 		}
 	}
 
 	data->evt_skb = skb;
 	spin_unlock_irqrestore(&data->rxlock, flags);
 
 	return err;
 }
 
-static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
+static int btusb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
 	/* Only queue ACL packet if intr_interval is set as it means
 	 * force_poll_sync has been enabled.
 	 */
 	if (!data->intr_interval)
-		return data->recv_acl(data->hdev, skb);
+		return data->recv_acl(hdev, skb);
 
 	skb_queue_tail(&data->acl_q, skb);
 	schedule_delayed_work(&data->rx_work, data->intr_interval);
 
 	return 0;
 }
 
 static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
@@ -1386,17 +1390,17 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 
 				err = -EILSEQ;
 				break;
 			}
 		}
 
 		if (!hci_skb_expect(skb)) {
 			/* Complete frame */
-			btusb_recv_acl(data, skb);
+			btusb_recv_acl(data->hdev, skb);
 			skb = NULL;
 		}
 	}
 
 	data->acl_skb = skb;
 	spin_unlock_irqrestore(&data->rxlock, flags);
 
 	return err;

-- 
2.34.1

