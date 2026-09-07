Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA00442B10
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770759; cv=none; b=P89gK4gMvxOqG/gVVbzbP7MWLDVpA34hCTl5fy77OZdzjuA+OMkOAmkrE04w4ffdTc57Mk1st9GPLDjIFHjOYd3u1mrubFXugGnfZuwJ3thLwIUBVUF+rP1J7KoqEe6Q3pOgxJNxSD77evx2gGsDjuRYKKdRADZDCjK8kHp24YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770759; c=relaxed/simple;
	bh=IJohJZrbFopFvD7sBZflYi9Ha6O9iaOVUlcxWkrDY3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cz/XyOMpR+vHvyzHDSLuvkfqakolm7i+4p7WQH5utzt62T+7xw6AmRPPIiniiMW/NX+JXDZv95rwetdShywlioXv0993r7Rzp/O4cP/tdK+56gU+UPQOgM0uweM49MX6Q3IQx98dN+fmBSrNrPx8uCrGS/5k1J04qPFp7fWGLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UY7vjuuJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=caKLk2+U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UY7vjuuJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="caKLk2+U"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777C7A2838491
	for <linux-bluetooth@vger.kernel.org>; Mon, 7 Sep 2026 08:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VpvA1E1OPOXh8tlIuqcAnKYz4rMdYVWJjjeIFHKWD8s=; b=UY7vjuuJkwioeXLo
	jITbtUz2DEkeEPo3dBjm96Da8GuFUxe5+mj6LRN7+RnDt4ARnupUZkjNnfPthxO3
	nZfiPh+c6TZxtH9xojfr6hk5YSeEAN3izNrZhYiWJRLsnIOx8jt7vTMIWg9YZpvJ
	Q7UEXQtS8we2b1FZ7qoIPbb05wVy50jU9odSFJERRb156iktVnih4T2DRMV0Vn9e
	gO7n5ZbRMvm/lD1zPY4p4Bdtnlt3BVLzVJrkZNwIKwYG5fybdW6Sq3ypna7cY7EV
	8PpBnDdWQrVSo9xnXRejz59JBhXm3/m/axmtWmj4EqjRoMm04QxnAlyw/Zdw58OI
	lM/52Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuep1pe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 08:45:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc0eee75dso1048232a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788770756; x=1789375556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpvA1E1OPOXh8tlIuqcAnKYz4rMdYVWJjjeIFHKWD8s=;
        b=caKLk2+Uym0Tivzo5P087Crwkg3Ak5XRD+POzABSiE2GwmRGDac4sI172qTPlWUxiv
         +3NIhEh2aWKKpT+yxaGgpM0O8Iu5iFU9rWsFMGQy/dNKd4vaym96qryhXXAQpwkdrEEb
         sq6TCy4mNkR8XI7QiHhXz99X790uJjs5wJGTxcHPjQqoYNmdFwxYbvhU4mZMljGBsQ6N
         412F50CUVgEjYjJIuwpRyl6zSXT5OtUqc3mGHDld8WinkGF7LJflWMKu/3C1VDl9dLWw
         yS1IHdVvDgF/tqfHfUB2qXpGmw2cPMQiN79AJEwE7653kFkUob0eFQhCIMqJ3oqFrGv9
         V7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788770756; x=1789375556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VpvA1E1OPOXh8tlIuqcAnKYz4rMdYVWJjjeIFHKWD8s=;
        b=nC5oIj2YJ8gahUiI+MlE45LPc/LJ9cNsKNxXv5YJJHAqAB0MG54Dtia9xD98sRjF6i
         /TKyzk3eA8JXoW/ioyUlSzKaD00KqsFdaWwCrbw5MuJKhp3/Lc6TcYb0BvTPxxnc5OVc
         VwiSGsvJxC6Wmnlq+XbRoSZXYO2Krk8m9s0Lpt/iIvHQ3awWI+6C14Qn0mLcqJLUfhDP
         P1T3iniwROIhTVOOr3uqqIOnX3WRqLv840u008UO3stIYEvnWFWN/NnFVS3vLj9JVIbF
         dCScRSOrg4p8ZE25VKsmiAh1CedT3MXCloI4WOj1rDThOa2DmmmI0wa0WRer/Zzld+Ru
         EjFQ==
X-Forwarded-Encrypted: i=1; AKwUvBy6/BYzSeVeid3veRLcsJXNFksD5ekZiiIz2nhSjg9hGT2CuuqcXm3nVO+1J5PdG9NKQ0yl/eBVfo9PwDemPjs=@vger.kernel.org
X-Gm-Message-State: AFuF++lJ/NnE7HWGDLm614o40PiT1McS7PuyTRS0pbo4lPi9uqBAiFuV
	hpfOSSPRJe9iPlxDyjihr0pQ/s4W+Q0FRGW97R+EPGsUtDCh098+ANvAu0CBX8/DhUI66hjNTWO
	KOMxadynbuNCNea2Uvsv7dLTjx/gaO/eGUOtknCyY+xw9yuh2I+PL3iYLZAiYk3tjY8FWc5Uxiq
	fJnjI=
X-Gm-Gg: AYBFou365JhHdzPNPvxd+IacrK8t960P/VtLs/dfL+AfxC7dMj/Ij24o7omCxnFM/jv
	9v6WAaxJgejZ4fbT8jrM3yvGvdwqiE7plEUVBwLQZOHIeWdoea24RcdXW2w8T7Kss/t/PDDXxLt
	YdpSkzawYevg+8QSmOv+exZh74TVwqkFzWiqwusiqC4F4SXdE4Lket3fRhKNHwfLHnLd/mrESAR
	n9a5QoqNwEf08tREnnIqaZ9qWoj+XmLPYOooitzXu033Rx0JE6yOOfiJ6EVxm0R27y0s04TY+mH
	g5floOZdd/vFjLNWvcLy65PLHM2mJcDGZbQQiBy6ai1jp1povDGDMwj8QolqK0tayYJKmNS6i9y
	KBb0x5DRXUnq9OfLDgB3Zy6xRyF1Nudz/oxPWJ5nxM7NPkDw=
X-Received: by 2002:a17:90b:4a0d:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-39b3d7fe6a4mr12704844a91.3.1788770755994;
        Mon, 07 Sep 2026 01:45:55 -0700 (PDT)
X-Received: by 2002:a17:90b:4a0d:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-39b3d7fe6a4mr12704799a91.3.1788770755432;
        Mon, 07 Sep 2026 01:45:55 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm23622117c88.13.2026.09.07.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:45:55 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 01:45:38 -0700
Subject: [PATCH v3 1/4] Bluetooth: btusb: Add recv_intr() hook to
 btusb_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-btusb_qcc2072-v3-1-1f65350b03b8@oss.qualcomm.com>
References: <20260907-btusb_qcc2072-v3-0-1f65350b03b8@oss.qualcomm.com>
In-Reply-To: <20260907-btusb_qcc2072-v3-0-1f65350b03b8@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfXzS/rCQEoOD0g
 ntL9XxtvTGwD5h9RD1fa+legPaNw3/PDDuEjcTro8CcjKWq8aWM/aPkyvlrpJkRO7JAJpL/wS4O
 Z2Za8bWAagkwL3arEauWyOELac4iaL5foZepINudPzzQoy/eZoLjzO24f3A/pKEJWdDjK//FwG7
 1WUqVb27JPr8cm+dK3Ieg/RQDKhFVBliOQotBztnhnxLBqCH5VjNbknNfAEI4VLeQ0ZJv8osI1n
 CbkY9alqjBouP3YqmyS2XdJAfSy523ZNSRmgdRDigLCfo+nijTy1/jMbPV/+K087pS8VoVPSUBM
 ArnHLbF0Q2s+avyZ3Q5AT/262gWeOftqxv2J633fyZGFzb74d2721QutBmG1mzO9trhxRuC6npX
 nNQ5U68XOU1fg6nMPagUkHujGEmOKG+D+TL+Yt4A3UoBsXtoV+CVu3Kpp3Rbalwi4V58QOQoVpl
 pfr1B3h/rcLyNiP+JoA==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9e79c4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=I7BhAMs4-vxSTl9LnVYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 1qFtm-SnYqySMSj3z3yWYx-A9g4I9vZr
X-Proofpoint-ORIG-GUID: 1qFtm-SnYqySMSj3z3yWYx-A9g4I9vZr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX+zPBMEI3NfDp
 oKkkpwV+nXyT6e4Dj3kCwiVnoT0JQjJOvUp+yrC3iQSwMEsI3BXCyUq1FwHsXG6Ghhs4Tjj/irI
 NYT9EF4n73yKcPTfzj/8ZN5VA76negM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070094

To allow a vendor driver to assemble and handle its non-BT frames
from the interrupt endpoint.

Used by Qualcomm QCC2072 support.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 61c18402911a..39496336adf2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1046,16 +1046,17 @@ struct btusb_data {
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
 
@@ -1556,17 +1557,17 @@ static void btusb_intr_complete(struct urb *urb)
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
@@ -2825,17 +2826,17 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
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
 
@@ -4366,16 +4367,17 @@ static int btusb_probe(struct usb_interface *intf,
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

