Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A737C907
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218730; cv=none; b=kqnH0lVDv7Rq6GUnaDVxBX04AmSDQGjRFV9mTx6NfE83N978h4yuIIZUaEIGPRUOLfbdzHGEOBjkIDKgKSoWBkm+qkp5Z68p7Tb7e3k+rF1PUsiJaxxKwglLPmzzkevVSn3cLwBghm1jNbxaWdVosT0/LuX/WvXoCAK7FiBZYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218730; c=relaxed/simple;
	bh=Xp5FK98F4aXVm1IaIUQg7a8ZJjOswS0wCMRvU+2daPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYaikjS2aBPINlhkYIE+qvgVez9e6MBb4jiTtwCxD/aZJawblJZ3eGNj0gQTyyDSlLPN1qu+Xux9e4dITHAqUruFpnBYw0vRx8fgA5kFl1LVMI+OBOdRMywQc8TfX1Gh78OhZWSFzatXhbYGwUf5DVEu9s4lVt+ALsE7f1QA3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qt9HQI1v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ICFh8BX7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qt9HQI1v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ICFh8BX7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJmYf2734528
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KnNGLFZg8KBKoCKQkuNws9wP1R08Qecii+OaAbhSdTc=; b=Qt9HQI1vaCGtbfBA
	SyYNQAwcyr3yHQqJVYqzqZqd+cZhHgb/Jl6W8i0VtNlkGJY8npAPSaKcyuAigC9y
	LoVjcmqvwnqbrCy/wjM+VQ8JfFk4VDCHrF/1d9uXZzWvadgFMrZI3mrpwbpH+uLU
	YQMX/zShurTmpUekIIYcDH8a4byUacD7taKw7LTF+HdHSknXVTA2QGsYQYdJxvLa
	P3g+mKHbdufnTaHjARHtfkWhLBHCYXllDmyf7QC+y0D/L2AuOFz8DB+KfotvAhuy
	dAdMUBaCv2VvFCwCwRdlYGrJ4JOCvDSHWWcVMFr5w1Hh3qY7oUQT16vz/n+Igab0
	VfSEgA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv1ugh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c20762d21so47483891cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218719; x=1784823519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnNGLFZg8KBKoCKQkuNws9wP1R08Qecii+OaAbhSdTc=;
        b=ICFh8BX7ccbDB6jf5kd0uhOljt7zkj+KAfNIHAkXKCe3bvTIGqK2sVEMmV29gCBQrb
         hOKynCz1EyaQHeDNmlO5EHDoEsjmzSPtem9GRulzp4i7ohF4642tDKhujGu4V+An5k0q
         PH25wgFbc3FpfADj1maQZishNT6EsrcIqKztk2j2tcIsanCFW1a8vmzBILvn5Mzpcmsc
         vHy17mXI5FuVp12rJGPYCU/MzKRc5koE1uHb9bsIQgnhYwvvPaQHwuU5RcYH5gqrRCpj
         XUa6bn7AWiQva11m3Ly7HRQ12K6CEhxlH/YFDglg5OfcNNkziQMMgLDIUtoBpG//rDDb
         y+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218719; x=1784823519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KnNGLFZg8KBKoCKQkuNws9wP1R08Qecii+OaAbhSdTc=;
        b=Udfwo6UMuGTbJYqA/Zu3QYdOjQGu+PmDAkPAu5VdNgfBIu2KucLK8qE726dftkj81B
         GWiXMZZB8xww/g65Xbhif3/a+PtYry/ZUbsnhh+JngaYL32p7evMnn1IHw7Tbh4Xvom+
         JKRxZck3abdJy+FI8u28kb1f4/Md7GjgENaJlR2obAOR6AkVfYHwruo9BTI9LT/WnBc2
         iKgJ40Ies8nekDolEFaYevS/bSgXKPEbxNBxfufTo02kM3KWIUn5RNESOjrvGI93Jhjc
         1MNPBquH/T1wVstAlXUVJX5r1GHRSwrwfAGDqRIlm4qPOrgyWtrxVPR1jW+hOyS8Rfsj
         M7Wg==
X-Forwarded-Encrypted: i=1; AHgh+RoMVqWyRCfrslnN6JnAMcifldz9jpnbEKhcuaLJhJQlvlUnqWcnqgXsHyhlhej+Ggjknp3hCt7z5TnSfrk942Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEzS3LBBt5rarQUsaKmIyuTUCO74mo3Q0zYvzkMfAy/fs+Sh5N
	xdzkofkZ21cMcJT4NW36ixWeHoRRsiO012mBEnZeHxi1zX29+mHuiPc23pFjQzbVk7Lj+XJ2p+H
	wZ005BrH9/onIbni3FXNaCTpPrMbUTN3RBGj35QVY1vAxBYCsz4WwCr/rm9aPfsaeSX4mYFA=
X-Gm-Gg: AfdE7ckELVTi7cchNVE2GAXCs2W8RygmTlF5Jb43QHk5KfQZTUFZXfXvjDTi3/glN52
	IpJ9tDwI/Wz5kTaeTHKc8OC5emio7NETSnD5/44Mq58oV9gayojoWe0n7idV6C/KeAL2k31c6CB
	O3rKkB7o40BQEyW7exWgRKzeeuHX9hajJ+gAjTDTdNo4btOQ+dJq5Qsk7ob13i+8Gc1v9Qhm2Vb
	ca7NPw5eWgzV9s6y4koAWVSJnIEsWheLl+Z0F51R0CsZBVyx4+br+hrTVh9rwUbIg8MjunwfS6d
	p1ppo4upqTrhM9dNPy9ZigZtczzOj+BCdw9h0jaDZLr/HWJbAedmfVzQPBaFW3fxYgZxOflV6+j
	wDjLBJk7wksq3Dsjq4fG6ffOgA1T3unTP0CdwzgL1tcLQB2tGhmIxJgkPAEISgKCfSojUGOAXNq
	2QRHrePjfWeGxQ2CH0nDI7TJkaMDjCKna/zOGhOEquPh+xHqUr94o=
X-Received: by 2002:a05:622a:130c:b0:51c:1b78:b044 with SMTP id d75a77b69052e-520be7934d6mr2443351cf.61.1784218718648;
        Thu, 16 Jul 2026 09:18:38 -0700 (PDT)
X-Received: by 2002:a05:622a:130c:b0:51c:1b78:b044 with SMTP id d75a77b69052e-520be7934d6mr2442971cf.61.1784218718124;
        Thu, 16 Jul 2026 09:18:38 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:37 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:25 +0200
Subject: [PATCH v4 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-8-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX3c3TsjrE/TiB
 o1hbodSPvwVdE5gXdb9DYgE1ptNKQS305btUeJjiuWfqie6mOjihvE9PVeI0+pso9/1IHsvVz6I
 hY8t/LOJ1qD8I82zPGTF7UH+AHr5fPZSZUbCc6/LHG74R9OZNDk+TTs3PbpfpAd/Os+jQhDUHHb
 9yGJzTfqQxadWuiaxwJ9cRsuHQcSvT45P6cGQmr//EumvIJOloqodNMu2EbsQKZXf9oC+VklpI/
 yGmUSzr9zZQgZU/XTUtt8/fZPnwe7iuRtNULQXoaApmwmftzbHmqF6+vAPbb8lEhDrPfAcyrg5S
 ak+NRQTMPOJZBb1MVuBjG4aa3cwzO7t5bsfXh5Q6MiV76MO4vuonSTULNbDZs+m1LqNnBON1ZS2
 wO8ijD36fz+vtm/dFY/lt5LrPY/2blwG+NcQZLbecMwOf9ATCT9KwZDbWfGjJTNvcTUREhjl+2H
 ozvbVCsTuLJZnRwKDVQ==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a59045f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CW3gqymaXyTMcD2nhgsA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: NkOSpqWUpzQ7hgG1EVjDrLu5yt4QyFQo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfXw4AGjjMxpxUh
 um2nbuqHTMmZLOUD3wLuw3QTe9/zsnUD/VaBsI31/eqyGlj8q5/Emm0dnZy6i6kghBGS0snVGxC
 Rn068vq3VJ8DWEpFXtrt7f47sWptOak=
X-Proofpoint-ORIG-GUID: NkOSpqWUpzQ7hgG1EVjDrLu5yt4QyFQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160166

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
 drivers/bluetooth/hci_qca.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 25c4387136245fca25e375951f960d7240116781..22f6185a946ef04c45e41b2b34126e3f58d603ca 100644
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
@@ -2387,6 +2390,28 @@ static int qca_init_regulators(struct qca_power *qca,
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
@@ -2417,6 +2442,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
+	err = qca_serdev_get_m2_pwrseq(qcadev);
+	if (err)
+		return err;
+
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2426,17 +2455,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

