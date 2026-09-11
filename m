Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A8E37E2FC
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113615; cv=none; b=upCexunDc9UQ4TxT8DFMJQ4meQ9G9UeS/lQbsiFMWeRmYCkAUvVyIKKfwA9RIHpbZZZg+ARWDdHWxBLw19YFULr4wKj3CBJosK5uRvDmIKu0OE+GYppVQlolACNggFHxA2AYU5R88qTXtFsVyNKE3JSY+1EJjWDN2C696uunzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113615; c=relaxed/simple;
	bh=FeX+5SSAOfbaQ58usKljVzvtDRwIa0YCMI07fyqDuvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uc4QJgP9LXz2FXCuVUNHcU+cV85XCjro8pYFhOKS7OcsjKrEo8t/SbMCug8gIqIvCcy0qJb0QZtmR0QuQYL3de9U+uksE1nTAuAK6SSlztzVJrwz4ofC0paDOxEmRJQG1XelmkrZR/Cvd/PZy3aVlz/G/hoL1A5faQpVODbJIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AqQ6ivH4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bVWYHXIV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AqQ6ivH4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bVWYHXIV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7kuu53513998
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 08:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I39ywH5jWkYs6V2okSMHwL6YcA82wKWv6kdA/H5Q9QQ=; b=AqQ6ivH44k+mMpQg
	thmXNXeQ/tO18Bz9GZ+d0c5SgWylE5GF2ZdEJQVQ802Q0BbujSezYT8OhthgEFsY
	xdPXusVYC4lAGttUVDIqWNTGjl9x3GQS/rEJUvzoIJQ+z0qPGZlbb6l3bpUVoygA
	8Iil3wNrMQiBjQMf0U/YTdxmxstFWoLeEDusxJXuDi3DJDRwP5c4PC7KeO6mp1yJ
	V7oV3xl5wL33gieB5XxR/i5duriP306aAm5Cz2lCzSiSKQMllOE9tQLAdoI1Gpvp
	jfeRUdicyLYaJ/z0ZIXf8m+K3oHwUwFgLhexaV2WFDTENFKMR4gAiT6ThoDs9DKK
	i2fIMQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd50kan-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 08:00:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-384d033f7f5so147332a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789113612; x=1789718412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I39ywH5jWkYs6V2okSMHwL6YcA82wKWv6kdA/H5Q9QQ=;
        b=bVWYHXIVvsVm8Q64C9uptfJE7Y0LXaffafCzDBwHglXgq0I1yb+BskCUS0qyZznz9q
         Vl19iCUq0KmwMsEoBo0HhYuivuDHvP+/ntN0KnMAdvJB1jxAg+Molos1XTU8X7UJQ8wr
         SpittGSnMSf70z9jH+6u6Ger312qQyBgrk+ewlcxmcgvv7Mflb7PzGSlyJiFcfqe+/s9
         vjnpofL52l96R2wrPC1xDO0zDhW2jzbDungcw3N+7VeaN9wY6sgnWa9upFGa0j0focuh
         iHPtm2akEihAU5/rBjOt9KVIqxP8747Hd8hvz3RlZKTI1Bkr/s4azgpcYD0Hs69ko+wB
         mDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789113612; x=1789718412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I39ywH5jWkYs6V2okSMHwL6YcA82wKWv6kdA/H5Q9QQ=;
        b=Ikb0ZqAjjWdk5eR+4wquTPQUrmidwjrd0MhCyGBUkiJ9/LCXCXkht37jdot1Ux6nrZ
         ZMqQ2nqk4FoO6lFntj/2pBKXpwNfBxD+CzIz3B1/iHakClvAp/yFgUf3pEk6qlrXvJaz
         1kbmSRQGXF7M82ThzwDgWzlaJFaBQjxPHHLbavb/wJE5ai3LSJMqbx5Vr50s8QXgAYK4
         wY8xcOTGRXvS+N24oNW8e+rn0k4TYlUp7l2qnBEbzzsfbj3rYZvYWulDzQqqdCRcDJ+6
         SnguT7TFa0anIwt5WlnWOE7Z1aRuHE0bjfVcrdwl+QZEpcMC7mfdvdJzDoa8w2icVxo9
         CdpA==
X-Forwarded-Encrypted: i=1; AKwUvBy/zgFIKJrJQndUUANwoTfKsJM+9QZXf2Rf0jdyduQ+5Uo/S+4nSLX4eQuKEvsWJHd0wUjg/rDKRmfGJQacjkc=@vger.kernel.org
X-Gm-Message-State: AFuF++lNibKxMr7pvJcvCoOxkvHbcGVvDH+VTuVOXxzKCTMkom/GFBDH
	qIL54NfQyJt9JLaNgPGe1IBjQUQctA9uM0BjxxpHFmvvFG3IMJbnL0T/Zx5nmg9G56ChsYSmL2r
	tecH4w2Cfa4t563XjjYVMnW3M9XWmmZkxXcFrtxUuVfvdDCi11CApy3pZyKB9mL48YjWGHlE=
X-Gm-Gg: AYBFou1luqGgf83dNk4Yke2J79oyvhF1GDOvHbRpZb+vcY1a56a/NY2o2y4iTvxkCLy
	aP5Y8P36KjNuyGNqYeYbM/UmNpkMYq11H1+YbEhOiW6afifcX/oBFid4udCG549SbTys14ud2DC
	B3h/f+alffC9q7FdFXHBV+1Q46b9hnvscZm2KMYWaq5Byvxc+gOIea6BrEvPXMfYRZKK2xSt1cq
	ZN1Z2h1M4TrGtALQ5DtrLv0uNOrq1VKVjmp5PMz1Q9plW+dNJvzIQlofUeojFsDepVqm2kU+CJ9
	lultVvzNBlScyJpqJR50/KnAySMhUfVoeFYECnOw4tGSVgN+hEXonjGwLSBEdks4iOcx6mW5uRF
	sIorVJMPh2O4mZVYiOFhZKsk/9LjpZSze9EUTlt/s0m2UN2A=
X-Received: by 2002:a17:90b:52c6:b0:38e:6d4c:14df with SMTP id 98e67ed59e1d1-39d9bbf2f0emr3518877a91.1.1789113612189;
        Fri, 11 Sep 2026 01:00:12 -0700 (PDT)
X-Received: by 2002:a17:90b:52c6:b0:38e:6d4c:14df with SMTP id 98e67ed59e1d1-39d9bbf2f0emr3518823a91.1.1789113611521;
        Fri, 11 Sep 2026 01:00:11 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf31c1sm4422328eec.1.2026.09.11.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 01:00:10 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 01:00:01 -0700
Subject: [PATCH v5 1/4] Bluetooth: btusb: Add recv_intr() hook to
 btusb_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-btusb_qcc2072-v5-1-422754f4e938@oss.qualcomm.com>
References: <20260911-btusb_qcc2072-v5-0-422754f4e938@oss.qualcomm.com>
In-Reply-To: <20260911-btusb_qcc2072-v5-0-422754f4e938@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: Mwnr9Hwc2bu-3KuZWoXjGzMOUb3iItQ_
X-Proofpoint-ORIG-GUID: Mwnr9Hwc2bu-3KuZWoXjGzMOUb3iItQ_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDExMCBTYWx0ZWRfX/zFWznNRj2Lu
 szPVoBp/Kcr6aY+f1cOHFJeAqM4kSdWRdNgza4jByM09ZOdT7P6lQ690gwO8AhIhRPcE4YCkjyn
 MSYDtmGzJ2X6KKg76Q7GUalUrUgYwwM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDExMCBTYWx0ZWRfX74COzpayUMDO
 B9k46+KOk8rCghsAx7aCp2HILBKuS8HPEQdQdAnGEMahZ0Ln3LrqStx0je1uvphL3KU6GW1/WZS
 4SIp7cTCOOurkWORl0JHRTgpVX3clca2yHnzORXxl+kvMuQ1NEMWJJ2ETb0wHnwA94xNYoqYCI/
 nnZAm+AJwdeasqh5oAS+gDz53fFRFKMHkxVwYhhdOTgOI3uCUnTdcFqphl14uUO7bvs/tTxoZS2
 +USWRsuvB/2rCx/ntYtL8ViiD3tx+8t4iHBw6pPvcn1LSUfnqV8MLrNfyNGSZjdYGmrfxHMUMOW
 RVn7ADkcvjgE8JJJ5YZBb3v5K8iD/ZZsdtYUhf6ex3tT7jOiohlTYsN5KhsiGkwOJC6uGuluMaJ
 pqNv40E2CW+qG0KVTdTqXtJLMS9b9phTema1NYyVfiRpk1Ig4bP+dJtd22m84ntLzpK4IH8tBc7
 Y6xY25C6I/ajmLjjc7w==
X-Authority-Analysis: v=2.4 cv=db0VTnXe c=1 sm=1 tr=0 ts=6aa3b50d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=I7BhAMs4-vxSTl9LnVYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110110

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

