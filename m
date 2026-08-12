Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB33C4577
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521870; cv=none; b=Fd8i1GAfec32F5qeMwHd0Em0dmVNEv9nLLfyw5Mt4XSg793z5+7YHkywEGFXZ3YqXy9wJWIkk/dXoOV7EBEpgQoHL0cxKAml0xM9vzP8pdbHJ1lVhYTSzKywfITdv5zHy3oxCoT+NR9P+ne2G7iyUnDRMBqnGMK0DhjOeQeGiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521870; c=relaxed/simple;
	bh=pkET7enYgWp0OBLQyF+ZV/y1VOj/26eYQLA5ga8chAU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUk7b2sycuLc9U5GK/JSvFlyAdOwJhV6rP+tCrcVxhYMUwsuzNSJCq/ZoX2ZXMVGwNXhqWVYRp01tnG7pI12E2PcUV2mPZZ/zFG1izm0+wOdzX3BzTr/Vsn9bMwIgwJVplB2gn23iokT1BIylMx6rus1hOJttOcvESOOjRCg89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AFFF43EE65
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v4 5/9] unit: Add test for sdp-xml duplicate attribute bug
Date: Wed, 12 Aug 2026 10:01:36 +0200
Message-ID: <20260812080410.2116906-6-hadess@hadess.net>
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
X-GND-Cause: dmFkZTEATMgZESnXpnF9odixN+j9pjFJQtDJ1lOhKFVo5Z/nUe0V4kv8/975cH/jEC+64/687m2yeqptp72V8V+Fn9K7g/HOIo1s/A9vRcgAydT3FnC79LRZiaW2AsRMtWp8LHcLMk8RcFDZX+r73gvBiN0XAE69n/K+cGPfKTwfhuW4u+6P6l14AuHgA/JCsdUHL9YAy7vZyMQgTf4Y9kDKFjf6ZpkPzEK1NNr+QOxeLPriprXbk5OoT4J/7DzuhFaA2uT7ogxycD/0WB/G3uqVtCR3ahE9Xg872i09EVeEPn7oX7BCDVBYVDLUT70+1UfOo+2x9MExJKd0WKIq1ANYXqkcpduEp6qqYH2Jyii8OlVVF1gcolr+qOX6U0i68kG/8yMTyNjW4nGIzYWDpKtJBCX3fdY9SlfujZsNaUgAQ9BYHfMK8BoFG4x3vbsa2tfv2CO3W1Ym4LWszW+neU17IvmjbSkoo85zEZ78vt3rrTKe2vrlwGqL1ojL7M2W9QkewzmRjzgFKevKn+bu4GHY9E/bJ2/fkOIjlPG5QVdQEOVzZjIsqZfnW/gElUJhMhdkbWQl9KHFNGnvOJK9RaHaDr4EyeHNDOoptq3LLz0K5QlBrcjo4xm1ax2POmkHD8S0BGjdXLUVriiDuK++96uBQjArNjEGIjS0rgCGuozItaMeBg
X-GND-State: clean

See https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc

Co-authored-by: Aisle Research
---
 Makefile.am                          | 1 +
 unit/sdp-xml/duplicate-attribute.xml | 4 ++++
 unit/test-sdp-xml.c                  | 2 ++
 3 files changed, 7 insertions(+)
 create mode 100644 unit/sdp-xml/duplicate-attribute.xml

diff --git a/Makefile.am b/Makefile.am
index 1d5f02b0d362..3c6cf92ab403 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -649,6 +649,7 @@ unit_test_sdp_xml_CPPFLAGS = -I$(srcdir)/lib
 
 EXTRA_DIST += unit/sdp-xml/Bluetooth_HID-sdp_record.xml		\
 	unit/sdp-xml/compute-seq-size-type-confusion.xml	\
+	unit/sdp-xml/duplicate-attribute.xml			\
 	unit/sdp-xml/qt-SerialPortSDPRecord.xml
 
 unit_tests += unit/test-avdtp
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
index c8288ca10b8b..9bf35235423b 100644
--- a/unit/test-sdp-xml.c
+++ b/unit/test-sdp-xml.c
@@ -82,6 +82,8 @@ int main(int argc, char *argv[])
 	DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE);
 	/* From https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34 */
 	DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE);
+	/* From https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc */
+	DEFINE_TEST("duplicate-attribute.xml", TRUE);
 
 	return tester_run();
 }
-- 
2.55.0

