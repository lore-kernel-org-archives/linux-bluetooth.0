Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E41E5702
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905846; cv=none; b=BAOpTOdvlh75kVJLu86uf/f81Kb24QuaLwGxlJ2Wb1oO7RU6NdupqzFig4MWdSIlVQgDjCpPNIix5YAbk+7diIiv1fuhkM7Lx354obYxrY398Nz6PaTR/OjMYJRw/HwN3oUyxQLylHbIABZWBFILJWMz7nOTNYcBDyZDWyTYl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905846; c=relaxed/simple;
	bh=t26JZHwkQX3zco9QwTYj7pXuDqQR24HeiJZJGjELDSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sVIMe2ueIYYtzryHdEgWeTCNa0HD3z1zKOnJ+NIPKYrA3N4U62zfBxkcm4lvcjL2MYK5jakD9lPXCutSzW/hQOHjiDyiP38Z/FMTUL57F2r9gQ/aHDCJ0amALf2RPu8qhv65Blb3cRMEhWNKfL0Unp4UDdiDKVo+digIbaNUuWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fb5G/9qQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=izD0PlFh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fb5G/9qQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="izD0PlFh"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRgZP332284
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GKeKwZoXUr7FfD5C+hV9Y+ZcIM6xr5NbLls
	xaCvW3U8=; b=fb5G/9qQttMb1RAcPTb7wxmAglrpW7CEz4Hip+KZjg8wHk/aVr3
	SM7YOfLZnvDRbtfSBO8TnfUxTkDQ03NphUr+E+cI72gP4JOeiDyk6LQlEL7t9L58
	QWgrteMfezHbgRBWI4YmslbExaAzFNGD/vMnRoR99Whf+pO+Up/8x1n3a+9gSf23
	oATuc5SzFFgDKerPq1FAcVXGHgKcqpbZYKKW/XaJNVA/L3/XySibvcbgxmsd4LNS
	R8k90/eiR90cxvAOXgc77daSyAMyalfOLDAI+jVFvWY2kZDh9DE/Jjras/9JZZJl
	DuIbVu2nIt+ttF2EOh3xeNOYed4Q3b3bPrg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9cya8qg1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:17:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c5e166fb75so2442659485a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 06:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770905843; x=1771510643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKeKwZoXUr7FfD5C+hV9Y+ZcIM6xr5NbLlsxaCvW3U8=;
        b=izD0PlFhTEkHXjZFWW6tB+duR5XnoOBxhETu8yqPxJ7rzHE1VLO4Qrk16Xzuqy4CH5
         sVD1q1QXfxlLRBHcPCbhG3bczCnHN7UHQLAcIloCV4TBQ+668Eu4Hd4lNPf//6FS0U21
         4CJpjfNnOs2Uo/O51Y3FoFzcd/666dMQCqwce1hA0w1/lqwyO8kkBaTEUWZHYi+9pqSU
         91RSti+wn77XgUajdKJSp05sysmYubyu5Ah+CDTA4xD0Nc5Pg01cOJnljkaddnKooTa3
         Ac8HQm0RTqus1nmGkTc98oSTQNdyUFjzpoGapFvZX/KtNdAjTW9nIjyayv/dm3c6xL+Z
         bLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770905843; x=1771510643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKeKwZoXUr7FfD5C+hV9Y+ZcIM6xr5NbLlsxaCvW3U8=;
        b=Rioh82qvxt+WMA0TZLYaySl5QjLK/OiWOm1Bz/9Gs21x0yjoZsszaR4WOj/iF9prQt
         VgfTGcXv2i4DMUnkwaZ5oPspEVSVi7UxVp0ICt9gA5K76AcrTAxzwBjNK0NQHiS/0Sn8
         wUi0KcjR4fdx2wgiZbwnj1m15SyGYn2BGJusAoLd3rFXwgbsOi59olCiBVhxU2cvQZzi
         yXw8g/8Nj+K2zJ1HAOOpmqcEjHHAter+LwtY2CiiYHl4tlT2DT4NidoxDhlhJYxtn2Mh
         Vy/uvV/gjIaBVExH+5dnaLuhOiNVcTIXf2hmCjbtlzrtORwzzotgxUugOCDC/TovJ/7H
         jMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUujt5K7XcDp9YC1W6q5ZpK1nwPRZXsRaAZSy7QfhtE9YoSsYb197gSn/oYsgdXzv1LhwZVYs0woFJFpyo9T9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfhqcdAK4vHECgjzgpFT4OdVEYfqD2ifwW2Gu8y8UlWMzKiLa
	/VJTFAMuGvIT8Homlf575oYISxBInP96CGn5NQ9VkhUD292ADFsj6jhPbX046tzLbDJ3IzOHpVM
	bzV6o3rc+FV68yV0NRN552BoNgyDga0f8NwPu9moCv+O5vQ8D/mgfFeP0zdEAkoL2X7t0L40=
X-Gm-Gg: AZuq6aKa74PwIuAaqmBeGU+eDmHnJl+hICLtzShTj4GhDeUjRAhMmScA1kUxFC9rEBg
	lhyQXaBfup8p7V5WTT44KXrPFzxilx5aG/hh5Kz3dh/w1Uh2mha79lMH1+obCRAvbQZXZLyCqmR
	Czkl2R1tumFSmJtvWt1GAv9UIUQCdFRMUDs8VcU57nPN10kE+dVHHfiYBU9ZhOvHlG4a6An5x25
	PJOHiQRj3T/KBXxUca0NHXdghf1ZsFnIgiGzAD2XzWrFrVAga4AAPrfyyKDwOOC4Q82UDk6NBLk
	MeP0RQYAZ+58CN/fqh3rl5V/t5qY0QRMeylvZNxK+XRkUrx21fGEBUABe+KoQgE+79gZSkhjceO
	lIzq61Lw+DKUwY+AGfXhKDNAB1wiKyQ69UnU/UN3Dz4/GZK1YkIfy5iyixlzKR3yT+tbUH/P2F3
	SlDbG3bMKtNZzWojVCNaLQsBRZsKIbnITfD8kX
X-Received: by 2002:a05:620a:2097:b0:8cb:38f2:6a5f with SMTP id af79cd13be357-8cb38f26c9cmr118757885a.25.1770905843410;
        Thu, 12 Feb 2026 06:17:23 -0800 (PST)
X-Received: by 2002:a05:620a:2097:b0:8cb:38f2:6a5f with SMTP id af79cd13be357-8cb38f26c9cmr118754285a.25.1770905842971;
        Thu, 12 Feb 2026 06:17:22 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f83e1a853sm119556166b.19.2026.02.12.06.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:17:22 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_qca: Fix confusing shutdown() and power_off() naming
Date: Thu, 12 Feb 2026 15:17:20 +0100
Message-ID: <20260212141721.69961-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: n3gvvJTEQGEZZt67Ix5RGshrSlsCFTfx
X-Authority-Analysis: v=2.4 cv=OrBCCi/t c=1 sm=1 tr=0 ts=698de0f4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8 a=9clcvE9WzNz3_oQShkEA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: n3gvvJTEQGEZZt67Ix5RGshrSlsCFTfx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEwOCBTYWx0ZWRfX02zEm7jxZD6p
 QGX8f6u17tbFbXjqr/ztNErY+PvL81+Ucc9FqL2XfzMYisv7ZQjffJaa2ySGRnc1MRNSYOlvGMB
 gx8dCMH95DqoS691HW/TxxXQrz+QtbISG60CxKSczCQKXSD27Fxokff9Npp7GvMuK/IRIUOpSzo
 CnJTSydg4uoxj6NLxT0bnGGH2n+mZFXVC6QhbHDqQlgCaOa52IwJ5vmE6ch3ay+WljcZP8rwvJA
 8N2o/2NfIsPQc4iPgADAUfz09Q9zKL62WJs7pXJhndO1cRcUC+wMlE7YCHT7ip2OTEaYQhBwqjH
 ZTVw96kSu35rBrdtvTRdg1YSNrZBv6Vq/avIzTvxWztRRtTxFOmagKN764KKHoapougpjbJx/yh
 cDK1WXBRet9haibm+A8hpne2qIm45NM/ZvLYWY0lPp1JpAFj1rRsHaW+tksY0zBO6xVV+Nl8+uy
 sswnk/UO91aU6+RoBuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120108

The function called qca_power_off() is actually the hci_dev shutdown
handler, rename it to qca_hci_shutdown() to make this clear.

While the qca_power_shutdown() function is actually the counter-part
of qca_power_on() rename it to qca_power_off() to make this clear.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4d562596ebf9..fa7ab4272771 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -235,8 +235,7 @@ struct qca_serdev {
 
 static int qca_regulator_enable(struct qca_serdev *qcadev);
 static void qca_regulator_disable(struct qca_serdev *qcadev);
-static void qca_power_shutdown(struct hci_uart *hu);
-static int qca_power_off(struct hci_dev *hdev);
+static void qca_power_off(struct hci_uart *hu);
 static void qca_controller_memdump(struct work_struct *work);
 static void qca_dmp_hdr(struct hci_dev *hdev, struct sk_buff *skb);
 
@@ -2015,7 +2014,7 @@ static int qca_setup(struct hci_uart *hu)
 out:
 	if (ret && retries < MAX_INIT_RETRIES) {
 		bt_dev_warn(hdev, "Retry BT power ON:%d", retries);
-		qca_power_shutdown(hu);
+		qca_power_off(hu);
 		if (hu->serdev) {
 			serdev_device_close(hu->serdev);
 			ret = serdev_device_open(hu->serdev);
@@ -2171,7 +2170,7 @@ static const struct qca_device_data qca_soc_data_wcn7850 __maybe_unused = {
 	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
-static void qca_power_shutdown(struct hci_uart *hu)
+static void qca_power_off(struct hci_uart *hu)
 {
 	struct qca_serdev *qcadev;
 	struct qca_data *qca = hu->priv;
@@ -2232,7 +2231,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	set_bit(QCA_BT_OFF, &qca->flags);
 }
 
-static int qca_power_off(struct hci_dev *hdev)
+static int qca_hci_shutdown(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
@@ -2251,7 +2250,7 @@ static int qca_power_off(struct hci_dev *hdev)
 		usleep_range(8000, 10000);
 	}
 
-	qca_power_shutdown(hu);
+	qca_power_off(hu);
 	return 0;
 }
 
@@ -2498,7 +2497,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	if (power_ctrl_enabled) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
-		hdev->shutdown = qca_power_off;
+		hdev->shutdown = qca_hci_shutdown;
 	}
 
 	if (data) {
@@ -2530,7 +2529,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		if (power->vregs_on)
-			qca_power_shutdown(&qcadev->serdev_hu);
+			qca_power_off(&qcadev->serdev_hu);
 		break;
 	default:
 		break;
-- 
2.52.0

