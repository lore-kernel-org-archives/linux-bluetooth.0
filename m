Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951733AFD0B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577711; cv=none; b=kmIIiQjOtkBbe4z4GBpakrTLTBee54tlz3mkPy+p6Myi4mfgsKVHqReBexZLddqPy72QUiZbA/JCPH8T5xIa5noRIF5ZoaSIB9oohYMPwnMft6x+jiongvIhZXUHNKGUAuggWcqTr+TyIQGLlXVq54NjWDnkaVImH3Uw4PimU/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577711; c=relaxed/simple;
	bh=w3BIzNIeL+lPk2Jhk1KKLSKIsbTnVcn7c7u1hjAExdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ShZ+m2UJ9z86JMo2B47vEQKnnchkH32iMi0dDHHdR1Xr/ZEAO3t2aEl13O7tklBKbtzSAD6//LC2bJptdeEgm6w36++CT37ej6ej+G56ZoMravRw3cTe3hGtLSu+uPIHRTgHOdjWv+10Gct8ticy1GI5q1nmyFnJEUOwHHsoNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QXfoiwyG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JwWHUQc4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QXfoiwyG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JwWHUQc4"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960NYp916740
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 06:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0vpI239nFtr7dZMaZ6MhEyKctj32QaRl9liWLRj9N/M=; b=QXfoiwyGgK8PIgkx
	kbhmaHgS9kYbPElfd7CLnajP5DG6cwHHoAXoqP/W5n65DJX2k7lgjfdmKCVKi+Is
	duOSeFjOf5CU2Irjcioip285W+clLRunax1GWepTtbVoGq7O4eJngz1ekyc/0rjs
	PAgpUaLKCS0/YMd0eTbbvuGdFmue5tM8XPKNOOuuuw9m5LNhsEKKERkISok/0+l4
	jBHCc2t4kEvAkntXwUlny1i3vp6A1yHPnyQdKizMaJbBxxh2L6HxDTZypRq/pGXZ
	7xhFadSHQatA+sGjt7sdqFK4rx6bM5kWDK/o82Cj/v8l5hX5wKCeTJb2mA3LtqIb
	YpNr+g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv565w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 06:15:04 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca8aee882c4so36396a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 23:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783577704; x=1784182504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0vpI239nFtr7dZMaZ6MhEyKctj32QaRl9liWLRj9N/M=;
        b=JwWHUQc4GcsMmyhmM7IeNv908kenc4wY4tDHHHbKsjyDLg/gkC6uTEO4rcQmfyGgnm
         YAratNv5N+PaoTEx4DH+7TK6m7CfmB09vMh+0zpzB07R7CkDENHGkFsH8XOrgcmurv+X
         eAXuIPpCDKQMLEWAgaMQfyKY/YCqwzC4YuXvBrYb+y3XxSCT4Bw2zPFJL2C5mnnVblVC
         XsNk08oV23u+jNRy1Q1FCAZeC7MHJBhDGUNzlvDyX08iXjlK3xvoiigTh+gtB1wJAqg+
         4yEdmuE1FNNCcyGIfS0M22R0O4hTsblEWaSQ/MCfMHn0szlod2T01WpIiPd7BtZlITnj
         W8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577704; x=1784182504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0vpI239nFtr7dZMaZ6MhEyKctj32QaRl9liWLRj9N/M=;
        b=UgnFD6KNnjK3rq3FqV9HxCh5hYwnOJWB0nC5+xTMOQl2iyFn04YH/xQntH+jUmI69c
         DVD2VlhKjM0e711WFNSJLWw9Jklfr4yA1SOTSoOusGs8XMFEQIJGpSEmDt8YXnE7OVCx
         jOsgSPyFQ4kKJb7D9nJ9whOZp5ZocHrp4/OblI39PIfLL6zuSDzJHN70WDUBkNLlSYM9
         Sk4bKTfMOs9Wl7+6Sqm32pYV94L6ytOIS1mGKrp0Fooe3mDyiov9UssQyAHVNqyx4jAM
         lmNES0xPMcNOn2h535L7oXmc+48g+f+R8mXL6bpF7MzJ5v18LX1/gwnK8QHbTpcGu+/V
         BaYA==
X-Forwarded-Encrypted: i=1; AHgh+RrzMbnu7h+hyriDKRBgA+3/1zmBojSzVHcDThELGQyLLDo0ZvpJemuXAMJFLWVfMHjXZnNLUT/hVfAZSU95ZSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNZK8E12JBXuhpKUhnCbSf8sa6u0CuKFOxYwy61lfVvnkoxpj
	Ry2szZrO9umHY8w6MhHBZidWABvWQ9cX7IDANmiYTR0zXW4pXcnZ6TCKzUoZlaagMv+Yo+ogVhC
	RZtN1XomESINQzwnYKDpuZnyTC8wE0tBRdYB9aO9n4smwqgt2RIeffIEp+DQNEZ4L4WxPFi0=
X-Gm-Gg: AfdE7ckWThtA7XeBVDlzZYcJOpxZu4lSz0WBiQel8nHO/NKCJoDkTH+Oy0IzKZKqfpc
	V9/CmDzdbUEXOE2veRuzzaqDQkLs4nKsMAh1cPSgSw4erPx2HRP/BtLiObaYcJhpSZfdlnQfcgt
	pk1uu3yXh7Isf0h+31Z0PEE9ffluaDtzRO6bP9RaAcSYAk8ku3ytYbqmB66p3BSof9M3cjhwg0d
	W+tplBY08WF7dmb6718Ii9rRLO7fJluppeWiYxTqA/+/7SrC17hJbGh5t+dKDR8JFQQMR+tnz2J
	eJ3WiJvE8S4QxM7vPHl29w6vbeq15yKUH4AqvB4o16Zd75PcITJLhGdZw/5tgzEGQgWhHoy+JwN
	AeKJm73sMExhsqMV7x1Bndu+pg8hE3bB8f3QEV/Z8an762Ho7mFWTr39KvA==
X-Received: by 2002:a05:6a00:1804:b0:845:3ffb:ac1d with SMTP id d2e1a72fcca58-84842ee0509mr4607200b3a.2.1783577703911;
        Wed, 08 Jul 2026 23:15:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:1804:b0:845:3ffb:ac1d with SMTP id d2e1a72fcca58-84842ee0509mr4607177b3a.2.1783577703491;
        Wed, 08 Jul 2026 23:15:03 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm8146032b3a.57.2026.07.08.23.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:15:02 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 23:15:00 -0700
Subject: [PATCH 3/6] Bluetooth: btusb: Add an indirect recv_intr() hook to
 btusb_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-btusb_prep_qcc2072-v1-3-d835b187fd01@oss.qualcomm.com>
References: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
In-Reply-To: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4f3c68 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=j0w3eOB3VtzsIZiBwfcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfX3YaBz9OrZneS
 Y8vIs7SjHlQY35ADcF52as11ITDz20SvQv+wkWxVmE1tIZdaZC5VIhnaL5FILhP4EDutmU6slcv
 IPgWZVP6QtVULMb7Y3uVZRUNTE08cjw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfX/tU5k7C5wAIH
 NEhbDb7s6Eh4z3K54RoQgcQ8PzTlQV+ZiGjIshsWlGQ4pq2mW+b1fhxXkOn/I3DchhkEVxy3w7v
 EQIHBqeZRBFCvnWVDuaAnouhjZIl6lCqLC38R9CD9e5C3azWt9FrlUkKrKl7izCwTX/dhxvyjXw
 e+c+eKzwmUc9KHW5ST5Qc8KkzbO7htZWFNipjFBqN01X2mxl0hswUK8wGyUo9Nm7yVkUpujX0Nc
 ZvhGgrhgz9jENpWWbVAQrmD7JOjkCt2zchHl3IwnjLvOj2j//16TM66Yri+RNbhE+SLLEaYkIaV
 Gx+cgXF8vF6Xk/rcyfVp7fuLFan53ZCpcyhQYbpPcTShFaMGDDKW8o35eXiZUzMn1gonIspqgII
 9eonOJbBGR/nsiWCECkpv1NTBnh4dLqXM1axujkgNxTcPV/pGWM34+ieltL5ID2uX3jf69MWl7s
 5U4RHezkn6Hfp9+9w8Q==
X-Proofpoint-ORIG-GUID: 3NPof8DggqPup3_izBXoPSRROBqowrNV
X-Proofpoint-GUID: 3NPof8DggqPup3_izBXoPSRROBqowrNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090055

Allow a vendor driver to assemble and handle its non-BT frames from the
interrupt endpoint.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9726a007d25a..e5642d966153 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1030,6 +1030,7 @@ struct btusb_data {
 
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_intr)(struct btusb_data *data, void *buffer, int count);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 
 	int (*setup_on_usb)(struct hci_dev *hdev);
@@ -1502,7 +1503,7 @@ static void btusb_intr_complete(struct urb *urb)
 	if (urb->status == 0) {
 		hdev->stat.byte_rx += urb->actual_length;
 
-		if (btusb_recv_intr(data, urb->transfer_buffer,
+		if (data->recv_intr(data, urb->transfer_buffer,
 				    urb->actual_length) < 0) {
 			bt_dev_err(hdev, "corrupted event packet");
 			hdev->stat.err_rx++;
@@ -2709,7 +2710,7 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	 * same way as the ones received from the interrupt endpoint.
 	 */
 	if (btintel_test_flag(hdev, INTEL_BOOTLOADER))
-		return btusb_recv_intr(data, buffer, count);
+		return data->recv_intr(data, buffer, count);
 
 	return btusb_recv_bulk(data, buffer, count);
 }
@@ -4172,6 +4173,7 @@ static int btusb_probe(struct usb_interface *intf,
 	spin_lock_init(&data->rxlock);
 
 	data->recv_event = hci_recv_frame;
+	data->recv_intr = btusb_recv_intr;
 	data->recv_bulk = btusb_recv_bulk;
 
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {

-- 
2.34.1

