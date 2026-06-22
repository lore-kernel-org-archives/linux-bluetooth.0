Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA06318BB8
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139946; cv=none; b=HfaYayK38K9Vrdv24JNV+VxnblwCSkpFKVGLFN0tDOnfX7Txv1UaAgBeMFIV225lN/odo9v5o90guCnDzTRcQx84kz6hr8dwtfKMH9XwGQBKSzO3rvMdYlpzYN6BZhHWHYKbEJVBcsLlcmi9Ie7qDQHWTfT+7lgWS4TD2MNFtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139946; c=relaxed/simple;
	bh=rPB74OEdCgFCMQEcleo1XL4y2FFq94baHvsqW1Qqs9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFw8oUGjW4tmL/5VIwm4Zm2VmqAHGzbY3hwtmpgYjiP/TtDgqYB4GjMWfYnilQ1L140zqFj5M1rNTqAf3PCkzuuLmWG0giRi3K0iYgDW+PTRfkPrgDMCs2h/1eXh+NYOwQnXeYqQjfl0iPRxN9lZi/qM3krxb07e7ZmLThZXoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LnQjEZ/l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PNuZKjJ6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LnQjEZ/l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PNuZKjJ6"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDFuIp776128
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HD2h4qGjOicG5v8r0EDgKpiZXF9glw/H2ZBt0fVKZZ8=; b=LnQjEZ/l/JCW8E1o
	SawWAC1X7UCUDRcEyMhz2yU9bcNcSqo6Tyy9zeR2R0r0RZ5bIWg/Z2sXDJrgxgH/
	kSx1sajBbpaZwXwCpC5gZF7gO6lQ6h4B9Hm24d4XsB+iUn8TbpZxueNDCKnKelCN
	YxlfUdKsedIVQRnpYMham/9VS4eST+5kPm62m7BRG62INT1GmdEXqhJCGQ4BnqYa
	We9JBww7nPc8pZrHCtkYgkTt1eNSqlKk8EaG4gW6iFqSa9sHTYHxEfP1ddDe7P+c
	uH9mmV1yR/eExapcC7Kc6irxX1awSd/i/M9ZeHJ8Ws7Wm0XqX2YAoX8KdVJCi3ka
	W82CQw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yj90dk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:23 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139b1795119so181351c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139943; x=1782744743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HD2h4qGjOicG5v8r0EDgKpiZXF9glw/H2ZBt0fVKZZ8=;
        b=PNuZKjJ6ffeZ0YMiQnsz3M3iA4Zqpa2K4SCL1k2l9p5f/n1OuLKNkPq99QHpb7zYYI
         Adg/idQxnA3zE87MhfqEdxm1sBbXDv4MXd4cYMBqLhkDU4I5ATLA90q+h5DMddfO+xzy
         Yjyc+6PpaW/ThSBugeDXFljFNp1LsDVm0bY8F9+rr5jNpemZNAQ2aN3czm2Urr5P5Vla
         mL1FNiKXsRjWaujJnNM/7qpKMrGnb4M58b4jNR9vylRfYAhknLvi2N+vnPKb5j5RsI3v
         l8xkVTRM5AtCB4JQnHAXdUA2fg0AhVK0ggtSVpdoXYX4RVdS5FANL2Iq5Dwxm4HRRc0K
         sIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139943; x=1782744743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HD2h4qGjOicG5v8r0EDgKpiZXF9glw/H2ZBt0fVKZZ8=;
        b=oqv1c8EBXHUCVpd626nzO2iP2N1jweb5Xl+dLP0OnljQnA4628h7oc6NIfSVlNBbWy
         LcG99M8qNwd/sikaqIEZeaxe6nBR8Y2vDSE9uNZN9qCwjkPnKyjJObcbXtqwFZVMFxZm
         r+vTDU2PntThXhE9b9jD/bRovykePwBG9NggURZ/uvZC5njPOB4N8Mt4hKTDJE2apLXw
         imKoFWpKEVmTygxAgaMOqviPMUijtewN7RvnnY8iJ/LhgtJ0ebZ/izlxSG3QF4ZvWehi
         +YrSoF/0TQ1YH2CrDoJvJg7xCVakK8/TstwFma1a2O2ly3P4GKrA4d9uftHYKhSj/VCw
         endQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqurt+MDZLwNNkwJsQ8cpZRbOOUHf30sxb4OfWx8ORJyLZVdiS4LtbdDdjC45Io2XusMHHHxLpN9swvWs45Y0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd36arq2TyrFwfRnzgJYMFZOslcGslRQ24oUNqwE3X9DMuFf8n
	KC4fS0bAOX03S0vUobO7x3yLijfp0Zd2h9AiTljBcAXlXcUVpYN53/sLaweWZFiLXQPjV0D0lWM
	Kb+Pi6R0+UjUMTwg3qVuh1Xdf6jGwS9qPAwckMJKuZR9ZKaTR5KkhHTjFSEn0cMrbzbT4OM8=
X-Gm-Gg: AfdE7clsBsiRMYBB1fM4vElrhN3joEFz1FDBDsl0M58mx0GUdhvqhEEx75Qpvirpsaa
	wsBljuLTXvTaUGJP+Ifh9MF7Tcx0YIwO9X/LnwVzXcKu293Ot/MONDnDuzvq/vcH1wJkkpAvdmv
	ItBJ/dubUSMOv8N0k91EAa5U8mMmer47onPWFQ4NwCZJrE4aqjxQ1yodBnRjbasc1fw4vvRUyMb
	A0b02hdm9X2B18jjs6nZJ4K6jiTr4ZxWRicq+qwqRWt3HwuLvZW22mR+ORlA3r0sDfmCdmiUIRN
	nMDF1J95yHt1kT5lyLnJW3+R2t+nLzKBVuOGwgQNz8TC8hyfwO2RRqEgL83Cj6wuKmbpO2hdIQU
	zlDy2FZQ8lS39235t03Wd6Ze2C8Hrd1hzX6UVOD+8T4AQjhCteTK3p4ORJw==
X-Received: by 2002:a05:7300:ec0a:b0:30b:d2f5:d503 with SMTP id 5a478bee46e88-30c52370473mr232874eec.7.1782139943200;
        Mon, 22 Jun 2026 07:52:23 -0700 (PDT)
X-Received: by 2002:a05:7300:ec0a:b0:30b:d2f5:d503 with SMTP id 5a478bee46e88-30c52370473mr232852eec.7.1782139942673;
        Mon, 22 Jun 2026 07:52:22 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:22 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:21 -0700
Subject: [PATCH 08/13] Bluetooth: hci_sync: Fix return value of
 hci_reset_sync()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-8-11f936d84e72@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: vSW-_qojIX827TY5d95TLSZcD2z66EmU
X-Proofpoint-GUID: vSW-_qojIX827TY5d95TLSZcD2z66EmU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX/86xp50PkMXy
 KABYw68Oq1NlTkj1623xEryi8j5YVM28s1fY6sXOVHSoz0Z4GVrAXO+/0BAT3AI3CYZyuJ4Z9bD
 7GIYK1xNccQx1QGQ2pqfzm/Y+3YWrZ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX/L0NtIfE0IiY
 bZch1rPNm3H/vDOCSj2vozKhaHPuD14ervgkT0xo8hzVzFjNMSdxyzSr/785eNM4Ku8wEyT7UYW
 B0oumkq0sNwsS20r4u4k4ky8wjxZdhsh2RT5MwACYIu9twSJHUrceA2CXdyGeem1JwSWM8HWG4l
 P3w6qwCgo2OKzr1VeQpwrfoslBgEFO9ZcZaCAnN7/fb/4+rbp+kkBT0ArNa1dBXXjc9jHu5BmoN
 QBtifJRdqrVabCd31y+plcO4Vnh6D/Oj5VeFim2PXx0DmZQaVsM5cSVQw9m2aHqUS3TMNUdqM4u
 UdWd6lG4qK/hmRIKknG4eH/tjZUdzXgibz7eIMjXKDO3VAZQuyTVYvpengG0ibXqzywziDKoaEt
 Ep9KMDu0n5x3L2uI/lT3etv2e4LjUBUA8qxAhf38w/ZAneUJFqpXvKGNamscb0Kp1X/cOXcIluK
 6c8LmYhxUVgBqSq579g==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a394c27 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Uqdqqp8oKja_hPjkJiUA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

hci_reset_sync() may return positive HCI status byte as-is, but callers
in the chain hci_reset_sync() -> hci_init0_sync() -> hci_unconf_init_sync()
check errors with < 0, so a positive status is silently ignored.

Fix by converting positive HCI status to a negative errno using
bt_to_errno().

Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fce9f9526cb5..601d44ef975f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3678,8 +3678,10 @@ int hci_reset_sync(struct hci_dev *hdev)
 
 	err = __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL,
 				    HCI_CMD_TIMEOUT);
+	if (err < 0)
+		return err;
 
-	return err;
+	return -bt_to_errno(err);
 }
 
 static int hci_init0_sync(struct hci_dev *hdev)

-- 
2.34.1

