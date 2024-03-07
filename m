Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C912FF8B
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829739; cv=none; b=kl7rlOGjcoQ/N3f/7R8ALgcKkgZRNyUM+PiJ8EY5asx4gjwQ2vdT1IymSXdEbrozPSFdC9FNGsSk7XHy8R8MqLizr52/X3oyT7+eyds1sQ2PE2Yg7St8kIQL+3EIwKuY/jWfvd/4UVl0NWpPrdq9vyA6HioyxJOwFAt+Qzf3P50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829739; c=relaxed/simple;
	bh=H1OvJTKyTFsoPpie/iVcrTQ62Ie48SJiioE27w5MSFE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=Gt170lfObYrfwN28WivCp4qZ1JxNKps7lnCgybPwpM/ng5m4w1tSdKqOrk56uaOzVo8UySLyVSapcHSo3Fsd+vaWNoK5CkF/fKo8tImIZVx7+mRAzcKOCq/QWgH5E6jfDn+zaHP/dytwfnWvEIcwmiA2JkuDgLU3bRX8pU1QIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OgtQ0774; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OgtQ0774"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709829735;
	bh=H1OvJTKyTFsoPpie/iVcrTQ62Ie48SJiioE27w5MSFE=;
	h=From:To:Subject:Date:From;
	b=OgtQ07743Qn7sR25HQFWPz1+dIEJdjCitBtsJ/D2AI1Z0H10TuIW8hftq32WVxTjf
	 Ol22Wv6yIuYC+QyFU8TSENHn2cbIoUQ0PTqdcSrQKLVy6hUIhUd1YE85OPK/evAuDs
	 ZSfafIJKtI9c+sedIMbUmKrzUYdVw2pBprqCkhVDv9bS9m08LgiUSC9ighTr1r9nqe
	 m8rUCT7yKLCrBucpk0dJ8EZh/pUlYAcC9+tNLwBLFXdE4h6FKl94IoSEM7qcFJik/m
	 V/+jMm3NFmYfxxzO8FOIBmqbIJon5lYM+iHkWiluGGuQHqyQnNnzgE6vvuDM7OZBXr
	 GUcB53+/POQVg==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5604237813CA
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 16:42:15 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Bluetooth: Fix eir name length
Date: Thu,  7 Mar 2024 17:42:05 +0100
Message-Id: <20240307164205.1011133-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

According to Section 1.2 of Core Specification Supplement Part A the
complete or short name strings are defined as utf8s, which should not
include the trailing NULL for variable length array as defined in Core
Specification Vol1 Part E Section 2.9.3.

The trailing NULL was introduce by commit f61851f64b17
("Bluetooth: Fix append max 11 bytes of name to scan rsp data")

Removing the trailing NULL allows PTS to retrieve the random address based
on device name, e.g. for SM/PER/KDU/BV-02-C, SM/PER/KDU/BV-08-C or
GAP/BROB/BCST/BV-03-C.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 net/bluetooth/eir.c  | 29 +++++++----------------------
 net/bluetooth/mgmt.c |  2 +-
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 9214189279e8..1bc51e2b05a3 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -13,48 +13,33 @@
 
 #define PNP_INFO_SVCLASS_ID		0x1200
 
-static u8 eir_append_name(u8 *eir, u16 eir_len, u8 type, u8 *data, u8 data_len)
-{
-	u8 name[HCI_MAX_SHORT_NAME_LENGTH + 1];
-
-	/* If data is already NULL terminated just pass it directly */
-	if (data[data_len - 1] == '\0')
-		return eir_append_data(eir, eir_len, type, data, data_len);
-
-	memcpy(name, data, HCI_MAX_SHORT_NAME_LENGTH);
-	name[HCI_MAX_SHORT_NAME_LENGTH] = '\0';
-
-	return eir_append_data(eir, eir_len, type, name, sizeof(name));
-}
-
 u8 eir_append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
 {
 	size_t short_len;
 	size_t complete_len;
 
-	/* no space left for name (+ NULL + type + len) */
-	if ((max_adv_len(hdev) - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 3)
+	/* no space left for name (+ type + len) */
+	if ((max_adv_len(hdev) - ad_len) < HCI_MAX_SHORT_NAME_LENGTH + 2)
 		return ad_len;
 
 	/* use complete name if present and fits */
 	complete_len = strnlen(hdev->dev_name, sizeof(hdev->dev_name));
 	if (complete_len && complete_len <= HCI_MAX_SHORT_NAME_LENGTH)
-		return eir_append_name(ptr, ad_len, EIR_NAME_COMPLETE,
-				       hdev->dev_name, complete_len + 1);
+		return eir_append_data(ptr, ad_len, EIR_NAME_COMPLETE,
+				       hdev->dev_name, complete_len);
 
 	/* use short name if present */
 	short_len = strnlen(hdev->short_name, sizeof(hdev->short_name));
 	if (short_len)
-		return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
+		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
 				       hdev->short_name,
-				       short_len == HCI_MAX_SHORT_NAME_LENGTH ?
-				       short_len : short_len + 1);
+				       short_len);
 
 	/* use shortened full name if present, we already know that name
 	 * is longer then HCI_MAX_SHORT_NAME_LENGTH
 	 */
 	if (complete_len)
-		return eir_append_name(ptr, ad_len, EIR_NAME_SHORT,
+		return eir_append_data(ptr, ad_len, EIR_NAME_SHORT,
 				       hdev->dev_name,
 				       HCI_MAX_SHORT_NAME_LENGTH);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9613cc8a60f8..32ed6e9245a3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8408,7 +8408,7 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 
 static u8 calculate_name_len(struct hci_dev *hdev)
 {
-	u8 buf[HCI_MAX_SHORT_NAME_LENGTH + 3];
+	u8 buf[HCI_MAX_SHORT_NAME_LENGTH + 2]; /* len + type + name */
 
 	return eir_append_local_name(hdev, buf, 0);
 }
-- 
2.34.1

