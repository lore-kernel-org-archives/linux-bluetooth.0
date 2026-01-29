Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01B3876AD
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769691605; cv=none; b=SMVTXC356Fugk5ZCbCywf+R5w5F8Hh7Jmb2ipEDIlzYjb0D0jMi/yEV1nENpeg4CTGRLNwnw93jns7ikIy4ZtCQhprN5C57p2D/Gh4Sn+kFaha9vZAOJMED5np29N2aaT0CrBBf3iH1eCVHdeYM+eN8lVAkGVbOvov8BkJgCo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769691605; c=relaxed/simple;
	bh=279qr8gaOUtHuE7pyUtIgXWgjuscKi2zxcfi6yyU+6k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=suJLvP85/GLwpetL5Bb709Dlph0Sd1cwXMMqQHLytzSAP/+P0IWWqmZHnyJv++Zdm0/aduazHHFjGEgO52dkLWKxT2m5c4nGqtRLKdc1xK8DFcsYvbmeGZJL4aj6JBZRO3vP7Ty50UW7hjFnv325kAoa9udKdDZWjfCDIaJaKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CE5D43285
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 12:59:56 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/1] build: Don't install btmgmt man page as tool isn't
Date: Thu, 29 Jan 2026 13:57:01 +0100
Message-ID: <20260129125948.2724071-1-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeivdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffleeuffejvdeufeffvdejjedvheekgfeltdejhfeitdettefgjedvuedvhfejueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeivefgheffgeefvdekhedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean

As discussed in "[PATCH BlueZ v6 10/20] tools: Install btmgmt along with
other tools".

I have a similar patch for meson, not sure whether you would prefer it
integrated in the existing meson patchset (which would require more
rebase work) or as a fix afterwards.

I double-checked that both btmgmt.rst and the generated btmgmt.1 end up
in the distcheck, and btmgmt.1 isn't installed.

Bastien Nocera (1):
  build: Don't install btmgmt man page as tool isn't

 Makefile.tools | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.52.0

