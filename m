Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE22495028
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050949; cv=none; b=XoKZ03mGy/LV/sh495xiAIEzDuFLlwUHOYnEvEXv4aMa8GnlVXAjjnJ78NREt8R/4FRj/6SBCy7hnhptLO5h1mj0D62hQMF7gCgL2xoOXErUiEfV+yuF2I3HwpXzCELXlaeZ174bmrp7T311+vQFxVVZ3/cA3IuuKc9K9Rr349M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050949; c=relaxed/simple;
	bh=EiCMZi7d5KkdXuY7/xcVOQAc9PXEO0YMgOdZbG2Zr+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WPf4cUCdDDF66oxKfMfpWSGWlzHiAhE7yH5OazB4GK6yhdOJ2eAD5UqHZdlcHMrEgE/qq9vqwYrVM2bWwyBRjs0BCsSJq+4n3ze1IUCfk6gBoSzhvZQib9oSwq5CRGq82zBJfH4c7XfvsHwf2nzOG2WCViu3O3Egs0BfknwufAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WL52885S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FqOkxOnP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WL52885S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FqOkxOnP"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7i7k780831
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3yjqGFveYAg5N/c7ZDihywXXnO37kbnrZ4JILQgcx24=; b=WL52885Sh8BG/xPl
	yNc7Z1DNFwVTx73rTmxs8nPU5yvc+I2mAl7wDqNQLo8SGXk2Se4N60nQ2HXEI+oo
	WEAWQx2LTSd+boBPnKN2VA6gEadPrx/kS2MBmLBWdC3h11rgTCwA1O25o+7TZM+Z
	muBxOlOKivqKiR/K/gUs8GGvv6J8635J53KQpzKrneD/CE1/mve+PMJF5ht+3F29
	BtoXNGIU/ny/KU9+T/MZ4rv0+b7oWHYNn7ykw8lZyqMUhAgp2vNkzjBgZgiRFK/A
	Vma4Synn4AQJWUwYGE3z2UhvgVLBW9ds1p2oFyZriqN7GMsaO+N9Kk/woe4oQBsL
	hYowlw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrak9rw0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 14:35:46 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4c2d7e8e286so17520b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789050945; x=1789655745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3yjqGFveYAg5N/c7ZDihywXXnO37kbnrZ4JILQgcx24=;
        b=FqOkxOnPItwv0E7K272w+OVNqDok4uEgM63F0uGxDbXV+buTQXFWCkAVKA2vgOrRfT
         GHfKIDaXIjb0j1KblZ7vGe8cawVLYnqsPo9WW3UuXMKOqCGVsm3u9TCE+wdyeriSMPkv
         vN8jQk43OTVOH6iXQ7O7EtDxhZ+h3FH9MSdEtM1wg9MZxTexE6ql5+kox0auK4RlEBwL
         2OpWAytTin0Q0QOMG8vWvQ33Bkfmr7FzSik8rgQBdFg61wZflCiYCmbQngqFmchi3dEV
         SIuLD5TyzgWlTiKWTTwGj3AnkiEdFyJdHsQ5QJ0mvxjBlSh40Z/gtZhasyOCzoPwQ/vL
         CaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050945; x=1789655745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3yjqGFveYAg5N/c7ZDihywXXnO37kbnrZ4JILQgcx24=;
        b=rOsRakSR9auz/r0qBAOCWgVFuNQOnG3lEe27nCSpTXvvGOeh/tZtVr/wbavvzaQ9vq
         vIBun+lql4fzRvPVI3eipIS+UtRzzM321m8zR6PMuhA38mzETlbvHLYNone9J68WDyv6
         ZrLYIJ7NDEN7bsQ7SGB/wI88DP0jXwU1dfPB0RQ8G9Eq+/3a1u+htEXvP1T5tQDLqiaH
         wITFveFZlEkC8LngGVE1qOOOUB7bHEC5PQOF5sKJBrym8bBmHnFc95bRNwp3AqfIbBji
         VmJ0ZhlyAYPx5qSOnYwwm5KC+7og8XkXZHg+vjMCWb75kzoMYRcsRgPo6m/MK/l5TEPz
         LBoA==
X-Forwarded-Encrypted: i=1; AKwUvByqsXCJKJm2iphhTQhxUUHsfEimSEZrB3aLyN7tFB08hfqwF5lPd2sHbHL89r0Yck69C5gqjYyY4gMPA2QehOg=@vger.kernel.org
X-Gm-Message-State: AFuF++lnlR1OZbfU8PKLV73qC8tzyi8LKkzrRyz0vDbA1pnra/INcog6
	Oz2nsBFMzjfRZKLtmiDfb9+hXlwbVn13r98YwfmqBfJlH0T4gDwbVsTr+IYhq09cnZCGNdvOeZ7
	ljpqJBokzXvIvpOvTvcMpkpW0sxldBEMmKQS8GxtE4ZezHTWTVv72glY1Xe9mBIV7Nhar/lO34F
	KYGL8=
X-Gm-Gg: AYBFou2Imss1+1zG8EsDgo7If8Rdx7l6A8Dx3iW1tkQLM5gzOBLbUM7wHlB6l9u3vbq
	uQYjgmLg5n+SuftZH1x+1TszHMfc+HsEMXUDelnS9Tb65dw5sQKyMYDnwt/V1hYnoXYaw6tAEcn
	ihcnNs3/QciYxf4gvxrvmPGt4osw90Eqda5kjHIPJF0pUp/ynhaizBEQm0jDmkdBXUtmNoI03Fh
	IpHRBAHGRMfE85vmwyWBHAgatgKRbw2/561m5v5v8xEiU8atI+X95fpW1S3qWKg4foR4VPfgp0w
	IaMSKlj6J8FOtkViEoAv0/6xC/JYzeAAaqg/TDUaA9a2ZlDWMLhdiUIAxL4AlebWXKYI3OXMFPM
	eaAV5zCbYDm9YdLhRZlQLiKMMdb6oclYjsd0uXHjJmAEJdO4=
X-Received: by 2002:a05:6809:38e:20b0:4bd:c8be:1e0a with SMTP id 5614622812f47-4bdc8be2b22mr7374882b6e.1.1789050945556;
        Thu, 10 Sep 2026 07:35:45 -0700 (PDT)
X-Received: by 2002:a05:6809:38e:20b0:4bd:c8be:1e0a with SMTP id 5614622812f47-4bdc8be2b22mr7374874b6e.1.1789050945067;
        Thu, 10 Sep 2026 07:35:45 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971246d9csm19056119b6e.7.2026.09.10.07.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:35:44 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 07:35:35 -0700
Subject: [PATCH v4 1/4] Bluetooth: btusb: Add recv_intr() hook to
 btusb_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-btusb_qcc2072-v4-1-e78f04b7675e@oss.qualcomm.com>
References: <20260910-btusb_qcc2072-v4-0-e78f04b7675e@oss.qualcomm.com>
In-Reply-To: <20260910-btusb_qcc2072-v4-0-e78f04b7675e@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE3NiBTYWx0ZWRfXwIUVn8KMpYap
 M4uf0eTuE0u226IDdRPOPYwirzdRU52msE8Kyj1XEe0nhLzLgVO0o2xz+yMvN6E2BtrvviC8v23
 PqHC9xDyU+sbkEqwuku1cGDtkKUPFrE=
X-Proofpoint-GUID: q7pkQTEF-9luFUv6h4io268VMzvz2opY
X-Proofpoint-ORIG-GUID: q7pkQTEF-9luFUv6h4io268VMzvz2opY
X-Authority-Analysis: v=2.4 cv=EspHPicA c=1 sm=1 tr=0 ts=6aa2c042 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=I7BhAMs4-vxSTl9LnVYA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE3NiBTYWx0ZWRfX014r71F0ee78
 42FgzdIqNVcmiMg9Cc0ouat3HCg0+ev/+usddfYj2FO2FoirkkJqPkiouRheqvAwEqpZiWK7TaW
 QknJfvS72jKwVw0fuO0G4sdw5qcybMhyBYsmIZ6pslj/kz4diI2TeW9GvBhRjB8ANuiTv35iQUD
 fvxiwh+F5HEaR2ibw6YLgK0KQZXda1Fu/GfHgiYArjYnXUUvaV/2vMzQ3m0v0bK9zEPcqPomSuH
 QzBiMNCT9Ud+su8vYm0Fy5yMTkY7kBi2EkTNYutJIT6sEj8hCNEIpBEb3Kg/aGcym3AcopEckze
 IU9G/qPD+qSvrirnRP6uG1dScMkx1ij43WVeIkMdbNSq6Os5fbTsRlosQPbrsgT2dVw70+LSFhi
 Z/vsyvlXIVgS0Z+Cq7LKvctVvvGyhf+BXIEofaGms4laxn6dhEMISEFxgzWPl89baBahwfCrsLi
 lEie2n8ZljUxX+O7bNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100176

To allow a vendor driver to assemble and handle its non-BT frames
from the interrupt endpoint.

Used by Qualcomm QCC2072 support.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a47b51ffdcd0..53010732d9ec 100644
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

