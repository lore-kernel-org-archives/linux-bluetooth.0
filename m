Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0E1411E8
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549532; cv=none; b=DG5Vl3zENn1MgoZ3zKpRNUEP1na4j42pM9uWTshT+VUuJA0bOjDss4oTFMRnn7tYGoIBEyJ+R0xslse/WHK4srGvJikRxlkNXtbbbGGng7Q+nvJ9vjhcVGdymbnT5UdSyAHcCfKN1O4Nk3pVrUg9MbVNYDTLJSW1EJUHYG3psNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549532; c=relaxed/simple;
	bh=dFudLloDviN/TDXnNDnXEekBSh428fo2cUF88yQuwsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTPzMOtFzqZQ8t2VczL8CDyf2D9+4llJZZer+4drxbAyP9amtbUVxftO/8Vv2vIXH3/cSG+AAPyJxcbG3+qiIL24+8mR6SH0V101Bkn6GtVrPhTzYDfc0qI7D3u8ohKnN7TNyGK2Ui/dW91wpOpJo6PFYxnMN8fy4r0k2yTedXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3826240007;
	Wed, 27 Mar 2024 14:25:26 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Gui-Dong Han <2045gemini@gmail.com>
Subject: [PATCH] Bluetooth: Fix TOCTOU in HCI debugfs implementation
Date: Wed, 27 Mar 2024 15:24:56 +0100
Message-ID: <20240327142526.332756-1-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

struct hci_dev members conn_info_max_age, conn_info_min_age,
le_conn_max_interval, le_conn_min_interval, le_adv_max_interval,
and le_adv_min_interval can be modified from the HCI core code, as well
through debugfs.

The debugfs implementation, that's only available to privileged users,
will check for boundaries, making sure that the minimum value being set
is strictly above the maximum value that already exists, and vice-versa.

However, as both minimum and maximum values can be changed concurrently
to us modifying them, we need to make sure that the value we check is
the value we end up using.

For example, with ->conn_info_max_age set to 10, conn_info_min_age_set()
gets called from vfs handlers to set conn_info_min_age to 8.

In conn_info_min_age_set(), this goes through:
	if (val == 0 || val > hdev->conn_info_max_age)
		return -EINVAL;

Concurrently, conn_info_max_age_set() gets called to set to set the
conn_info_max_age to 7:
	if (val == 0 || val > hdev->conn_info_max_age)
		return -EINVAL;
That check will also pass because we used the old value (10) for
conn_info_max_age.

After those checks that both passed, the struct hci_dev access
is mutex-locked, disabling concurrent access, but that does not matter
because the invalid value checks both passed, and we'll end up with
conn_info_min_age = 8 and conn_info_max_age = 7

To fix this problem, we need to lock the structure access before so the
check and assignment are not interrupted.

This fix was originally devised by the BassCheck[1] team, and
considered the problem to be an atomicity one. This isn't the case as
there aren't any concerns about the variable changing while we check it,
but rather after we check it parallel to another change.

This patch fixes CVE-2024-24858 and CVE-2024-24857.

[1] https://sites.google.com/view/basscheck/

Co-developed-by: Gui-Dong Han <2045gemini@gmail.com>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
Link: https://lore.kernel.org/linux-bluetooth/20231222161317.6255-1-2045gemini@gmail.com/
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-24858
Link: https://lore.kernel.org/linux-bluetooth/20231222162931.6553-1-2045gemini@gmail.com/
Link: https://lore.kernel.org/linux-bluetooth/20231222162310.6461-1-2045gemini@gmail.com/
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-24857
Fixes: 31ad169148df ("Bluetooth: Add conn info lifetime parameters to debugfs")
Fixes: 729a1051da6f ("Bluetooth: Expose default LE advertising interval via debugfs")
Fixes: 71c3b60ec6d2 ("Bluetooth: Move BR/EDR debugfs file creation into hci_debugfs.c")
Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
Hello Gui-Dong Han,

I've made changes to the patches that you submitted in December 2023 and that are
linked above to:
- correct the commit message and description, this isn't an atomicity
  problem, but a TOCTOU problem
- corrected the "fixes" references to be of the original code
- added CVE references for the changes that warranted it

I've kept you as the co-author of this patch and kept the references to
BassCheck as well.

Let me know what you think.

Regards

 net/bluetooth/hci_debugfs.c | 48 ++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 233453807b50..ce3ff2fa72e5 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -218,10 +218,12 @@ static int conn_info_min_age_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val > hdev->conn_info_max_age)
+	hci_dev_lock(hdev);
+	if (val == 0 || val > hdev->conn_info_max_age) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->conn_info_min_age = val;
 	hci_dev_unlock(hdev);
 
@@ -246,10 +248,12 @@ static int conn_info_max_age_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val < hdev->conn_info_min_age)
+	hci_dev_lock(hdev);
+	if (val == 0 || val < hdev->conn_info_min_age) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->conn_info_max_age = val;
 	hci_dev_unlock(hdev);
 
@@ -567,10 +571,12 @@ static int sniff_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val > hdev->sniff_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -595,10 +601,12 @@ static int sniff_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val < hdev->sniff_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -850,10 +858,12 @@ static int conn_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_conn_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -878,10 +888,12 @@ static int conn_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_conn_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -990,10 +1002,12 @@ static int adv_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_adv_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -1018,10 +1032,12 @@ static int adv_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_adv_max_interval = val;
 	hci_dev_unlock(hdev);
 
-- 
2.44.0

