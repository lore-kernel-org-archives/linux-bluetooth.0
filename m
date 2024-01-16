Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C101BDF1
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3lR0g0R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B12B3C433F1;
	Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705414737;
	bh=Drk706czIQB74tZtjIszLCoLbItr0C4ypGp+yRwcxvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L3lR0g0RS5qD3+uk+eND/+g6O35YEZAo8YopmL2bLrGkME5fB8cu3MKU02TBqhQl0
	 ngYHB2pNwwgBPMjRiXtAITpnThiNdmCMbYoVnvU6Mg1pOALHm6swz+UCtBXom5c4Dv
	 8B0as0ekPAA4l3ExHd4BPTs0DB0MGdKiY/+3x3ZGvTbo8nSLJH4bYE6BGEtuh2jP7O
	 ft+tDkuLqI4Vqrd9Ra2D7gDrwyV1nQwAhvPO7xPozf8GRkVTm0DPZVAEU8/fKyMvrG
	 YA6aD+j6WvAzl5K+zO0Bl1Ufhd+qMtAssYCVFFsIF2Au4tnJbvcGK/dDQGXBExxgD5
	 IOJ6GxMxR9cQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC78C47DA9;
	Tue, 16 Jan 2024 14:18:57 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 14:18:54 +0000
Subject: [PATCH BlueZ 2/8] build: don't export internal obexd API
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-rm-ext-plugins-v1-2-62990fb07369@gmail.com>
References: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
In-Reply-To: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705414735; l=827;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=T0AIHHzKyS8F70Lq7NH7HmKSqGQUdU/5YvZARVJoz4Y=;
 b=cVZdkWcGGy4IlRdvrra7YNOAuxpwA6tftTtQ53iUl2NFvD9xVbg4GPVBnzgpy7ny/HzZq1It8
 KGGsoW9Ef5HCl8qdT6fqMp8Pbwdi+a0rD4VM/QrOeNF0WzLX/ZAQJZT
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

Unlike bluetoothd, obexd does not support external plugins. As such it
should not export any functions. If that ever change and plugins do
emerge, the symbols should be controlled via a version script.
---
 Makefile.obexd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 2774f3aec..4e473d50b 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -84,7 +84,7 @@ obexd_src_obexd_LDADD = lib/libbluetooth-internal.la \
 			$(ICAL_LIBS) $(DBUS_LIBS) $(LIBEBOOK_LIBS) \
 			$(LIBEDATASERVER_LIBS) $(GLIB_LIBS) -ldl
 
-obexd_src_obexd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic
+obexd_src_obexd_LDFLAGS = $(AM_LDFLAGS)
 
 obexd_src_obexd_CPPFLAGS = $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS) \
 				$(ICAL_CFLAGS) -D_FILE_OFFSET_BITS=64 \

-- 
2.43.0

