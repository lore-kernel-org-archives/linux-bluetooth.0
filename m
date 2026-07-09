Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328A3B0ADC
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577712; cv=none; b=PbEifAoP/+zX3lo1AIEfuGfPd/PigWwOKC+RbzNrxCpTQmvKtERdEhJ3vqGmi7As6dY/f4jWRBU0OrHRlYOxa4EtrffP64fqG9pQVejLxUYb8X02P83XFGpR7By4mu3Edx9T20NUHK7CAslnRg24c7i49M1Ha0c+z0sA+GeW9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577712; c=relaxed/simple;
	bh=137gcoz0TgKJAcHHEeBEdd8QiVuI5k+lENG8TiN6hhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfpOliWfhqkYcoZNxjWDfkXiGgatqEiaxYYTbELe45DH2MR75Rw/phIlOEPXKyDLo1EWcfeHgOhzlQD09SAMc2ayIZmZpv6Vr2mgbW3u5AOCa3SznzXc0peyRalwRQpnsV8D8/47v/u9uk51dZILEEKRz3NiPC3kihUE2gmJk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jDujQEa5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=baGHwY2J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jDujQEa5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="baGHwY2J"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960IUF972695
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 06:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Muv8BEkgUvAlNp7bAE5TQabLx4WhhNbs/wZQQA70eq0=; b=jDujQEa5cu4ZrExd
	Sb4Uy4xBapEmuyu0Xyx1UpfhMoo5QYsy9jhCjP88uUS6WgssOZPzhoXXRGq1m+r5
	tkaWxyK+Ohy0hfxQvGUp2wtBcgdeyXxFxdS2pAHHDNJoMp8M7v/VsDHqaQkeLOFz
	pk1gUS/k0kjqxOiUcl4GVBiQXWUfbDTx+GGjGo3C6HXoyEFjRqBtNsdySrXTlnWV
	TTQdnKXBcnFoZTm/W1LJPVmrPIn8FnSs8R+dU3vXMwrYm0UkD1v47s6RY5+b9win
	7gXPAazNTG9sG2DVOM87ckE5oiigln13nGCf/7JR+wvMDREFl4YtzuMR9CJzldF3
	aS1oGg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4vt495-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 06:15:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84848067b0aso421064b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 23:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783577710; x=1784182510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Muv8BEkgUvAlNp7bAE5TQabLx4WhhNbs/wZQQA70eq0=;
        b=baGHwY2JdKH+7Mpw6dNeNLLltrRM+v/3ORrHs3Rlq5LhCEALoQJXQYz5s0kWVlWZk/
         lVqcvp2brXf88Hix6EnFH7kZpAxLhAwgbjJB1XoEKqZKP+TOpJqICFmqU2MzDtPvuOmU
         RQJDVGzGgQRAmhjuMYvWyGTbDKjGISOhYkQ5Ig/c3A3RTD/PF7Sf0PMChF5Bq+lhWzoD
         Z4WYCqWL5YPnB2IaeUDPsD7gXP5jXWT13LYWEEMYR3yI5znYbbWowpNKLnGyyuVIxbFt
         1HuYvqWZ5N98TarG5V3j0KPPULn2tgZShhGE/qEjPCXjTRPfp0VpzbxWFOlUzg6E/UX9
         LQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577710; x=1784182510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Muv8BEkgUvAlNp7bAE5TQabLx4WhhNbs/wZQQA70eq0=;
        b=jn9FGZLiJLEqea6jFkQlmGibtXodtVF00zwYO25s43XDiaf5M0UHsJNBfmjshd+2jZ
         OPjW64YZaHfDn4lYvtyFIQz+vhki6vh2g3fHZizThcWtP70CAQbROQ8v5rIW7bTn54Kd
         k28xPAqJPwRXgozgESx8VDsHWRVilN56UIaRBRzTvhR+hK1DICvq5cdjOfaGDRdm3n0Q
         CXrmAbjmOnOBktKTp7vHMBXoTZ5L3LaXxI5c2kZNbc7O50t+sk4cVSuE+sg/C32g12EV
         YYq8+cr58RgyXljVJEQ3JeR4jKCcRQEg+n7j4Jc5Z4zQ0LWbGQRghZlPCxPpzaq79k+O
         okuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/GN2hG3fsRwoEi0ji/kDw2XVbwxTZ058g5RVFFERsCMZ8aSrgmOmvoFKu6l3VzjLhhfuZ4nU2CbAOITd7tx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEEaDy3cu3S3VDYcgI2lMa6OnnovCuKInz62TkpdNJMo4nTdUz
	VfNFzHMj9e96p/t6rDQWsVOLho2p0eaV1bTs0GzVgxpoaL9fWylPLkA7/5A3pf7uEHFdBQ3H5sg
	cjKQxrc90nUpC0MF+q8a4B9mBez7YLBPDJknkXmHvxetJGeGUwxEG1lJcgTRUwkwhVbUwoTA=
X-Gm-Gg: AfdE7cl1OTnzj4v4/5feD1YepIgODe9pxu/F/2kQ8RAYOh0v6vCkjtpApPLUIlcoVhq
	F7IU6I016QE0vIkUwzcsGzV42BYHg8l9mTy9pVCQZi1aprNReri82w9vpUbtUUk+xwvfNFGzmSD
	4D0yb18Po8NhcKo/NgEHTAS90M/orEsSZs8nRQj0IouWjL66cXrYOqUaNd6XOrxN2QQKrwGBx+m
	cNgk2A/5s5hkZh3A0HPNdL7WsI3EO2y9TFj+FKMnjS1yue2BcX3OtjLT/zMCPGD3RcKSINOo4ST
	XEJNF81sojomhJEba2LdBLEJeKN4iLvwRUzG4eqFA29aHAwuyOMdigkdK1K/WW148zullqK0WuJ
	+owWRUn1xBdsBTFjCr7/CBU37ix1LoGdDs21xL5KtdgnDhW/1pAclUQIjKA==
X-Received: by 2002:a05:6a00:a0c:b0:845:ec35:6d7f with SMTP id d2e1a72fcca58-84855fd49b0mr1606605b3a.4.1783577709741;
        Wed, 08 Jul 2026 23:15:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0c:b0:845:ec35:6d7f with SMTP id d2e1a72fcca58-84855fd49b0mr1606572b3a.4.1783577709250;
        Wed, 08 Jul 2026 23:15:09 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm8146032b3a.57.2026.07.08.23.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:15:08 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 23:15:02 -0700
Subject: [PATCH 5/6] Bluetooth: btusb: Add a simple static
 btusb_prepare_reset()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-btusb_prep_qcc2072-v1-5-d835b187fd01@oss.qualcomm.com>
References: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
In-Reply-To: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 47WzBNekDyAcMfaLiof9r3q9YOfVYAhk
X-Proofpoint-ORIG-GUID: 47WzBNekDyAcMfaLiof9r3q9YOfVYAhk
X-Authority-Analysis: v=2.4 cv=GIg41ONK c=1 sm=1 tr=0 ts=6a4f3c6e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VT25rOb33v79RPrqpfwA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfXw+Wv2VriFBF5
 1ybpIpkfKy7kb4I9PgcCBIlMpJqF2esQJppv8EFVcoOcVXhz/aSMtkMHJ4kE1nlok+pA1kj6lrC
 28hVhnwynoJjjOEtBZ7SZcJGsCavGuMb9jhDoVgDaS9KDMLxpYoQCFYRSRBjx8YmuhB/Hlgcnfs
 Ezc6rCoVgCftke4Wp+xejQkmRmBZnyBPVw6AyvgASkYbWOK1vVNhvjzgSgz7cynwKOwdfRUGfaV
 rfQDianugngqZyjGyyDmLCwetejsdUX1ybeuGqYYakaJuKjBOFZ5CLw+mU3gvudOpv9SM1Aoh38
 qVzkyYh9CSIuQUn6ROlQ8HA+QHBqJynCyHSEd9NbdSNeJJnHh+ew27YMQaaoHUQjyGbyxEGrR8r
 8wMoabDuvJV31q+aA8v6O4NRHS5nsWf/8+Vs9FM1HLJq5X3wy9nN2Y7PpHHANdS+dIfo47XB+Sp
 5VEXcSpaSzQFGrO4giQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfXz5CUDPX0F0J7
 y99vqDKt+6ptAUh+vjnw7vpVBpS+5XBXYUPbCGDk0QNlGqb+etJEqxaLbXJdyYcBRInsfA6AR3B
 R/fRRktFpx2fybSCbhAbfdVZfbB8rfg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090055

Add btusb_prepare_reset() to do cleanup before a reset, and apply
it to btusb_mtk_reset() as well.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d8f076baf3dd..e914ed043dc9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2085,6 +2085,14 @@ static void btusb_stop_traffic(struct btusb_data *data)
 	usb_kill_anchored_urbs(&data->ctrl_anchor);
 }
 
+static void btusb_prepare_reset(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	btusb_stop_traffic(data);
+	usb_kill_anchored_urbs(&data->tx_anchor);
+}
+
 static int btusb_close(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2927,8 +2935,7 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	/* Release MediaTek ISO data interface */
 	btusb_mtk_release_iso_intf(hdev);
 
-	btusb_stop_traffic(data);
-	usb_kill_anchored_urbs(&data->tx_anchor);
+	btusb_prepare_reset(hdev);
 
 	/* Toggle the hard reset line. The MediaTek device is going to
 	 * yank itself off the USB and then replug. The cleanup is handled

-- 
2.34.1

