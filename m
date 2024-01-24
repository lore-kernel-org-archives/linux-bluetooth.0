Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1A7CF25
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113210; cv=none; b=kqSDHxObnykYkRbkNQkbnmvTAu6sLKYis4Qy8GcB9MwbT1kh4KJIU5DtelgaYAetz+jCgCAu7q+o0uYBRtgykWOi9ivpt76UFM2re8hOYXg92YdaMcHysbRTFwhrPZVBJ4jqhc+omkXzdb2qUNEB9BS5VKCp0OuQPCdqMTb0O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113210; c=relaxed/simple;
	bh=LY6HxNa1Rb7kL6kWsoMm88OVVfL0zYKMiI+DT18wXSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQTxgoDKeBN+wb+S4QOmLD8ZlGwoLta2+gAnKOeI75LO89cq9mqX6HCh0oCBze6JDV/6Oi6S1dbZXUxJ5hyYCbg7jt/puju8Ol8JvW5AyDAqAudi6owQ6dtwLOk+EdykzXdGHQH1E77meKQXrTwZFpC6aTGB5iHY/X0wYVr+ZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHzs9UK6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHzs9UK6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9153BC433B1;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706113209;
	bh=LY6HxNa1Rb7kL6kWsoMm88OVVfL0zYKMiI+DT18wXSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WHzs9UK6xWwA/88i7xd4tQhIOw/MhuwysJRRTF45/i2r5yrj3qYIP/SO2WkuFfiw0
	 k/cteV8MJg26XFfX8YJdmhzLGM0ojRdwfSsfvNqe1T8CR3hRTi2kMl+sfl/R536zpa
	 9ypnEobghKYUWJoDgm3MtFPr6pm3P6Fqh0lBFYWFDjHZ5DXAdkua1jhNukFgxCyZZz
	 RTa1lw88GhnvhAWE6tBjDbqITQsmPQwjmOUxPWiFArTX1QpyjnFdIGjTsqWWGlJlCy
	 csunMpxmY9jdT3Qj9P+Hgrj8zWf93XWmTr20KzZSQlE0fG7V8GA4+YAQJc9d30CXBd
	 bFeU4b+mx5H6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E067C48277;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Date: Wed, 24 Jan 2024 16:20:10 +0000
Subject: [PATCH BlueZ v2 5/6] build: enable gc/dead code removal
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-autofoo-v2-5-a210f20aa2f7@gmail.com>
References: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
In-Reply-To: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706113208; l=776;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=tXVcdUfXETqQpcM+wIkv5sahEbGpnPS14+ukiFkfzcc=;
 b=O47pFB1MpHutfgeP+aMWlBF+ARi5rE1aUctgbZlF5tjqT3JInSAszK8MFhNauFUT3ImJQdtfk
 RYCwnpcXebACBvbPeTzkFwXt9S7YToicJ6vi3y5hWFNMVSbRkUKCo/3
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

