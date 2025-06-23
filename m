Received: from outbound.pv.icloud.com (p-west1-cluster2-host1-snip4-5.eps.apple.com [57.103.64.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3162E24BBF0
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681908; cv=none; b=fvZfWMPp3jNEOFrsv35N8n4TjWsrfh5yZyy+4STTrtxBHJv5MuYCVJLgQT/UhfbTUwZSXx/LJxB8mh9kS56WirttdzSlJJS2zqEhbZsCRnHAH2jhC852ePoeXvhmf41B4S3DV5GkNqqz4aK2bjbIQECeVQjHj+xzHWDZC60t0oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681908; c=relaxed/simple;
	bh=u27hfvZPNVdrOyO84MBRvJr2HBDqcDvzO+IV9vUv1XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nyWMAiYDi2MWBmhjP5U9m40Gvc6Qk/ZsrlEtZZe9L9rrUno1u9wC/pJ5FPgKcJ8GyHEFw9/32M3Hv34WXGSHYBV/82nxiObpbfVbpA9wnmJKZ6vgZV3++4bIQvqigHcENKLxsBu8sPfi7YodczFCjedXk1iSsbyYD7oOEFBgf9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=AxIixocP; arc=none smtp.client-ip=57.103.64.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="AxIixocP"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 877781800ED4;
	Mon, 23 Jun 2025 12:31:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=+kkJTNxFq4wgb7WDvA6T6uZaSbwuO6NcGFlwCeIcFT4=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=AxIixocPYrARiA45SthyyA+hinZmhlPhnffxqS0OeWP/CPCnmyFen7CiEnMvGXD88ApMPgLUE8CwRCHlMSMKb66aONYjpVhZ5X2rZXZjnSXuRTDSIt75/A2xpvnhJd5FaO9N2B3mxzwpwcWC745dt6Rf60v3btEZHw3487gmSFVDwn/uoUu7r7HnL5yQazeR1JUcYVpS93VWr0e9swBDjlOes5s6G6BQ1ijHJ6TqsKoRBeHBPcfrDrHZDuxcUmMhT0McEDmqC+SYqZYH1fZQhqhtNWcWbgofUqNPoISyllHVbvqs8OQHtQnjeekSdofPZlttCrX+Qhf1+aRhDE+wQw==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 8D8541803774;
	Mon, 23 Jun 2025 12:31:39 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 23 Jun 2025 20:31:19 +0800
Subject: [PATCH 4/4] Bluetooth: hci_event: Correct comment about
 HCI_EV_EXTENDED_INQUIRY_RESULT
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-bt_cleanup-v1-4-5d3d171e3822@oss.qualcomm.com>
References: <20250623-bt_cleanup-v1-0-5d3d171e3822@oss.qualcomm.com>
In-Reply-To: <20250623-bt_cleanup-v1-0-5d3d171e3822@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: QuZYD2IY1lnqgPnITdud7qNjCE9tSjJ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3NSBTYWx0ZWRfX+EJoweXz+YDT
 Nw2yR1SfV79NFDIfxFxehD2DPg/DhW5rLVnVF76+gM388cHLHMS5kS4tK8rPGQJAGAXMFLIUMHI
 QWhK5YclZWBuHJn0RiDaJlEzePkI48O3zH5vmqv7InDSB0AJL0LiEiv10nETbMenHYmEwR5COx2
 XiT7aAFvpQ455Loe28wn3DRM+0Cy8I77OHVbO0XHpLoVLVVvM1NJoliMMrO7fXGOPTLaN8XhupI
 DSISwmcuYWZdP4onabYMk0pFhSBWiKH5kGF1VCRuzPs+3Ak1wU0YdQwwi/rRGfFtqv1+BWtpU=
X-Proofpoint-GUID: QuZYD2IY1lnqgPnITdud7qNjCE9tSjJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2506230075

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

HCI_EV_EXTENDED_INQUIRY_RESULT's comment wrongly uses 0x2d as its event
code.

Use right 0x2f instead.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 66052d6aaa1d503cfcd542656d0ffbc5824e239f..c4b87bfb4c1a76cd865290ba2bbce7901a6c26ef 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7433,7 +7433,7 @@ static const struct hci_ev {
 	/* [0x2c = HCI_EV_SYNC_CONN_COMPLETE] */
 	HCI_EV(HCI_EV_SYNC_CONN_COMPLETE, hci_sync_conn_complete_evt,
 	       sizeof(struct hci_ev_sync_conn_complete)),
-	/* [0x2d = HCI_EV_EXTENDED_INQUIRY_RESULT] */
+	/* [0x2f = HCI_EV_EXTENDED_INQUIRY_RESULT] */
 	HCI_EV_VL(HCI_EV_EXTENDED_INQUIRY_RESULT,
 		  hci_extended_inquiry_result_evt,
 		  sizeof(struct hci_ev_ext_inquiry_result), HCI_MAX_EVENT_SIZE),

-- 
2.34.1

