Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825053C0623
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144001; cv=none; b=Qf0xzW5KPjjRkp+5pnfecpxLhu5Kn03D7Y5uOtD3+iq1p6PtukwiFiSxI2YdWmjfl6e3k9Sqh12JiRp9afi/QihjuxBYvyaRirm8Qe7lK3fdca+DyYFXVm08egk/hJK+GIfl2/q2RFjXcGNlXEvk9GvnCISO6KSUTum6kWhXIW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144001; c=relaxed/simple;
	bh=C8UJqDJrfZrBDiUiuv5LwUWq9gEx41QlqUjwEGmLU9E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=G8b8UxT9vv/yKukpKCjegxOn0pN8EtsbQuWxshb4/WyVZvhcOPyNqXfuDA8POFnxjfs6JxG+kpvGtptonZrkAeUid9aOeASWrtgOve4kZDztfJoYuaVf61uBMCZzTCbiIKrl8loiex4Z5bPLW3z2D0Rp0gC+XhB68L4X3LWNMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 695BE3EBCA
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 09:19:57 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] github: Disable stale bot for triaged bugs
Date: Mon, 27 Jul 2026 11:19:42 +0200
Message-ID: <20260727091948.2746998-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTGLAS5P/YO1++Cdjt4tjQLECxbcBwfEy/uuTy3RB4YycwtaeWmkaTXbiJLNgTbE6eObmCaJ42wI93mcdv3tZKnfthPZWuBa1lxhxfP1TWUiVqr3yx6P+//uFMB15IZe9JT/xsk4/8ANp5lJZlyvPN20xPnnCh3okMmm6X/wyNCpmTmGdtAqvpKnXhSASEdjnbnHXNR5eXr2jsUzun0tkhx6xUU/mCGIOT+syHY5nvhWWfvoBiQa2PemMAF0D+dQvbpKJdEaz0dse1OJLDOT1rGJ8AIZobsLbm4GrXSpdrDkzKJrz5GMVepZVcl+kagKVPcrZidfZq+Bl4VqBf65uCzlP7GGR/u0oTOCct4WmfRjpkhDStfQqgmoeTDJz1uGt4UgJju5scqBFZJl4RzG+YjHVVFCJ8TZvpBaLkOq121ihwCs7plA79NvtWygFpR9kRR7/PS5jPmIKhJ2XslbIsXXepo94ik0DPSxnOO0maRN1GVivXLitIXKgRHs5m+ZceNMsocrqbmZV8yezqmiNo24qOEx20n4fZbVta/h6A7zJR5YPtJdVHXWqgZk2TEjoOvzebp6+0GTdXi/NWge17MTkSG7guqt+lZwGqkYRDrfvOyYZKr2c/NtD4ff1byjMpY63l+07VeoNzitb9okeEgB20QEp9OKdHOsU+FnBybTLw
X-GND-State: clean

When the "bug" label is set on an issue, don't reap it with the stale
bot, as we've triaged the problem and seen a bug.
---
 .github/workflows/stale.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/stale.yml b/.github/workflows/stale.yml
index bf2c20226cc2..94ca3ba59b61 100644
--- a/.github/workflows/stale.yml
+++ b/.github/workflows/stale.yml
@@ -15,3 +15,4 @@ jobs:
           stale-issue-message: 'This issue is stale because it has been open 30 days with no activity. Remove stale label or comment or this will be closed in 5 days.'
           days-before-stale: 30
           days-before-close: 5
+          exempt-issue-labels: 'bug'
-- 
2.55.0

