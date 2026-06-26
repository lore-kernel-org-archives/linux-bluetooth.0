Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6B39A060
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451195; cv=none; b=C88Ckh04HPrLKDaoTECEReYY+fR0dqatYj71c/m9iX8aDqe8x3wn3WCEyBBygb26qCFNnfy6ht4mS0MxiJNtLzreLtuVH9GwZ0TUoN39WuwtS9j1R0CCoKRcCNfpi9O9F/km/Xk3DqqUyjVgQL0pkogUwRzT99baoEXSlY9L8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451195; c=relaxed/simple;
	bh=FTWDWGLYNfpZ6m1IV/lColI/su3Eco1XDbbh6AubtTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aobs/Yt19mQsSgSnCm7dev/old6kJ2SUj2hy9vkgXDCuq4glVk4EXUTLOHXYkotcfTe5CyMWK1v0g2aWNSAc6s79Cf9lfGmqQs3yW+Q/Qhgj+TblA4LN0miTGl/RZc4MtE8e7GPTIS/JZMLmXEseutjMZlWgs1tK21DNrskQi4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oi0nzPWe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A1zTSzIV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oi0nzPWe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A1zTSzIV"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2j2fV2313692
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tgz3T8c2eN5f8WUpPXHXO8Bhb0KkzZfElUTxAI9Xku4=; b=Oi0nzPWeWHploVOR
	C4akz+amS33M6fjfJy+ABkMnmrEJbxf9+c6r56whS/zfHlUl8Sdu7wi0YROOgtDf
	sHhKgRyyuR6+or2UzjBD7vvuWU68B7BWnVRay5Ajkt3CFPkSRM1AYIPa357WB7kW
	sr6MNgx4R1brNXM5e3roIoULfs7BouMsorKrsQn/vgMTXHHvzaJtXNZC34QIMyyl
	sWW8pMg+/PmsyV9YXhvWJBnADzaAFTRKo4LTv6JjuYSocfRS5WCLzhXn/gkBrGkF
	cQRz4PW5qQL0pvLy6yNyYhXNrXqCkC3GseEJ9936OkcNpMyXKIZh+siKd6cnOmxF
	n0RPmA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f19m3t4as-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bd0d5f5a4so61872eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451193; x=1783055993; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tgz3T8c2eN5f8WUpPXHXO8Bhb0KkzZfElUTxAI9Xku4=;
        b=A1zTSzIVFGAfG7Gd5zkfC5EgFakgsEjHzBjHCfbpqAeyPf7BBIqkr76x3xCbEiHEK+
         rbVPWNNVTFZHQ9baFbUz8efnjtQzpKeDDX3HkvoIcDQ+EhyeEbRPOPmLsFCX8EVOjS7J
         wIUzhggempG1Teu9dF2aWhDfXdJbKV4dcpF5tBdo6WDFCpzbk0yaS/YIPi1GVWfQMGvb
         h2ST/UrEFc158bUj6e9flBHhBXyemegA0qDHFN+ahLu+jVLr2qn276ki1xQLb/ElxyFP
         cGgjCPHdiT1bKIwwbwjcktDDHj8shEBiwglEFs4Waz2IKloBiY9Ht+MhzQfw91H0kne6
         +Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451193; x=1783055993;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tgz3T8c2eN5f8WUpPXHXO8Bhb0KkzZfElUTxAI9Xku4=;
        b=CHwM084kqqL4ruzbsz3pi5IVgTKoL3qWEcZErwLfkwyxqabDvnoMrldE9s/UzK/w28
         l/vmBPRv95NxMslYv4r1ot5GwhGnZyARd51YUKHmtbKCmWyW6JGvB0Y6gu/j02K7nAyR
         56YO8GVnsuU71t5ffl8h5oyqDqSTzY8Fqb2mfo4lq8DiFh5OKoH65eoJyg+yfZlmzsSG
         F+mjAuZZ4jeCFvXtpgo5FkCrVJhN3lLEZkojqU1ITRdHNRs6mXbzoLn9i85seMohqAzE
         nujLn9WCKsjzwY//S/XSPHC1jWvAaIzXnMR6f9fIsFzzwG/VUmy0ivSVEdSiGf737QLV
         JdxA==
X-Forwarded-Encrypted: i=1; AHgh+RrX+4piKc1YpclTj1W3vW8gwL8A28Sqh164nCC1NpImL1QA3c6n/wLLwyDLTTem0aDupgwf97ndxEM/HD4xN4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYzDGFmulbBnJQeD/movHT7ch2ZinL8CjoN6+ZdW38xDMexTe
	tlcUo9s/zQPzxKYSLDsO7s3N4ZVHYcTd0mtDzYk1GVKWHZqEeuSxH58Hx1ZQQFJ1QgJGrrKNeSg
	zdCbUIveuTxsS5mRJ8QeiRB4sF1e+KjTlrIMZgrDwupJv0T8KOlsyNICIF5X+Yt43jyk+RQA=
X-Gm-Gg: AfdE7cl6b2C7l8Dz0+m/EIY8mnzgxpfL8kkisjYFtF9dj4YpFPUwU0tFoELfRsqnNjA
	lJJbjAOGQ2PrOtkJFfOXk5eFM6a4Privyn5MCD5enN8hXIoIQkDdAnwhjCHsrdfqpkv7O453Ccl
	SyXmstFcRrCdLgCJ63a2tZ/Vmo33bABSDoebrL2WhS6U/VNPRmI5Gooie6NncIik2GFHwNsCms9
	Vc+CuUQWhEfqnRZJWi0ah9fxD+gcaC7dIR66yIuCJ9+2pjIoqqlDhPybhHHNxDjj6ydPmr7Eqw0
	wiFfjqLl1bmTkP5Jgktm39YK0TjVkyTTK6GegwqfZQ1b6uuGM18ykzxmKJJxy9HjMxjBRzvQn98
	LNpPquBiShcq1xeDRfuo27nARWrfLTYmf3C2svvMfQJc0SsufrB6ujzF9uA==
X-Received: by 2002:a05:7301:4e8a:b0:30c:8119:f36a with SMTP id 5a478bee46e88-30c84c77ec0mr2434635eec.4.1782451193082;
        Thu, 25 Jun 2026 22:19:53 -0700 (PDT)
X-Received: by 2002:a05:7301:4e8a:b0:30c:8119:f36a with SMTP id 5a478bee46e88-30c84c77ec0mr2434623eec.4.1782451192540;
        Thu, 25 Jun 2026 22:19:52 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:19:49 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:48 -0700
Subject: [PATCH v2 03/12] Bluetooth: btusb: Record matched usb_device_id
 into btusb_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-3-93396a6f7d5e@oss.qualcomm.com>
References: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
In-Reply-To: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tim Jiang <quic_tjiang@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX5O6pWF/ssDHk
 aMelqaZ8pXPYV+Jzl4XHovXihNpoHMueTCEbZ4CMUkbdLhUGKWqupK7mLSId21YJNB/eFioP8tk
 LdlA9SEjUKYGlWvjuMrLs0goLF2VVg0=
X-Proofpoint-GUID: NknK8qg_XF4ILuJUJudA0nYGHf8mQNsn
X-Proofpoint-ORIG-GUID: NknK8qg_XF4ILuJUJudA0nYGHf8mQNsn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfXxKbtx9sjnKSK
 6nYU1Q08xanr7DCI+SPzzSXFyXqk5ll/LbNhmcW5ibT/O+HkvgYs/HFtab6eO0DRrFkyFNdopku
 Cg444gwXFoPogMUeXmOcZKpY3bwzzJ4CD9jdZ5ZpvPPdom8+xm+gegtekQxFEHlcy5aV1EJXkns
 8Ywra/YrW3iTlUdwTmhLpC0EBdw1VWGaO4cDV1ryWC4w8irCu8QHzZWtPuHAksqUajvrxf05Wuk
 i3JKgsjRCqvilloQ0XGl19COKWW2TcKTsHhB29dGySfLgKlWOdN0SNEpr7L1MuUkvPCMiW9fHqk
 DChrQ6H9T7hS07YdgT3OldIaOAj3P1UAKyLvA5T0Pb4lNm02qEyQo/n/Hcr9kESdVjnsf26p02v
 PvSFKQMwaYFJIXNzkivPgyBP7+ZWsPIO8WnksltSu9ronVRbPQS0ijUvguWJ1sMnWBVu9Ncm5cC
 FKFRGTL0hfvDMO9Ef8g==
X-Authority-Analysis: v=2.4 cv=Vv0Txe2n c=1 sm=1 tr=0 ts=6a3e0bf9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kCdYwly7LSaV7O0ZGUsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260040

Add @match_id to btusb_data to record the matched usb_device_id
which will be used later.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 17573749adda..31cbe075edc9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1012,6 +1012,7 @@ struct btusb_data {
 	bool usb_alt6_packet_flow;
 	int isoc_altsetting;
 	int suspend_count;
+	const struct usb_device_id *match_id;
 
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
@@ -4120,6 +4121,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (!data)
 		return -ENOMEM;
 
+	data->match_id = id;
 	err = usb_find_common_endpoints(intf->cur_altsetting, &data->bulk_rx_ep,
 					&data->bulk_tx_ep, &data->intr_ep, NULL);
 	if (err)

-- 
2.34.1

