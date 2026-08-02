Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDA4338595
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652331; cv=none; b=GGzFdnIgEHV90uzldZBkhv9PuGKYYz08o9muOcHNr8BxLO+d3T7u3xmJbPAzePU40jDGq9zuTdnfOEoKSw8GbKHFdFGWi0Z81SO1wHgfK8jK/29w6ZiCqrB+JW2/Py0SnTvX2Wpu1pAH25fzyRRQs0vDgdcMWWAGMi5F1raW2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652331; c=relaxed/simple;
	bh=tz8FLBGw7fhQ/8/Wjt/KoeIHLWEysZ+vI9iEjrTeUDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0ZLnk8scudUyQKO2EADMTnakWX7YnTYqdYcy+RilcKn3lQ6GLMlYHQO7EepN+FgOXSVLdOQmY+PQfMCQOOJ3aNYDSlfcscnIXUf2NxBHmSx446rd+vJb7SpQTo4D1RLbV37QSLrjfwI4aHqcb1hlhQHo4Kqy6XZnPjsaxosg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RB+dPkXH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WxxV+g91; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RB+dPkXH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WxxV+g91"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6724anWJ1012936
	for <linux-bluetooth@vger.kernel.org>; Sun, 2 Aug 2026 06:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FbfuV9Ukfo1XJYoE3g2qVScsLis2+9HDCeRaY3lX96A=; b=RB+dPkXHAsF+Y1Zf
	Iw7HeO3fq87ikvext26mNthMJR4mov3oR7pxFpj87AkiG1oWK9Zzuz5XLy9A3sxj
	W9yGnZt29WdtDiZOpAuyoBYumQxbRqPLtn/6c72PP6ZEG2zj6CkUn/+OQ7h7cpt8
	mmxKUGkGqMARpGjfI8UZAcI/wUK8OqovOSOC98ny92LwIANgTQUpmCU0NgjOak1J
	yuw6w0XPRyBus+6px2krEbGco5sx7bZQ6SxIM01NqbB1eYCrXKIhfpBh2u10zzfi
	B7b63mCJUnlKV2S1sc8uco7rSkmvXpZ5NIkNop1suOcjGIpkdLHcQbmjhFH9W7yL
	G9hQGA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8q52d96-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2026 06:32:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca0ed258cso7245215ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 23:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785652323; x=1786257123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FbfuV9Ukfo1XJYoE3g2qVScsLis2+9HDCeRaY3lX96A=;
        b=WxxV+g91Rv71R+EcAQZsfKbBrdMNTqUf3N5DnEeUVzAaJfeq8c+qM7NcJLg1eGeLTu
         SQNzQeGSwu7yL+v1/Tg/O2JIBrGWOZyt+o6796mKkhKssOlYIuzZue1ZAD4JfVUT3lD0
         Pc9BUDG4ly7Q3OLhhz9k1/IPGbh8ou+WEaxwyfrqu5ZjrmA4hKPiybq2XNVTqkbbmFeG
         Ldr5DBDpeFisjY/qsHS+iWZA0w08ld9TsRE0HXUUKRb576rL3noQMy8LGYLZZjZAN/pc
         QaRZaUFKtzAIBLesLSa8Gwuqzo7nsq11GXs2Orr4vzqq3IywLD1YDrAYkYVL+QACqNA0
         C4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785652323; x=1786257123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FbfuV9Ukfo1XJYoE3g2qVScsLis2+9HDCeRaY3lX96A=;
        b=mm9D5NT7PcodTIHShMBPefLSmLjcOtoZfhJmCN93uuh0sSMHV7GInHsB1uRTFiV0fQ
         ESDM9QHrzKufkJtDTfNSokI3GUsakbrI0Tff5htNvOs05r5BKNIy0fogdo6gJPOnPKBd
         t8RPeduZwPiNa42dlKpokZQV7ADrC6iepbahqhnrTZbt8b0kNI9HUW0Bju0aycUkhobW
         uBv4CHXse/0kppMWw3f/mmoMM0JBQwoYoDklMi2yI6u834XEtHyE2Pvi7WVJg2M1tGcI
         sSWFIr+P4My9y7BlQ8TOjhB8ymPBP2lArs9UFOZ94abB/owEy5pq2EBwRRFJ1Y3+b2q9
         SwuQ==
X-Forwarded-Encrypted: i=1; AHgh+RqpYMgZrZhELj5gfmztxzGlWJ0eP4aOsMjXyyFwiFpGp26FVfwoXVLZzx4URBraFDDtnD54XY0Nx5CmwA2JwAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Z/5DVvlJUecx/McGb5Wn0jVNCcgPIyRsOSxHnkccXfjd7tH3
	B6L3k1kgWQVPFi7HTuiTNP02P2mqrb3xwC/7b2RVVinwbz2bbITCLck8CGUoezjuu0QZH6Xjjpt
	UOJQvqSNtx9nNs8G0sOY1K3tvRvyJ80U0Nw4HnLE1lj4YiYP1Gl2kRZJqx46zmqeEoR0178E=
X-Gm-Gg: AR+sD12en5IVl53t/AY0JNyYdVsOGpbEo+uZGxlxaXqSsoC02P7FjiLyT/DffmcUFhF
	gE/car56nISzU3S5WsFnn8kDZEjxTljwABjMy8+TLG0QK9S0OldcGWshbcNUhY2WgNLC6wA0Xmj
	9a9Z5YKIeVLuJKmlb2zl7C9jChwTD3gtlJA3ag1tkdZrxH4JljB479oJZed2zYyycTOq9OvkyTk
	iP4mCTtnzlTinXeYwhYHC79sq42t3ClQ6eRfQbi9MJlxRL5di/Lq2owz+hK6VcmX0NupEjpf3iZ
	7LWy1ZPpDc9vLl7d/XQEhcKnxXfLSH+tRwBuacGMVW3o4O/t+UoXPT01SxvFbS9u8npnyeYYRMY
	c6B2CEdRRY+g9wMgTTjNNLpij4vbD8N/nKLDVb/COmF+6Tqg=
X-Received: by 2002:a17:903:1a24:b0:2ca:ecf6:9105 with SMTP id d9443c01a7336-2d0521bd8a0mr83420235ad.1.1785652322683;
        Sat, 01 Aug 2026 23:32:02 -0700 (PDT)
X-Received: by 2002:a17:903:1a24:b0:2ca:ecf6:9105 with SMTP id d9443c01a7336-2d0521bd8a0mr83419995ad.1.1785652322251;
        Sat, 01 Aug 2026 23:32:02 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c93dsm24233304eec.8.2026.08.01.23.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 23:32:01 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 23:31:40 -0700
Subject: [PATCH v3 5/7] Bluetooth: btnxpuart: Simplify nxp_set_ind_reset()
 by __hci_reset_dev()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-generic_fix-v3-5-efdd8dcf3430@oss.qualcomm.com>
References: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
In-Reply-To: <20260801-generic_fix-v3-0-efdd8dcf3430@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfXzBT5vm6nHlcb
 uE8H1lxplGm+Vlnn6i8Ygoalu7U7jMBYUIE9fZ67ZzFca5Pgh8CG46byAwcrVLdV+loCEwNuic1
 GvY9f+NNVb/B1KMlXUO+TYKZ/Q4suxc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA1MCBTYWx0ZWRfX4sd7TE9BuBc+
 j9VloLumupspWlFS4lX9QXR/CThRaWQ0b7uyP8oITo8Gp2Catiw01MdpkIAvikYzNgJ1JvFwLFk
 0VJHY9tnaZv7OseWoGuASafxrIVAoQ4yWcHEASdzr6tbbHzKYJkD0ve0bvqX5uQSV6UlNhIoibz
 w51bU/ZjNYcYslbcdndisGAUeBg35nQfr35AdqzeqePGX3OFC9bIV1K7QhH+htxJOTLy8YTCaAg
 qqgZ1PFEKYrrpQpsTFkTVU0t6T6rBzj0teoWfJKl2NrGUmwkU+gl4+HH6vvugiWgYM8r8txfZ6t
 bvJ6XL16yEMYkwVGu65FdgZbfi0q8z+FMrc+nCvoChex03N6pYDKmC21MQj6xsroF+IAYqRNEFY
 C7KbEjouU4otYlrmSVwdjplBLdcDcWXdRgpQicBlz49+dFLJUujcNVxVB+5PAo35CNYN7S0mKYi
 m71OJcFlOBdYrb4llcg==
X-Proofpoint-GUID: Qc1EOlZ4nO3ZE6iO_m6FAIPVPgEinFPW
X-Authority-Analysis: v=2.4 cv=IYC3n2qa c=1 sm=1 tr=0 ts=6a6ee463 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=AdqSwI6SsC1MfKETgzkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Qc1EOlZ4nO3ZE6iO_m6FAIPVPgEinFPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020050

nxp_set_ind_reset() injects the non-zero hardware error code
BTNXPUART_IR_HW_ERR.

Simplify it by __hci_reset_dev(hdev, BTNXPUART_IR_HW_ERR).

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btnxpuart.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 0bb300eef157..993c48b5f593 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1326,29 +1326,17 @@ static int nxp_check_boot_sign(struct btnxpuart_dev *nxpdev)
 	return wait_event_interruptible_timeout(nxpdev->check_boot_sign_wait_q,
 					       !test_bit(BTNXPUART_CHECK_BOOT_SIGNATURE,
 							 &nxpdev->tx_state),
 					       msecs_to_jiffies(1000));
 }
 
 static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 {
-	static const u8 ir_hw_err[] = { HCI_EV_HARDWARE_ERROR,
-					0x01, BTNXPUART_IR_HW_ERR };
-	struct sk_buff *skb;
-
-	skb = bt_skb_alloc(3, GFP_ATOMIC);
-	if (!skb)
-		return -ENOMEM;
-
-	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
-	skb_put_data(skb, ir_hw_err, 3);
-
-	/* Inject Hardware Error to upper stack */
-	return hci_recv_frame(hdev, skb);
+	return __hci_reset_dev(hdev, BTNXPUART_IR_HW_ERR);
 }
 
 /* Firmware dump */
 static void nxp_coredump(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	u8 pcmd = 2;
 

-- 
2.34.1

