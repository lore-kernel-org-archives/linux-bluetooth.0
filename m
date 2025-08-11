Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF352D8791
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942341; cv=none; b=RIatup/Oe/SpCNwCq2hRnTvBAmLiqQ6OYDeWVrggs0tOl2mokp+t3E7tPDo9TTILuz//BR0K5KjhWXVTqZgsdgGywGmHGn6g8nxlqFuQQC66PKwoLqN4MHBPZEKBS0PnFPGm6nPORT0hvzAAJDhmXzRnnTVqXIt/PkuNV0LDQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942341; c=relaxed/simple;
	bh=dQF+SW+VbeQ+KxI4cFpQ8uairgzunSMUaRZa7JwuY7U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wsh20GrBpwqAOyQBxciQoA9ivpsKLlp3cdOi7G3f+D+4uL3WljJnV8Efj0ECFS2ZIQGBw1BZHHdAdVK0RapxIC1kTf9HiQieNSv9xYMdr1a8bZRinJLEZ82X5AjItO5TRSgYE8/WhMGB4Tt0aPx4PB94sfiEDU12DQTx9oijv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D29CC2059D
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:58:57 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] tools: Install btmgmt along with other tools
Date: Mon, 11 Aug 2025 21:53:48 +0200
Message-ID: <20250811195850.1775759-8-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250811195850.1775759-1-hadess@hadess.net>
References: <20250811195850.1775759-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeffeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepgfevvdefkefgheeifefftdegkeetfeeuveeuheeuhfffteevheetieevieffieevnecuffhomhgrihhnpehmvghsohhnrdgsuhhilhgunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

btmgmt is not installed by "make install", but it is useful for debugging•
some issues and to set the MAC address on HCIs which don't have their•
MAC address configured.
---
 tools/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/meson.build b/tools/meson.build
index 66156ab0224b..9ca76079325e 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -171,7 +171,8 @@ if get_option('tools').enabled()
   if readline_dep.found()
     executable('btmgmt',
       sources: [ 'btmgmt.c', '../src/uuid-helper.c', '../client/display.c', '../client/mgmt.c' ],
-      dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, readline_dep ]
+      dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep, readline_dep ],
+      install: true
     )
     executable('obex-client-tool',
       sources: [ 'obex-client-tool.c', gobex_sources, btio_sources ],
-- 
2.50.0

