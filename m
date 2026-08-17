Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88613C585A
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999832; cv=none; b=Wiq/yISFHmy9mvzug7Gu9JJqlLjkY3fOq8eDlXA1lhU3T/OkIdno2ZYlbrCBPSk/juF9Sx9yJSwzA3u3/kSZX8O0KFAu7BqVDAqsYcY2/FiMERtZAAR+2pxflujbxbUDKjE0U0IrdMtUAfB+79UArqNS9n9KcT0VfDV2OMXCeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999832; c=relaxed/simple;
	bh=hiKDUR2ZhrnU0CbtL3/1omHFpuRmEhvjUkaedO7oodY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXK0tB1IQq5HhSugxwuh4QZ5xJZN4r40ohV71L+EG16tQK+nXhGUkVo35rrLKFxQ7uBvWcjCpGBj8iO3ptKnhO3vDKO9X8oyaPH4PeR6fZxgkzfbLuSLf9FSpQgnYLGKyaT0aq2TQ02BbHtOvZk+3IBnxr2AKV9OkYUI9cqSA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j4NGydDM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZekqN7or; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j4NGydDM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZekqN7or"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIQiAj3107841
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 20:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Qp1qdf6reNQ
	mVusA1JNp5ojvSmijOCCDWcz4TPn1Yts=; b=j4NGydDMjkJ1RKj/JqtWCy7Knf9
	FAFLJqndYWmguSq08qaO9sY1Z0mo0SCp4+AgKvVSpK1Vda08uwRroJLmowwn6jCq
	MvqtXUyBg/9t5WlmRQ39yIEI7qjMFGAntZU9LY+1EHKAIuFNZ0rlDtK3tZJhB7wI
	7imMMazaTe8Gqhgh2VB00X5dbKDUEXTg4U+7qTmteEERRvHZK1QGtRVwA1v1KBof
	W2vXAclkmqHk10GakOMa0Qds36hFljSZ2Uzy+HUb8+qX5hdbOPnoXsJjZauT5BAM
	Sr8XcX91iTw2vP/PTrXQIlzTd/TWKRuXePybfjhhiIg7d0305Q9FixuQ5YQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4615gxsn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 20:50:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936a796a23aso334184485a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 13:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786999822; x=1787604622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qp1qdf6reNQmVusA1JNp5ojvSmijOCCDWcz4TPn1Yts=;
        b=ZekqN7orkutNBbZndQfvLevAqTN+BR3MrvqAZZ/+9+HnoX9TbmZ0tflQ8DfBWZ6w4x
         utDUFLBwHYbLdh/3niMWIvMY0XRZBn+IMZxpXf+7cQaVEiceRKymNkJThB1At8+NES9P
         6yLjs2T/VnUgs91249ffGnGQ/leQp+kHiNBnqbab/MUyVEwIyXVRe4l5LrKct0nBiKUp
         P4Der3iPRJJS5tEnAnTbtvCBTbQTo8Ld5puujoxYPQ5jGCcO2nYRWZiNA5rqCkmLVMwR
         FXGoGO05oYDHllvBmauS9z5Zoqy2GaHW1dFxNEFkxo+nZ3E/3JPidsoI++B4sLu/TXFN
         fCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786999822; x=1787604622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qp1qdf6reNQmVusA1JNp5ojvSmijOCCDWcz4TPn1Yts=;
        b=Ndtv+425ly1i6v8rmsjjwGudB4w9l3kZvrCTyfXvMMft5tA/b06wswMQymFSFO3LVk
         VycNXoSyHc/iVGD1lbjyIyGMqAdnSVhbkUmUNYLKQG+lBVIcgckpGFwiuWOr10FU+68Q
         BVTw9rpZDDNhVSZHqaEtvAJAkz/n+jGJz1DuDBnU3olEWXiAiUCcWAEBbKpK2egr+T4t
         kvpZP89a+UDscffziBp4/ceveDnUxjoO9vf+p4Ei32r0n4uZRqs/CgHE/hPdfzdzq6Mm
         k1Fw5VKHCjfcxnkQIwwVxRSO+dD+J2oTOKYL07RtFmuVVQ1HAbCpiW4wu3m+3i/gSqcN
         MooA==
X-Forwarded-Encrypted: i=1; AHgh+RoxgMAPhC0UNX1C94DzDQApYro1D2+XPg6G104HkOynZh2QrS76Q5l/vTt6FnE4RR0HQyYQnvkSO3Bkp8lCuiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHWnMU3rDjDmI2QdQKy/D56Vr+F/0ZSGdmXUPuOPZFlF68ubN
	QaJkINk2cbbdILn1FHLWHVHpI1UEHqK5hF1PlyjrbJwwdz1Z41w2oUCNlED1dVlv/aMlmEJThRr
	pgLUcZtv/qvBXvIP0V2Z+f29Kclv4nqyeGN/25k5jS0sOsI/DGQ9ODkjv5G9pPoPqHNbl7us=
X-Gm-Gg: AR+sD11NeEOdb+Xvx/944SHiWL3okjJH1R9SrY4wacdoAxxSDN3IIS38KqGyEW+Gxpv
	uLEg+x3pMWZDWXF44a64KNX1jY0s9F7NqiGrpk6BXUjtVMMKGEETFPhMhQ5uE4s2rNSZqOqZx55
	f7mC8965Hd4dj1IGX4ojRGsOGaJflFBygCJhIkG8UCMBYxxEJSwRda7jT5AwNBlcTr+L4XsVjc6
	nxP6RcqO+Hlr8XIVMLPjYKOZ572AD7VyH1ojmXn8hJClsb5T9dwDdhws+jOMcn3U7bsTiQU4Nie
	8VzpQdO+jiYTZN0QBho00OxeO5jrO07ixHJTH12r5wMvjm2dssmnftegJjAdWTW15dnAhm1vekT
	ITyIQsdnMNBlxPHlBNlfhYm9DW3DjcZCfH6ZaqVHZcX5PTbqGreFFcBA8Z6WudoyYMl1KhjTNk1
	aaxiwCX6r+KXLjw2Q=
X-Received: by 2002:a05:620a:3d01:b0:915:a111:86ae with SMTP id af79cd13be357-936d238c318mr1909397285a.35.1786999821359;
        Mon, 17 Aug 2026 13:50:21 -0700 (PDT)
X-Received: by 2002:a05:620a:3d01:b0:915:a111:86ae with SMTP id af79cd13be357-936d238c318mr1909393485a.35.1786999820683;
        Mon, 17 Aug 2026 13:50:20 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fe7b854sm101745866b.4.2026.08.17.13.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 13:50:19 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_core: Handle skb_clone() failure in hci_send_cmd_sync()
Date: Mon, 17 Aug 2026 22:50:17 +0200
Message-ID: <20260817205017.56524-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817205017.56524-1-johannes.goede@oss.qualcomm.com>
References: <20260817205017.56524-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bQD7QKY6gcLbXasKI4gq0m5aZ0zHsnrC
X-Proofpoint-ORIG-GUID: bQD7QKY6gcLbXasKI4gq0m5aZ0zHsnrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1OSBTYWx0ZWRfX4bpPkyPSF2dN
 6byRNl2rLt4h8E+gprxZ930gO6x9Tndmf1oodalDeeAN9mexbrPjSUNwgJJvD26HlNy0CMTHGAG
 eyA9Yc+uAmBWwYMFi+YT4NxV6Iy0W88i7cLuNTVWdygyPuuTfHAPASw6HrZcmC5WKvMdBySOINi
 hL+OrUCpJhz19kK58cm4GInOCqS3M0nPsoH65QyhLTYoO1jmKL5LiiBQ1ixwpbTaSObr5G57lg2
 YLJ261c6waawct6j8D9Fkz7s/jVQIHVqTilDBp3AFhIzvfX61T4cOjPrYYUSe/hfM7om1YXuwNO
 ll2G8XRpBd+/hIaydDgSVQYhpOgcGpOY0NfRj5rSsOPrefTQXFqmGzOMUNIIhp/AAMuwk3y+qVT
 mi1dne6KzJML6fwfsjn+qPEYCVapJ8EeTb7UH1aGKb8Ad1w1LAmiJYJCpAGJti0vVgfNo+M2/ki
 ku23+oMisyFPTKV6U7A==
X-Authority-Analysis: v=2.4 cv=Ruf16imK c=1 sm=1 tr=0 ts=6a83740e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=XAmQ0-y-R7DJRi3rB_UA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1OSBTYWx0ZWRfX9FDuqsWu6gL1
 T/nOZQrFS7nFkvb2BkOoj0f3FEg4+3Rdfrq05z0ywwbGPqEWWTIMZxLIz+BSMzVr/rM/+wENA59
 UUpIamOrD4mMhhIKL07L7b9s8cVHPnE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170159

From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>

hci_send_cmd_sync() does not handle the second skb_clone() failure as it
does the first one. At that point the command has already been sent and
HCI_CMD_PENDING is set, so an allocation failure leaves the flag set with
req_skb NULL. The response then matches nothing and the caller blocks for
HCI_INIT_TIMEOUT before getting -ETIMEDOUT, reporting a memory shortage as
a controller timeout.

Clear the flag, cancel the pending request with -ENOMEM so the caller fails
immediately instead of waiting out the timeout, and return -ENOMEM so
hci_cmd_work() does not arm cmd_timer for a request that no longer exists.

Clearing HCI_CMD_PENDING here is safe: all code touching that flag runs
from hdev->workqueue, which is an ordered workqueue, so those paths are
serialised and cannot race. The one exception is the cleanup added by
commit ed516e3f1aa6 ("Bluetooth: hci_sync: Clear HCI_CMD_PENDING when
dropping the last request"), which runs on hci_dev_open_sync() failure and
from hci_dev_close_sync(), and the workqueue is stopped before that runs.

Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 net/bluetooth/hci_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8aeb3024428b..9585b42e7970 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4092,6 +4092,11 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
+		if (!hdev->req_skb) {
+			hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
+			hci_cmd_sync_cancel_sync(hdev, ENOMEM);
+			err = -ENOMEM;
+		}
 	}
 
 	return err;
-- 
2.55.0

