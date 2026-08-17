Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2CD4B0497
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000453; cv=none; b=eJU6Tg3nMAIgDLRoQ48O1+gLofEZX+9pwFs9FMEhp9kljLxPCe1oYbdeQAzkmn34iy7e4Kinxr0alncj9WlZdr0818uTSYfRrdgEnHURyLHjyQI0rUAbJLhmr1hVOk/Df3vCik2LPF9XncCwsQb0XJU6XOTMroQNlhlpMy7lD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000453; c=relaxed/simple;
	bh=s7K/oyMv1+bwCy02AXHnGYsiDWmyxyHW+lrmRwG3rF8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OE4LwSVLD1qB9aPkNwDXE1jlycmh+X8UlSuBHR00PZlnw7TyuE5BEao0xn28fXtZwXWzFJ2A6A2p5ZNTrwJXTKEXD+8AriX3IsenioSi+zcZLgyqU3T2q3RTZc4S3gPM51aqPmQMYpQMuuPIrXBuGhQeiBaq21OuNPkbn4oGjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHPzrFuJ; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHPzrFuJ"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9696319e14dso1193691241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787000451; x=1787605251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4FYqOuvmrzFmBWGwwTVNSK7c34xUj8KSq7BDeBfPh2s=;
        b=HHPzrFuJTG2ajgAi4G5wFpLYNmjy5FdrtQZrxO19nujL+dEal38DpM3CevoFbcS3Bl
         OsJBQ6rf0+ATYs82Ag7McSq9HcH6EZUi0/DW+astph3Xm1xFKMCErAs80IHrXs2BFBpW
         GYDy1e+GAPkfDZquYkPNrCUYnZS/eFf/OUBHf5wGB2YijCX1kGzdt21ZghShInYpKwrf
         akFj2KldKnv30TCa/T+++jXyKHtmiLoSZXyEY8KVUHV0G8sEXTLQRxydMbhxgLbL3rKR
         Wd0/5t0/ubHWhTcMS0xe8tO5Kq7sK79OXFqiZL3jQCmE14Xb+QvxKUicwZe4nGaBzKRf
         hWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787000451; x=1787605251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4FYqOuvmrzFmBWGwwTVNSK7c34xUj8KSq7BDeBfPh2s=;
        b=jXFtYwCI/8rrDqMk84nuH+hrEJ/KcTxH6GNkcrzj1uWfC+MLMz8aKoH2MfYJds1txk
         8hzg++daFLOTSIuTgE+PqW+6pWnqlwkUvDzIFTbUbGLFoGIR1ozar/TVttIsXNiGNzuP
         S2U6vq1jEpRb4vYdXfONEf3CXcA/uPQZTozD/8zJDI8oMpozkKEWKFZ2/WBtek0ZvEPw
         EF4Uk5EAyC7KJde+PF7eUKjDSBpSGP92PTBZMd5OE9AUs91RpRhXVTKnZFgwZWRHQamw
         HR1OHTVAI8JcxBx+d0nbe2fpXg1wfLLAOEode2P+4KMXyUZhINRvzlp7dWfTxEX5oBAX
         V9jQ==
X-Gm-Message-State: AOJu0Yz6sPFjjArMcP4RFrmLJvzJzHtMEjq+K16oK4vemKjytIFIhrIA
	ivHI9MX1jR4M8G3arlFuhL7xObS8xeWNV/Mh4+buCL/4eZrWE26ovx0ahMW2J3hVnGmoaw==
X-Gm-Gg: AR+sD118rVaGBz8kFk6QSTtTTIR7PacXSisKDUIvgk99tS82b9/hpoY3HSVm/6Z76dW
	77xOGzzk2SCuKEFFmZzKQzbYVv5/wxHtg+jWawVn55Um3PlRzU/ARmzlrWSarbbs4fTtWBNLcIR
	DWu7uQLYeou2WvujYoQ53wBhryEVdymhTIaF0xtTU2OHCxEy3alf2xbuXN5X/83WCExnflmxHOG
	7jf4utM33/Wo6nmqm8Ya3VZNU3jjQHUdHcZ0yFWFw7jaxnD9cXRbmgqzRwNHjhqFs5erlnoX8SV
	A0o/p8CHp/Wwy6OVraGY4esYqKwWMAFdJmPu+cKHikaXvnhj0EFtQMiE9jKkBpfxltSLU3KrxSe
	HRRhGpHmTBxf/LcsZ/38KruFBMlnBhmAFFkoFuF7CoIaE0QurTgYPELcK3DqMAeA8ssl/qqP5yT
	HszLZ5rHxjXTn9MF3kEiq7pUu7Wys/HDfPQKx6JSXs2MYBt5yQTj5hOsasoGLkJcu8NS3Oyap8U
	47tTLs5mi63rFcxYONbiKiefVf68VZiR5dKRtt/i+r/Pt9y9r1/H5w=
X-Received: by 2002:a05:6102:3fa8:b0:740:2664:801b with SMTP id ada2fe7eead31-7747e101d7cmr683716137.11.1787000451246;
        Mon, 17 Aug 2026 14:00:51 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c2c29e934sm2121511241.3.2026.08.17.14.00.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:00:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] unit/test-sdp-xml: Add a test parsing alternates
Date: Mon, 17 Aug 2026 17:00:38 -0400
Message-ID: <20260817210038.1839617-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817210038.1839617-1-luiz.dentz@gmail.com>
References: <20260817210038.1839617-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

None of the existing records contain an <alternate>, so nothing covered
the SDP_ALT8, SDP_ALT16 and SDP_ALT32 handling.

Add a record with an alternate holding an integer, a string and a nested
sequence, which leaks its members under valgrind without the previous
sdp_data_free() fix.

Assisted-by: Claude:claude-opus-5
---
 Makefile.am                |  1 +
 unit/sdp-xml/alternate.xml | 12 ++++++++++++
 unit/test-sdp-xml.c        |  1 +
 3 files changed, 14 insertions(+)
 create mode 100644 unit/sdp-xml/alternate.xml

diff --git a/Makefile.am b/Makefile.am
index 3c6cf92ab403..2754e1b7f2da 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -648,6 +648,7 @@ unit_test_sdp_xml_CFLAGS = $(AM_CFLAGS) $(GLIB_CFLAGS) -DTOP_SRCDIR=\""$(srcdir)
 unit_test_sdp_xml_CPPFLAGS = -I$(srcdir)/lib
 
 EXTRA_DIST += unit/sdp-xml/Bluetooth_HID-sdp_record.xml		\
+	unit/sdp-xml/alternate.xml				\
 	unit/sdp-xml/compute-seq-size-type-confusion.xml	\
 	unit/sdp-xml/duplicate-attribute.xml			\
 	unit/sdp-xml/qt-SerialPortSDPRecord.xml
diff --git a/unit/sdp-xml/alternate.xml b/unit/sdp-xml/alternate.xml
new file mode 100644
index 000000000000..a35ebccbc71f
--- /dev/null
+++ b/unit/sdp-xml/alternate.xml
@@ -0,0 +1,12 @@
+<?xml version="1.0" encoding="UTF-8" ?>
+<record>
+	<attribute id="0x0004">
+		<alternate>
+			<uint32 value="0x11223344" />
+			<text value="alternate-member" />
+			<sequence>
+				<uint16 value="0x0100" />
+			</sequence>
+		</alternate>
+	</attribute>
+</record>
diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
index b338788aa295..cb5b91717fca 100644
--- a/unit/test-sdp-xml.c
+++ b/unit/test-sdp-xml.c
@@ -133,6 +133,7 @@ int main(int argc, char *argv[])
 	DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE);
 	/* From https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc */
 	DEFINE_TEST("duplicate-attribute.xml", TRUE);
+	DEFINE_TEST("alternate.xml", TRUE);
 
 	tester_add("/sequence_on_squared", &data,
 		   sequence_on_squared_setup,
-- 
2.54.0

