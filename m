Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA833CF943
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534667; cv=none; b=X0V3/tJpkj8DPJP7ITv9afyporsyvKiqrRQhlSKQWQomQvyVUmcIfqROvCOeiDGHzkrR2ts/9gQILpRotSZxT74hX+sVrUvRSChTXDEgbru1YzWzLMGGh4+j/lH5Xic2w5Bm9M4S9PdLyc3ClKCDLeN83h1YpbpUoz5o0my3QAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534667; c=relaxed/simple;
	bh=U8KvuwhbRpvu6yox7283/96nA65nj+Pg5RSb19E+fVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYmBDHqTbQUGpgmnU49ZYkkS8fTyS0/7h4/lZNTrZWKDn++VZlQzH3WX5ngogJBV29YDXyd3hUx3bYfRNCBPS5u8NcFVcEulkP5YTMZuC7HZ77sJhvLo1BgX/ngi+//LvFxzxDh9rAiJm3xGmniKEYnFCb8sBfpc9m3XNO5WRSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SEW7l6PN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RaVBE1eJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SEW7l6PN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RaVBE1eJ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RTPr1762243
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NlR6oxj2RqcNvssqISSxd1MdkBoRpFWAjkKBrBG/ulw=; b=SEW7l6PNW4mzQ8Fz
	LMfkWiQQX+926LWkPHT9O40TIIhZ0FaQ+GMiOJTrA1/r7s3wAkURYbmKBT9QtcWX
	Dhl686U6TSQcNEHw7apYtL86ChI41II2DboJI0QujoN6fy517Y8j5HPrgPJ+SF7c
	6YxnZ9bIQ7gMKeoDIVLRXm5QB+Ujk5rCugEfIObx1c+N8AsMK+n5BhSxKS3LTYyE
	h5+Ihivtt/h/Uvl/pIRi9PFQNXMMCSZPziM7aTtDr6ALKBgEVo2EHnzJ7OBbmGeC
	QMkzSSE/W0QNkBd2aOSGcpbq9Hratd2dIczYQ0TEidO3K820YERZABSvm6hEp9Gn
	53UO8A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnn3n6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0e702df8so138542841cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534664; x=1785139464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NlR6oxj2RqcNvssqISSxd1MdkBoRpFWAjkKBrBG/ulw=;
        b=RaVBE1eJ1H0C7QjxoUIUpZx3FvkGbedSucrBCIQFoORflrFLm2MB8UTmrCu1AqxLLI
         MsBtiuzPDxwevfKwKGeg+n2/WT392J5fd7Eq7dcpWm9F1/huNMcvFKY2cEiv8BzOwPBd
         TKzQ+v71oxukMVvlAJO/5oDIxTcl7bHPcI13EueqmbeKapn/JsybdhlvmerPYXrDZJKm
         5QLvKIqBZmMKHxG56BBLztnMCWdPD8zosEHAh4aFZDQupDrcRUN8BpyeJjR3wtM/AXNQ
         yguUYDI2V0r7RE8Loy0XA41JIeKB1eChmlxmSiiiQQxerwQskItCrrf4GLYmzvbgpBHT
         Zmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534664; x=1785139464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlR6oxj2RqcNvssqISSxd1MdkBoRpFWAjkKBrBG/ulw=;
        b=MQDGfXelYS7G91q6h+RlLgpU66+t/rMuhQF1JZLjc7vpsC778b67L/thpTY4dV2yq6
         lIavvZbpQlMKZEgieMhKYcIwH23CbP+0EBN90p8LN1rox/IpfySvKJChuMuMf9gsmdF6
         /LZF6Oise6c0w+1N/wueqcQD72z6pfU6GMKXsOH5Vnpf+g4bsYIJ7tWC7LIi+413XSv/
         w0UPoIisZz145cbPoqAhKuskGHAd0RUK4ANOQqdi4bxoRTMHacsNr8cAoucHTmLt/0m6
         bkdEqBJC/onT5haQm/Rl6m8X82yR186I4WH8ehxPglb7i/TU5vgrHEY/x94THhs/BWJx
         7jew==
X-Forwarded-Encrypted: i=1; AHgh+RpqmUoVxBJxE+sgnss+0i/t8/uyxm79XQzL9dI6vTK+WGb2h5q+rNTeXuQD5C37T3CFnouA5ZeqedjbUhc1CK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Ao2zov9f84c8pykmD/hvg2bRDHI0JQ8SIatpoZQtJmrRhQly
	FIZIhr/MiFMcu1NhApGPGY2uV4XVvHlhg3+H4TBeKrxcPpB6j+Ipt34xnOkRoMyarsHafwIeo86
	MvzTABlxN6YVeXoCZAsROkTJzvsssNn0Htbm7+pxcEKpc26btjEgI/82Y8DsfYNadSYJojI0=
X-Gm-Gg: AfdE7cnAAB7Rc38uJVqDzLf5ywY+5mj7kPBYbsU6g50sCCEHXV872gUUVQNczZjnTkT
	BstdNpOK68wyKAQ2ZdK+3j9IVDMu+fxy8jpE+r0CtsnGZCTlZgS2mDvESwYE1ekZGqeG/SOmFW2
	qhNTNz9g9DDYz4tF+3hk0yBq4mk7BBRoyFv5WJp+Y8s9GsylnRr4bTcFoVPkwG5VhtWbZDQvhJu
	h+HmcLOKsYR71tIXnYUknH4JXavmoL8XvmqEdgFRsXAYEe5drAkkIfSdSVQHI8QFKO1XfibJjsI
	Zp0XSHnHrSG0Gv59ghY5g5Mm+Z635EBLQ3rtoCsN3EM1ThY75HrzpjKzhQN9foFFV0nExqFrtKO
	VL+AOQEoagqZm8ZBGcV3qdXSc3cgix/UTfaIcLO3gAu432Qu1EJAHsWMRj27dyvWH3FX3nrg5vx
	iq/cO4fsdwye++JbQj+RPkteXuNYXksaJDfdhM5ZoGDLJOyVPS2NU=
X-Received: by 2002:ac8:7d0c:0:b0:51c:7b12:5fdd with SMTP id d75a77b69052e-5213ed77366mr122378901cf.73.1784534664224;
        Mon, 20 Jul 2026 01:04:24 -0700 (PDT)
X-Received: by 2002:ac8:7d0c:0:b0:51c:7b12:5fdd with SMTP id d75a77b69052e-5213ed77366mr122378671cf.73.1784534663794;
        Mon, 20 Jul 2026 01:04:23 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:22 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:10 +0200
Subject: [PATCH v5 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-8-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX5IfwKke5quQW
 zIkaVMOOIo4J/6kNaOY5PCmMwMnS7xyR78cUeqnjYv3nDYvvXiWnhO2yY6fvRB1zTvVezhs9dlH
 kBQlK1exZV12oIpkLy1jmjZC/OKZ1uoTwqfb/WVT01ndB/PJfNUQicnr26CWs1Ph1HJLPQC6YBH
 6xtg5R0Wh96Rz11sl8V4KOwmHFRqsNiq0B5/3EDb0toJRdWbLtXM+F8UbL84hwtm9VugVlX0KQP
 k4mu1ON1tv7QPQBThMmDoKum2/+rrlGIZ2Ivm4vpCcqccyUSXDyN7LE3FifTV+KfUiScn1DK+4r
 W3nWOVSgFcBhLII2fvKizgm58gm1OwJpe1FMU4mnDczbueyokUagFnTnO+MNwv6hI8FKizkhXie
 TPPYHlUCPTeFoqlJ026TJUtc5v9MMyKIiiTHTyaxQoSmRkj1k+SOzgoBHuCKAnKdU85jxbtNEnn
 xPyVlSHW16Sf4/OwoTA==
X-Proofpoint-ORIG-GUID: vJ1Nqpa0tG5FmRczL0b4d7fxQj4zPeD1
X-Proofpoint-GUID: vJ1Nqpa0tG5FmRczL0b4d7fxQj4zPeD1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX3wlQK4V5DHbN
 Du515nfeccNHiXY/keT3tELTfhUSov1h/dNQwXJgWcq2ZgW3CdxfKG564IQ+Wui2gErsqFGIW86
 MUOB0vogFYdb1s6G04nIz1mv2Ll0B+A=
X-Authority-Analysis: v=2.4 cv=deOwG3Xe c=1 sm=1 tr=0 ts=6a5dd689 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=reVw4oyKNVL6WbIJD7YA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088

For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
rather than a dedicated BT enable GPIO.

When the serdev controller has an OF graph (indicating it is connected to
an M.2 connector), acquire the 'uart' pwrseq target from the connector's
power sequencer and use it to control BT power instead of the bt-enable
GPIO. This is factored out into qca_serdev_get_m2_pwrseq().

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 47 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7e4cb03d3db0722e5f9fa2e7a5a9a0894bf4f18c..8496bd428602c48d093bc76f9810abb9b1c43cfa 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
 			/* Controller needs time to bootup. */
 			msleep(150);
 		}
+
+		if (qcadev->bt_power.pwrseq)
+			pwrseq_power_on(qcadev->bt_power.pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2387,6 +2390,34 @@ static int qca_init_regulators(struct qca_power *qca,
 	return 0;
 }
 
+static void qca_serdev_put_pwrseq(void *data)
+{
+	pwrseq_put(data);
+}
+
+static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
+{
+	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
+	struct pwrseq_desc *pwrseq;
+
+	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
+		return 0;
+
+	/* The pwrseq is looked up on the serdev controller (which holds the
+	 * OF graph to the M.2 connector), but its lifetime must follow this
+	 * serdev consumer device, not the controller. So acquire it with the
+	 * non-devres pwrseq_get() and release it via a devres action bound to
+	 * &serdev->dev instead of using devm_pwrseq_get(&serdev->ctrl->dev).
+	 */
+	pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");
+	if (IS_ERR(pwrseq))
+		return PTR_ERR(pwrseq);
+
+	qcadev->bt_power.pwrseq = pwrseq;
+
+	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
+}
+
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
@@ -2417,6 +2448,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
+	err = qca_serdev_get_m2_pwrseq(qcadev);
+	if (err)
+		return err;
+
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2426,17 +2461,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		/*
-		 * OF graph link is only present for BT devices attached through
-		 * the M.2 Key E connector.
-		 */
-		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
-			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
-								  "uart");
-			if (IS_ERR(qcadev->bt_power.pwrseq))
-				return PTR_ERR(qcadev->bt_power.pwrseq);
+		/* M.2 connector modules are powered by the pwrseq acquired above. */
+		if (qcadev->bt_power.pwrseq)
 			break;
-		}
 
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*

-- 
2.34.1

