Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7B32ED5C
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139952; cv=none; b=AnI3u8lRaS4CNY9eKNzbSNZPjwo054pvAAkvK+IQj+RUF9czUPCBDiQs9JzjMZOI2IpIPLcnoqDd7uywmjyAbzPWH8MEfLRv12KotKBBvsMgzEloD0Xjhzs+cHnYy7J0i+DJ8/9AnuNTcBVy6g/VuA5YntM0pESJgFITWEO48io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139952; c=relaxed/simple;
	bh=x3KGAx3NUoCYAm+qOqWa1FsPjEcAIKu8HQXo1YsgeAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+jZEWyT/EMXA9fJSJSFWcajbFxyvwXQckGFPSWoQ1PaqgFiqtE+Qk8uAVNWPRiy8XGS3FR+9HEzR5N9tDpBVDUVIFiftn7+G6An4hAB/py6tbRSJSAsXylubXrz7ZBdAbMkOo/Qvk/qP1pwf9vp43UAV3DtpEaw4JVA5P53W9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kAUEWgoS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C2WMeSPu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kAUEWgoS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C2WMeSPu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDGRT91063142
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mQBfOU67eUUkLSC8Z5n20WscF+NgznuYOZ1C8BX2+2o=; b=kAUEWgoSKeOqukS4
	DN8m5jTJT1jD+bn6QNpJcz8V3bJSVKg6s6ejo4zWSGl43YNZB9H6sQhglRJeHORH
	Gn3Bl06hmbYZdLdQI0iTCYljZL6jv1c7dKsPcWPUi490dzoB8FMDhJ5DqczVoXoh
	H5i009f2DXqLmzRu9pNHmwofT+Cyx1LXHbfDPAPm6E3ec65BaCqg9APSYR55cVzq
	xuxv//IVFkDOLoBRvXNoO0PXGDHlPMgZIu4H7w+xCPSNWPTU/cW8dNBae7kHqgAD
	UmfTtzJ+XK9gWu5fsFb8DxgSnl1ZXhs1RzgK1EDzYj+1vsMRBfxQeHem+4Gl1re/
	HIwP4g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1t0tu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:29 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bfe1e3d45so537120eec.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139949; x=1782744749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQBfOU67eUUkLSC8Z5n20WscF+NgznuYOZ1C8BX2+2o=;
        b=C2WMeSPusIwSW9RV3LMAXehMjhkM/bXRv+mXhDKqdGjzWLuM9+h1JqTvHyqaAG+sc1
         TRitwpURfEQYXay2X3fo1t+hfWqagTvz9002om1gV4lOsWQ061aN1ifDZcGZj0RU2Big
         wdqjaKxJXZkpV/bIheg6p4wOCZ/q0cY6ZghmY84aQR0mEcoqThmdWoEKnE/Q3iRUHpBN
         189fNYyf8Y+8oSkpNEVy8UbEy1229j1fTWcbYRcKfUxOJCuPsL6NFT9S40GDLFVG/V4t
         xu3VNJYgB8RqUU6k9ChkaxGQO25gjSPg9j0stSMUxL/KDST7Lq8EGOYREo0P0KhuGgLv
         pwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139949; x=1782744749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mQBfOU67eUUkLSC8Z5n20WscF+NgznuYOZ1C8BX2+2o=;
        b=dQ4tI6O5BLW656fcUBdfiJsDXKMGFryg6VwueCvB+qSGWta+1Kye/NwX5oKK/bmBOB
         fNBw4CPuFNtpLXk8rWxe6W8bc42jd8zaA686igzWoP0kFG/U91dwx5aS/zhOBmYOSsTi
         PpeBijK4txN0QLPeqIGZZPFZ/Pm56ncjRi7xZZkbnenduEoFbVvjbE6tp4yxHqFyl9Yw
         SQjsccunQV+1qJvPBRMRzn5xs9hkyY8Er+G13Uyast06hFd2Bl6EiseVtaIlsgXOPYjE
         hu9fLHKjy+WX0rp/rkx10eNecxCwlkbuJFhKnYPKgAZfbMpmitme8120N/s9EuWS+LLz
         LncQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp6HcLRPZXbo9MRlj8mC/19Ee6rCvRL2W7QpH/z0kq60ZnBpAKkHZHYRH/3myk9m2CUgh9YQfTNgKn7+7uLE0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQPdic7YAIEUtdAGYNwAevipgrVbnQMA9v0wEWy06BiEmCJzs
	Unxn0Ed01xF0hrrLqX9bKVImXaSSijsrqSgIe5T6jb1UIbkLJCLA1f5za+xk39epkg36IqINPN+
	9VFKPp92iDAbthl9xULnujfV6UYtQhLWGr8QRKfhFm9lHKL/z3Ze75iuP2CMvRBu5GAKRtk0=
X-Gm-Gg: AfdE7clM2TJahy8+7+5zDhGR/aqLD9zjZW0d6z+KnwqaCLnAOK4NEr0CHKtcrJbIjbP
	x8Ysgg+33QF0ufzosHrK+ZKtFrRfXFu8kG9vZ9QAN/XFBpaIeJw8PZGpZzQh9dFJT+MT2hhXlQi
	VWrMVy5gP+1OFNyhr1KO01JV+D5DJbfsnwY/bbBZ7cI7ZKhK48jqc8OScQKWJGV+NbXNUXyobbB
	z51Mi4ENVc/NTNog5cbG010OJ7GhyF9hh7nADDjqM7/qTfsC85gagFqLK+CIdJMgtGE0701LKQK
	vrKRZ+/9FesmXifO5Gw9diSIqLUuPKwmxua7KKsAq0h1J1vNtbvlU8Yf8V7XCOTX+5ufzwOru7W
	Kcyiy0e8QdDim4afqhBJSv3QTijHbkdGnss2OzB3gRPclbBTWhsfUE/VZCA==
X-Received: by 2002:a05:7300:e7af:b0:2e6:b55a:76c9 with SMTP id 5a478bee46e88-30c177c788fmr3746235eec.0.1782139948902;
        Mon, 22 Jun 2026 07:52:28 -0700 (PDT)
X-Received: by 2002:a05:7300:e7af:b0:2e6:b55a:76c9 with SMTP id 5a478bee46e88-30c177c788fmr3746219eec.0.1782139948238;
        Mon, 22 Jun 2026 07:52:28 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:27 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:26 -0700
Subject: [PATCH 13/13] Bluetooth: btqca: Fix qca_set_bdaddr() using wrong
 HCI event type
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-13-11f936d84e72@oss.qualcomm.com>
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
X-Proofpoint-GUID: sUD4OnRXmcTaFuOnqCEK1C5LNRSSaqWV
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a394c2d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ErUVIrnS-jkk5iPv-M8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX35klzsaNbukJ
 SFy816iIMXjRRcRwLjjNbZLWeUPS8Mhve6IvX9CdYUg2oy5/HEOtyVpqHaaN4OvE0ZYioVhbj1+
 kUC8gUUJjz8AJeJkg+i2ZUSJ2S8xs9s=
X-Proofpoint-ORIG-GUID: sUD4OnRXmcTaFuOnqCEK1C5LNRSSaqWV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX1gZzNuF5x18+
 EoUxsywKBu31FoQgGbJ9NIF9HPIfVIwSaLWV8pJ33+AS5ZEz1Yt09VFeCDQ0bYSO9/JybSkwh+m
 f4DNAH6lE9oU4pMp6s5OZ6r+/+59FVcZ6oti/cFa50pFzVGi1McTqGZmDmwD3OUNFn2A5mQD7BO
 1obmHa8NMUb3ve2GlnOi5x48IU+MXJ3Gc8CTATiGp2TGr+AKaTMMW9zqgeL1vsc03q63fmmuSsI
 fLYQLPCKewzPw5pzOz3lr4wGPdmK06fUrSc+hiYwsmjZxQDUYEC9RR3HxcLwQHALZzVI6L3PC0T
 hmhBoa0sXHbz093WP0C2c2l5JpJn8IYlh9sEOTQ/czWh8IetGINCTh+gzU8z8EM5fZ4uIEZFYBZ
 CiuVr1oAhSi7wr26M9p3ZR6krtuFSls6TTGmAFSDrj6iPDzJOEUhBgpbNZip9LM0udiKXSMXJ1c
 QI4cT32t1nDW5WfjBBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

EDL_WRITE_BD_ADDR_OPCODE (0xFC14) returns a command complete event,
not a VSE, but qca_set_bdaddr() waits for HCI_EV_VENDOR.

Fix by passing 0 as the event parameter to __hci_cmd_sync_ev() to
wait for the command complete event instead.

Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 875216e15603..f3487de813c2 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -1011,8 +1011,7 @@ int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	baswap(&bdaddr_swapped, bdaddr);
 
 	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6,
-				&bdaddr_swapped, HCI_EV_VENDOR,
-				HCI_INIT_TIMEOUT);
+				&bdaddr_swapped, 0, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);

-- 
2.34.1

