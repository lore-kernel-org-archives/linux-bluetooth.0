Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7893C0A1A
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777637; cv=none; b=bNE3qi458EewwH3KnpxEI4llkPF4z4vGoSDN0g5gZ4OoNWeG85R6qofDTFPtlGWQ1ohQ3Vrbdd8Co37nMgOamqkXJQ512/ZWtxab/IeNgs2kcfy/gEe3ql+GsM2xOgRM4hiRS85giqrh8yBJ8ZpinIJBou5K2g5R0ynFykjV0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777637; c=relaxed/simple;
	bh=Ahd31xY5ymJjl3UAeH1o+QxntrbVmiOeEzXV6TM+M28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DYdLkvnJ2sSgV/VOugZ2XZ8V3WMrRWWe5Ka1yiemApgy901JOBtkvbNex94LzusZDLNAfxu/jmCcJbeVhE46q/A57cZtgqIE3J/4R9eA6Q4EOXuF9QSu9Us7yEF0q7nJaoYO76PL2C3thnmxA2vdp5fSt9ogcTD+tK2Vsc872P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=io3GcHnn; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="io3GcHnn"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbs-007cG8-BV; Sat, 06 Jun 2026 22:27:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=IcP4rIqU/LjSRgmys3X68snLpaIdeX/fy4NhLf5nqkA=; b=io3GcH
	nn+Hk4zDBHTTLrSjiDB8NYGldDOEbqtpEp3CanE4nNn7Y8I7kc1D343E0ZJ1Hf8whzAwsSSV2+Y4f
	GGcpZNHoKmXA2iFBT5BxRmyREcCgEym07uBZRixjHA29JQaGKdxohARs+67Uojd5TGYYD0hrNJYUj
	nepcV+tHm7AZKxd8PUZzhkyjrtwLcFvxTtFoXBHvp7vzIVYPn9NVBKZ5WiW48XpkHgj7ucD3RY/+3
	qKnKT5LI+iphikFAd+yrwhJv1qaI0nj/MmwJaaQaDJ+3PJ5LmZyaaDXCvGbJA4yBs/6SEmD59O0IS
	p2JWTaej39jTWoVyWeAYE1Xzybng==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbr-0005CT-Qq; Sat, 06 Jun 2026 22:27:12 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbj-006V18-Nu;
	Sat, 06 Jun 2026 22:27:03 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/bluetooth/bnep: Use strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:20 +0100
Message-Id: <20260606202633.5018-26-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 net/bluetooth/bnep/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index d44987d4515c..1e14fa1e886a 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -639,7 +639,7 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	}
 
 	up_write(&bnep_session_sem);
-	strcpy(req->device, dev->name);
+	strscpy(req->device, dev->name);
 	return 0;
 
 failed:
@@ -678,7 +678,7 @@ static void __bnep_copy_ci(struct bnep_conninfo *ci, struct bnep_session *s)
 
 	memset(ci, 0, sizeof(*ci));
 	memcpy(ci->dst, s->eh.h_source, ETH_ALEN);
-	strcpy(ci->device, s->dev->name);
+	strscpy(ci->device, s->dev->name);
 	ci->flags = s->flags & valid_flags;
 	ci->state = s->state;
 	ci->role  = s->role;
-- 
2.39.5

