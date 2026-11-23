Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429540;
	b=dHz9g4lrRD/QwLdMsy8iAuArk2nE//1H9kMvIrbzFGQD3FCfVKEKLO1UO61B+S2w4XOZ
	 WJ4mkJEh+++SwJHlZ1S/fskuYEDlUFxalG0s/pZ5H289CKljh+dLNzepp/R6vCpwIoDXn
	 NViyrk53oggFRWWawBX45OWMF7RgQCnl+Oh3Om3y7ac5sLMOQtvwHdiAiyADo19RVWwBk
	 Gbcik1YBf9UyvNRMGrRYjOwOYGP2FAeapypFKPqlVs0jws54pk/WtGc123cqc0PVlBsnA
	 hz1v5UUheRUfT2pWyiX8+bAkK+PYx+ONKR6p5CO/ouV4hoD7FUHXYkJVbq9b8WxCBuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429540;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=adhFQLImZQirbFPoLtUf2pZq/lJYN4GsRu+tngxUkCU=;
	b=1scJRVgAFIVMJhMgXpY32XwXstYN+ZfhH78bh03dXQiKJbn19Niv1tgEzS0zbGG5WhmO
	 UEfLPa8rSa2nSmXaOqLNOSNQe2CdLq9Sj7x74HJmO+/YE30AZiXO2QCumecxf6gGmjW0I
	 FVvoBvQoVjviPHDqn1QXI2zffLYLB6UG4jt7CSYFy5/3BhlYDQafg4Uayl+qL6lrD3f6f
	 aX+CNvn6cc2Q3r/09GAZ6wKmHTGCxycjBJDWhXMk6LRAEwS4U6Qqyfqc3zK4gNOv+If/P
	 /irTiDgc2oEkkwjISyQEirN6fxk+ZAD0sCab6VZ7ng0hk+4t9o1LdI3hWVFlugciC1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Uy87OOjD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="NMic/003";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88305606A33B
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88305606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Uy87OOjD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NMic/003
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9G69A1899666
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	adhFQLImZQirbFPoLtUf2pZq/lJYN4GsRu+tngxUkCU=; b=Uy87OOjD+M+H/Cgp
	W4Mm0/BO1WugRB1SeYHgWze84y/G6wDJpnIYqP2i1iXA9SXj8Q5a7acNJvc6eVtB
	gA2t57cXgdFgPVtlJ9cGFfxdggXcYqc6obSojxKxYswhTyLVmM9XErKydwMk533k
	C/Yjn9kst64NcM0bU2oiubzAgrTP/HRzOqJLs1i/Zd/b1aNGGQqkDRgPj8/eTBLB
	cvddWDshVee3WCuICoTPweQsqEks4lDcoPuwc7/AW/i6NLQ/iE23DYYwJ0l/RATi
	kzVVyFaPFe3znakGyzW07wlgzzLlt/J0bKA11gZlhm2E2p1QJRnsVjo5dJwIG/k8
	vdDr0Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k0xhv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2c0e6653so497661985a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 02:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429538; x=1796034338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=adhFQLImZQirbFPoLtUf2pZq/lJYN4GsRu+tngxUkCU=;
        b=NMic/003iKo2gWqt0MmxRpp+Oy1YuG/JH+556AEirB2aTjFAaBkvsdd4K6e8m0oL4h
         ffNaHMmlGiT9oAtIDJR2fZiGQcepAquml3k4iGjvae4fv4Rg89BAkpOQ7wMgjauQ1OXj
         UhZ7oBnFaR3POPqoxNXtoemVHAdFrfTSJC5hOlPT3RXR8Cx5ch8qp+Jl3PdMkT2BsY0x
         ONqzXngc7N8G2MMc5eL/8hxC+ezJcnXHMmVmyl4/rYRh6mCpvQCcZZeZ7anxAuWTwCu8
         FC10eFvML8YbKn8lxxA4aH0KY5AFluAR4vxDhHZ2bU3rUusFoVwJr1+lRjYpdIp6ROQb
         zqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429538; x=1796034338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=adhFQLImZQirbFPoLtUf2pZq/lJYN4GsRu+tngxUkCU=;
        b=2Dmrfzyv6VRJrNf23BLesbxSbymVkKcYKLI0C6xBdpvQp40iM/EgNYaRJGsEIxLxjJ
         s0gIaEfRUQBmnFaGGvi54t5zWlgiS66w/2WYskU30w07/TRwgKS2LpbQLS1c/0J4nLVT
         8RCYUHCMqINckNB1w/04CvydGupdxptnUMBj9zpZWoysSewsmfgYPEtuo7z5065kwYZK
         +MNZod3VE66lVRozSM1hKDi9JBXMPWvrrICS/pY385waTbr/tXzibJSn0+wfKB53wBgx
         gG3llk7r4e5mtvhLRCm8KnExVyBfNhkyFZJ9J7AZk1Y7QOfIeEsTuUQ0VIfvChf9l87m
         1d7g==
X-Forwarded-Encrypted: i=1; AL+hErEgYX30GnPxoIMsnb0oIOb6ReG0Frs1EzP1xZ4Fi0AurJhYI2bsW8LHoV0VJqW9d8mnEXtMLfgkyPRIs++dirc=@vger.kernel.org
X-Gm-Message-State: APuU4Z98uwornunM+TK1kPRx1/TrBWAWly+qyd4Qh1LzoCuOiNf9VKuQ
	nT20XUUza04Ky0tQy6Yd5hi5SfDPYtOjszeHCwH1pFdh7Pyku1iCZ6rUZrs3nIPRfX7n0sj7LH5
	YFeVd005Eb+m9735/my3pHfD0Xagi0f55fsRXEmBIQt1mF0g9WicjKCQCKxeOsP3+wieGNCg=
X-Gm-Gg: AZFdTZdY0ML9Sp7lPYhCjeMoXCFlNvb2kRCfnmZVzWDnbuxf7ozcRulL7hocqfB9aL9
	Lx6sregwj0gXS3miTidSWL1gjwaVOjnOWJIojH/moH7s6lQhwaEdZi6XZPpxBbFA9ShTY2J14su
	ZDlyUqvFmyNTUASxIaKojLtkFXqLo4ONchZheQJK+AvOsX2CkoDdJcia7ngsOR3fMnejY7qARKd
	NlV+IOGFUGwsJ2OyomkW8RK5BMIqiDiYZ/NGLiMeuVtYYnUATLUYdd9H8/KTAwalKrNY3pSDFRA
	js4SuJ3a23YLtsAB3hn2KS2LU/PpvQ9eYF52NWWoGlsDTx6BBSWOSrdS3zQZ45/stDj6KGEMjcc
	HpBcIOZjAXdFN17xPSNHx8hqRVmHLVdTvX9YVDEdDsoaEYdYzZ6lUlyoRKOcSMmK1jKpj6KfoZl
	m6TB0oU3JRqgBRVYU7NcksJAv0cNg8IKl9W0/1NjZXQjx3phyzE7ZgRVICIT1qpf0WlxRMYJJ5D
	l9cPj5TMfZb8UhYL/SJhgJWIVik
X-Received: by 2002:a05:620a:280b:b0:949:5e26:e927 with SMTP id af79cd13be357-949bac774f7mr1912582885a.73.1795429537868;
        Mon, 23 Nov 2026 02:25:37 -0800 (PST)
X-Received: by 2002:a05:620a:280b:b0:949:5e26:e927 with SMTP id af79cd13be357-949bac774f7mr1912578385a.73.1795429537376;
        Mon, 23 Nov 2026 02:25:37 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:36 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:32 +0100
Subject: [PATCH v8 1/8] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-monza-wireless-v8-1-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Jesse Casco <jesse.casco@gmail.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX+La1vQm8Z6OO
 9/y7aPs52Y/MQ1D3n0Vpe4oFYexw4M1HeOqyRhzucY35x7OqCYR9fEBoqo3sOJ7HyBJbt+qYn2B
 K7invzKsRJ6IZKcikQ1KODmOk+6lPrc=
X-Proofpoint-GUID: mF-ZXGylNjCRJMj7j7PypRIDt9eA7sl7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX2uBncLZpWLEL
 0zvSPKl7XpQvzr5F1rmTtNycih+Pd6ue80COa4HMsPMhkUl6MK8mAegBgc+1B0AyFXgI77b7W2R
 24pWpZRUvTSCl80ah6z/xrhIKXOd39S+rZxpPKRTpALr7k8HXfnYhNoEt7bo7hVv7NpG5n0+MWr
 fJgEzKiQqn/VsxqhhkEQ+3X98XC3mZsE2AI6+onrts25uzvozc/6NsS1Zo+18n61DI9Y8dibjKT
 lEn6bL6nzQwCqquLpKQu4cJN6x+cH1aKAPnmduumkV1gQWQQvn+3BxZ4l+Sf63akrm4zB9FFS7B
 7LbYMGqCKHP9FdmMHfLUshAJujHIE4FD3wm2X/RKi2gemH8YAC/tN3nhrV5ThlmT5BHoEZQOQq4
 gaE8VQCMqzDLJLm2Rd6Ss0wtWTnGSWgddOnf3vGpr7U0Wy/GbrrXhl9sd1OdiWvSD2wdL+dzZSn
 gXAe6mM+dCG3Fwotbtw==
X-Proofpoint-ORIG-GUID: mF-ZXGylNjCRJMj7j7PypRIDt9eA7sl7
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b0414a2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=nT8YUeIo8neH6xSWzyEA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support for
getting the pwrseq device if the OF graph link is present. Once obtained,
the existing pwrseq APIs can be used to control the power supplies of the
M.2 card.

The descriptor is looked up on the serdev controller, since that is
the node holding the OF graph link to the connector, but it must be
released when the Bluetooth serdev device goes away rather than when
the UART controller does. Acquire it with pwrseq_get() and hand the
release to a devres action bound to the serdev consumer instead of
using devm_pwrseq_get() on the controller.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
Tested-by: Jesse Casco <jesse.casco@gmail.com> # ASUS Zenbook A16 (UX3607OA)
---
 drivers/bluetooth/hci_qca.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 158f294c18902a0908a400fae552ed5ad9fe0240..998796ea618822298d7f956a00c6c50f14332363 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -25,6 +25,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/consumer.h>
@@ -2430,6 +2431,46 @@ static int qca_init_regulators(struct qca_power *qca,
 	return 0;
 }
 
+/*
+ * A BT device attached through an M.2 Key E connector is described by an OF
+ * graph link from the serdev controller to the connector node. Resolve the
+ * remote endpoint instead of merely testing for the presence of a local
+ * 'port', as some device trees carry an unconnected port anchor which must
+ * not be mistaken for an M.2 connector.
+ */
+static bool qca_serdev_is_m2(struct serdev_device *serdev)
+{
+	struct device_node *connector __free(device_node) =
+		of_graph_get_remote_node(dev_of_node(&serdev->ctrl->dev), 0, 0);
+
+	return !!connector;
+}
+
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
+	qcadev->bt_power->pwrseq = pwrseq;
+
+	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
+}
+
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
@@ -2490,6 +2531,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+		if (qca_serdev_is_m2(serdev)) {
+			err = qca_serdev_get_m2_pwrseq(qcadev);
+			if (err)
+				return err;
+
+			break;
+		}
+
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the

-- 
2.34.1

