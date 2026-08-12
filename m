Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3543C3F4A
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521868; cv=none; b=jMdcHOa8sOnKQ6DDWHQabrKRHEYWBUBV+w8wQObvfIh/JiXg8uaIAP0S5aL+VmpX9ZOA8QPEqYPaKjjIcY7E7qZNo/Uve9+YKQKqrjmAkbV+EZHvAgbRqjWRN2s8V/bWN2LaUVFiQvVVk6CG7yzo1OIXsh4lRmycimqAm6JMqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521868; c=relaxed/simple;
	bh=S6xdLvefL+oxjRXpAYbcQ+ROUGt1pXxNnOh+XTftjV4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=I4F00a85ZUN+DW53jzBISnwl31/i8U4nozasUF9lrO5ZgDFTAJHMSHeVSct5jiHyGlCDyO7H6IbtrF8p0XNImBqhN8h4dmLZcJbLfdtCtUT8XluZXG9yPOjHoi7Umy2rHWxEl+pMMVjMNi7eYytbphpe48qNok8VH3rjo3VFUNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93F033EE55
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:18 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v4 0/9] 3 SDP XML security fixes
Date: Wed, 12 Aug 2026 10:01:31 +0200
Message-ID: <20260812080410.2116906-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTGAMCHi6vuE1VJasxFZzehowbaYPHotOtA3Bv4NINeZ9haZzFypQAmdM+uscp5nKL202x76npdS2TOYVaKIJ82gXfwLn/ybAy4SxuJg5b8j06v5VBZcOMuzHFOgjJfMblTrcV+c7R+itb0EcTI1FjrEHbXTO/wc2AidY8kxBRzZUp//ZgHVsDvlDKmFrPJqE0Iom2bEs7TRibR5Bsi3kviKkByg2LM0bpRr0pUY2kTsxHmC239ew5Vg03nPnegEwSkfi6u2vvTyjnl/o5AIeNgU5BBE5nxK9uLxEKPqGozUhleNU4JxkXOH/sL0qQ0ttcQyTmEYvSAyvnc27fYYdMT7C5mY9qKB5sPl7fE+ZXkYmeRFyuKFbahl/W/+KB4veiD1xxd8UlJwEJ628rc6Vc2bYG+9i+UPmXyo54FpY4Y8ulTx3bilTy9zzYyREQmCk5BTI1h+jvV4yyErDfht1ZQ91/9r540HELr8oXQZuk++TsoCGDDsYvTmEhwuGhQEnd10hbrB/JbfEt4yfPEMCx5csyw9r7UUkA8oncdf6Tpakfu8sjjBVhlgRM+kehm2TV2My15zc5DmbCCqzJ9Tmzil0P2VRPQKo3gdEFalCst81D6hjeWsHq02vf7jYSkuS8SlYCliFkSTDjI+HqbAQkXF2KD9YQe4glTdX5xyBi6Nmw
X-GND-State: clean

Changes since v3:
- Fixed some "line length exceeds 80 columns" warnings
- Fixed "macros should not use a trailing semicolon" warnings
- Fixed "Missing a blank line after declarations" warning
- Fixed distcheck

Changes since v2:
- Reorder commits so that unit tests are added after the fix, so as
  not to break "git bisect"
- Add "Fix stack overflow when converting large sequences to XML" patch
- Fix crash in unit test when test files are missing

Changes since v1:
- Added "Fix memory leak when adding duplicate attributes"

Bastien Nocera (9):
  unit: Add test for sdp_xml_parse_record()
  sdp-xml: Fix crash caused by type confusion when parsing crafted SDP
    XML
  unit: Add test for sdp-xml type-confusion bug
  sdp-xml: Fix memory leak when adding duplicate attributes
  unit: Add test for sdp-xml duplicate attribute bug
  sdp-xml: Optimise parsing large sequences
  unit: Add test for slow element_end() append
  sdp-xml: Fix stack overflow when converting large sequences to XML
  unit: Add convert_sdp_record_to_xml() to SDP XML testing

 Makefile.am                                   |  15 ++
 src/sdp-xml.c                                 |  61 +++++++-
 unit/sdp-xml/Bluetooth_HID-sdp_record.xml     | 123 +++++++++++++++
 .../compute-seq-size-type-confusion.xml       |   9 ++
 unit/sdp-xml/duplicate-attribute.xml          |   4 +
 unit/sdp-xml/qt-SerialPortSDPRecord.xml       |  57 +++++++
 unit/test-sdp-xml.c                           | 143 ++++++++++++++++++
 7 files changed, 404 insertions(+), 8 deletions(-)
 create mode 100644 unit/sdp-xml/Bluetooth_HID-sdp_record.xml
 create mode 100644 unit/sdp-xml/compute-seq-size-type-confusion.xml
 create mode 100644 unit/sdp-xml/duplicate-attribute.xml
 create mode 100644 unit/sdp-xml/qt-SerialPortSDPRecord.xml
 create mode 100644 unit/test-sdp-xml.c

-- 
2.55.0

