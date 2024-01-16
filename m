Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449A41BF26
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox0XJKeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3ADCC43143;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413118;
	bh=xIKRvutDfGrk64nQV8LGv/L07p9HoubFZiadhFozn28=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ox0XJKeJ+JDZa5Xsf7sKW3nYPx2cCBlctJCD7/gm8TcqB+EE6U00QlsnZjhXoTwUW
	 Aj5Fo+u1kupiSsg63+ASgk+qUqeBLR7savFCQ9IRA3NVLjLkU0IbNCAjYc6YF8iX2q
	 1iRFoje1bnO9CWtXgMkz5rLLbLoCdHskdJ1Acy1R8oiAm8b7Cgy6xD/E77LNfNSh+M
	 T6i0uFqi4fHxq0Q6ftZ5VDguoAXZ6jGR9ppKQEPS9t1yda7IrdbRULJWE0V3wZNeKW
	 cTp3sJcuYBxEUQ7bXtZvo9q4N642QHLUIesvosfGkScRSsTPsgK1GYczc9Y3Uzr11C
	 uGSn3AcO0LayQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91634C47DAC;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 13:51:59 +0000
Subject: [PATCH BlueZ 05/10] build: remove unused variable builtin_nodist
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-autofoo-v1-5-626f6b54bd06@gmail.com>
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
In-Reply-To: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413116; l=721;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=1rROEGp9NOWMlEicl4MnpoSQNRD9hD+pCI8aDd5Iw2Y=;
 b=6jtaeZ6PO/Q9YbEwDcmhoxjfYFo0I1NkXk0OaOcsnq4hzzT1mYAgRHMErs2ozaGoGUvadEUbF
 /OQSpMQba1kCv9RFKEWeiuhh3tfrzReStoPvq40JPvAWx+1Zl4sGwyf
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

---
 Makefile.am | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 16d6bf160..564f1b935 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -282,7 +282,6 @@ gobex_sources = gobex/gobex.h gobex/gobex.c \
 builtin_modules =
 builtin_sources =
 builtin_cppflags =
-builtin_nodist =
 builtin_ldadd =
 
 include Makefile.plugins
@@ -344,7 +343,7 @@ src_bluetoothd_CPPFLAGS = $(AM_CPPFLAGS) -DBLUETOOTH_PLUGIN_BUILTIN \
 					$(BACKTRACE_CFLAGS) $(builtin_cppflags)
 src_bluetoothd_SHORTNAME = bluetoothd
 
-builtin_files = src/builtin.h $(builtin_nodist)
+builtin_files = src/builtin.h
 
 nodist_src_bluetoothd_SOURCES = $(builtin_files)
 

-- 
2.43.0

