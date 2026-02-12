Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9831E5702
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905849; cv=none; b=rbnmWEuPBE6/HWsrGj0+hy8MmyHMP+2u/nMTnwriRQyvMDcBkGKPwRfTKCc0F8Z0BuOz9/R7IDiU3ok82+hkZX49CbRxM9FPGb2G6CZIkHRCzWUT5T3Zo/eNO6AhUQ9ghWPbJMqXW9CsDwRnLDyRlFkkwCbeLhbvslu8MHyqMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905849; c=relaxed/simple;
	bh=Xm/ZAWsF7VzjaO122xKyDfyKXevlw+y0xC3FUx9Pbco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jG2ilctN0V6k7FgV9MwoeCzL0iVv/r8Ocx8Dr5OfgVHLnG/QXQwGyZbo3V2JoTUnpT9xLActo237ttPs9N06s8X+bpWRUDoTfae9Ox2v9LsCfBn23Z95xvcTjdo+u5ssap02gDuBH7ozFB0o7y5iAuV8BpYF1Vci4hfCqBk6KQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=izG1DtTN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L8Hkv6wc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="izG1DtTN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L8Hkv6wc"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRic2332331
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v/0U/NR0N5W
	sUfDazGrHqqkBRNkIVVwSQFZnwvJA4Yc=; b=izG1DtTNScK9IYc+VN1g0F5jowh
	CtVzu/zTHwUN/vv5mJeqotUN2BqoL9F6t0ESPoOfwG0D8klIDQfsKTD/bdzNe+lK
	4WQ5D21iaNhxEqnMor9LbIB5AsVMYS4feWC0BtH2s2HSKOUr05cATnzUmO4w3x/w
	yR2lNEjmzdG8W1IHyEsar0AuT9eQvW0MEFbGw/mCfH5kMCmiiK5f7MgCJoAmzrrR
	4RcCTS1GMVbS7opqPHHZakdaKLyyMpt961/J1umiaYnC0gqygD+krY4KFEdFAZxa
	l7tz0jWlVOVHP3jjw0L047K0TMz4UoeFzawLejHlyvs5F69aG6Vi31GJl1A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9cya8qg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 14:17:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8ca3ef536ddso2801223485a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 06:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770905845; x=1771510645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/0U/NR0N5WsUfDazGrHqqkBRNkIVVwSQFZnwvJA4Yc=;
        b=L8Hkv6wc3NB3XfolnUv7jtrrJ+qtcjs3wfXH8bm6y5VIgsUL8T7z+eVDS5v27lRsMc
         igt4d72SlcYmzpXAemW4pi8pnsEq8FBtMWiMPp9ssBzuUW+43UwTiRi+9S+8FT1voapS
         +X49lEBo78crLI8gAVcCBiyWm8QUr9rGEWtgIPkUWwptYRv97yx5lTn8gjdDx3azV0jb
         tfM0+hy8Qp70kg4qpBkj+pzeIsxYQLfLdWKHg8yoTpygEARzIwBTNLLlRBv4ZNux3L/6
         yIGBLve/8HgYfc3lOnDoBKAWkBJAak6dr0cEOMtMWqzWIA5qES0WvhPUZA12V8CD3jHG
         d4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770905845; x=1771510645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/0U/NR0N5WsUfDazGrHqqkBRNkIVVwSQFZnwvJA4Yc=;
        b=q6n0hQWVrqstahxJAKKnc9oU3XTM9zCSIcY9YyHkYbP0RE+nsxqhtBJRyPqapWzhWo
         W4MqzYpUPVVA+6VuCth8yAu2UMDg0SKo5Q9qCM+d6WnPPYxNTwCym8vEZTeHyYOywgPL
         fi2sGcXAPrFcnQ6l3e67gX/ffD/iWEat+CDHzZQjAYvpO3chZ6H7DfixtIchqMOhn1KU
         7P4Dyz2JiTGWx+pddte+r+5rPl/an6UbDKGp+FZq4yVPA0V2DIKwNf6/fDGf/q9E90hA
         UcoJccrckgi2AcCivZU9lEx817WtiPlkt0LIqyavOQU1B2O2IsyC+7JEF3UiePD5ZtNu
         OXMA==
X-Forwarded-Encrypted: i=1; AJvYcCW3SAGUCC14NWSX8DeidHlmvg9/R4lLcQ3yVqCM+TPFRhA4oPjptsThrHrLH4s1fZqlfZ+5FffHwuURKM7oUgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRgYzJKaymo5Ad4qyf/MXO+/H5AFUrx+dS+NRmMFEgUanvjv+
	pXM+XOc/gGWX0/sUAYejF5127WcGrcBJ9VmeeOxdz3FC6842ccwSpDS1mkuQ63Pk6+Y2o/3rSFb
	ACPmxZ/VzdxGokOX12CQhjNfmNU2XXZu7lb4rFcwPAQ4gr88q9LSha2Z7f3JRrJV/dwyuDS8=
X-Gm-Gg: AZuq6aIYxKYAFHqDZ+UllEEaNrg6Lpnn09KLv8/UJmh5TnEW7jtJxwZ8eUbqYwMkSB9
	EAyYWddCvqT2RfBlUnypXuNX0NKnyV0ZA2kZ54bbmZnw2fCT4SrLQbYsLcptI8+LAj413p/mMX7
	nYtbWV1Vuf/O2CXVooo4RRzMp71Z9x4qwrvonOoEVjI9LmMC+tK0iDpTM7sAI7tCUayzchB3ZSF
	BJDz3Syf4WeGsP/RPQzD0zOEvwxwn5KUSwD8CVZdpx1F8qiYF2gJXCBSKAXJQ2fmfmwls97NUoU
	nKJvl0TYjHuA1HN0iG8R3wYISqhG4b5FQXcM9055zGwWxuhdi3oP/P/Zo3GLpUsrNTlvGNH181U
	fXeWIzpCQymMg5IPJJcluJ6Yx14QpCVg7YLI6c6mREEGRRIBvJ5H8jmg6xYvl+l11E275ZQbaVR
	IxIz1j59tVqH2Wvkb6XfWmy+F1p+5L6qrK2Bry
X-Received: by 2002:a05:620a:3706:b0:8b2:e069:690a with SMTP id af79cd13be357-8cb3314094dmr256440485a.68.1770905845281;
        Thu, 12 Feb 2026 06:17:25 -0800 (PST)
X-Received: by 2002:a05:620a:3706:b0:8b2:e069:690a with SMTP id af79cd13be357-8cb3314094dmr256436685a.68.1770905844640;
        Thu, 12 Feb 2026 06:17:24 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f83e1a853sm119556166b.19.2026.02.12.06.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:17:23 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_qca: Fix BT not getting powered-off on rmmod
Date: Thu, 12 Feb 2026 15:17:21 +0100
Message-ID: <20260212141721.69961-2-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212141721.69961-1-johannes.goede@oss.qualcomm.com>
References: <20260212141721.69961-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ry2JLAEu8LW3zfihc27hiLv86J_bxrcF
X-Authority-Analysis: v=2.4 cv=OrBCCi/t c=1 sm=1 tr=0 ts=698de0f6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8 a=45zLG3vbpgUbxSzxPE8A:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ry2JLAEu8LW3zfihc27hiLv86J_bxrcF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEwOCBTYWx0ZWRfX4tGZ4NRg0zT/
 yw4sMj4oA9IUZN+2/UbKV1rmB/D7PKJqOjpW1yhfx9AWADpOyM5fjLjVJcT6WxBYZBv/FQrLQNt
 BmIK8ArGI+UzSTcrtzXR8yB8xGzcwE6KO24ahpDSPanKECJyUN2qA+e2NbKwYEKwRCR4vi1kiB0
 SC87qDeVqG7pVThWBlnec2C134B8J/pQLHBKQCBwcSccbARpimEx48gcPc1bvYyJqMFBouZAO7m
 IUereScwp0fevoDyvP41qJB+WPwk41kqbv/YlTU8mkp7iYNVEK0G8HSI0J9msl3z9altC+2oOIp
 +Cl2OKYmxY6nVOmyp7Qi6+2gRtTzE9ngDQvQiDCroNqmb14rQSwEnAC95Zs+b+78MCjri+BkEV+
 ZSE6p2Sl0nssuALjaJ1CQCKKdv21r6C0zTyJElP6F5cH/9/eyYGK54BXYCVEaiye6yABhFL9KRf
 sW04pukCqMpw0rZ8WJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120108

The BT core skips calling the hci_dev's shutdown method when the HCI
is unregistered. This means that qca_power_off() was not getting called
leaving BT powered on.

This causes regulators / pwrseq providers to not get disabled which also
causes problem when re-loading the module because regulators and pwrseq
providers have an enablecount which now has never dropped to 0, causing
the BT to not get properly reset between rmmod and re-load which causes
initialization failure on the re-load.

Fix this by calling qca_power_off() from qca_close() when BT has not
already been powered off through a qca_hci_shutdown() call.

hci_ldisc.c will call qca_close() after freeing the hdev, so this
means that qca_power_off() can now no longer deref hu->hdev, change
the logging in qca_power_off() to no longer use hu->hdev.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index fa7ab4272771..9993e748b56c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -721,6 +721,10 @@ static int qca_close(struct hci_uart *hu)
 
 	BT_DBG("hu %p qca close", hu);
 
+	/* BT core skips qca_hci_shutdown() which calls qca_power_off() on rmmod */
+	if (!test_bit(QCA_BT_OFF, &qca->flags))
+		qca_power_off(hu);
+
 	serial_clock_vote(HCI_IBS_VOTE_STATS_UPDATE, hu);
 
 	skb_queue_purge(&qca->tx_wait_q);
@@ -2220,7 +2224,7 @@ static void qca_power_off(struct hci_uart *hu)
 		qca_regulator_disable(qcadev);
 		if (qcadev->sw_ctrl) {
 			sw_ctrl_state = gpiod_get_value_cansleep(qcadev->sw_ctrl);
-			bt_dev_dbg(hu->hdev, "SW_CTRL is %d", sw_ctrl_state);
+			BT_DBG("SW_CTRL is %d", sw_ctrl_state);
 		}
 		break;
 
-- 
2.52.0

