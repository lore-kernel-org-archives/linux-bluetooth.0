Received: from outbound.pv.icloud.com (p-west1-cluster6-host10-snip4-3.eps.apple.com [57.103.67.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325FE23C4ED
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750677847; cv=none; b=gtpblXakY9FmsX6/I7niIebgZCwgcX2ZMH1UC6BcsYVciqnBSAb/0Anxkw61bQV8UIZMHvgPA5tmxSP6wBP43BpsndrmWopltv0JVE2VKnqIWolUhrUiWUiRvCH5CwhdSURmYJkUipO+oLXodU+ZZ7bcSGjy/e1DRYT2b/M4Kwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750677847; c=relaxed/simple;
	bh=xs5CAZeO2kCTK14Z4YEuLqifgzUc9ovVFslAeRWAxm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o/reeAdPelnNrf26PhA3BpTiBfJVVw25vH3l7PoKnh4tGW8RvbzX1XkONujUgm7BNR25baW1g61a0iw67hdA0AuJ92PLfwTkpKAbjsPW1cKZrFSQYzGScUsBLW5Vc2RoiUXcu11JFweX/Gazd48wobvOqyApy1XtMmo0VtzUt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gTwcHlfa; arc=none smtp.client-ip=57.103.67.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gTwcHlfa"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id B5E991800A0B;
	Mon, 23 Jun 2025 11:24:03 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=FXO5JrJqKm5uEmDS5QxFD75CtUcUoWq1Z3yegABBRjU=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=gTwcHlfasq+ZqJhGSIbJjGJjPvyV58v1W6hzjXB+6IrDAgH5Op7C98LSEnVlOsq/Z755izGrzZx5JV+bDMC/0fF6cfIQo+XHN4kdB30J9WPSZDveDZk2y4LB9MGDldmF0+Yd7LdkruWd2ukEDLy5hAHBD0K89MnoJcuZQnZkwn+d645r57Paf/CBpieOk0QDrKkQYP/EGXVXPHmNR8GsczuagYLHDxnXcG2JbQU50v6yrxA/ZM1ndaAOrfybpzm/8YTcb3J7iNdXC5Uq6TdcqhbDX02vbnsQYV0HoBEY3XyD3Ja1UxLK4D0rKxzAiv+RyzMF4ubwqg1nTabmUoIxzQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id BA3761800271;
	Mon, 23 Jun 2025 11:24:01 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 23 Jun 2025 19:23:48 +0800
Subject: [PATCH] Bluetooth: hci_qca: Enable ISO data packet RX
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-iso_rx-v1-1-65dd2882b670@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEM5WWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyNj3czi/PiiCl3z5LTkVANTo0TDREMloOKCotS0zAqwQdGxtbUAurg
 mg1gAAAA=
X-Change-ID: 20250623-iso_rx-7cfce052a1a1
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: lAENmWWWen2W7bjIfLX1xhn2TFWZKg5v
X-Proofpoint-ORIG-GUID: lAENmWWWen2W7bjIfLX1xhn2TFWZKg5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA2OCBTYWx0ZWRfX/CZqQmeKPUiK
 lJaBsbqxkX7dG2Yd/3hKDzw2Xu0o2u4tH1vVt2eVckcYwVlYy/qf3l5GzaSLt/twSSiBd4G55oP
 luiR/X6PR5JM5UuXGIDkKCGfzi4byCGaVit7eEBAHGHnbFIh0JrWSS+Fh5WNJarkqx0r6GC+Xc4
 vzDJTRvg5XUNavIfGGXrO6T5xEk8Uncpkz/3nNiufDbBGeLHwYvLc8HtrNdUSH4xwDynfJ2veNA
 Ld9NIlplgKC2ozRsqdOVOwbqgG8ZdCf48E8h3489dKakHtfyp293U1wSjDG48MHgupqn5Vt6E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0 clxscore=1011 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2506230068

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

Enable ISO data packet RX for LE audio.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 976ec88a0f62aaaf994091459c49188c435f3f7b..2324a4f5b95740ca500e64408cc7253eabfa9aa7 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1264,6 +1264,7 @@ static const struct h4_recv_pkt qca_recv_pkts[] = {
 	{ H4_RECV_ACL,             .recv = qca_recv_acl_data },
 	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
 	{ H4_RECV_EVENT,           .recv = qca_recv_event    },
+	{ H4_RECV_ISO,             .recv = hci_recv_frame    },
 	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
 	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
 	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind },

---
base-commit: dc3f099e8d709c2fbb25e1079e1b3d703a6828b2
change-id: 20250623-iso_rx-7cfce052a1a1

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

