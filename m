Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B743BED5C
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521870; cv=none; b=rkIL4FYshTQ1cSpYxZQH/rOL7NYognBLgZLYc3GTeulw02vKWXeHTXfyy565HuMsdIHvBg3AzErizVhGicjWSfY9RYCSgdu4BDhrIj8CiniaEhYSVVM+INmPZHX6MKUg4ecOrVzsVC/8HanQY8Mmz5WC8tVlDJYSatuu8CaqGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521870; c=relaxed/simple;
	bh=QVi67mlvwnjJ36ar47zFcg3qMkpF845z/5x30JNLAks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXe8bT4QFqpStOY7uBOykS4EIMDth6tC8ZgdPzvnlKW6pp3M8y7ExP/b8kVQK5Epv3X3judLB/KY7iOfppD7i19lwSw9BTLgxEA5crXQiQlfqM6K/i4WBTmFxjvuBA01VzoDGjUngrIWrd4+CKD+bx/lufjHLB4JKSgr5YhANvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 511933EE63
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v4 3/9] unit: Add test for sdp-xml type-confusion bug
Date: Wed, 12 Aug 2026 10:01:34 +0200
Message-ID: <20260812080410.2116906-4-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812080410.2116906-1-hadess@hadess.net>
References: <20260812080410.2116906-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTEATMgZESnXpnF9odixN+j9pjFJQtDJ1lOhKFVo5Z/nUe0V4kv8/975cH/jEC+64/687m2yeqptp72V8V+Fn9K7g/HOIo1s/A9vRcgAydT3FnC79LRZiaW2AsRMtWp8LHcLMk8RcFDZX+r73gvBiN0XAE69n/K+cGPfKTwfhuW4u+6P6l14AuHgA/JCsdUHL9YAy7vZyMQgTf4Y9kDKFjf6ZpkPzEK1NNr+QOxeLPriprXbk5OoT4J/7DzuhFaA2uT7ogxycD/0WB/G3uqVtCR3ahE9Xg872i09EVeEPn7oX7BCDVBYVDLUT70+1UfOo+2x9MExJKd0WKIq1ANYXqkca9FhEIq2QXO541N7Y7NMRo8+uIn6BjnL4g/rfpy2e4RQi5gn9kgwxgI1pH9QWD/UGLl/XHW1D42wsYMhSJ71VgTsOR4pWn1x5iWxY/FisJuYJf5ykrDAxKl1ValTJ3bHUrXX1ifXkYUziOiRz/N6EPf46ZLFUS2o+NEnnWqSxGi+G+Wexw1irUKn5/oGxoefHZfbtxaz/DNPUNsq37SRD21+FFw39YF9hPsqX5ZFrWXeAcxe++eKH9733RhliP1cJCf1FHsGT5ArvCa41n4kfNlNqRkFBGCp2GGHKaj8EqNyWEjYSBFoWbpqc0ozW2DSm+yP1n+aScndsBfWxm3Lsw
X-GND-State: clean

See https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34

Co-authored-by: Aisle Research
---
 Makefile.am                                      | 1 +
 unit/sdp-xml/compute-seq-size-type-confusion.xml | 9 +++++++++
 unit/test-sdp-xml.c                              | 2 ++
 3 files changed, 12 insertions(+)
 create mode 100644 unit/sdp-xml/compute-seq-size-type-confusion.xml

diff --git a/Makefile.am b/Makefile.am
index 1ecb5e1ddaec..1d5f02b0d362 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -648,6 +648,7 @@ unit_test_sdp_xml_CFLAGS = $(AM_CFLAGS) $(GLIB_CFLAGS) -DTOP_SRCDIR=\""$(srcdir)
 unit_test_sdp_xml_CPPFLAGS = -I$(srcdir)/lib
 
 EXTRA_DIST += unit/sdp-xml/Bluetooth_HID-sdp_record.xml		\
+	unit/sdp-xml/compute-seq-size-type-confusion.xml	\
 	unit/sdp-xml/qt-SerialPortSDPRecord.xml
 
 unit_tests += unit/test-avdtp
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
index 9af2f8c870f6..c8288ca10b8b 100644
--- a/unit/test-sdp-xml.c
+++ b/unit/test-sdp-xml.c
@@ -80,6 +80,8 @@ int main(int argc, char *argv[])
 
 	DEFINE_TEST("Bluetooth_HID-sdp_record.xml", TRUE);
 	DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE);
+	/* From https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34 */
+	DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE);
 
 	return tester_run();
 }
-- 
2.55.0

