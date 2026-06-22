Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1A3101C8
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139946; cv=none; b=upCgxexK1cflVYjQus/9yO8UJMIqC2DUzKxu/Ztfn0sPNw4XJbZQKZLs+4eyqm5Pr6Nsd1DuFlc5iuksmLEKsm/yknvudpqMxHAwdavumEjuqwstP67y7KHCjKX4X/PpGkQjH4FcBaaNgtOZqcTsE8hWcY3OWku0oQybTeCR+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139946; c=relaxed/simple;
	bh=rpKRFG9vcFaBSu9zoOeEBfEtigbSiyCzqTWFue6VjDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bPnFKbuKUcrVjU5aE7YW6yAAmkJ+4J6+3t2jnWPLn8oaP7imKMrhzObJ8dllzvM2UkLKlmZTPp40utA40n2xCuthK+2AiMF3F62piLxQ9tYfrHRPnu+Z7XcVRr84f5MRQAynCPpHY2FsHRYBMUL+Z4Z8l6J+MYGs1mphS3P79WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cplIyn8q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eSg/AY5+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cplIyn8q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eSg/AY5+"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDFeUK792146
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jMS5GUEo/xk0l+pec2AyN8MKYe8ZJ2e2xb+mNv5VHUU=; b=cplIyn8qn+byYUjW
	uJ2zU+K0ZN+HaXoTgRw1+8tdA2prnVs9CMuRscoga2tJmGfyVN6VdjJwD/vQhc7R
	GxjiKkT6q3ob1BJK5IRCTd5dhFl0O2HyKNvsyRdM0U5b0RNF55ygSY8sIk6zvHza
	y7Gsqe6GhiIFTAQwJO7qp9njbp9h8COko0wsAX8spWAnsiSMpHotk7hDxl4gI59e
	2OAC6Xj9ZMUO8hMc5s8hzCnyM+HMpM+RpeUN2z0EzGhPl9Jh9D6zTd/rx5n/nOA3
	uDXh7cm8TWm7b4MDol60h4CrFVVi9dizeRN72x9kovz5KsPtLKkQQacuu6pZsknG
	Wj4qdg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3cq0veh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:22 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b1795119so181345c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139941; x=1782744741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMS5GUEo/xk0l+pec2AyN8MKYe8ZJ2e2xb+mNv5VHUU=;
        b=eSg/AY5++8YtIf3e0j/UFtxErHFjCWXfG6j6RP57ca26M79F3r7NoetLeLHZ9S4tJc
         t5ihBH0VC1Ts58H5p2U2NOkMRdeTtj/p1Xy3tD+J0kxerlB8/GS+HUWIRbb9lo46B7Lb
         LO1+n3jCL06HmQvTUW+RJ7hMqIDn5jqVc5F3aJENtUTxtFkKgI8N6WZuJSRVEMEhcPFg
         ivQlYT+bo7lDA0P0W3MvGBPQRdho59m4CJGoExduYmg9rCPfbi0HEVYlQ9DNIDTKMrXq
         xswdIFiJHX+Q7d7PVoVeDk/ZUgz2JMQ0C45OHgL6toYRspucwuTKBZx5CMDpsBwNIn0g
         a/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139941; x=1782744741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jMS5GUEo/xk0l+pec2AyN8MKYe8ZJ2e2xb+mNv5VHUU=;
        b=tUjVYP6LynRruwzwV+K8UhPdvTytJhsiFaztdw9+xKWRVnYQIVm6mAHIcJavl54ZF/
         cKU886ZacwV4DolyJnfSR3++uTcxh8nRl0LRLlvfBwhgMw2jzFJWTwPy+nqUtZFzCcOy
         +g1fjKGziQbIdoY75BUO3Q2nXHDlStyA85FiwOgXr/3dfHLztck2TByv4Qwum+AmXS0C
         RNyAn7aXNJME9rRhZ9uycz64CJ7zakTqsp6ypXx/xAkvR5orBEt03vlMpvhclI260LF0
         Owpga2THfkAtFr/U0f9XxFh2ecvQpvQp0iC0eiprpuGvOqE6yd91abPBOFAZ+rNbksxN
         DXng==
X-Forwarded-Encrypted: i=1; AHgh+Rpfp+GxRXDMeByLxR0UEPqglbdmxNH62LAR3jRTIo+4AWVkT6wiWTi/oR8HiV0J7MMB8MD2H3jXN9b/FCb70XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0rA5q/W2704CAMbpWOSO06zIEQhovt9dLOPGTCRHn828nqBW
	+B2SNfP77UMlxnVF4kS2sCiBl3L9wEi0lyNPdPNKZwnLo8TB0BLVYxpBCCIUc8pY7zgtZ8DSJpZ
	0lUV6da9Zxvv6DRqZa1hlQ2T/O6EzIvcnYy3+F7ZcW9vr4uTsQlAUVhMrMGKCuMQaDrBb7i4=
X-Gm-Gg: AfdE7cmtn1zf7BZPIyVXCZexfUQcowKMSLkhfZJ6vUrJhoHor/TQJZwXsOURcm4qA2m
	bFRv/gEKDGcbpB+r7g5ZlRLUdKwIHKFGn9gRWB6/T3MVjKBuPa+pGDalQv+YWgyITa5e/+TMbmy
	XpHLjHHrwApB9Ez7yTpdxqIqQ47pCF/HcQ5opj6eWAHfT4apn8J/vggqhT4Jm6N8HvirSa3EHTC
	dMMzeF1AOWSeP80X97VtA1BZaklpxZhXvLS+Urxvjb2VWWYoIAbPzSL7eOqfRPVeSk+O6EvsDiZ
	7ZwEJKVexHPaQUrwMqkrw5SxERGg87xci/M/27oXNszliru9Gqmd735EGlmff0j5lcsWu2IqY8D
	Yomh9/7aiffqVEtMWa//vvZ0jFXYmA5xsnnuZ7uMRgGy7xSBqFBXbWmmAtA==
X-Received: by 2002:a05:7300:1910:b0:304:c73b:79ea with SMTP id 5a478bee46e88-30c522fdc9fmr235830eec.3.1782139941423;
        Mon, 22 Jun 2026 07:52:21 -0700 (PDT)
X-Received: by 2002:a05:7300:1910:b0:304:c73b:79ea with SMTP id 5a478bee46e88-30c522fdc9fmr235804eec.3.1782139940913;
        Mon, 22 Jun 2026 07:52:20 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:20 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:19 -0700
Subject: [PATCH 06/13] Bluetooth: btusb: Fix BD_ADDR byte order in
 btusb_set_bdaddr_wcn6855()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-6-11f936d84e72@oss.qualcomm.com>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
In-Reply-To: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: TcHNKBIA4ZIYcBJbfRmyKUM4YsznzMNZ
X-Authority-Analysis: v=2.4 cv=VKXtWdPX c=1 sm=1 tr=0 ts=6a394c26 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ItwU2R1ETwvooMAJNeQA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: TcHNKBIA4ZIYcBJbfRmyKUM4YsznzMNZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX+FcmN+md1zkF
 r2QxMBXVUYvALFWEbSSQ64RbzAp1+xKPh8KH/67KY/fA6WUDrn4vtpeTu5kTFHnT0BZUY5jBE6g
 R/zWL+DUKcKEz5raxyW51QsFYdobt+EBCDWF/lUL7GewStB3S5Bm6oHEhmbdGAcmLLyh1xvx8p/
 ts0dXl1gSa2eg54gVi+uB60Absu2yBbSalJqydVZ7toJb4ORrEOAT9wPOWm2eR83yt6tW15+UfF
 uK0itfrYguI0duUQ9o+/T6Sh19lau104uBb2bw27TlCDL+MVn5a4FKwQxvZDvnC/NlDkJPBBWg6
 YemiTHflwJCC6C5xv4TJtCdIsb04ygpdg49j2nkcSKSj6ns8Tw3Ys2RJHhLWs6Q8aWAW+n7FN3I
 oVdLvscwm/RQt4TxiZksQB0sS6MC7ysIl5saKkDBeyvUW04TY+krmRn4Z/fA0Yi57X0EdExi01D
 vabQoZLJjBhH5QUUB9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX4u/fUY2vJTmE
 FA/zWp6I+KZS+QKBA19ABukQSaoMWnp+8Gw3oCDVGWKpswmSOzzWzTFr0kgTJRQ5oqTxD4IejHH
 /s6CNGWWeBsOFl8hy10tPxAFgZUDI48=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

For VSC 0xfc14 to set BD_ADDR, the endianness of the BDA parameter is
opposite to other HCI commands like HCI_Create_Connection, but
btusb_set_bdaddr_wcn6855() sends the address without swapping byte
order, resulting in a wrong BD_ADDR being set.

Fix by swapping the input address before issuing the command.

Fixes: b40f58b97386 ("Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855 support")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6f965c313dff..e78277e24cd8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3075,14 +3075,15 @@ static int btusb_set_bdaddr_ath3012(struct hci_dev *hdev,
 static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
 				const bdaddr_t *bdaddr)
 {
+	bdaddr_t bdaddr_swapped;
 	struct sk_buff *skb;
-	u8 buf[6];
 	long ret;
 
-	memcpy(buf, bdaddr, sizeof(bdaddr_t));
+	baswap(&bdaddr_swapped, bdaddr);
 
-	skb = __hci_cmd_sync_ev(hdev, 0xfc14, sizeof(buf), buf,
-				HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync_ev(hdev, 0xfc14, sizeof(bdaddr_swapped),
+				&bdaddr_swapped, HCI_EV_CMD_COMPLETE,
+				HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		bt_dev_err(hdev, "Change address command failed (%ld)", ret);

-- 
2.34.1

