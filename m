Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150D363C46
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525059; cv=none; b=MQNJCKLyspQpqVbtVW+SHHiSgZ3kUMAQ08vmYajllWx8b4Dp23b1QX2HGL/9l1OMdDk+RTCeaqndhWM+rNHK6EcdNhi427jhh1zLG3PFfB7an4K6jUGvnrX7fHJkmIAUUHwbqKF3Waff6AMfqfbdoaliLpTkWcpsNuI304qtbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525059; c=relaxed/simple;
	bh=dMaBFIhHgvp6kj4ikE/WkqbjE/VbovpetLkGFImIOZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DUjAliGVjeHJCAbp/cxuv7nmcf7y3YoSAhGNung2lg0PVl2Y3czJP/hrKvt7nvob+O0UvYwZvjNhjv6ARX8eRqngvNLOUFzQt7wN7KBE4mYWeXp7tTkSD5ipzSDtETU3Chc6OEH1ID8C2uwe9ef6NmWujFSYbPJW9tEO/J6TOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SB8PG/qi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i7QmglOT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SB8PG/qi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i7QmglOT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLZ9b8980299
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 02:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GbSdUBix7PWKvhUPV21eCSFWHOqn4Rr6vLWfPbupJ0w=; b=SB8PG/qi5oiPO+O8
	jacXbxjGdAi/MzTLKfb5280X0jkUcpQsMI6rAETSATs6+HHZUZMQwnelu7x7jXLV
	I5a8YMFmqkSRfK0/ZKPB3ES9MtGwlJy97FL+28CAN0rNpi673J03GlYlfxnCt3so
	M253THPFgXaqNBzOW36LfvnoFIgQhtguR59VNvKpC7+JpshQmHUQXkgUG9IhHrW0
	vHOePGU41Eu1OP4heHrWnE88TcYZSdx5Cyyz4zORXVoUadUs/YpgOs4s3Q/YGaFm
	wJQE3nFIF54kyHe3kRqdy+AvcsX+jcWW8ePPfoWuPpnkv1ElnEYpBjtm2sUsZiUn
	9d3Rcw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3xtvcms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 02:17:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8d1600b3so1297880a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 19:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789525053; x=1790129853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GbSdUBix7PWKvhUPV21eCSFWHOqn4Rr6vLWfPbupJ0w=;
        b=i7QmglOT3FS1N5kBEBogyqXnqCkhZx7up7n013DPnUIDKFUEEXwxWDNl8uYz7PrkSM
         Rra7qtnFo7/uf/LWEoPHL8F06uY04O/elZWEl1B0zUKhiZyuK11NZ4xH8lLO4nmbVtvG
         aZvJbJjUDtyBaHCpMUZyTPDFE84dRJmeM5JDekGO8v6bApLmCYu+7Z+h4ghvADn6IThX
         5FRPh/EZNo+bcV0NqRBwke1vk2u/vwCP1JtA1LkYsxP1zHe+rSgkiScWVV3US7UYaj1/
         +jKlBSlH2yUSHZwlJ96VCnErNxJwfLGpgnuLfC2rZrtRQXtaxHkJn1jaeuGsREreoEDq
         i4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789525053; x=1790129853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GbSdUBix7PWKvhUPV21eCSFWHOqn4Rr6vLWfPbupJ0w=;
        b=hAfapJMW64+c0ReCCYgge4vmkJLlmWEXZmTGPxfN//Y3CmziHFIzRkzZweoC9bh51r
         Hdj5ntKkiJwB9gXLM1+fnMTThTo+D5bNN9Um7rv/h+ewT6zc/3b3Mf8X5DyWlurSdaUc
         3Wghi0aqRoKok+h+DrQKzAtOkDzGDSB0258+UaeG9hxDeWGtW6ZU/vJQKLcnnXc4ABlg
         Deh+1Btz4ekDpj0xrnYmGiSeAda5EIdPbK57QvPspb5SGFAKOTlOXLR7plSGkVbNV0DP
         o/LiZb2W6ondCzIP7J33iEZtm4WqcwrXFxybY9ike5PnL+sgE0k22n6bVrjw3mT82VqG
         3qtA==
X-Forwarded-Encrypted: i=1; AKwUvBwhmAhv9HK/erbWgPacAeYtJRf6ObXtKsRwOA3NDxHa/fDuenTws36S6WPoELJ5GF8ZDMElKw+HMsI4dEnKUwc=@vger.kernel.org
X-Gm-Message-State: AFuF++n/cotQjpHOGTlUgcNkRvBUzRBXKqR8T/2GQsGI691Su7Dd817l
	ssAxqeLbT+39o0fH4gt1aAUh5S7b/zN6MjOX2616jp8S0MfAQjic+PoYwLa8QLwUXdCDwCOqAcM
	hKM71Up9Wv71PoxRUakbkEs20/l1mV5gjIku2uxbSNtmfm/dQ94y5tojKpoH6ySymhMWrUhSXIZ
	oVQAM=
X-Gm-Gg: AYBFou0agjaBZgohHN5CjPZc4YjDWSacturpc1W5RXije3xSEqWMU1YLNeCK8kXJtgP
	oO++j8emj1lJlk0S6+YJnVkYcUkb4krHjxqd/h4Mi6wOE4wrIir3fGXIw6Jh5OXrHOfVnXiX+G/
	zus6h2K6YhCERqQZ6exTktW31J304Ksi5t1JCIMA4DeXi9IL0LKLMyCWFW44TlqEqRH6EC32vRJ
	j4zoc1mN/wsZIgQB+eOK86JLfZejxcmlxXkc5UKmlIeOl/W5F9MymBz8h5ho0lEmofDPtwNQYpR
	O2VUMg2V564UP6xYtIsbTg9Uy0jm3ynQsA27GGxhmBNRL2j9dV91FdskIXUyAinvV5G0VNPcLnr
	TcRU9RLwky0xxvwkNVEIndvOnB3yRXdrEuEo1edJLMlRbufE=
X-Received: by 2002:a17:90a:d444:b0:38e:c140:2a0b with SMTP id 98e67ed59e1d1-39e1e4e2964mr1274970a91.3.1789525053145;
        Tue, 15 Sep 2026 19:17:33 -0700 (PDT)
X-Received: by 2002:a17:90a:d444:b0:38e:c140:2a0b with SMTP id 98e67ed59e1d1-39e1e4e2964mr1274930a91.3.1789525052707;
        Tue, 15 Sep 2026 19:17:32 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5ad9ed5sm3200332eec.22.2026.09.15.19.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:17:32 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 19:17:18 -0700
Subject: [PATCH v3 2/2] Bluetooth: btnxpuart: Fix skb leak in
 nxp_process_fw_dump()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-misc_fix-v3-2-31fab8976ac1@oss.qualcomm.com>
References: <20260915-misc_fix-v3-0-31fab8976ac1@oss.qualcomm.com>
In-Reply-To: <20260915-misc_fix-v3-0-31fab8976ac1@oss.qualcomm.com>
To: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: p5V_5z43mPDsBYt_CqWc6zcEEvYIS929
X-Proofpoint-GUID: p5V_5z43mPDsBYt_CqWc6zcEEvYIS929
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDAyOSBTYWx0ZWRfX0X1ibYYKI2A3
 n1PZcv1EeOjlXxXm9azTdo+cnjmAXGCYD00CJV6O6PXqr8QFcm+FOD5DjKGkGdHmFeR51dZQ1Dv
 5fTVOwzm4u8j8wKsvXnQii+z8KWAMpg=
X-Authority-Analysis: v=2.4 cv=As97T+9P c=1 sm=1 tr=0 ts=6aa9fc3e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ts5nViFRsRHbD-iAU4sA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDAyOSBTYWx0ZWRfX6J7/8rPwxooY
 I0c04Ex3L1SKthBkUMWC6X/jXshvzkjDpRk+U8RPROQSmHV1LemAnu4odi953SYH8axHqTrSfnK
 RFlrgMwpKl+XcfO3729S4fVbMKzXCmn/QmzmdBXpiFNN3s1RJjq74j5NWR5j746GxMdu9HWfeu/
 vtia6Lx0KxVwXoYZgoUTwqiI5tPHVidSBIcKY3PQ4t5ri4+bjJHfA8o2chvF2TxWX8Fw+eGML9C
 NkTCBoaCNgOTgzRXoefIWRc9pbSBVw6eyrnjubz4vwtiIIh9d/f7OAwecWP0Nt+mmQgxzx6OjtX
 kW4ipXkqkZUHURIRVB272PBcyzGJkQrEHA0wCYI69MhhlJNVCYNDFE+f27jAZgGL0DO6WbpcvpN
 M/riJHYvrHBVd73nO1tYiRqBjeOihi8wHvxaAPSBNLt2rPHjrwhDfC1mI5MnsMK6r+leNVUOxir
 DIifBUSzaAAw4qnflLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160029

When CONFIG_DEV_COREDUMP=n, hci_devcd_append() returns -EOPNOTSUPP
without freeing its skb argument. This leaks the cloned skb and also
prevents nxp_set_ind_reset() from being called to perform recovery.

Fix by guarding the hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC))
call with IS_ENABLED(CONFIG_DEV_COREDUMP).

Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump feature")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btnxpuart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b975a00eb6f8..5c730e336114 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1383,19 +1383,21 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
 		err = hci_devcd_init(hdev, NXP_FW_DUMP_SIZE);
 		if (err < 0)
 			goto free_skb;
 
 		schedule_delayed_work(&hdev->dump.dump_timeout,
 				      msecs_to_jiffies(20000));
 	}
 
-	err = hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC));
-	if (err < 0)
-		goto free_skb;
+	if (IS_ENABLED(CONFIG_DEV_COREDUMP)) {
+		err = hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC));
+		if (err < 0)
+			goto free_skb;
+	}
 
 	if (buf_len == 0) {
 		bt_dev_warn(hdev, "==== FW dump complete ===");
 		hci_devcd_complete(hdev);
 		nxp_set_ind_reset(hdev, NULL);
 	}
 
 free_skb:

-- 
2.34.1

