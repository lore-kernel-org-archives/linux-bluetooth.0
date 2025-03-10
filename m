Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C918C011
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603392; cv=none; b=Mnz20vXttgbx4cuXPU4VnFNTPq3/yB2etAZoizDrj3pp/3sezEDdESgsZo75ngaI462uAd95c+vmOeOS2kOp9w8DP9zEkYbuUpzVTLqjXi9KFFk1nDxcHATc8xVY3gzjTJTt4pM5lEbUdShxpJT7Ii8keN5UaXS492xc8HiNLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603392; c=relaxed/simple;
	bh=xYRpIL6dXeoA3OlkSCv5DQGyex5Gu7i2aLPol+4HnNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwwV1YSTy3d9tbePsrcQyB0aiSCQjzYsF8/Zs7Cuaw3Ch476hg1mlgD8unUP24QPW9Eap7vu/VnQ+hjvdi26TsJ+QG93+Gz1M0t8fxyRzEYLK4d7A5+RrPG5GYmMch3mhge0wBwWZLxb0cgfGimJLw2UQvnlV2HaoaNwMZQ03UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from b.2.5.5.5.8.8.9.d.7.e.2.4.c.3.8.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:83c4:2e7d:9885:552b] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1trabD-0023QI-1t;
	Mon, 10 Mar 2025 10:43:07 +0000
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ] Fix URL for submitting patches
Date: Mon, 10 Mar 2025 10:41:34 +0000
Message-ID: <20250310104134.4124489-1-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous URL is out of date, and now just says
"This file has moved to process/submitting-patches.rst"
---
 HACKING | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/HACKING b/HACKING
index 29b136b34..5e07d91ea 100644
--- a/HACKING
+++ b/HACKING
@@ -116,7 +116,8 @@ The preferred way to send patches is by email, using git send-email:
   # git config sendemail.to linux-bluetooth@vger.kernel.org
 
 BlueZ rules for submitting patches follow most of the rules used by Linux kernel
-(https://www.kernel.org/doc/Documentation/SubmittingPatches) with some remarks:
+(https://www.kernel.org/doc/html/latest/process/submitting-patches.html)
+with some remarks:
 
 1) Do *not* add "Signed-off-by" lines in your commit messages. BlueZ does not
 use them, so including them is actually an error.
-- 
2.47.2

