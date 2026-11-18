Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017569;
	b=IdDL/GVTboXIKQInqHi8p7ZqX/LcbCCM5U254SDHM21NebGmepC7OPCzcjoOg6Y9e9LF
	 4N2ESM4BuqAALwyaeoZabMlQOuyPDkQa6G+v5jmduPZbW6hKnLbEGahGBiVvmASHBEvjC
	 n0c+FV6dZc8g5F8PFUzK3Xc8yeNJG0Eau/AOG++a6gNuqY1rGjRtbmgPLs7Umw5JxGzea
	 B9iIeLqjTLkSVpdvCgC0FBgVoFOLU3wCtPu+nsx1lusy3nF2y5Z7ZFDzx0w5kSswqNHU0
	 Re8UGMrk3kMPHlrZRMtaa40vTcfha3BAcL5oTIwGj5te61lBynBTmfP+2xTNJR275hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
	b=scJbXaCs1taONnY0DdR2owIFC9hmCRR1wob2XxNxGy9jLGYxAYYvcCrbAkNGFE4FBRIM
	 Srcls2xWME82/8YA0S/dRxzvftz5i86qG30xLWiiaVvtKtvYdm/ajLfuttUzqP0KeeT64
	 FhkU0akqHlr/I+yh0bPYkDdY9ni+bJrXWRGyEkIyWsQN46HymhHmEPONppZ3WJ8vP4w9i
	 k4jr6lRt7EcEis3n/VhrcTJVatEXMgA0VOul29Hxd8GAw0LnF9dqQ3bgTeWNVNBX5wnBh
	 LvwDCoqmstBAsEASzku5zfvHsjQuLjBVqVUmYZS9EsDOZeZqoPMD/9daiDY+LIb/xwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D2hGC8ps;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831CE606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 831CE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D2hGC8ps
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eac01ff101so414901e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017568; x=1795622368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
        b=D2hGC8psgB7YYivuAvicDuUiw3hSAaXURX1DJ/0zczT1TMBQeHL+9v8BmhMw05R+zj
         c4eEr0YJMA2EpJmTNGc621JhVDeNLXdSdDvd9gwfZBdu3Ox6gfE8cisrU1W+prLAT+Nl
         41Hw5gqFFxX+T4di+mK5fEQ6k/9Bdj6owGy9BDgQHMjSNOe/tAjWCjgjZqABsNxuf5tu
         4i8cvrdTSDqYntt4BjWEfUVCo+sJJl0I2AWg8rA8xMYGh1TKqKdiXWfuPlQB4/GBaWvQ
         dhsbSEWhwKXN9bqL6+ajRk/5jVBf+McNGQsEW551bwNldzf9zdEz0wlo5HyqEwmlpq3C
         lKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017568; x=1795622368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
        b=q/qwQMcCJrDEVbdqDXTseSRVBkcWLp55oVLxbzGj0u3Nn+Q9I31QZmSrKWjfIAkWB2
         F1Q/NWb/KaqLuY8iGvV9LyeOyBRbvCqzQEprn4iRGmHsXdFpGtG6IvvqM85oTOmSFqzP
         w930cEOaXPHj2rKTjS8Xl9dZCGTUxYC2IOzAZRY+0KNSehzwYMy1I+Yq23CQA4jm7ElG
         caHi+kBsSTJyihnAryrtogTRkdg4dAIcucSvim6bBFoRFPqnBr78vKdg0pQv71MVW+N8
         +zjSsEQq8CRF1qdfhGc7Z4w72kMj9IFqVdGB2BZgcG/CiIdK9MdUsxP3g7XWiQS9Yvsk
         BoSg==
X-Gm-Message-State: APuU4Z/NHPKVzI/p33xqVir42HFGS7jYrWjpa/eRT4A0yksjp4sGIUFj
	VZCpem070j5QOx6LEMs7nbSA+9c/iivF51A02LMZ2eS36rJzHJhhsfPN/cqsvFZh
X-Gm-Gg: AZFdTZeMEvJMpkjfivmHUDRP1RS9quk+AAwAffVAxTxYFflmRzeuTJfSnaoy+Y0EClZ
	AqCMiCkvurQ3uV0+NpeNT8ADWRtyS199Ndzhjqv62/Rv78oT9xEcCrEDyeOj29PfVg4swDydo0b
	yiiOqtLMpbN8fMhH/8NN5yp8Rg3llpcaTUgJ7h6ru3Bh/yNsdEVoAYX9jKTLfqrYfEbYcX3tiZj
	wqvZycHUrLU5gyPsO7dATwydmSgwarULfpxWUAqyMwdzxWvW0Lf5/HChuy45+7Y50y07Y8Spcuc
	D6cFq3h8A9RqYJLs2yLUnvelv2OuAEod9tNcwkrQb3wbMoLkSNPfrra6DljTq9MgyjiBQX4nOn+
	aMh99a1s1xs9v8Ywwfggs7hAmlv4sVcqZ8FuqHdFDON80/XqkmRhhC35ISrj4roqUbIg6SjUa3o
	B0xLDuKKib/oCb7k5sLwg9helsNwvWGt3W+XTn/SITpyJmMBjeHJ33K9LWdvObCae7r2aFUIqqK
	4mFzme1KMaGEL1GhubzZEWt+cACgo31t0I1v0fS5oghDEjG3+jiD8kGm+eOIsGkv7ZJWSc3d0FA
	QpyqP7bV82yc3XO5ggyiSpFHyLmkWTCIkmr+R0gPqTZbxoPu44/0a8apY+e7Kg2XwlR/mOawER6
	PI6uLujsJzxbjYdTS/sN9o5R0YH78QXy9Wp5YtVSQMLwfPy2QCEJHZfMa48r74Y8glEb8CkZWpR
	jeG+c=
X-Received: by 2002:a05:6122:1801:b0:5ec:4112:6839 with SMTP id 71dfb90a1353d-5ee647160b9mr1415908e0c.15.1795017568445;
        Wed, 18 Nov 2026 07:59:28 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 15/17] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors
Date: Wed, 18 Nov 2026 10:59:12 -0500
Message-ID: <20261118155914.178050-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118155914.178050-1-luiz.dentz@gmail.com>
References: <20261118155914.178050-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_remove_single_adv_monitor() and hci_remove_all_adv_monitor() only
require hci_req_sync_lock, yet they look up and free monitors, modifying
hdev->adv_monitors_idr and adv_monitors_cnt, which Read Advertisement
Monitor Features iterates under hdev->lock. Take hdev->lock around the
IDR accesses and the freeing, but not across the HCI commands sent to the
controller.

Reported-by: sashiko.dev (linux-8b358899-5ac9-4687-af16-58420a4d9bba)
Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a6bf806b9206..5522d4397682 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2129,7 +2129,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 	if (status == -ENOENT)
 		bt_dev_warn(hdev, "Removing monitor with no matching handle %d",
 			    monitor->handle);
+
+	hci_dev_lock(hdev);
 	hci_free_adv_monitor(hdev, monitor);
+	hci_dev_unlock(hdev);
 
 	return status;
 }
@@ -2137,7 +2140,11 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 /* This function requires the caller holds hci_req_sync_lock */
 int hci_remove_single_adv_monitor(struct hci_dev *hdev, u16 handle)
 {
-	struct adv_monitor *monitor = idr_find(&hdev->adv_monitors_idr, handle);
+	struct adv_monitor *monitor;
+
+	hci_dev_lock(hdev);
+	monitor = idr_find(&hdev->adv_monitors_idr, handle);
+	hci_dev_unlock(hdev);
 
 	if (!monitor)
 		return -EINVAL;
@@ -2153,7 +2160,10 @@ int hci_remove_all_adv_monitor(struct hci_dev *hdev)
 	int status = 0;
 
 	while (1) {
+		hci_dev_lock(hdev);
 		monitor = idr_get_next(&hdev->adv_monitors_idr, &idr_next_id);
+		hci_dev_unlock(hdev);
+
 		if (!monitor)
 			break;
 
-- 
2.56.0

