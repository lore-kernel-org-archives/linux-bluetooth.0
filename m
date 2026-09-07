Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A143CE4D;
	Mon,  7 Sep 2026 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823297; cv=none; b=nGzxZtEN648u6nBCrGegCt7P/miTdKUdGAKMNJrJfaMu8aMe3v3Bq+idnbyvNvdlJYQbEI38ducG1p98Fjl2m2fFKhR5jVTQ9N4zL3fzZ3rCISk9mNrA/M76AQ0ywAqXMEh9z6Q8am7Pqei24Pye+Hr5p+pKA7z2neAiwQkmQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823297; c=relaxed/simple;
	bh=J5mVYywtRCjj8Dx9PqTBtT2Y7m1+qiMCAy+fFim65js=;
	h=From:Subject:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaSwiyHXPJXXu7Y18bFlcy/ECpaxcX4k7bT0TLhqhS+mUcoaK+vayGeAU8MZRhqO9wBf9EEmqy5HKRlTRJPQmNaxhgnrLFIKPDOj43WjklKZH18hBhfawrH3xsVE2fI8mC9JZ4y6RUGgZ3BZdF51vFWkfdd6wLSZL/tVj0zh058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz; spf=pass smtp.mailfrom=podgorny.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=RFQuTGM7; arc=none smtp.client-ip=77.75.76.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="RFQuTGM7"
Received: from email.seznam.cz
	by smtpc-mxb-7db765f675-b5z24
	(smtpc-mxb-7db765f675-b5z24 [2a02:598:96:8a00::1200:50a])
	id 6063c94cd659645565ecd304;
	Tue, 08 Sep 2026 01:21:32 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn1; t=1788823292;
	bh=+aF4uHNTnQ/mTWVzyycsCGXCZ+bRODmcm4ig9M3d/4M=;
	h=From:Subject:To:Cc:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	b=RFQuTGM7X80L9gArjDD2gyLWpTdpgcEjrLeFCL3hD4S3OrJX6E8Xuzh3VDgt80Q26
	 8mAhhmr2W9iy0MmbAXH5cLGseqzhwndLJ+34y3EoPkYw8yKCbNpp72qyU7ERdapvPv
	 JX/38iTDOJgKYn2MNPqR+YZmqTAPqskGS04dFh3k4+oTNmLxSJzbaDfP/E0VTayiES
	 lVkJDpMMj9bSzR4cnPN87xCWN3oize7nIBzs1EY6bv2ej9vm7fdDudBYu5XSO8lBhG
	 KB4LvWGsRkmlDVdjlBa3pn7H7jp07HniR4sWcxIWozpMSkDQqt25EWTJqzh0EholQl
	 EbYBXAgLb1ZTA==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-57659868b8-2vb45 (szn-email-smtpd/2.0.82) with ESMTPA
	id f16c165d-6d9a-4205-9e85-167e384885dc;
	Tue, 08 Sep 2026 01:20:50 +0200
From: Radek Podgorny <radek@podgorny.cz>
Subject: [PATCH 1/2] Bluetooth: record when an IRK's RPA was last seen
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radek Podgorny <radek@podgorny.cz>
Date: Tue, 08 Sep 2026 01:20:48 +0200
Message-ID: <20260908012048.3681904-3-radek@podgorny.cz>
In-Reply-To: <20260908012048.3681904-2-radek@podgorny.cz>
References: <20260908012048.3681904-2-radek@podgorny.cz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailer: python-smtplib (git format-patch body verbatim)

hci_find_irk_by_rpa() caches the resolvable private address it just
matched in irk->rpa, but nothing records when. A cached RPA is only
useful while the peer is still using it -- RPAs rotate on the order of
15 minutes -- and without a timestamp there is no way to tell a value
seen seconds ago from one left over from hours ago.

Stamp the time in both loops, the cache hit as well as the resolve, so
the stamp tracks when the address was last seen on air rather than when
it was first resolved.

hci_add_irk() can install a live address as well: when SMP receives a
peer's IRK over a connection established to its RPA, which is the usual
way the cache is first populated, it passes that address along. Stamp
it there too, so a non-zero rpa always carries a current time; the mgmt
load path, which passes BDADDR_ANY, leaves the stamp alone, and readers
check the address before the time either way.

The store races with concurrent readers the same way the existing
bacpy() to irk->rpa does. Both are benign -- a reader either sees the
previous value or the new one -- but use WRITE_ONCE() to say so.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
 include/net/bluetooth/hci_core.h | 4 ++++
 net/bluetooth/hci_core.c         | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c12cd6873f65..8308ef6160d3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -212,6 +212,10 @@ struct smp_irk {
 	struct list_head list;
 	struct rcu_head rcu;
 	bdaddr_t rpa;
+	/* when rpa was last seen on air; used to decide whether the peer is
+	 * currently advertising an RPA or its identity address
+	 */
+	unsigned long rpa_jiffies;
 	bdaddr_t bdaddr;
 	u8 addr_type;
 	u8 val[16];
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 66840df8c020..8ee26cb10276 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1179,6 +1179,7 @@ struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
 	rcu_read_lock();
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
 		if (!bacmp(&irk->rpa, rpa)) {
+			WRITE_ONCE(irk->rpa_jiffies, jiffies);
 			irk_to_return = irk;
 			goto done;
 		}
@@ -1187,6 +1188,7 @@ struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
 		if (smp_irk_matches(hdev, irk->val, rpa)) {
 			bacpy(&irk->rpa, rpa);
+			WRITE_ONCE(irk->rpa_jiffies, jiffies);
 			irk_to_return = irk;
 			goto done;
 		}
@@ -1331,6 +1333,8 @@ struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	memcpy(irk->val, val, 16);
 	bacpy(&irk->rpa, rpa);
+	if (bacmp(&irk->rpa, BDADDR_ANY))
+		WRITE_ONCE(irk->rpa_jiffies, jiffies);
 
 	return irk;
 }
-- 
2.55.0

