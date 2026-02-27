Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227F3EFD34
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191762; cv=none; b=jxByfnhPX3TCb7XflFJUnEmYULr3utAVfWgResxF/WdGO3rjtt5uCYI6MKzKdq3XXXAg45CH1JFIzBC4emmiTt6THFg2I+weIGlovbIe4Mj/6FNe+nqvNV2y4PSRvFRGNhSso1bfgRWE5mUcw+NR9x4NjHASSOZjm6Zcz/LVTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191762; c=relaxed/simple;
	bh=2eh/7FxtbZNCk3td+up9MB2TjMm//7saPQYgYlhx4Z8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGc31cXADvLqUyTQAQnbUKIKpHpJFPCfOAL/ZANUA9rmQN36lCXqH+RA29RGn10MTLo74pBi+zbcdQjtxEURoNJT4D/UeEUnuvWZiOR0V7/7WHnrCu+rBE56CKhm8sy7l9JKchWwfDb0+XQmw+EQ0Oe6IGCEAQSpuqPBjbEjJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8652F4333F
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 11:29:09 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] tools: Work-around broken stdin handling in home-made mainloop
Date: Fri, 27 Feb 2026 12:27:18 +0100
Message-ID: <20260227112900.1946851-3-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227112900.1946851-1-hadess@hadess.net>
References: <20260227112900.1946851-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpedufffhffegveeijeekgfefvdetieekjeduhfelheettdehudfhjeevgeelvdejjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepkeeihedvhfegfeeffefhpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean

bluetoothd has 3 mainloop implementations, one relying on ell, one
relying on glib, and another home-made.

The home-made mainloop handler use epoll() without any fallbacks, and
will hang if one tries to epoll() an stdin that redirects from
/dev/null.

Closes: https://github.com/bluez/bluez/issues/700
---
 Makefile.tools | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 589f7c94f9df..7c52e053ffee 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -531,8 +531,8 @@ tools_obexctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 
 tools_btmgmt_SOURCES = tools/btmgmt.c src/uuid-helper.c client/display.c \
 			client/mgmt.c
-tools_btmgmt_LDADD = lib/libbluetooth-internal.la src/libshared-mainloop.la \
-				-lreadline
+tools_btmgmt_LDADD = lib/libbluetooth-internal.la src/libshared-glib.la \
+				$(GLIB_LIBS) -lreadline
 if DEPRECATED
 noinst_PROGRAMS += attrib/gatttool
 
-- 
2.53.0

