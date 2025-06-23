Received: from outbound.pv.icloud.com (p-west1-cluster2-host8-snip4-5.eps.apple.com [57.103.64.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335124A07A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681905; cv=none; b=ScWfQgy4gyMCI5VPkn/l7UVM3tXF84/IVJ9EXIrNcBhcf7HmmM73d1DntaAUnNmAjpLn3JSr0VOVGJ7CgLZH39RnQ3j0hycnjUkJbqdDVt3Ed2s92WzxhEIqEayqBhW7i3gdResvYGox89nztRgFvCHaHjwRL+LZ4aSgpzef9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681905; c=relaxed/simple;
	bh=lSYzmt2e/7sb/9/P+7v+9g2YrTs5nehaODUIs4dbQms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3Va/V/DztZ/nOVyi6TtwarhdRFblnVJW44MHkXiQx518l4KK+CeKPKYdKZCuUrWBx6Vg9Sregpf/Ln/Eq1yYbzDzjdlfgxRLrauNIKlf5n1cWvPkglZ70yaB1G02VCKH8B8EdPSQ0BWRV3H0lauBge1cQJAQRCywLYKWK5TLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gKxUeb7v; arc=none smtp.client-ip=57.103.64.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gKxUeb7v"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id F16EC180018F;
	Mon, 23 Jun 2025 12:31:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=mBETXbdc3NL5vO8AwaqSutoRmMvp/eieMDamGyhkfPE=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=gKxUeb7vm0f1EkbOhG3asREHEMYkIdhl+w/Pn0k9bVzmbyD2xC5Vr87H8UTlXosGCgEG7jUxvi0b9n24n0TqMS+d8MGyZus/nggqUGRFjx0VP4CfN5epxoavMlEx2X9FV28tMsQJFKaidXusbkMQElJ4ev/s5nPtJB7q6agD8kcF0AFD9eoocWrBKCyMR9dROfHyOjY6EunB7xTM/Na6PIjfZbJATFEeEYp2M7PIHQQAE8oS19+R3EWHR9NZul3mbbYSEqco/PSpCh0jMOpJKPybzqvB/Dkg67RLt4v7yPa/GhgJ3oSm2aZ3udNMUo6g2Md9MoHQtktjo0ODlFmp6A==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 739211800EC9;
	Mon, 23 Jun 2025 12:31:35 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 23 Jun 2025 20:31:17 +0800
Subject: [PATCH 2/4] Bluetooth: hci_sync: Use bt_dev_err() to log error
 message in hci_update_event_filter_sync()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-bt_cleanup-v1-2-5d3d171e3822@oss.qualcomm.com>
References: <20250623-bt_cleanup-v1-0-5d3d171e3822@oss.qualcomm.com>
In-Reply-To: <20250623-bt_cleanup-v1-0-5d3d171e3822@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3NSBTYWx0ZWRfX2dWKz4PPiEO7
 q0RTvO6pviQrBqumA0CJojuBX8ifhdNnBFzdPLjp9IyweNfqQS5+9hE6SgUq4Utte6hEdqgreRg
 ETs3JvCVyhdEK4hgyzC8lPgq5lzGKnKQqQcRYwkLoqF2L7IIptShR19bDu7pQsIL1j8nXb/8ofF
 MD9oDM9NrzB7e53qc3ubH9HbCG/Kf1J8Jt4ZnDfdglB8Vu/ctwPb/63HiF/tTqvqgfrR8waabrh
 EETGzaLhrpgE/gkuyhLSR20fnWWMfmWxCzccuVJxdBoYcPA8uZc4PepkIJUK8vGYr7JaRkmuk=
X-Proofpoint-GUID: MWi7XUJp5w6K0sA3MrXFrAezW9VDznG6
X-Proofpoint-ORIG-GUID: MWi7XUJp5w6K0sA3MrXFrAezW9VDznG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2506230075

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Use bt_dev_err() instead of bt_dev_dbg() to log error message in
hci_update_event_filter_sync().

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6687f2a4d1eb44c154f471ed0c4cad7e8d437c88..9288a2ff5476fba04729799e7b7d8b4d43087e6c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6073,7 +6073,7 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 						 &b->bdaddr,
 						 HCI_CONN_SETUP_AUTO_ON);
 		if (err)
-			bt_dev_dbg(hdev, "Failed to set event filter for %pMR",
+			bt_dev_err(hdev, "Failed to set event filter for %pMR",
 				   &b->bdaddr);
 		else
 			scan = SCAN_PAGE;

-- 
2.34.1

