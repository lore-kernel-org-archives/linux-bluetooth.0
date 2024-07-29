Received: from mr85p00im-zteg06021901.me.com (mr85p00im-zteg06021901.me.com [17.58.23.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91A18FC8A
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270140; cv=none; b=g/o8VvSvBk8WLMq8WuU3QfjYFo8yWWpqqK+0LXKZfrLzEpq7PFO4rj5+mysqfm2wqnmJEsy6M2w6cAq5bnaQrHdVbJxG6Hbr9KNRfjg/l+BDkcIIG2lBW1kWYuMIreQQj8qRCk3TfV3FbE3srwffWbZXhLpfFoGSjvW3V8NLxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270140; c=relaxed/simple;
	bh=GXSyX5h32pZlR3NWWUJpZoFglo7EuA94+siR4uBo28o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QKDMLLsl86uK7XklT4m+CIBaCEfXz6/uPsUpqt1hsAimdYf0sMgsF6t+hgjRl/43qaiukJElODOb4uhuheES2xYZ4yOQX5EjvpVK7ZbXILm2+3HEuoJJ/2UWppkvxVqrUetG1B53PF/SvAzPYy3fmT9+sb1m3GDwzXmUJnqj8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=iEcr13/B; arc=none smtp.client-ip=17.58.23.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="iEcr13/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722270138;
	bh=KOrRGY8mn8r2Bejzz65Ymd7dY4GRF4aIcYISeRSMx4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=iEcr13/BeUVz8XKb3bSPrCekzh+UC4+4Zi8qB+yUXhsXrDe+uli72cwMcndPwKPjd
	 pgMIQG9TueCiUxzlGMUJsGUyV2EIOtqXiMXyf7dHA5JwpLxeSX4GB4V4Obapt86IL9
	 4AbbmTuy+2S6nA63PuVaF/V21cQPrew4U+XuOjbFifMUgDXybxSSOzgnp9XRK9dy/i
	 bJd28cccdTA/u7H+u22edj/Luv6oQu+N1RiqCNDfFs1tKrLN7yDWmD/l9RJBm0116t
	 dtvWmCHl7eBjOXwjiKumwbZl/vsiouG2oLr50j0JesAHbah90iO39DQ/WkaXMb/5kX
	 3cwF2tfCJj2rQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021901.me.com (Postfix) with ESMTPSA id 4CC657402EF;
	Mon, 29 Jul 2024 16:22:17 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 30 Jul 2024 00:22:02 +0800
Subject: [PATCH] Bluetooth: hci_qca: [Don't Merge] For QCA6390 regression
 debugging.
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-qca6390_fix-v1-1-e0340a511756@icloud.com>
X-B4-Tracking: v=1; b=H4sIAKnBp2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNL3cLkRDNjS4P4tMwK3ZQ0izSzNINEUwNzAyWgjoKiVKAw2LTo2Np
 aAB57uKpdAAAA
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <zijun_hu@icloud.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: g0MgE40dmEhtsC5Y8eiwxiJILOY6KgUU
X-Proofpoint-GUID: g0MgE40dmEhtsC5Y8eiwxiJILOY6KgUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_14,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407290110
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

For QCA6390 regression debugging.

Signed-off-by: Zijun Hu <zijun_hu@icloud.com>
---
 drivers/bluetooth/hci_qca.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ca6466676902..3ae014af7f1f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2187,9 +2187,12 @@ static void qca_power_shutdown(struct hci_uart *hu)
 		}
 		break;
 
+		/* what to do ? */
+#if 0
 	case QCA_QCA6390:
 		pwrseq_power_off(qcadev->bt_power->pwrseq);
 		break;
+#endif
 
 	default:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
@@ -2418,11 +2421,25 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_QCA6390:
 		qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
 							   "bluetooth");
+
+		{
+			long x_err = 0;
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				x_err = PTR_ERR(qcadev->bt_power->pwrseq);
+			dev_info(&serdev->dev, "x_err(%lu)\n", x_err);
+			if (x_err == -ENOSYS ||
+			    (x_err == -ENODEV || x_err == -ENOENT)) {
+				qcadev->bt_power->pwrseq = NULL;
+				goto do_default;
+			}
+		}
+
 		if (IS_ERR(qcadev->bt_power->pwrseq))
 			return PTR_ERR(qcadev->bt_power->pwrseq);
 		break;
 
 	default:
+do_default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
 		if (IS_ERR(qcadev->bt_en)) {

---
base-commit: 7a27b0ac58abccdf46e89bea9ed9f81a496132ab
change-id: 20240729-qca6390_fix-df8f6f0a5070

Best regards,
-- 
Zijun Hu <zijun_hu@icloud.com>

