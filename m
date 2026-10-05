Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9597F483827
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202921; cv=none; b=nRc1EX1nimFL9Ugy1VcgbDjbvukowKGXoVBOMWC80UJnXe/ZN99n46e8BURJVvVyC+F5lrnbR60vcqynI5pVfj3SIgbzH8qNogHV1FGnZagYKGx8PcK3LVfdLGvaTH1ibKGtqJkzzsUYZewzMM07jxpHz6GD9HQogPu/9PiNM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202921; c=relaxed/simple;
	bh=1Xn9dR7yMaJeAlVajeQ1a98Xi3BPhNLay7aDn0ORCsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKRIoiXrHjLIao/go7U5h+kQajW+FNNee2bSf1h6/DdYUsR7//toi7yy3SoIAfWIp6ZDgvzaiAdJ+oLwgVva5i3Z/KofPynWe4CrrWESt5ZTvnWkG/u9hdcve5Scy6qCrkBZ3LXMEfxH8urTlNHC49pRJY5IPz58PG8wErSq9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cmr0TpkZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z0MG9NC8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cmr0TpkZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z0MG9NC8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFUqp1068704
	for <linux-bluetooth@vger.kernel.org>; Mon, 5 Oct 2026 12:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7YOAMYRVUcEG/JAVsfgbkUt6h7/k6zJmH94/0qM7FAo=; b=Cmr0TpkZBjjgkdC8
	Kfbc1eTI3bAz6UBLK2diptX4ZUbYDdZXmqeb62ksJ+eUwub3EflkMBFgSzXRvod6
	9Dssthd//NdSzdu+IJRnhHDTyw4vp9l/9XmX5QO0QvrDkOY3ywZXRSbJSGjxBdFF
	cfcEeQ8KQKIfkdFAqSePQXbA1YCS/dPML2/hl6n4y6Y0wrwf20/5Fk/sglNWiyI6
	xDxLSK2FrQ+fVC9SS8AQDRRGG3O+ZbbP+SSxcq9HQbD8OzuLnq/sglr171G0/+xH
	9ZZkf6IIkmHt8B6b7ICdEvrKwGSf1FiZJ82KAArTwAA09zvpPzW3D+KEQ/rIZ965
	YvZEcQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2u08nnrt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 12:21:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cbacbb996so259253485a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791202916; x=1791807716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7YOAMYRVUcEG/JAVsfgbkUt6h7/k6zJmH94/0qM7FAo=;
        b=Z0MG9NC8RQv4oznZ0WKPrAAAujIoQpFmTccpXNt11QuNdjgDfwj9Nx+hbqzw6EPNxS
         SGcGNouV+yeAU3desQ6k05www9QDDrv25klVnmke3+wD83C1R6DrGxMNeB8NFKF2bMjw
         8xinyg4FQZK4hgeVNN4HYgPS720U9tkpvXGuj0ypCjEWNI1wEIoAIZ4DKPgUuB+LgnN8
         7ZOvbAy7CpR0F2g99xx0iQIC2P8kXr8JqdkwqtMnJSafgjhidoQDG7uUn8r6nzJHJdL/
         2TlP/X05lQLXx4q4JsYn7sgDUZWGlWR/XdnCOxwgJrCs6yhjEBOc8JHSwII6VFrfoUES
         TWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202916; x=1791807716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7YOAMYRVUcEG/JAVsfgbkUt6h7/k6zJmH94/0qM7FAo=;
        b=WFRhabJbq9/Ot8XC9mL0ZVFe3DgMQPbR5W7yBBkwbq0VK+qgIt0xJam3s/zUzU92q/
         QWKYHWHLxfm4vRaG3rAHc0auXla2EZW6Ky2lcRfO6VzpCLOW+hSO6d+M50GsniwZnDhS
         /L4y7bSRf38Hlzbd9VLcPWkG695O51TuOCNvhAXTRIxV67sgx5GEB2vib7vF9soYq8ZC
         nVEmJxzQKJWcUGCYcu5wRIKW91mgpUCzP3uB51d6QZqipQ2WeeOk8wOjtco8F/ZcEYMT
         lf2HSnLiP9fuilrKFSHYGt0LmQVU+1OlR0PkAwmwmU3d4yAdLMVAobImg1ocldvXYJ1E
         dd9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxkKYnVWLBsW5y4oyMCuosdt9wSX1MjIEdRbDHVFfFEEmT7yc+gaJmWce+afTZSCssCH9ESIS+8RL92DLmUk5Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kZjGUS0UOw1GABVjicyDsbMXymQ/abyTxyLJ52JXcawKfB5AnN
	bZlN0DP8kaYXRqOxed4ovR1na0hiJk1n3KQA9Y9EVb+VakG0MUmnVbBlf1LGFFbtDgSktNFkTlT
	yc4ojLe3OkfaQ54o5N3YH+XUnnpion7WKhm9a/0HSun8zSrQhri3efl+jt3jdA5nUi9Lz2Is=
X-Gm-Gg: AYBFou2+N2MwhqDLzpF4z7uaxaQ3M7UXkcfKmYlelgsw0TPc7ZGb1vLLrJSFrCDZWcp
	xEiXkRHYiZDKYs/rK7tlW0O/coCBKyzP/ONJoTcPoesM9cNJwDb61dIx7vUL7M+M+GI3JiatpF+
	XRnXww3+xzoMkfDpgKyR5K+eNILHTPbOLrhc8TNh4XdezOCIBCIYbG+IWuNyZsWyC51NJX2KnzL
	zAmrF8lVsa6j4FRbcdOsH8d6WOchNY2sKPtELboOdfpb8ICqf0d3E27tyyFHPwYAj3OPSLI5xQV
	ow/aKvY8TiJbW6bczQ/zij9Rkw8Gha79TU3Ywn7zYZqwEqN8nqPh+JS8yxog1kcZz7BMGYyvlmz
	LKL3on4Z82b0FpPSamymTwdYPX01Mo3A5ftKngsMw5SoPyiV2mx9jIwCSxJTzrvxvcMQd3rLdOS
	sfe6TtoY4ZdPq3sWfalVUxN2nS4OMQeFtwbReQLR6nlZCM6JFF1j/b0tewUnnykOW0k1hThQ==
X-Received: by 2002:a05:620a:a196:20b0:93c:5b8f:482 with SMTP id af79cd13be357-93cf16e2fcemr1397179185a.25.1791202915896;
        Mon, 05 Oct 2026 05:21:55 -0700 (PDT)
X-Received: by 2002:a05:620a:a196:20b0:93c:5b8f:482 with SMTP id af79cd13be357-93cf16e2fcemr1397173585a.25.1791202915259;
        Mon, 05 Oct 2026 05:21:55 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm324157425e9.1.2026.10.05.05.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:21:54 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 14:21:36 +0200
Subject: [PATCH v7 6/8] Bluetooth: hci_qca: Flatten struct qca_power into
 struct qca_serdev
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-monza-wireless-v7-6-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
In-Reply-To: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 20b5VrH3olBWqP5Mia_2b8MLE2yPDNXz
X-Proofpoint-GUID: 20b5VrH3olBWqP5Mia_2b8MLE2yPDNXz
X-Authority-Analysis: v=2.4 cv=JqlkP84C c=1 sm=1 tr=0 ts=6ac39665 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=IDBDRlgmZ80N7xYWSSYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX+NYVVnyFP5Ex
 sXbiz5ATHtZ1jHhEI0IzjNbbGVpr0np9qVHcQs15ciz82zcYyYTI2LzxXIOB6g+IVJkgu4nEP4I
 QSW7A4FxIEEsLL3NE7AwTbmfl7kEYxA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfXwss5tw8TVMMY
 Jeuug/qcoqramenzAEeQlp2ytVoK3JkwLHjLVldPycKucqFAc7lFZU1Bre9Own9Qo7fvypqT+E+
 PamjATu9W9gQt5Z907DBZymZwUFFHgf7RwTxR1cPyQIm+/JVrzVpD2wDz8HuWgV2QFRjk1eBOpf
 O5nMSm24yklH8MLzKM4AZ+uKvPz/rJNq23/nuoYHlRDUGTt3QRddYsNiu/gMtqWh2Jh6eYMrrpl
 GPM3VBsF8Rtn/O6U6Q3TEWphP6jS91GuBq2Ri6LbFyU/tKqk+Wee6/WYh+FIFgt1jp3n2O5sPFP
 Ade6heqGpqeq5PDYFlWKNwmx6O9dwqtm2sD51464j3gFqkMSPuO2f2XgKRWyJLw9PjQzXsIppBX
 L5WX61CbE0j07a/u1zy31BVdKxQ7PI78vb5RqwyanGTv7LqMVaJgLCwLi8pHbdlHkmjjeXovFrV
 34CLPBxSLuBwvrohfdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050048

struct qca_power currently only groups a handful of fields
(vreg_bulk, num_vregs, vregs_on, pwrseq) that are exclusively used
from struct qca_serdev, via its embedded bt_power member. The extra
indirection level does not provide any isolation or reuse benefit,
and just adds qcadev->bt_power.<field> noise throughout the driver.

Drop struct qca_power and move its fields directly into
struct qca_serdev, updating qca_init_regulators() to take a
struct qca_serdev pointer instead. No functional change intended.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 91 +++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 52 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b6ec1a57248e2cf4bd138898ffc5cad45b1b4a8b..55a3b6c1c2ce7cdfa9e2d55a7ab97298d69b0057 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -211,21 +211,16 @@ struct qca_device_data {
 /*
  * Platform data for the QCA Bluetooth power driver.
  */
-struct qca_power {
-	struct device *dev;
-	struct regulator_bulk_data *vreg_bulk;
-	int num_vregs;
-	bool vregs_on;
-	struct pwrseq_desc *pwrseq;
-};
-
 struct qca_serdev {
 	struct hci_uart	 serdev_hu;
 	struct gpio_desc *bt_en;
 	struct gpio_desc *sw_ctrl;
 	struct clk	 *susclk;
 	enum qca_btsoc_type btsoc_type;
-	struct qca_power bt_power;
+	struct regulator_bulk_data *vreg_bulk;
+	int num_vregs;
+	bool vregs_on;
+	struct pwrseq_desc *pwrseq;
 	u32 init_speed;
 	u32 oper_speed;
 	bool bdaddr_property_broken;
@@ -1779,7 +1774,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (!qcadev->bt_power.vregs_on) {
+	if (!qcadev->vregs_on) {
 		serdev_device_close(hu->serdev);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
@@ -1876,8 +1871,8 @@ static int qca_power_on(struct hci_dev *hdev)
 			msleep(150);
 		}
 
-		if (qcadev->bt_power.pwrseq)
-			pwrseq_power_on(qcadev->bt_power.pwrseq);
+		if (qcadev->pwrseq)
+			pwrseq_enable(qcadev->pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2230,7 +2225,6 @@ static void qca_power_off(struct hci_uart *hu)
 	unsigned long flags;
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 	bool sw_ctrl_state;
-	struct qca_power *power;
 
 	/* From this point we go into power off state. But serial port may
 	 * still be open, stop queueing the IBS data and flush all the buffered
@@ -2248,7 +2242,6 @@ static void qca_power_off(struct hci_uart *hu)
 		return;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	power = &qcadev->bt_power;
 
 	switch (soc_type) {
 	case QCA_WCN3988:
@@ -2268,8 +2261,8 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power->pwrseq) {
-		pwrseq_disable(power->pwrseq);
+	if (qcadev->pwrseq) {
+		pwrseq_disable(qcadev->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
         }
@@ -2325,23 +2318,22 @@ static int qca_hci_shutdown(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = &qcadev->bt_power;
 	int ret;
 
-	if (power->pwrseq)
-		return pwrseq_enable(power->pwrseq);
+	if (qcadev->pwrseq)
+		return pwrseq_enable(qcadev->pwrseq);
 
 	/* Already enabled */
-	if (power->vregs_on)
+	if (qcadev->vregs_on)
 		return 0;
 
-	BT_DBG("enabling %d regulators)", power->num_vregs);
+	BT_DBG("enabling %d regulators)", qcadev->num_vregs);
 
-	ret = regulator_bulk_enable(power->num_vregs, power->vreg_bulk);
+	ret = regulator_bulk_enable(qcadev->num_vregs, qcadev->vreg_bulk);
 	if (ret)
 		return ret;
 
-	power->vregs_on = true;
+	qcadev->vregs_on = true;
 
 	ret = clk_prepare_enable(qcadev->susclk);
 	if (ret)
@@ -2352,38 +2344,35 @@ static int qca_regulator_enable(struct qca_serdev *qcadev)
 
 static void qca_regulator_disable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power;
-
 	if (!qcadev)
 		return;
 
-	power = &qcadev->bt_power;
-
 	/* Already disabled? */
-	if (!power->vregs_on)
+	if (!qcadev->vregs_on)
 		return;
 
-	regulator_bulk_disable(power->num_vregs, power->vreg_bulk);
-	power->vregs_on = false;
+	regulator_bulk_disable(qcadev->num_vregs, qcadev->vreg_bulk);
+	qcadev->vregs_on = false;
 
 	clk_disable_unprepare(qcadev->susclk);
 }
 
-static int qca_init_regulators(struct qca_power *qca,
+static int qca_init_regulators(struct qca_serdev *qcadev,
 				const struct qca_vreg *vregs, size_t num_vregs)
 {
+	struct device *dev = &qcadev->serdev_hu.serdev->dev;
 	struct regulator_bulk_data *bulk;
 	int ret;
 	int i;
 
-	bulk = devm_kcalloc(qca->dev, num_vregs, sizeof(*bulk), GFP_KERNEL);
+	bulk = devm_kcalloc(dev, num_vregs, sizeof(*bulk), GFP_KERNEL);
 	if (!bulk)
 		return -ENOMEM;
 
 	for (i = 0; i < num_vregs; i++)
 		bulk[i].supply = vregs[i].name;
 
-	ret = devm_regulator_bulk_get(qca->dev, num_vregs, bulk);
+	ret = devm_regulator_bulk_get(dev, num_vregs, bulk);
 	if (ret < 0)
 		return ret;
 
@@ -2393,8 +2382,8 @@ static int qca_init_regulators(struct qca_power *qca,
 			return ret;
 	}
 
-	qca->vreg_bulk = bulk;
-	qca->num_vregs = num_vregs;
+	qcadev->vreg_bulk = bulk;
+	qcadev->num_vregs = num_vregs;
 
 	return 0;
 }
@@ -2422,7 +2411,7 @@ static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
 	if (IS_ERR(pwrseq))
 		return PTR_ERR(pwrseq);
 
-	qcadev->bt_power.pwrseq = pwrseq;
+	qcadev->pwrseq = pwrseq;
 
 	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
 }
@@ -2471,7 +2460,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		/* M.2 connector modules are powered by the pwrseq acquired above. */
-		if (qcadev->bt_power.pwrseq)
+		if (qcadev->pwrseq)
 			break;
 
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
@@ -2481,7 +2470,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * let's use the power sequencer. Otherwise, let's
 			 * drive everything ourselves.
 			 */
-			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+			qcadev->pwrseq = devm_pwrseq_get(&serdev->dev,
 								  "bluetooth");
 
 			/*
@@ -2490,21 +2479,20 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * through the power sequence. In such cases, fall through
 			 * to follow the legacy flow.
 			 */
-			if (IS_ERR(qcadev->bt_power.pwrseq))
-				qcadev->bt_power.pwrseq = NULL;
+			if (IS_ERR(qcadev->pwrseq))
+				qcadev->pwrseq = NULL;
 			else
 				break;
 		}
 
-		qcadev->bt_power.dev = &serdev->dev;
-		err = qca_init_regulators(&qcadev->bt_power, data->vregs,
+		err = qca_init_regulators(qcadev, data->vregs,
 					  data->num_vregs);
 		if (err) {
 			BT_ERR("Failed to init regulators:%d", err);
 			return err;
 		}
 
-		qcadev->bt_power.vregs_on = false;
+		qcadev->vregs_on = false;
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
@@ -2538,10 +2526,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	case QCA_QCA6390:
 		if (dev_of_node(&serdev->dev)) {
-			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+			qcadev->pwrseq = devm_pwrseq_get(&serdev->dev,
 								  "bluetooth");
-			if (IS_ERR(qcadev->bt_power.pwrseq))
-				return PTR_ERR(qcadev->bt_power.pwrseq);
+			if (IS_ERR(qcadev->pwrseq))
+				return PTR_ERR(qcadev->pwrseq);
 			break;
 		}
 		fallthrough;
@@ -2565,16 +2553,16 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
-	if (qcadev->bt_power.pwrseq) {
-		bt_en_available = pwrseq_is_controllable(qcadev->bt_power.pwrseq);
+	if (qcadev->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->pwrseq);
 		if (!bt_en_available) {
 			/* The host cannot gate the BT power individually.
 			 * Treat it as always-on and drop the pwrseq handle.
 			 * The descriptor itself is still released by devres,
 			 * so dropping the handle here is not a leak.
 			 */
-			pwrseq_enable(qcadev->bt_power.pwrseq);
-			qcadev->bt_power.pwrseq = NULL;
+			pwrseq_enable(qcadev->pwrseq);
+			qcadev->pwrseq = NULL;
 		}
 	}
 
@@ -2612,7 +2600,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:
@@ -2622,7 +2609,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		if (power->vregs_on)
+		if (qcadev->vregs_on)
 			qca_power_off(&qcadev->serdev_hu);
 		break;
 	default:

-- 
2.34.1

