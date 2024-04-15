Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F74E1D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174302; cv=none; b=LHNXWeadNAP+NIfjSw77pgCLZ68f9lR1l4LcxNLajQM0iVTMgXx0pOzQOFmRQW9rbH2c43nQBk4qKO6MvlR+Hd5fkjvDzhuKbUuCfxT4QDVYqS5urCr/nXzWPJh7B0Ul6IAdhqRNEqahKw23Pa2YD+nPd8/ZyCfG1kQaXBTT4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174302; c=relaxed/simple;
	bh=RV3PLP1lUN/DEj7hsNzxhzYAic48eSzloEooL+DFT8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hq6lKigZdEm34V//MgA49qR0NYrm6Jd69RaJtgDzsNsOlfUoOVAPq++5cXZkwMQnkOfb+pp0YZI2vDvZizIJgn3WpGDqMQvTtztn9MmWnkZBFJZnScCBmDJhqS4ojqltdX+/G+LBmC0y6+ZAQs/oAy+XRd8pXBs6yjeQqAnvRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AVLS4tLy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ktbLvylz; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AVLS4tLy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ktbLvylz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id A1B5718000FF;
	Mon, 15 Apr 2024 05:44:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Apr 2024 05:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1713174299; x=1713260699; bh=m0Ck6IMqNZcjwbD12su6k
	qAlAx79t3rG0VyxaFTxXCM=; b=AVLS4tLyjsU+AayB1GZ/naPfAvpq/gLpliD90
	Zju7ZZASJjfwSY+xGVlBV2pObELa4h8KAMTp6ZM3VJLAFVc1j3BUyo8b5oHs3WqK
	7BsSPBq1I4YdQKyC8PXqRoNUaQplV5EV9brkLRYz5K2nQgyGL2D0jYRIfhyAsQPN
	G4uNT5A4XHE/oZJDU6ZrAc442ErNNsCEhz1g7ixxFVTZpmEutIhyQxmO1LVWBcXD
	ko3yiGNAzktnTaYvdFtlWhsPJ6jCTC2GJ2pdRfoGwA7PCe93LRESksNRucOk+GDa
	fiPgG9+7WIlmJ2nodX6dm2E1CtKFGkHJF6fjq4uHUdSxuIMbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713174299; x=1713260699; bh=m0Ck6IMqNZcjwbD12su6kqAlAx79
	t3rG0VyxaFTxXCM=; b=ktbLvylzfcrSbItyZp0tod+2RaQyzuwXuoF4asenoK3c
	Huv3yhuF+TnzVpNuTYDAc6dsT6wc1fZk5O5O+p0cm3/AU6YBuVj7e8vX0fzUXui7
	DhE7cQ/WgUYbsdmzM6h9NcKw0RrDO7DyOoeSH6Aa3G79lEBkiov0VFT7XLjjtvAs
	rXxq6+8G9h/5wGGafku34+MgEqpBi+sJGVFpPu9qvZ3OEllguoPmvQancAYSCHBv
	IUXHYcq0dxP8VuAfoNo0Lm8XsyY2J+e5i98OcmMTFPfOtrQJHcEdrxaMzmCU4+i+
	LRRhSTE/IQe2OR98IHeiTpj87f+ChXkw/nH2t41tuA==
X-ME-Sender: <xms:G_ccZqtVnfmPSQGnHjEMj9CxA7I-lRX3XDToI7gzDufZXuZCguza9g>
    <xme:G_ccZvc3jy7amvSToIWEpCwHmbLE0Khl-1isaC9QMVTnGtiDDVTrFEHs3Kd0UeW4s
    2VT6NHg8J-ZOSLV6g>
X-ME-Received: <xmr:G_ccZlwWV0AIlc7eLAPusuJ0tSTNl7KhcZJrjK4SKYppztO1AXP9PjFKp57BgbocxvwyXSfknzZxfkRAqXSbxo7-tgnXAZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflrghnucfrrghluhhsuceojhhprghluhhssehfrghsthhmrghi
    lhdrtghomheqnecuggftrfgrthhtvghrnhephfekvddvgeekhfejudeiveeuiefhudekhe
    ejhfelheduhffhleeggfettdetuedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepjhhprghluhhssehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:G_ccZlOZ3kw28rZXznYsxyFfGyU2tq44EeBxVbJBKuZ7pt2I5izaHw>
    <xmx:G_ccZq-eT0f5rlkAaQMh3lEX1R-xuPNGvmPfEMiW1d6uqyV7EjdJ4g>
    <xmx:G_ccZtVmsnHdHYG0twDZPbo5mAb8FCi5NUrLLdkHkM85yGXaBRa34A>
    <xmx:G_ccZje4UqZgGY7LDr52bM629et9xiwRGJbNMR6xVGDLmv_s-vj4WQ>
    <xmx:G_ccZsIy6AENcVTZp-pukihdY_ZY7m_yqI-U7ipGv_n3usHaa_DQUF_E>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 05:44:58 -0400 (EDT)
From: Jan Palus <jpalus@fastmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jan Palus <jpalus@fastmail.com>
Subject: [PATCH BlueZ] build: list new tools/tester.h header in sources
Date: Mon, 15 Apr 2024 11:44:40 +0200
Message-ID: <20240415094440.5820-1-jpalus@fastmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix dist tarballs missing the header
---
 Makefile.tools | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 27a753762..679c914bf 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -135,7 +135,7 @@ tools_mesh_tester_SOURCES = tools/mesh-tester.c monitor/bt.h \
 tools_mesh_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
-tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
+tools_l2cap_tester_SOURCES = tools/l2cap-tester.c tools/tester.h monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
 				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
@@ -182,7 +182,7 @@ tools_gap_tester_LDADD =  lib/libbluetooth-internal.la \
 				src/libshared-glib.la \
 				$(GLIB_LIBS) $(DBUS_LIBS)
 
-tools_sco_tester_SOURCES = tools/sco-tester.c monitor/bt.h \
+tools_sco_tester_SOURCES = tools/sco-tester.c tools/tester.h monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
 				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
@@ -203,7 +203,7 @@ tools_userchan_tester_SOURCES = tools/userchan-tester.c monitor/bt.h \
 tools_userchan_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
-tools_iso_tester_SOURCES = tools/iso-tester.c monitor/bt.h \
+tools_iso_tester_SOURCES = tools/iso-tester.c tools/tester.h monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
 				emulator/vhci.h emulator/vhci.c \
 				emulator/btdev.h emulator/btdev.c \
-- 
2.44.0

