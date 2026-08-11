Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969063905E6
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461034; cv=none; b=plE1hcgRMziHI0LaD0roV+oeP8UFB1FOFa5gV2NtJ4RtN5udAJojBk4UcUzcRourk8OqAuUcXv9ewHIFWePoR7U647yXn1Zc3iD2b9S5BGwplGSpVCqb+x/rv35W7p5OOullFE3EGECziKLzYfyBerO1DrjgJFLOUI0OIH++tMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461034; c=relaxed/simple;
	bh=M+2xzrSZX6ga0wubhODlWUO/0iXGP5SsaMrmNYUpLhI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyiWzq9hiRQP9fbSSJjAIuGYwter9kuZn3w+3Lp0lUxCnG3POJEb6GxVjNSN91RPspAoEO5fFgMYxyEC5dKrqKHjdPjcmIfn/SxpbpU1VIri6XhQvmBP96qHk+D3fOKXxcv7ilaaTv1xbJS69tof6h+6phQ593bRwKjosGN/uOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 8C57D582365
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 875663ED0E
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:14 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 5/9] unit: Add test for sdp-xml duplicate attribute bug
Date: Tue, 11 Aug 2026 16:54:08 +0200
Message-ID: <20260811145704.1766949-6-hadess@hadess.net>
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
X-GND-Cause: dmFkZTE7//a8gsi3w1GPpapT5Ukt+fEcfN0ZqTSeGCFTUi06HsKf4CTnNBAfQbQDkgHMQet12ca5SSLbtGFwNNEDfR56GEWiE694LLeds/YbTFK8oKE84ZZdRJN/9FvvJbitjEXe5X2Ux89sLo+6GZDvGV8fazWxgXEouHAPP8iOQOz18/3hSyqTpUBzum+i6Ub0Nt2fhaOHGrZ6NgN+LKLEtlkbSxHz7YtbNs3pVeVioymzgo9MfUufhQwyCrV3uFtqkiDCROWsNOJPwtkJ1K6Q+FDhjCe4szlYUmtKvmhPVzImpKtNCEY8GR2ieMfP074xV8f74uk7YI29NimMTemkaUPePX/qAOrZECxxn0o21qnUurXjUW7gT1p28W/QH/viTZEczqTUcgnRsZRV6JKVdUby/h6++y8jNAiHk/XmagzfALJCgJKqsuSM980s3YRKKYh3PISSwcR61gX9cNITwFKlIOSgrRUwtsYsXhr9Y5cKGNljKkAYlaLq6voa79tuo2RAVuNb+EhrwC9Te7msVTObmxRDmoNMcnZSNy9HHBrY9flSl7QodOJYeMwlXGZ/1TQf+ZT7YT6ZKXzPAFpoAzMmoLRitr8lIT9uVJVEcq2aQlyPzIg2bLGr3tNoLOJw9m0t4HnT89EE50mYW908A/ruQJG+euNvQBee9PYBeODRWg
X-GND-State: clean

See https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc

Co-authored-by: Aisle Research
---
 unit/sdp-xml/duplicate-attribute.xml | 4 ++++
 unit/test-sdp-xml.c                  | 2 ++
 2 files changed, 6 insertions(+)
 create mode 100644 unit/sdp-xml/duplicate-attribute.xml

diff --git a/unit/sdp-xml/duplicate-attribute.xml b/unit/sdp-xml/duplicate-attribute.xml
new file mode 100644
index 000000000000..a30bc59d94ff
--- /dev/null
+++ b/unit/sdp-xml/duplicate-attribute.xml
@@ -0,0 +1,4 @@
+<record>
+<attribute id="0x0001"><text value="A"/></attribute>
+<attribute id="0x0001"><text value="B"/></attribute>
+</record>
diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
index 1e3123892f95..2794170dc153 100644
--- a/unit/test-sdp-xml.c
+++ b/unit/test-sdp-xml.c
@@ -79,6 +79,8 @@ int main(int argc, char *argv[])
 	DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE);
 	/* From https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34 */
 	DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE);
+	/* From https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc */
+	DEFINE_TEST("duplicate-attribute.xml", TRUE);
 
 	return tester_run();
 }
-- 
2.55.0

