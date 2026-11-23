Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442177;
	b=QbK06KXXqmDVXbOVTy5qjJFj++F6Ar+6sboYKYCOG1cthezqElmAJMsceQjgRl+Vf6Bf
	 wxpan4cq2qyK25CxB8UM2PqZ4fNSL8v0QtO3V3TS+ZjdEEZF1ABAblv1Kl8Gvu1H16MXq
	 Y/67DmewXWhY7l8iQBxLE6zZv1jyl/8XLF2ULf5a8lrmO4c+Wl8ZEP67w9FSw46b+Slul
	 SjOwK9S2n3yFAZoiot2vPiIHMzKXavgd7ZnX9OFDsO8t+srqZ53/yVr6v2VKPziBW02rV
	 OeN2oLPg0c+oDdxMSfDs7fyl0CVHx8Rwe5DWBkOR/DydvgqquKTKbZus6/sBtRA8lYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442177;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=m5HVoyvcOYYPn841BrG9bcSw+LozVDgWcsxFSE0WYck=;
	b=QUpJu1evqWrAuqcKeY25SF6cIjYWKUOkpU/deCS9Rem5FygE13EhzJLZewOPTK2uHihE
	 Vy6Vz9zJH77a1WmUs003hcw9Mtm0a98jAmqXMm1SLNGqMqT2Rxdx2d5KhGACzHO4/IO6Q
	 cvtwkbhsbRsgiUFBPFQ5cKJ+tjiU+bWSRVtfFOQ9wYZJy1a6tTigQyhxfhzRgecVzReQj
	 /oUhOwvs78kCg+tSWq+DrLG9zwzfXBOvEhK0owJRW75EwlD3CoRHIUbZBZDKiTjk5KDGd
	 SXbMMqAf7WkEkpvSQucHJV9W6nMPzZ7uyx2UFkvtlN71JA/fPo33jldNJou+4zpTxsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cQwhuwMK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iOlVOy8+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B816606A6A1
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B816606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cQwhuwMK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iOlVOy8+
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKwlg2442725
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m5HVoyvcOYYPn841BrG9bcSw+LozVDgWcsxFSE0WYck=; b=cQwhuwMKG4HuwC/w
	C5jRFE9QyYl59JDVP3l79g5VRJB+LHFLySF4CDEcrB04fxFXRZLVYm2k5Dh71dX7
	mYgiFyAB1p9E+GHRoXXYyrGajeGvn3I1dFkHc+ow9riNQVBFP9YX9TPjgtQw2htb
	81Y8/LgBgmU+2Wq2Y+hFewPITf/wWAbGpsB9lmclX9iUQfSNC7K7Y8BAWYcHAxlK
	AAzKKu8RUMJf1RTMdvl5L26874RmOCqQaa6G/61JxXkOLUyvGZihI7uJ+X24O2cX
	Vw5C42XQJsiU7oLlL5OK2/PNpWsht7IHuOvKqV8Fw+35yD8EmhH4mwspAnAAeW68
	fuWleg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k1nm9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 13:56:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94961511b61so564731485a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 05:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442174; x=1796046974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m5HVoyvcOYYPn841BrG9bcSw+LozVDgWcsxFSE0WYck=;
        b=iOlVOy8+2jJ4QyZnpcc+BtQXgi8jEnmqKrEXMW6iTfqUntot4pwLR9uXv9pMa93drA
         EaQ3xFgiuVJS9/69C9F8ekgCfwbD1Rit2HfywZlgOT9IcMvZ6+6YsBcFGMLFI3VGSOxD
         us9RD5K1W1YYOwWdqqbebsUxlD5lqS7bF1cD7nhtIksg+HXNsmvukQPz5Vy19wQ7gHbs
         uZaVRT4Jiqsxk0jP6ayuYXhiBryCk1PwskMIz7UX4xuDwPP0IXbw3e4clQ3zcHwbIa1r
         MLYeO8h6FmFEAhRqdR/FeS/mDIwI9l9BsvqI2fJlkqzgm2or4cxEY9l8cNN0RVyZxqku
         7trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442174; x=1796046974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m5HVoyvcOYYPn841BrG9bcSw+LozVDgWcsxFSE0WYck=;
        b=MVeGIUdfDNiepTutr+qAxvpHB3bEYegaQV67Vqp8+a6L1hieXNVzhuTmNNzrU8Vol6
         YmyUw3IHOzgMWLDdEWK0o/c1QCCwho/jFCpqd7Y0vUIsqyyTGvd0EvTJcHLvbny+R5a5
         9/WnaQIbZ0sf3Wi9Pv41WX+0UKS5Xa1YD9GExF/pCQAnWX60oZPeSHJGCGNZd0ceQBFY
         S/NeVwmqYu7KGUXZ90TsmJC/pHE91v9vHn7xcpTlp9NK0rgnt1S3GnNbNQ4YVq/Sgywg
         BqC+BztlP031+jzbDfgSFcz31Hq0HR1kN2AN9mckLPulAFqbyYwQDVlxAUeheeylnVPF
         sCdw==
X-Forwarded-Encrypted: i=1; AL+hErH0ZCNgnIk9lCWxuxjXFqS9QqPOAGU9BQllwnMF4VajdLdJxxGnkrC9QOn3gZtimQnCdS6bJeurQpnLUDZMXpo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VefWYuMM0pYqwP2eOwNefHNTyYpyP316kkukqdBOXOisHqiIS
	I2QaIMnigNCPUCAnlwfv2zqMEgHlEHF6ryO+zlRq3aFmYopFAoHzZaPPaVg/vUX5MAvNN6oimfP
	LhAzyXktywtdjRyfIUl9BSfkK6g9eX7vP0pdIJoyULP1A6mN3ZWkuQzAHtvFml7ooR3rGJOQ=
X-Gm-Gg: AZFdTZdJxoCAddLw8qlr6QqES+TGZMteTb/SdpL3xawj+Nt9koH/p85RzTKQ1ZJKGd8
	y55LvEWrZO+Fg9IUgfLNkeBGNfdqiQ6NxLc5HiPTZb7IVpDlz3VFV+toP9EuXnKfSBZT0aUWGoO
	AyVMI3oVz8DJKILfGKAaE2xnOsrhHNv0aO2YarxtJK0hey6Ff8xFZYd8yAs/1v4HrJ1frHIKwE+
	X9MMWvaQqsFbCj2YyIbmhOpFZWLTDLvlGWcV/2M9+483tE9vv8AyYgFdYbn76sJ0V8exok6EkQD
	tGbQLE0yrDs8Q+h2QohxOaK2PZnuTdrvA4ua+PqOz63/AFommI6FHuChjotsrUuhzpxfFhsxEed
	qQDU8E3uB0i2aPFT4bMSspStoO/LCWxoekY+4aDAUkGaw34LVS5YDrQtFf8LQS/Gmm5xAFG0ox5
	zkscS9b/zn3RPo+OnXxMKftoseu2bFwuKugNsrrMptEWarLpcjJ5o0aGTIwCJtgLxEHQ/xeL5tv
	jErT88zJaFfrtEMTFPTZrmEfuXJ
X-Received: by 2002:a05:620a:6011:b0:93c:c1e8:6504 with SMTP id af79cd13be357-949ba9555e2mr1786390785a.23.1795442174328;
        Mon, 23 Nov 2026 05:56:14 -0800 (PST)
X-Received: by 2002:a05:620a:6011:b0:93c:c1e8:6504 with SMTP id af79cd13be357-949ba9555e2mr1786386585a.23.1795442173721;
        Mon, 23 Nov 2026 05:56:13 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:13 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:08 +0100
Subject: [PATCH v9 1/8] Bluetooth: hci_qca: Add M.2 Bluetooth device
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
Message-Id: <20261123-monza-wireless-v9-1-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX+z/66/bFz86E
 SKm5BOBcr8XiUjvLsjmMp2HCBvlgwqheti/hg9NyKB1s/zRYXVgCGiuu2BtFsAvIV0YjGowFr2Z
 6qgmHFH+23IqsWIi5DFqwMG/Ia/9v5g=
X-Proofpoint-GUID: K9TV8YH0C8AUmGyXO9iLBik1OQPSl8CZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX4do8F/IN6Jv2
 DM3prDXgp+I5zWNhWMNvONnm+b6PMDGg8hcddMROAv9jdFR4RqPOKoNcOphSuV0HmZCQx8ZCVi+
 zmLuzdCF+95SKqQi6myF3y7L/f4jtxgDDiu+mN6FimBRfr6GtlZOgDVcUbBxeVjHewT9kk7s506
 MpVjY+2QrkE5CbxDwZiD/PO+e3p6v8yXAS/TEQOqOy//PA4pv7UZI66W70hu4ORUvruQsWRJQdL
 jQnlPFULnY82tAL1i8CFdbwcR+PF7wjiypLdcaESKdVo8z60/IOOKA4I4zMJTvcmxhCkYh+lMxX
 Z0t/3hyQh2Sfhth1+FtlHf3+THOl8ldKLCqS9M7FduhD3xgYN5Gjsfs/oJX/DhvMPWrE4mYwc3H
 iN8HuESZflbZmouMlGvwkT17NAPLAfDa9Nh1OnzGLjOHcKgC5e2Edg1JEIqCPwWBt3iXCXyTaog
 EydEkkdGj7nM6xUweyw==
X-Proofpoint-ORIG-GUID: K9TV8YH0C8AUmGyXO9iLBik1OQPSl8CZ
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b0445ff cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=oxJxktCAzv21rYXR6MwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

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
index d693e28427251e9357019c192c030b837ebb2bb9..c4e42c9542adaddee17e256eb017902ef565025f 100644
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
@@ -2491,6 +2532,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

