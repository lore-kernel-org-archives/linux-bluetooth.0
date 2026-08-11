Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8C3921D0
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461030; cv=none; b=KatLUwGMb7B5QKWb7B5c90oQNg3o8UaCs5N0vksE/xnJgkiwbJT0BCTrNKWLpsmbx17oqFb3Ve/rrM71DVooKQY01z9Gf+G14j9dWwU9pMB9rwi9gHBSCAX0bPsBTvbQSBNXBiMR+tKygoYVaEOC5kUayUNEVUnezGNbJq9T+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461030; c=relaxed/simple;
	bh=4UeiZx/cLgV55iLGuzW2ecpjvH1bSBEi0kzSvvDe/CU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1Py3RbIkLGQFM5amku+scORksnj9/cuvTM4fGTV7zmx/+peaYhOmpSMhs7DHs8KIXVfxvNW2+7uI81UO+8qKc1WvnRRr72gmkBc15KURxSKNb9yTFl2TeAFGreJbyvf1SDD/f76lIj956cI/nfADSVIBH3rphzkNuUDL3GHof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 52D8C5821A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 248A73ED0D
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:14 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 3/9] unit: Add test for sdp-xml type-confusion bug
Date: Tue, 11 Aug 2026 16:54:06 +0200
Message-ID: <20260811145704.1766949-4-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811145704.1766949-1-hadess@hadess.net>
References: <20260811145704.1766949-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTE7//a8gsi3w1GPpapT5Ukt+fEcfN0ZqTSeGCFTUi06HsKf4CTnNBAfQbQDkgHMQet12ca5SSLbtGFwNNEDfR56GEWiE694LLeds/YbTFK8oKE84ZZdRJN/9FvvJbitjEXe5X2Ux89sLo+6GZDvGV8fazWxgXEouHAPP8iOQOz18/3hSyqTpUBzum+i6Ub0Nt2fhaOHGrZ6NgN+LKLEtlkbSxHz7YtbNs3pVeVioymzgo9MfUufhQwyCrV3uFtqkiDCROWsNOJPwtkJ1K6Q+FDhjCe4szlYUmtKvmhPVzImpKtNCEY8GR2ieMfP074xV8f74uk7YI29NimMTemkaUPenHw33NIBBhPuKKZYBcxfSXn1BcPAKymSgArQ07qmlgDFtpYRGA/+DeMhGCGsYE6W9IQbOdbDmTnkeH+fa6+BLCk3loPxopRlMYMm6wHkm4MKZFEEcZZ7OOkENFOvOgzqRxBqrvDyfomz3tY+6Tj2B/4rLrU2GB1n6rQuqBu4/BXDxAieR6nDEyiS5xvP42YdZ3CjkfU6lcIjzIwra77hFfD0s2cREfZ0tMQ6NhGEub4lsJflnb2sdw3etv2KkVXcZpnoeqPcm5T+jNM00J3go4tL+WeAZB3Kgo4+D7+/WLqDDlIUW0ZpHKptKr5myDrDdh3zsmD5X2HLRcv0v6FWmA
X-GND-State: clean

See https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34

Co-authored-by: Aisle Research
---
 unit/sdp-xml/compute-seq-size-type-confusion.xml | 9 +++++++++
 unit/test-sdp-xml.c                              | 2 ++
 2 files changed, 11 insertions(+)
 create mode 100644 unit/sdp-xml/compute-seq-size-type-confusion.xml

diff --git a/unit/sdp-xml/compute-seq-size-type-confusion.xml b/unit/sdp-xml/compute-seq-size-type-confusion.xml
new file mode 100644
index 000000000000..41d6478af276
--- /dev/null
+++ b/unit/sdp-xml/compute-seq-size-type-confusion.xml
@@ -0,0 +1,9 @@
+<?xml version="1.0" encoding="UTF-8" ?>
+<record>
+<attribute id="0x0001">
+<sequence>
+<attribute id="0x0002"><uint8 value="0x01"/></attribute>
+<uint64 value="0x4141414141414141"/>
+</sequence>
+</attribute>
+</record>
diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
index 11a83951678d..1e3123892f95 100644
--- a/unit/test-sdp-xml.c
+++ b/unit/test-sdp-xml.c
@@ -77,6 +77,8 @@ int main(int argc, char *argv[])
 
 	DEFINE_TEST("Bluetooth_HID-sdp_record.xml", TRUE);
 	DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE);
+	/* From https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34 */
+	DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE);
 
 	return tester_run();
 }
-- 
2.55.0

