Received: from outbound.pv.icloud.com (p-west1-cluster2-host6-snip4-8.eps.apple.com [57.103.64.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9523E23C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681900; cv=none; b=TBV9MeyZ1EdB1bQRjq+yUBBWyZ6vT3LyY0wMF6SaUdm0WuvNgaivy6MXSKVUjIGg7AL42COQ83fmFwecoNFNJ7DTH91OREXlqsxzuqqZf+hQj+xteJ03EB7eCmTpjiYtB8umDGzVrkgWOJhIP3kzykYYRbOT9QMjxab80ppD6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681900; c=relaxed/simple;
	bh=BN8DBGXySBoTVfMs+bmQgj2+i/NZzqjolT1YHNgGSjI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gj1LmsNilqZJIXmXOVTJY3GMq68aBCIXUl7wEy1bOqKX6BBuD0XzJ7dlVpVG5YrqLW0jH9wtmHMj08tH2MADe5+abCXwwCONOqDLfhrWetH8/cQpuOASOwvXT7fmLqpPqzjZUs/ikr9Nf68jFRukbQpB2BXZLraTii8o7AZo1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=IYMo8yBz; arc=none smtp.client-ip=57.103.64.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="IYMo8yBz"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id BBC9E18001C4;
	Mon, 23 Jun 2025 12:31:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=gw/2H+w3/Dh1/O5dkqOpLntn2CUwjysaImd5LMVil/g=; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme; b=IYMo8yBz1/bILRQBmf6eWoHNoURLnGFTYgYI2Fyl0ZWFkNhV+rhz7wZ8wWiKE8wKLNpfAqA3uVxdVYNrwvh9eEYH8r9d2O0PN+KaLNWzeuUyVV781WKAuDz9WiklLNjRUo3bgRwEvtKZ8N38PNrLWGy2CpGAaeqU+Cbnq5H1qGBTTpE+eUOu9XwgTDzTJiYJp3LumRxQ90iwqBYiYbjgAIkJAPCXRaq1djdt8J9NASlfldcRwd4JGzZ3J+dGZZ9grb8xcILWJclZrxgy5FJ5QQ8fE8qSI3ZVjByenwT8bLx+UAbptQaROrghd5U3BkdZqW3XUJRZ5CXszLzApcb+bw==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 57B6F1803778;
	Mon, 23 Jun 2025 12:31:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/4] Bluetooth: Trivial cleanup
Date: Mon, 23 Jun 2025 20:31:15 +0800
Message-Id: <20250623-bt_cleanup-v1-0-5d3d171e3822@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABNJWWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyNj3aSS+OSc1MS80gLdtMQ006TkxGTjpERLJaCGgqLUtMwKsGHRsbW
 1AI5adPpcAAAA
X-Change-ID: 20250623-bt_cleanup-faf5bcac3ba9
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3NSBTYWx0ZWRfX/IxPR7gtxWmu
 wWXLcEHg9GKgpBI+BxbPkchaG3OT9gWm4cgxFh9BSd5mp7joLFp8I2HaqupJO52FDosQcnRJR9s
 mQeStWvDoDCnentxhkoElCqBCRHm9By2JCf9Harovd01MParpM3cRjz9iD2u2ase7VOWlR/1DJV
 juTfOombKuvUbYHFgtIYxgzB+03Wwaeh6C+9RG+Ufi7oHNmYkK5MfJ/sE8jokIMKSJux3ifApfm
 FZw0hUYj+powaw6Gin1JlLbMl/igoFJmD4nWlpFFl9GQvDNqFRQ1ocoU/SAnx2N8e/j4zDSXg=
X-Proofpoint-GUID: oU73P-fGLC9Gz30Tn7cqtvp0_VWaXleb
X-Proofpoint-ORIG-GUID: oU73P-fGLC9Gz30Tn7cqtvp0_VWaXleb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1011 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506060001 definitions=main-2506230075

This patch series is to do trivial cleanup for bluetooth core driver.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Zijun Hu (4):
      Bluetooth: hci_sock: Reset cookie to zero in hci_sock_free_cookie()
      Bluetooth: hci_sync: Use bt_dev_err() to log error message in hci_update_event_filter_sync()
      Bluetooth: hci_core: Eliminate an unnecessary goto label in hci_find_irk_by_addr()
      Bluetooth: hci_event: Correct comment about HCI_EV_EXTENDED_INQUIRY_RESULT

 net/bluetooth/hci_core.c  | 4 +---
 net/bluetooth/hci_event.c | 2 +-
 net/bluetooth/hci_sock.c  | 2 +-
 net/bluetooth/hci_sync.c  | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)
---
base-commit: dc3f099e8d709c2fbb25e1079e1b3d703a6828b2
change-id: 20250623-bt_cleanup-faf5bcac3ba9

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

