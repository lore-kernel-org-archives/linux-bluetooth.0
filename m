Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B61BF23
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="katrSkco"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC043C4166C;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413118;
	bh=LY6HxNa1Rb7kL6kWsoMm88OVVfL0zYKMiI+DT18wXSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=katrSkcoNG8CGfQKRT44TKIUfkOAFQCGTGExOjcZL/HDwceICFA7Ftj88a9juTUZh
	 pbTSd/XF2RwRcraxJFs8A8jitjomn1Wa+WSrT7ym4OZLYerdMztx9YcPlNDde7ak+Z
	 nTsLlsHnDund4Oreme17yL1MBqgofgfF/xmfMytxMQF8YbaYwG6hi/c+l0qASjZTrE
	 UWDXsI8hA8tCK5K7IfUJjjunVuCWzyT4aJFP9jgMWzv8ERHuYUsrOqpR5otEAZvT0O
	 pVNsul2143Jjq4Nmg+GuMFAO1F2u94M1ldNKb4Qqz87Y4ctExBjtPFQDCgdv4DihBb
	 qlWuX5GdkI2kw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB8C4707C;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Tue, 16 Jan 2024 13:52:03 +0000
Subject: [PATCH BlueZ 09/10] build: enable gc/dead code removal
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-autofoo-v1-9-626f6b54bd06@gmail.com>
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
In-Reply-To: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413116; l=776;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=tXVcdUfXETqQpcM+wIkv5sahEbGpnPS14+ukiFkfzcc=;
 b=YJpXGBb1WaXwi5eDQsIi0UBhNBBbCzabSiP2A+Ct6xRvyDikxhZReDeIqGsTqS3CZMg822lFX
 hzIFEZpe69ZBwYlIena8ier+Ae0HsGw5DkNWFGE3L+rUCBKisSKUy+G
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

From: Emil Velikov <emil.velikov@collabora.com>

Currently, there's plenty of unused code in most binaries. Enable
-fdata/function-sections, which allows the linker garbage collection to
do its job.

On a maintainer build, this reduces the (unstriped) binaries from 117 to
114MiB.
---
 acinclude.m4 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/acinclude.m4 b/acinclude.m4
index c5d6de7b3..4b73a5bfc 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -134,6 +134,8 @@ AC_DEFUN([MISC_FLAGS], [
 		misc_cflags="$misc_cflags --coverage"
 		misc_ldflags="$misc_ldflags --coverage"
 	fi
+	misc_cflags="$misc_cflags -ffunction-sections -fdata-sections"
+	misc_ldflags="$misc_ldflags -Wl,--gc-sections"
 	AC_SUBST([MISC_CFLAGS], $misc_cflags)
 	AC_SUBST([MISC_LDFLAGS], $misc_ldflags)
 ])

-- 
2.43.0

