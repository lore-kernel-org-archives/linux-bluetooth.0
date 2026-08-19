Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA01F91F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144070; cv=none; b=B0k2GXCoVpLy0i59/Lk7Az4Yu/rsDdko/RXajKamDanwoRF57stbgt0gVURMURASiidhWmDHiUcDva+aQkZeC/1fK8Riqdx4kW0gg36d6PkUo7Jnf8dc2fs3cv1QggHHVW6jTlQ6RNDpV8ahnJlafOKrZ47RdmualhmRW0ZX5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144070; c=relaxed/simple;
	bh=CWUqQ1a2gb6hbuuM64I2hY7ukGRJCQGKjendK5/JXiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LX5oHqH6c8JqiMXveeFm2VrUz9O3iFHIMB9c6oIDegR/MEqg9FZcacjS6ggho4DDBweJped8NkDT3Y9f4pyIFDMrA4DtKyrANub5SSuqaC/RkdoSL1IXZEqihQO4nc+U7yPTlZVLV58qAoAMFOftVMUZgA0FVfrG7a/fs7l0e2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UVLOceN0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gP19kFzH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UVLOceN0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gP19kFzH"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JClxm64084641
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mKPsanuWE/uy+9lSL1WjIdqDrY0ukplYS9d
	DeqmBTqQ=; b=UVLOceN0OV++JnYVKDSz3WnxtNipTZcJ8yrGqkWuFw1QW4P6USA
	ech/btVdeDvakvxuErvqfCtx7JjgML4ONNivEvJL+L5ZQZ5P9p+RO744rgpFtA9m
	LAmyaVXCR8Prj7x5WzHaQrQ0z2sq8MEO5txlN/oxJtz9zOakpjgapcLqYYxxvcnM
	KZUQSps1zNyfWZN9ckk0W1kEnIEI1UJ9UuUdYklbg4kvlbOyVgId9yZWbRFeYBBp
	chj4GnVnN04hjAb+umwjGRiYmpoGLhp17/Us5m4WVtXzeQY/ZWIu9fPrz1/vSCYk
	TuLeEsFoCCkaKyCSha6iwBtuW2ve4738ksg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmb8p0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:54:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930b6bdcb4fso142098285a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 05:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787144067; x=1787748867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mKPsanuWE/uy+9lSL1WjIdqDrY0ukplYS9dDeqmBTqQ=;
        b=gP19kFzHlAeYqpZxoMO3/+QVUMDr5ZwzhMK2bWLovudsSrTs7pom2rkx3lA3sH33B+
         5vndnXLtrCl+7aWzQKSrqjytqfITPbP6d4HLedhzqLranVFEUqmU4qanauuuVac4NIPL
         DY0kaJg59qNQzEWpMqnMiqMHYE7P6tiujNJvDxOng7gZqTuZcDtpdXdlG/iDpXCdlDrw
         qxA9avAgC0SYCj8a+XHG9ERYDTAHpNlFXuQBsDfc/H+4670P29gcvd9CpX325TRGXwCu
         DflnDNf7riWNaNiVWlNmH+7/47v0R494Lw/XYBKyUrfSTHY4jCEql3IQg2zCv4nZoqL5
         QoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144067; x=1787748867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKPsanuWE/uy+9lSL1WjIdqDrY0ukplYS9dDeqmBTqQ=;
        b=DURUsVxLY2GRoE6bhaScDKPWKaNSslQ8vLBGV2DKizTNOPy5d8+HR/PeIVIjHoSu1t
         y2J8wIDVsg/LlO2ZfUBn5dMWGSIMh+eS86ge1tEBqquTkKIKCMJhSvFozkBZEMj0bjnz
         5u0IxP3fMJ5Gg1vQDxaIO+L7mXy2xA30UVFgez+2kPvWX5JPMJRmSbbV3HjtNKsjMX5n
         Hxr5ou1ANHZsz/zFAU1TtlGexeOTb/W9nT+NYbLlopKz+FeGrTeUeitcaW/8dvW+wi9m
         /BSxDyWYA5lXd6v3GVvC/B2s+ZMpdensAaOS90+qcEu5TcsGm9tSd9TNldaFPzrv8Ezi
         3+zg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7LCOT2ll24zfAQ82cmjD5EwEH+cxIUjfvnC3gdeFov/y33jUBGuHlUaC3cjsfdb3jz027QKWwiz+G6CgIaiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXov+wniO2Hma0GHYael8jYhwedms2T2QXi2as5fEeWrN9yukr
	CR6hfSr1EPbNMu6Q5l1xWtKb5+7THrrSDC6wWO3o/hWSqIr56juYS47bYu3r45fu7zMH8OcY7z9
	ZjG8eJL2rvWo+NxjZK5Q61scGT/F7C8BOPym3027bFeq9KexsHVuUbt03dQMFQzWRW0nvmvvsq2
	rnrF8=
X-Gm-Gg: AR+sD13RbMvT2Fc/mf0lLRfAfq/JimWNakfvYOooT+d3P+l6kF2Y1v+/KWbw4+Lwlc9
	z0viPEAPk5Phy+rrDYVIAYCMqQ9vXM0QIka2mAe+VyCZkufWTEHVJdjDGilw8BHSAAcSPI1yHXY
	+EbkV3FjBWRkLvb1XfEju5SgCWOvbX5ykI4Ny/DIXzM1sQuiVAlDIW2K4aL4eITbRZ8+C+bgli4
	w8XnpplYb3Yjk9vg3aHf29MbqH44L/Q8x12mynIUbrP176fYc7Orivu/818wX7PDFOFCiWV3EsC
	BDDGAS/+Eb8SvBSN0FYCyBaNMmFk8H2VcEHMzczZs2G5C0//5FZOk12nHgMdDv+7LO6ZUDjXzaY
	8KhIey5A27AKPHLKzP4fn2c/GOXUGy2iQxf33UIDlsosNRN5xvf5/Ar8Dgf37Z8ceEGZioggfMW
	vAJID4sXGOmW06Gyg=
X-Received: by 2002:a05:620a:46a0:b0:930:db8a:c608 with SMTP id af79cd13be357-9371e1f65e0mr387098585a.7.1787144067214;
        Wed, 19 Aug 2026 05:54:27 -0700 (PDT)
X-Received: by 2002:a05:620a:46a0:b0:930:db8a:c608 with SMTP id af79cd13be357-9371e1f65e0mr387093485a.7.1787144066723;
        Wed, 19 Aug 2026 05:54:26 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff156811sm748577a12.19.2026.08.19.05.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 05:54:25 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_qca: Do not write to the serial port after it is closed
Date: Wed, 19 Aug 2026 14:54:25 +0200
Message-ID: <20260819125425.192316-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX5XVv1BAtr/Xh
 QeimdROICCGRD+/gmCkyMMTmyBTZEmV/9M9viFZPyXWW2GToto/XRaeI74l7DeFKqN7OBz+uqTC
 zScOf0aD0j/bY3bg8pS/daM2moB95VEBYcMzA5E2tN5ptWvBg9EcXvuNFtXb3Rnm3G8cWmp+7FH
 hj7z0aiBWPGXK3J8WMKszYmSADmk33FOEx9+LnRKkxWWzDgkYlt6CXbSoFjCwJjhbNB5DZmM14U
 ozuUGlKceWEi/FfqtUBRScqm2LTessOY5ZPbDVaNOLEraw0lzR72l7CkZYUGIRSZgONaNY5JsyT
 xh9NvVG+vMdUuvO0QY35i6voBpsuWrNvmPpMPdxTbt2qgg8smh/LhWTUVwBrrABM/75ZZNNXDnj
 BKbmadbFA8jVVm+E3d6yr7dQ1ADZL68d/hgR34hpN6xA6c6iGfcQMQzQ/JZatq0dMD7q230NAJc
 P8jCTtyY7g6/zJmPi1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwMCBTYWx0ZWRfX3GDc+qjD15Dt
 LzC1X72robLck1WkaJCQ6rHsYrlmWDH4GDgkfTnaX0fEQTLG6Nh0g+xFRQYaLqHTbbHpRiIyaBW
 sMeY91t+tFYL3bu8Nt3vIYeFfFCsMAk=
X-Proofpoint-GUID: dabAwsEfbaxpk3xpMGFY0uJNJmAFC76v
X-Proofpoint-ORIG-GUID: dabAwsEfbaxpk3xpMGFY0uJNJmAFC76v
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=6a85a784 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=dlFzzRy74kIF9YYi:21 a=xqWC_Br6kY4A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=J0bGeDfF202-RPBtlhQA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190100

From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>

hci_uart_close() closes the serdev port if HCI_QUIRK_NON_PERSISTENT_SETUP
is set (for example, for the WCN399x family). A failed hci_dev_open_sync()
following a successful qca_setup() calls hdev->close() but not
hdev->shutdown(), so the port is closed while power->vregs_on is left true.
qca_serdev_remove() then passes its power->vregs_on test and calls
qca_power_off(), which writes to the closed port unconditionally.

Seen on a WCN3988 by unbinding the driver after a controller failure. The
trace below is from a 7.0.0 based kernel, where qca_power_off() was still
named qca_power_shutdown():

  Unable to handle kernel NULL pointer dereference at virtual address
  0000000000000038
  Call trace:
   tty_set_termios+0x50/0x238 (P)
   ttyport_set_baudrate+0x84/0xc0
   serdev_device_set_baudrate+0x24/0x40
   qca_power_shutdown+0x158/0x1fc [hci_uart]
   qca_serdev_remove+0x54/0x68 [hci_uart]
   serdev_drv_remove+0x1c/0x2c
   device_remove+0x4c/0x80
   device_release_driver_internal+0x1cc/0x224
   device_driver_detach+0x18/0x24
   unbind_store+0xb4/0xc0

Check HCI_UART_PROTO_READY, which hci_uart_close() clears in the same place
it closes the port, before writing to it. The regulator disable is left
unconditional so the controller is still powered down.

The dangling serport->tty that turns this into a use-after-free is
addressed in a separate patch.

Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990")
Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c4575036483a..0cee54949221 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2229,8 +2229,8 @@ static void qca_power_off(struct hci_uart *hu)
 	bool sw_ctrl_state;
 	struct qca_power *power;
 
-	/* From this point we go into power off state. But serial port is
-	 * still open, stop queueing the IBS data and flush all the buffered
+	/* From this point we go into power off state. But serial port may
+	 * still be open, stop queueing the IBS data and flush all the buffered
 	 * data in skb's.
 	 */
 	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
@@ -2252,8 +2252,14 @@ static void qca_power_off(struct hci_uart *hu)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-		host_set_baudrate(hu, 2400);
-		qca_send_power_pulse(hu, false);
+		/* Both of these write to the serial port which may have
+		 * already been closed by hci_uart_close(), which closes
+		 * the port if HCI_QUIRK_NON_PERSISTENT_SETUP is set.
+		 */
+		if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+			host_set_baudrate(hu, 2400);
+			qca_send_power_pulse(hu, false);
+		}
 		break;
 	default:
 		break;
-- 
2.55.0

