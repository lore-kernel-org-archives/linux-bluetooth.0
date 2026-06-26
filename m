Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DDC3A380A
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451199; cv=none; b=QrWTfoRzLIlF6h3XKsVsRnRX6EzlAXDI8K2rtrcRiSNSvasrTN3Qq7wMrp8L5C/q0G9uAJWsBNtfCwIMOsyt6fWOuqq3o8I1STg44XK80LF9F3pVTG6Cttej7qjpf/+PmXxYH/IBerdtQ3+WS0ewA1MCJBhvI0YkmBQUH0444c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451199; c=relaxed/simple;
	bh=mIcQxAdD2qd9jSn8ioOMwlU0Fa0HTZu03S4klJZgTaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bXX5k0mw+uR1BahBOgGkObxjjGTd3FtUXvlYZIp/CicGzv+X34ZxLQaKb+e42hycpihoUWBBnW+22yu8LVDakoE3IuGMGQdbmm3KjadUywSwdjMO8ibOPNxo/G0KPbo4TMvHRYbZi2mh5N5GqW7MrfRJPqz/z3iDBRbg9oaw9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L7V6Ql/Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZM0QsKlF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7V6Ql/Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZM0QsKlF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2jbwE3735402
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v4UjU91Umg3OK4JXPlgbYWEXaYIjR75Eo5tLKocjdtU=; b=L7V6Ql/QtRprGJN4
	mTsDjos0sb4qWsFXOihT9PCJvHSTry6zTfopFQ5lAPXPa4yL5hZqkFwQGpBvCGuD
	QQdynoH9hZHLPVxI94E6EpW9efR5OcAIwsW8PX26VJonY/eUFFHWRR3EuVurmzWr
	zr3+p/2feZgvLMBrGGS85FhrfF4TkdYNp6pd4BlkyswkIOXwLCDoKTMzzsVzgoCz
	w3f2uhRAdk9CPhaDYN2rze2vo887rTDhXNytRZlZLtl8WsIoHsdQGuMufXRcMMch
	KvzWos0P3SzZZsSCOO275Utx/vpwRsPe9AK9voNeeu0VOUj2d2FC/+TxXqSpd4vn
	zpT+OQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f16ukb2mj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bd0d5f5a4so61883eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451197; x=1783055997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v4UjU91Umg3OK4JXPlgbYWEXaYIjR75Eo5tLKocjdtU=;
        b=ZM0QsKlFcZNXEkCGQeJish3aMc5JvNYjU22mp4BY72RB1mk/4Tm0v5EbpaN1LawUZJ
         dKIaIMHavwK7W66d268KFBKBwO5ASTsdPccM5mvkir3F4MioDYI42ULZS2ygb3GYA65i
         B1QejghdfieS72W8YgxBOAd7k6TFrMkfo839IycZJmKGh9jhuymeA2lJsdZegnXWZ1NH
         kAACn46w3BOTSZmcc30cHf/WcNObitkmdQs4l7ed/4YqEb4Sm6ARKQuDTxo9wqC5d+mz
         yoNcufxbXs7CjHkf7177unzhvkC1s87IMcSB32RNdlT4Oy9JKv6nTpy6Yx/DMyzv234h
         hfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451197; x=1783055997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4UjU91Umg3OK4JXPlgbYWEXaYIjR75Eo5tLKocjdtU=;
        b=Iqlg5/3Jg/SiyJkEPamqYVVVYRUcNppBc8lY8cHrsyPqGGiTBLQ2Wx2oTZBGb7aQDj
         5vltqm576W37ZM6ilYXQOhYrfk2MPcjJTSDSxvQTb90xKcpjYpKfZQiBkH0gAWSVj9lD
         iXm39qtwo49ljc9DiAkW+0IhKgZ/Sq3i2nSr2zzos5HOcwpLYE07E8EwX7fOhErlzhgV
         ZdcKW1e3mTMKYN/kMN31jQN7Mmw1QMvJPzaIAMk6cnHKbH/WZvL1o+AwNdaOLo8x4r0t
         dDtGKdqKaRwkcB7mgImpGK2CPL79jwcaVaqjaS/Lr1bESYknhM0pbpBQAP+0INjz8rkF
         hesw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/9yIPIR4lspCki/KHngVDAY1uYIe0dL3TZUHBtJU178m6junJLxA1JuOAmX1QEh0U62KAl8um4ghc1EpMHhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+5Sk/di1nfmDeZz8oB02C6v/oIi2so5zNGuZ43ir00Gv2+1w
	vOPSlem7XeMhPPif5xuRpav9GdWJy7iyhVz4WmKsrVPQnwYOFWNTG4qrEnU++UxTVj3zg5WtdTW
	P1gztEx/CuG/SHSzrzMe/IXQXFyE20TMkNNd2jHiilwbf86RHkouYlZP9sSBRnB0yWLkNmSg=
X-Gm-Gg: AfdE7cmMY5FUmW24mDhg37aXRvJkUfX3o4THcVHR1OB2h7g765qOb7FfC8d2fZW1ons
	3f+rHwoD7Ier298PwQ9CRi8kV+iXXjTCfJ+my2G+9b8d9fDtsE/az4lWFvv2JDve8p4euBX4IC7
	OmRyCCI0GD3VNgvDc5FdJOxtql2KZIzGhsyN2Acc2sd/ELAc/Qo2XjpIjHr8PQo8PQ7eYriVjx5
	eYMYJbyTZUuAYqIGyEpWI4TYfrn2tD/0cOvjw57uJlhQ0a8NFhuzDT+L7wda/G3ELSNsaBPyGjC
	VI8+uRp4yritQuFUUcHiu33gwb+OfBMRDQqSVwuEwqlqWCIvGtWROtTMZdjU89YKHyK3c9PYidZ
	g4vqE4HXhQgPquHxU8sk8d76T2I3vhpY7Vpl/UNFiBaJxD4Sina+rcGgDqw==
X-Received: by 2002:a05:7301:6502:b0:304:3c33:7afd with SMTP id 5a478bee46e88-30c84a75c4fmr2279629eec.1.1782451196587;
        Thu, 25 Jun 2026 22:19:56 -0700 (PDT)
X-Received: by 2002:a05:7301:6502:b0:304:3c33:7afd with SMTP id 5a478bee46e88-30c84a75c4fmr2279620eec.1.1782451196092;
        Thu, 25 Jun 2026 22:19:56 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:19:55 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:51 -0700
Subject: [PATCH v2 06/12] Bluetooth: hci_sync: Introduce __hci_reset_sync()
 for device drivers
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-6-93396a6f7d5e@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=VuMTxe2n c=1 sm=1 tr=0 ts=6a3e0bfd cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=kQ_UBjYZPz6FNnKCBYIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: DgZCj2MEsgC0MrZmtPQECX0sj0UrQFuL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX2PxN5dtpQFDU
 HdAH2I7JWo7NL6xKcgQ4nUJib/XQ75RUFUpNTXc1ibFB0XhWEsTJWBHRCrT27fgu+ilsmrlI5a5
 anZKTLfr2y1IUzbR/GAGWOUEdwcYfot5BeW9GH5nrVst+I7D25PiUOolhwJb1d7ioLh0U6m3ChW
 Fgjp6QNH/K55tZ7ANEPdfTMFrkEYom0rMmDhouA37D4Z0dCdC/WaZkTmwD/t0Y9skbmy/mVUSsS
 oSQys79uKLjwkm3c2eS5aw+hkI9EpO9boQk3wUSBDt48ShyI+wnqBfXMVV76OJmRB5RetQ5R0Vy
 gqNBK0TBSWcCrxdQdn0lINhtZXn3/bJb5x7TaOtTzCb8xpna3ga1V4AZxFpCnd+4S2dLhStJOio
 0GSedZQxXbfad7rAUB2qUjQn9fqVI/0rvqgSogCwuuzimhYtGlqHlN3QHt3oIscfDDHHNMfgU5L
 o4i/oskEZGr8RPmENPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX+pHwuiwahi3h
 D/WVIHFTLj757MnPHP2Z/brxROGGLiRejFrxyJHQf5Ut3kV2mypZJKlkitNVV+UOU35wpJZd2oR
 +hd+578kmitJ17Z7HPqS2jaV3JBaGLg=
X-Proofpoint-ORIG-GUID: DgZCj2MEsgC0MrZmtPQECX0sj0UrQFuL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260040

Several vendor drivers have a requirement to send a synchronous raw HCI
reset with HCI_INIT_TIMEOUT.

Add a dedicated __hci_reset_sync() for them to use.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 include/net/bluetooth/hci_sync.h | 1 +
 net/bluetooth/hci_sync.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 73e494b2591d..7005fc9f257a 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -59,6 +59,7 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
 int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 			     const void *param, u8 event, u32 timeout,
 			     struct sock *sk);
+int __hci_reset_sync(struct hci_dev *hdev);
 int hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
 			const void *param, u32 timeout);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3be8c3581c6c..ca1ee6c89739 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3684,6 +3684,14 @@ int hci_reset_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/* Send a raw HCI reset for use by vendor drivers */
+int __hci_reset_sync(struct hci_dev *hdev)
+{
+	return __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL,
+				     HCI_INIT_TIMEOUT);
+}
+EXPORT_SYMBOL(__hci_reset_sync);
+
 static int hci_init0_sync(struct hci_dev *hdev)
 {
 	int err;

-- 
2.34.1

