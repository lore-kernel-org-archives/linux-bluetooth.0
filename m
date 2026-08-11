Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB341A57C
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437455; cv=none; b=umVw1XUvauMEBHCP3wnnl2TSUWUTa3lC0GdlYbCZL8pHBNXBAFrVRH6lFpAfw4RO5ZcAO2gaHeJHwgyV0Wz/vb5i5jz1+2H19ycRW6h9UEKUuM/7o3pmFXy9YPJboNCPSNONG+AyIObA2AgknU4dohDgubu3uGk8SrokbRMYVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437455; c=relaxed/simple;
	bh=cr/NcxcTn4m2cOVGIkk87IdfX5HLlJu10qgZsLser0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keHQoMYoXfvzy7LtlwyWQCXmpgaDvDMKAu2RYcQN78+MSjkoVQvSbrRc+vxZxrS8KhQM5JWbiTdJi07As5GV/NKhGnimaEi/DwALKT0jvmOnsNroKaLic/3JJ1sPw5hZ3Blu/sCtVZYQBhud7ulLvQdYNwb0kJYiDOp/0jHooZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E4xqD0bz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jSJmsEcu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E4xqD0bz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jSJmsEcu"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B6v9tP2252636
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 08:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eET8pt8EIz4eve4XOzAwqLJEC4iYOR3jpk2
	dxLkAo7w=; b=E4xqD0bz6wBy6j8vgjjgI1brE/rIUbGL+FzeRpjqUJWOhfJOfP1
	Zn3KIV9MZxRqFly5lRtvLoVCbSpnZ+Kv56vtDZy+c5Dp3P319R0HfYQ6Vx1PydBW
	W7t/LMWg6S1amvlJP9Hd6Y13zNUle8lWgNS16xODq6BasDr3gkGqpiECZ6KBoUUP
	1H8m8or65SYlfcjWESubfhcAP7sNtDb6whAE2hNeOaPaktjKp2TMMG8U4mQISj9X
	NIZolv1jzBrkheBWHBG6Jlv3KA+2pcUgVxgGck6jraofU/Mwbnhg8CI918tfb9/j
	pjtOJoY1BzvmAKvIacFTYi3rmDfqog5rEFQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk7b8jg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 08:37:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c01ff996dso38788291cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786437452; x=1787042252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eET8pt8EIz4eve4XOzAwqLJEC4iYOR3jpk2dxLkAo7w=;
        b=jSJmsEcuFc3ipvTNzFu+xDC8eVU/h3OlfdMi8LOgd9pMl0n14fCExEKrXsncVqD4Zn
         k/InLfdo/PbVU+DS/PajNAAT5JagENUu6U+27OG9S2cfLCAYI7d4vfnRiGv0pfIZXkRN
         g/P3bqiMFoIEflS4/N2nFrVQhjxq91bWf51zeJTzxAar1i9WJa9jarclcy04diDViYJU
         2DyKg3mJynXPOWjCnMCeQnE3L3QjL5k/ZtBrdmI7iQUxA0Do8jut2PL6RAqdphgHJp62
         yRXNTFNUuWeeQjGyjDtBooogUwKYSXYRaescPHXLdQaqyUmQ23jhRp8bUd6HlcuehcXz
         iJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437452; x=1787042252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eET8pt8EIz4eve4XOzAwqLJEC4iYOR3jpk2dxLkAo7w=;
        b=WJB1YPmA6bV9ZDowBRrctswXBUgT3RI96XudwUpU/RTPQNU9lvzu3hmOvPo7PTR5nP
         rEY5gwNF+AbqqN1nSZ0+DhUAyiXUYWbfviOhhfaAOOHrNytui9mzNBKWdx4z/ZCHNyoa
         kw8xIyGqbytQ7HedM9t0+t4p+WcRTWca242PW29JNzIhgf1Z/tkEv40qs+fPKwl1PmEl
         i8zOnvVjYfouzgn1bnneCooqAA8DV0UmINcYuJ5nF+9UX+eC0lyUFrxoSDYyweuRugmh
         WVwTNcXFpZlh9rLLHtjriY0BeYsYg7XlT7BT9VSTzMzyxTPlmHiv5B7nrb3p5mqg0kze
         Zhag==
X-Forwarded-Encrypted: i=1; AHgh+RotpoCrCB7e5v8Qx5rva3kIdlGCZL1kKmQEuSHHaWZ0ka/TCXFZS/rcmpXD+Kl8ORn/Ue1ZGR0vQoANiDj/z6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/dBUN28lDT1Yp5s0o3Pqcf4cz3SMpUdGybWl98IuEGCZTBx7
	wmOkIBK+Wgi7+ydmY+HjGx0ADuq2DnCDMkDTXuo8bzHq5lhFRQafdw1ViZu3kyvR0zAdRunApmS
	RHxbdtidWhmy68zzrJ4V3e4kUtuSzrh5yA7tfw7TeG+dtoleIhq8AAfq2XUlNx4+VU1OvE98=
X-Gm-Gg: AR+sD12rD7defDzi0NK9dxQ934dMsKlkRDXzR0R8xD4dDrBX/ln1aJ0FBG7HyG0+t4A
	jdglxbvUmstGbysFM9BBzCHeT2b9MPn5n78J9E9gBUBqeCAhszfezoJBw9LhdqDlaXFOq0bI6Oh
	a5/CfqE4QaNdecYKi+1BBDj029wyZNNGdpthsC4a4HxVG96JQnxej/WlbJIOdSPPOZqY2+UXVXa
	PaYkdd0/5HZAaJkSocTgIHRhS/gdjFfl5S8kKtE65w2oKc9a+ZrRO/aqaC1DLHqxt2JUlFMLnSi
	Xz/T/WQ161nUtug6aEPQotLpCYOgc+nMdayPnRBagwGPyBCNqoSto92UR1Tk/OF9hwYe4IQIQ+E
	oYUNZJAdUiyfZzuSfwvwNiNoCGQhl6ivagUgJvA0pYNVNi0htY5PCfbO8v1cU4Hkq/Zb6FmyjCH
	VLln2CpqrA2ydkaUE=
X-Received: by 2002:a05:622a:c06:b0:528:3d62:16c8 with SMTP id d75a77b69052e-52d586748b5mr12709701cf.31.1786437452250;
        Tue, 11 Aug 2026 01:37:32 -0700 (PDT)
X-Received: by 2002:a05:622a:c06:b0:528:3d62:16c8 with SMTP id d75a77b69052e-52d586748b5mr12709491cf.31.1786437451782;
        Tue, 11 Aug 2026 01:37:31 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a362eeb727sm357208a12.24.2026.08.11.01.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:37:30 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping the last request
Date: Tue, 11 Aug 2026 10:37:29 +0200
Message-ID: <20260811083730.71393-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yus/gYYX c=1 sm=1 tr=0 ts=6a7adf4d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=K8nJeBO14j-BIrTqJngA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: lz_9aaF8F53fWv51hcuX5M1c63lXuo2s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MCBTYWx0ZWRfX1kARpX7xqS2f
 9r96KtUoEE/DLoclEOdy4/G1DoHXRUxupIsDuBEensmrQZk4CvkKYGoPsVwnvDID3zV042pshfH
 PDYd5H3G7iSRytkdE/yyWzS5Fhqv5/YxfObc44S+/ME9mfMzTHw1JJtNZ3JQHrwBsYzJZqMj9BA
 0EA/EROm791GwMOjIPZc5C0lODOf/OT7Yx0r2YdfczG8udv52jJg5W+0T3jLtFHsyf5SfsGhj5z
 4FQHueLKvxfqPBtNoYypBgT79DMQUeygcj596AbKaelasa9m3J79Dd2Gdo3bWe76AqBHvxf/qC6
 m01i2g65H5OSLtlvuKF32mv6kxS4LCTxGqhg1GS3Oodq3NCDE1m/3VDtIOkN5rtFeYw+XfR++SB
 3D/lXSesjE84/JeRqC06YgJg5GKv/JI8ecK7acCFXSLr/hNsv5oScL3QeC8tZi+emqsj6RWkkCQ
 bSva/hY9YU4o6Xdtytg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MCBTYWx0ZWRfXxCv4883cvEx7
 k7WOaxPRrTeBdAvm+rVfpQ66tnxq8wuhZUCn+pZJQiW0/8eLC4m8d7URc0ye/nvDswtX7YrY8EV
 N/Ady5kFfQYkzbiUKKwdvPxLPOVLut8=
X-Proofpoint-GUID: lz_9aaF8F53fWv51hcuX5M1c63lXuo2s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110070

From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>

A synchronous HCI command that never receives a response leaves
HCI_CMD_PENDING set: hci_req_cmd_complete() is the only place that clears
it, and it only runs when a response matching the last command sent
arrives.

hci_send_cmd_sync() populates hdev->req_skb only when the flag transitions
from clear to set, while hci_dev_open_sync() and hci_dev_close_sync() drop
req_skb without clearing the flag. After a timeout followed by either, the
two disagree: the flag claims a request is outstanding while req_skb is
NULL. Subsequent synchronous commands are then sent with no req_skb, so
hci_event_packet() has nothing to match an arriving event against, and the
caller times out even though the controller answered.

Commands answered by Command Complete recover on their own, since
hci_req_cmd_complete() clears the flag as a side effect. Drivers using
__hci_cmd_sync_ev() with a custom event do not, because a vendor event
never reaches that path. On a WCN3988 (hci_qca over UART) this makes a
controller firmware hang unrecoverable: the driver injects a hardware
error and re-runs qca_setup(), qca_read_soc_version() waits for
HCI_EV_VENDOR, the reply arrives within 4 ms and is discarded, and every
retry fails the same way. The adapter is left down until the driver is
unbound and rebound, or power is removed.

Clear the flag wherever the last request is dropped, restoring the
invariant that req_skb is non-NULL exactly when HCI_CMD_PENDING is set.
Verified on hardware by forcing a command timeout: without this change
setup fails on every attempt, with it setup succeeds on the first.

Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 net/bluetooth/hci_sync.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 532534bc601c..33ee71c56480 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5302,6 +5302,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 		if (hdev->req_skb) {
 			kfree_skb(hdev->req_skb);
 			hdev->req_skb = NULL;
+			hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
 		}
 
 		clear_bit(HCI_RUNNING, &hdev->flags);
@@ -5486,6 +5487,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	if (hdev->req_skb) {
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = NULL;
+		hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
 	}
 
 	clear_bit(HCI_RUNNING, &hdev->flags);
-- 
2.55.0

