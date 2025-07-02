Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF792F7CFD
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484377; cv=none; b=n1j3cuvkQxEjV976Z1EuE87xeBRgy3oNMRy/FU1F54TK3aLTea5hZ0iYUhsvDdUGnngSZwugRqA3M1epjtT+F6oIakl3Omza6hJ3PuPkyoqAcLN0OVmWU6zdAkDqmizAbmo7JpV56qX59ZQI4x6gjIaTHBl+GKHjGNR/A9I6bq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484377; c=relaxed/simple;
	bh=Tdvas4OpeAgZ1cTOALymDlrj2F/3rJhLcUniW0TZdNc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XKiHFvBL3q96JnGsolXhsI+bs/vfdn7roNzTc4aXdcmSN8ZP+xpUYKFr7QLIs3th3TtYsG7L0gehkCfDnmcwu9dICV2y8Vk7MkvfYYTpSsg56BBW/Fsljq9LVRMMNXOosbQHIOyys01ssLMPOVEypN/AvlnOH44PCgtMNN0RtC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Baob1uuQ; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Baob1uuQ"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-88173565536so133951241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751484373; x=1752089173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CVduHayMJEdgNegyfnABaqCXn0WhHoQLGwvHR4ZsVD0=;
        b=Baob1uuQZaJCGz+pAmnwOekYouTM9XdqhVp/+PAsKabTAv5PQbsFC6mNsMurjv16GI
         CKQex9whLeA1HShNn1a8I95e3yyHSw54G4xTRJoFDntNOqwcyCC+5KcpihAxUof1ct85
         OYmPXdCxNrZ+PYC54lNRJI2AJ1Vnzm1Dblj228oun7/ojEG2te+dTFlFdt6jbIFSi9yV
         l2Oe5aPBXqP+B4tXHjsjzZO3IPR4grHL8KmJn3sdWjkOT09vzLFEdFDp90uTM3kworNm
         0OorLNfJfqQjjjPAXyLlkJ681EevIMC5T49Mp5gJv3zX87VCD0jzZQ63Xiv7hb3JcoPs
         KqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751484373; x=1752089173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVduHayMJEdgNegyfnABaqCXn0WhHoQLGwvHR4ZsVD0=;
        b=hRgam5tu6iR0Cxn2Klzyp7wNkzgD/Qt4nlOrMRaU3Xs/cpxsVukf1PicpcRQuPNtzA
         jRaHlcRPsLhOuND8z77EaTZWc8mYeY7VJj70DtXgTr95HMdQUeURCjPpm+AojfBeCYkr
         k1atv5STgnZtktTtndSGCCgq2lRSYNcSA30+f/wEbAx0FU3+vXXIE3OAm9igNEIrxUs7
         C2fjrMKVWrw7FK+iKDwwXxitdr8ON11dwc084VULshVzZzI+eIW4JQnTK8TCMERi0ElI
         ny3dUSIxKC64IZpjKEsbjA7LsNas//KG2wyvlPuG4tpah/TbicmOh1XKEQY/Xo3zoJjd
         MSmg==
X-Gm-Message-State: AOJu0YyW17TUCbmQX7zpxqGx02FSEGh2bpovsTi5UOBL0hEoSOSq9I1T
	QwIo0KoGluimXPsGR9bsE7N9KFQhQAZc2wh+n0JifmyDUr02OAw0wUjDK5h61VLjKe0=
X-Gm-Gg: ASbGncuqSEDfO2G/PEYbsJcBnGFRNITHYOpSZ9RpzwSXN846hkv/npar+DFBXjqzeTU
	lHDT36KLNOTnjcWfZz3c0U8k5mpSfuAFiOKqYYFOIDjwBqxzgSuwyumwIfkP/PhgumGa+73sLzb
	Hnx2Erd8Uzw3ki8FLIYD1cYTnO9btTDyykwESR9P9vVmwbpUTCDxFrtXdnLZdHw7qV2x/kAvGre
	8KgvpEBjDXBC0dQiUob0KzB8wwlVlV4Gv4X7W2w3AITVeuDeAVwJr8U5k09sSaLzmAKzEFzztkh
	pxb8kkWE014GaVtdTq7EpD6d7Lzxp8kW0vord8KXiqUAFDvr1y3qX2HBd9H7a+wh25BBcUkv9WF
	NVp2dRlLFQdRN2+/1elKcPXkVKW5Z/jU=
X-Google-Smtp-Source: AGHT+IGMPtXlS7nf2h4ChXGt3P/KKzvkgL0i9NK9CSeaHv6sRj4e6/VzLUwEuw6mlua4ebdOZUU5sA==
X-Received: by 2002:a05:6122:469b:b0:52d:cc6f:81a2 with SMTP id 71dfb90a1353d-5346603b2ffmr973357e0c.6.1751484373437;
        Wed, 02 Jul 2025 12:26:13 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5330924154esm2228019e0c.48.2025.07.02.12.26.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 12:26:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] unit: Remove dependencies to android
Date: Wed,  2 Jul 2025 15:26:08 -0400
Message-ID: <20250702192610.1547665-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add copies of android specific dependencies used by unit testing.
---
 Makefile.am                   | 8 ++++----
 {android => unit}/avctp.c     | 0
 {android => unit}/avctp.h     | 0
 {android => unit}/avdtp.c     | 0
 {android => unit}/avdtp.h     | 0
 {android => unit}/avrcp-lib.c | 0
 {android => unit}/avrcp-lib.h | 0
 {android => unit}/avrcp.c     | 0
 {android => unit}/avrcp.h     | 0
 9 files changed, 4 insertions(+), 4 deletions(-)
 copy {android => unit}/avctp.c (100%)
 copy {android => unit}/avctp.h (100%)
 copy {android => unit}/avdtp.c (100%)
 copy {android => unit}/avdtp.h (100%)
 copy {android => unit}/avrcp-lib.c (100%)
 copy {android => unit}/avrcp-lib.h (100%)
 copy {android => unit}/avrcp.c (100%)
 copy {android => unit}/avrcp.h (100%)

diff --git a/Makefile.am b/Makefile.am
index 02ad23cf2d46..0f5790adcc57 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -583,22 +583,22 @@ unit_tests += unit/test-avdtp
 
 unit_test_avdtp_SOURCES = unit/test-avdtp.c \
 				src/log.h src/log.c \
-				android/avdtp.c android/avdtp.h
+				unit/avdtp.c unit/avdtp.h
 unit_test_avdtp_LDADD = src/libshared-glib.la $(GLIB_LIBS)
 
 unit_tests += unit/test-avctp
 
 unit_test_avctp_SOURCES = unit/test-avctp.c \
 				src/log.h src/log.c \
-				android/avctp.c android/avctp.h
+				unit/avctp.c unit/avctp.h
 unit_test_avctp_LDADD = src/libshared-glib.la $(GLIB_LIBS)
 
 unit_tests += unit/test-avrcp
 
 unit_test_avrcp_SOURCES = unit/test-avrcp.c \
 				src/log.h src/log.c \
-				android/avctp.c android/avctp.h \
-				android/avrcp-lib.c android/avrcp-lib.h
+				unit/avctp.c unit/avctp.h \
+				unit/avrcp-lib.c unit/avrcp-lib.h
 unit_test_avrcp_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
diff --git a/android/avctp.c b/unit/avctp.c
similarity index 100%
copy from android/avctp.c
copy to unit/avctp.c
diff --git a/android/avctp.h b/unit/avctp.h
similarity index 100%
copy from android/avctp.h
copy to unit/avctp.h
diff --git a/android/avdtp.c b/unit/avdtp.c
similarity index 100%
copy from android/avdtp.c
copy to unit/avdtp.c
diff --git a/android/avdtp.h b/unit/avdtp.h
similarity index 100%
copy from android/avdtp.h
copy to unit/avdtp.h
diff --git a/android/avrcp-lib.c b/unit/avrcp-lib.c
similarity index 100%
copy from android/avrcp-lib.c
copy to unit/avrcp-lib.c
diff --git a/android/avrcp-lib.h b/unit/avrcp-lib.h
similarity index 100%
copy from android/avrcp-lib.h
copy to unit/avrcp-lib.h
diff --git a/android/avrcp.c b/unit/avrcp.c
similarity index 100%
copy from android/avrcp.c
copy to unit/avrcp.c
diff --git a/android/avrcp.h b/unit/avrcp.h
similarity index 100%
copy from android/avrcp.h
copy to unit/avrcp.h
-- 
2.49.0

