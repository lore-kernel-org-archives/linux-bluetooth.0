Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3E2328B71
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354064; cv=none; b=Wkyr/bVGOOqxUneYUMnm1fokmMlVLReX3XkyX+1Y3C8dk9MmSutLnMKT1WoAaRMS2ShKImonDx/wn1tUCzfQsaiu8233sww2Eu1rj4nkv+CBTkYe9/V9CID1g6/8DrOL9DtFcS3j9A3KpiKYJeDtn6pbO6vZgJ2waap1GmVjNUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354064; c=relaxed/simple;
	bh=FeX+5SSAOfbaQ58usKljVzvtDRwIa0YCMI07fyqDuvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYdcekPpDvDon14JExVy2Mjoq8XCnBNJAyBTFSrV+5M9fzKw7VhpC9iogJ45EUXxoUZQRuVNWsZ8cac2WvDlCmyGvuo2v/dqLce6xlK7xPrds1OeZAXanun48mxKEfHWJwFCmHdpsP90HM+UBP+AfAYEjit6f2HWPz5BfxVQbVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dyrhaJJQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SrrZl/HJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dyrhaJJQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SrrZl/HJ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2egrp3671440
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I39ywH5jWkYs6V2okSMHwL6YcA82wKWv6kdA/H5Q9QQ=; b=dyrhaJJQZ99mTDYw
	XX4Xa0Sj6NKrCWxo4kKNIUAbC1IxTF2HcDTXFPahImeFuZtubpVrxtC1c4ZqBgGv
	IVNkeTPowg4qYxC6NYqp7Pbva3LY7rFmXZGLU6tb46dOH4mCByz5WYaaGzRfwfmm
	sKPxaeEO/xCt673+0FrshYOb1dqJow1TCS1qRn5M1UjwUZpmFtfzZ9eyBzCwb1ja
	yH186sUSmizR3MrGZd7nNFHNQIolb7iNTRIcrwzlb/O4PDsCt5rJcAr2XUBi6ZhK
	IL5CDRc/Ha4TSKBVEpOODqPlMLsDLskq9vkMQ06jE8BCM1BD4AJAsc7zb2QG9ALt
	yb0gSQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3hsrjx2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1cb9b67bcso99120a12.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 19:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789354060; x=1789958860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I39ywH5jWkYs6V2okSMHwL6YcA82wKWv6kdA/H5Q9QQ=;
        b=SrrZl/HJ1naUDbRoYM5+YYs1crID8CHNSx2nxHNQSbpDTkfClM8swmklQa85gE3YxN
         T+Y1d5d0IXE0CGxB3SU/0Clsq6eUWau+px7XM+D7Et1BVq3KK7s5w9ZWMxkMXUCgY4my
         qKnFU2kQHwk7d3EtnDU9B1lEqNTgQp11l9BSLDz6R8MfB4vLaOiGZNsbHHlLTVIKnqA/
         UUajmWxbtkzHmkVfxcZD9qscioeQgiHUXagjbWUffRegY08NfY9nWI8SOv17o2DljrA+
         BK+3SI/4pG74rOLYECdLmHyXAKELehndIAd/XSUB21hQGq/niGq1k/Gfa71U+5/xle5r
         T2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354060; x=1789958860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I39ywH5jWkYs6V2okSMHwL6YcA82wKWv6kdA/H5Q9QQ=;
        b=CVKWSDlif0WxgzAIvg+SI7nZdTW05rK5CvquoOxzSD23EGnDivOa70k+T2R4NPQaap
         4FuHOnt1j+Cf8zO1RzEsnc8xzKV09dAx7zoit2EkbBMTB3xlQ1/2qWsXLqLXrEf2bpwu
         Aa/DWNqwHg0zbdSjGP1RUv9qx5xojx2hcfxUQ3afIsbcS2IkHPWAOI1aeArZ8k4ZTp8j
         H7bSfgqUSMYANMlivM5iw8lVLxMP6TssADS0dzqNyAWZ7o614xU9wzRfvkODcFJxAR7U
         Nw/QzSW1Xn4It7bs/Ryh3N6JA8zytbgA9NYYExefJJ8EEFqS0cf49m+3WHxeePud6yxC
         5yNA==
X-Forwarded-Encrypted: i=1; AKwUvBwZMiRIm/CRg2CyS8KyAhmUkO/pC/VDVWQMYhG0QJxm4s14Qk48zHtVYLEo4oYBzjpH091T3NvCNY4cfr+IifY=@vger.kernel.org
X-Gm-Message-State: AFuF++mGHL8wIKk1LiGbNNE5Cg77jwTNOqdWxcL/nuYCTyXbSezMSHZe
	SKXqspTlELpAq4+lkfnQBywNhCbzng713fPIhmlhvDbli51jSzOA0s16hwOM8+q2TtABxmXDtS3
	LioSA12N4s9xTHAtXzsyXAvz7VA0TK7In4LaQOw4MoqG8oihUX/Zz5u01zvEclKQclbhFFTg=
X-Gm-Gg: AYBFou10ZQlqdM6qZJa3h2HyMXzUdw3e4p9tyeyT5etE3HfkgPHxcDX2dEJ4A5uH9WE
	V1d2c2nPnvQqlJnq4BT8SN5Ao0lKUb3i25odPOhLidbvmNWXY97tkDH2Np9XraegxJIQhOeVlkC
	0FfkJv4Ww4gfDKcLutSMbisJ2TgF/2BMyXVLhlS6x8cXD9FGoNsVsIoPyl6gbWnjrSlBJSgJnO8
	TeC/xMFtPWRVYT8UL2FocRyhzEgdPbWSV9wAqRMYZ6wJ1lfTlU7uxAF48xN3twA8JTx0QHJ7Hq6
	p3MX3C9JWYdRr5erU/4Q1NLjDn+gz96ib1ghTqiebut7c03yQmIfZw/rUAInNqrW/tKBUUSJKPl
	pJkZNdOGuzWIDTz+okIaYc1P5qQUU3foNxeQ8HoSpUYFHhYY=
X-Received: by 2002:a17:90b:2688:b0:39d:e1cf:db40 with SMTP id 98e67ed59e1d1-39dec15a5damr950726a91.5.1789354059912;
        Sun, 13 Sep 2026 19:47:39 -0700 (PDT)
X-Received: by 2002:a17:90b:2688:b0:39d:e1cf:db40 with SMTP id 98e67ed59e1d1-39dec15a5damr950695a91.5.1789354059455;
        Sun, 13 Sep 2026 19:47:39 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed295esm25945014eec.15.2026.09.13.19.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 19:47:38 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 19:46:43 -0700
Subject: [PATCH v6 1/4] Bluetooth: btusb: Add recv_intr() hook to
 btusb_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-btusb_qcc2072-v6-1-137898715844@oss.qualcomm.com>
References: <20260913-btusb_qcc2072-v6-0-137898715844@oss.qualcomm.com>
In-Reply-To: <20260913-btusb_qcc2072-v6-0-137898715844@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAzNSBTYWx0ZWRfX+7h2OfQf+xLd
 YERp+9PJVLObvXwcuz8xTcfnkrQ+GnB0Jt0c9VuuBe9jvkKnfF0ljxx4hJCIU2IcPHEw6PsTgOI
 3p6MBdLcWq0jRJxwOhq3uBEXfUsQImrIFEKaTEyxU5yVoYIzGE7DVIHk9ldzsF0oNjCabfHRssd
 swsUGIMcjUKS1WFhGdbh9xqdL9I0Kh13DaLS+rgi0kCfwgwCIwmJmJpsfTT8K1YUOAFgogL/7NM
 R/z7njWmVD/iT9p4qeqJIpFn9HTzCs8P2Galv+2WuLnydf1GK7/oq+yu0cRt45limqzvaYJEER2
 56uNDLh92ohujiXSyGsXVMVfWAReGJU+2bk8D2iHHMBhcHPfHoVG/bxiEBsKK3gHqffDophxFTx
 LCZFhlaRo2ciCwVubPkWBHR04GmSx1diq675HskburK7Fh7DtTuO4rR2XrJm6zdudVG/5bsoL0b
 TdDGTLMXk8vSO0WZQdg==
X-Authority-Analysis: v=2.4 cv=IZwSymqa c=1 sm=1 tr=0 ts=6aa7604d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=I7BhAMs4-vxSTl9LnVYA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: MgtHXXZkmmwyPVW2VOjecUPik8GWQ6Sm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAzNSBTYWx0ZWRfX1FLq05OMcx1N
 2t0zjAeUye+xsqV7CUaW6J2s08eyaOlc47cOsQlAc85xwJm9sPPLJNj+dTkJ0efNeJ4YcU/MOzO
 mZO8B6GLE7E1B4U9fcqjosnk8C0KnaI=
X-Proofpoint-ORIG-GUID: MgtHXXZkmmwyPVW2VOjecUPik8GWQ6Sm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140035

To allow a vendor driver to assemble and handle its non-BT frames
from the interrupt endpoint.

Used by Qualcomm QCC2072 support.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 83d122de5d7d..5efcf31e432b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1067,16 +1067,17 @@ struct btusb_data {
 	unsigned int air_mode;
 	bool usb_alt6_packet_flow;
 	int isoc_altsetting;
 	int suspend_count;
 	const struct usb_device_id *match_id;
 
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_intr)(struct btusb_data *data, void *buffer, int count);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
 	int (*suspend)(struct hci_dev *hdev);
 	int (*resume)(struct hci_dev *hdev);
 	int (*disconnect)(struct hci_dev *hdev);
 
@@ -1577,17 +1578,17 @@ static void btusb_intr_complete(struct urb *urb)
 	       urb->actual_length);
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return;
 
 	if (urb->status == 0) {
 		hdev->stat.byte_rx += urb->actual_length;
 
-		if (btusb_recv_intr(data, urb->transfer_buffer,
+		if (data->recv_intr(data, urb->transfer_buffer,
 				    urb->actual_length) < 0) {
 			bt_dev_err(hdev, "corrupted event packet");
 			hdev->stat.err_rx++;
 		}
 	} else if (urb->status == -ENOENT) {
 		/* Avoid suspend failed when usb_kill_urb */
 		return;
 	}
@@ -2846,17 +2847,17 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	 * same way as the ones received from the interrupt endpoint.
 	 *
 	 * In H:4 mode there is no interrupt endpoint and every frame on the
 	 * bulk endpoint carries an H:4 header, including the ones sent by the
 	 * bootloader, so the regular decoding applies.
 	 */
 	if (data->proto == BTUSB_PROTO_LEGACY &&
 	    btintel_test_flag(hdev, INTEL_BOOTLOADER))
-		return btusb_recv_intr(data, buffer, count);
+		return data->recv_intr(data, buffer, count);
 
 	return btusb_recv_bulk(data, buffer, count);
 }
 
 static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct urb *urb;
 
@@ -4387,16 +4388,17 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->intr_anchor);
 	init_usb_anchor(&data->bulk_anchor);
 	init_usb_anchor(&data->isoc_anchor);
 	init_usb_anchor(&data->diag_anchor);
 	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
 	data->recv_event = hci_recv_frame;
+	data->recv_intr = btusb_recv_intr;
 	data->recv_bulk = btusb_recv_bulk;
 
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		/* Allocate extra space for Intel device */
 		priv_size += sizeof(struct btintel_data);
 
 		/* Override the rx handlers */
 		data->recv_event = btintel_recv_event;

-- 
2.34.1

