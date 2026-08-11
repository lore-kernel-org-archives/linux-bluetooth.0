Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31551391E7A
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461029; cv=none; b=TgV3+SDmXV8boH2WkImtjmoMWWyRRZjgZRfMWHcVHAFBC+LiKHmjgCt2MebKeSBLAj9c/GBuZfPuWeMPaemvIm2SZk1RmIh9WanrAYk7qypx/QTB61IfK4goj0/ex/ZJQCvch1XO6TKSntOABwoppdaLZh7jUVzWVUWSfkwZeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461029; c=relaxed/simple;
	bh=AU9nVYbWh+X1QIkRZ6QL5kkPpa8cs083kuakoxR4MUs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lbqb5OfwJJZHkc4fPLTXsOQo+qB+1ATB83pf88Xn55gK2B6x4lq+Up53C5C4vFtUoFJvHpWurauvTjtT2vQbJtfGWF75+AvG2TU6GrefW0XeKCgRgLWLp0NK/iXGG56FKpUQULATVogf4oT29xDhvNFzRCqJw5etc0ip5/mBd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 865625816A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:20 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 682523ECBE
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:13 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 0/9] 3 SDP XML security fixes
Date: Tue, 11 Aug 2026 16:54:03 +0200
Message-ID: <20260811145704.1766949-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTEu6jdyCTbz966vb0ec2guDXiri/9SmtppMxZ7n7AfbOpiW/Ro57dwQ3qt5FLUOPiy5O2Y+8YP3sJ3YKS2WQJhB/rwCFMjbh367LBooiGKIvFH45PEuqw1mn2f3WN08N2LwPmbqVT5eVFIDCTuBwGrmK+DoFiwEOvGVG/dYj/x8tJJLjQHlcsyX/pNiKvPIzc0pwpdx/+/Dv2qyfpcN38sFhsaLB6wvQOkR0C4Ee3O4yRM/2HB6xyxwF6esR4SL2XkP5lc3bVq//1OAhVNP/h/NahmcQeEkn8ndsCET+HqIHM6QpBeez9112kQkDBpasQ7n4ALfEGqKvGG6d2SdfI+/EnrbQDHrAjTD/u1kCQLbwkZIfL1zUOBq0Rv8biadrbLV11RmTKq2ho4D+PdVLpgFP7qGtNux2XARcU3bi2/VT28ksaTvL2p3VyVWynheeiL592ZAXYvcc7n2p1feaXkorGE1HBdaLb5dA1iYVeaBRZ/sI3TFogUGU9OEkvlQTYpDzx+j8ANgdRtVlM0HatGLQDvXQhl3/xp9JzGHkUm8kEWWLLX0/QxHUWGTkgHzy1hc/fHEt8FdmDrGRkftNfr2CImnjJeMTtyi7ccgB5apBbWtQUvUg/LYpjCl1V/yxYTWK9s8+/j9fpl39MTHp2pFCg+bmc9rLXOtfxIRjeZiFA
X-GND-State: clean

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

 Makefile.am                                   |  10 ++
 src/sdp-xml.c                                 |  55 ++++++-
 unit/sdp-xml/Bluetooth_HID-sdp_record.xml     | 123 ++++++++++++++++
 .../compute-seq-size-type-confusion.xml       |   9 ++
 unit/sdp-xml/duplicate-attribute.xml          |   4 +
 unit/sdp-xml/qt-SerialPortSDPRecord.xml       |  57 +++++++
 unit/test-sdp-xml.c                           | 139 ++++++++++++++++++
 7 files changed, 390 insertions(+), 7 deletions(-)
 create mode 100644 unit/sdp-xml/Bluetooth_HID-sdp_record.xml
 create mode 100644 unit/sdp-xml/compute-seq-size-type-confusion.xml
 create mode 100644 unit/sdp-xml/duplicate-attribute.xml
 create mode 100644 unit/sdp-xml/qt-SerialPortSDPRecord.xml
 create mode 100644 unit/test-sdp-xml.c

-- 
2.55.0

