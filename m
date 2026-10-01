Received: from mail-yx2-f37.google.com (mail-yx2-f37.google.com [74.125.224.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D6051FCB7
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867465; cv=none; b=HMCjNSYI1xdsEz/qFZupLNVCsbC90r79QrEgZpFaPFGFOiw9SI+UuHgGg3A6cjWtxNvJWiU53Q7wG9ehy729xRGUmIVHL8rRdRP7lv2XczjBpD9Q285cK8mAQ/6IWwvlDf8Sf5aQAXG/UGVQEJZxLH8qmLMW0pVaZaGIs5onV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867465; c=relaxed/simple;
	bh=d8v+dwvxIWjihrMIjMnPQ2uNF5GUM6fsAIGzwJPyK8o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Zi3rcoFBQvhruQhOd7id6pTMb84os8/L95MHQHN0WFKUjUHnpRqfzOWcWP9KMHOjicLH1pThBrIucR4e/RO1ADANHmFqZPbQHGV7Xi/+XawE2l1EbqM2keTKLr2apl5Uqs7I5yDK/ORBTMUfqqnr6k2vC/bSb8XEFRtAlgd3EVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/bcBKWd; arc=none smtp.client-ip=74.125.224.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/bcBKWd"
Received: by mail-yx2-f37.google.com with SMTP id 956f58d0204a3-677a7faac73so353990d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790867463; x=1791472263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RiThxi5rs4Hw3/1oNf86LR3Q4paSNP/wrpyKnAPxelI=;
        b=O/bcBKWd4ayb++uNiArKxjy2or4ZSBUfb7sbYxD61r/VvEaZvVjwU/qkRh28bEOCo4
         pqlqXiTOtrcZLhsFFiq01hnv20t2Jy5RdQ6d66RjcsbN6fbnQ8cxtw/2u+cSHK3IDR+x
         yM1Q6QJiX3461Clx9uv4QShCmoQcLXrl/tEbNChOrLn8I1SCNsK9pHUSSISVRPniS97a
         aHqYL0nj1QwKNqsQkNwC+i6e/1nqNk14CloqSfT5v018jyAAvaxBiRLDi3mokulHAqs5
         thOQqUfAA+wQkXbaVz0p/rsO9O8JJ0xygxck831+uh4Iu/nO7lOtEKmSPP5eJ2s3qg+Z
         OP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867463; x=1791472263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RiThxi5rs4Hw3/1oNf86LR3Q4paSNP/wrpyKnAPxelI=;
        b=uQ1GFCFBQ7Z6gztBIj42cN9b9qQNyJxAwNaabMJttLFvAZjRFgtfQInArp1p5dPDEW
         p9MtvkRQNfiyZEzrPwmwRNbEfIByP8qxvNMYgx1rlLSCE9GHSf8ZNuEyuzjgWQooAAbT
         tKc8ADy8TT8QiaspnJVFy5wrRUv6LS7UCzwWxbw18PmvIu9YF67MupG24qzHY19ayC8O
         uqOb6uTjf0CM2o7qNpHxSn8bNO0Be6wWTv+Lnzp/jB7mkpCMIDGdZ12hMK/8wT6fyzk/
         eM0eo6DIigqSc3ulxdqYtG8fSqCsuGb2wUK2OSYI5wjUxDkDLyqVXvpbskQutjDrDkJd
         4eqg==
X-Gm-Message-State: AFq9FYJfWKN1lrPqh5lJpWGgRLcv62J3f37Ti99o7MTjt4UHvBLfHbaX
	l5fLuHrHFXt3ApWRwD01VOwaS++skqxu8Ttb+i5SlbSVvCs6vjPpxVbFhO8k/Xo6LtjSfg==
X-Gm-Gg: AYBFou3NPh/+yLM73SAoszItGkDcr/rTL+Wz9GZqgy5CBrS4jCwyfMNtBcbn45QClr4
	JPyr1RoemJxV6M0+5UKx2YPjo4RjfFWFnmhgJy1DUI0H5+ZqsieNfLnNZhjXVtn74lbjTfDD3xq
	bq9yey8TRobxcJ5PcA5NV5RsiVMUs2UqcnaZxK+s4xbZjyu0ZA1Yxbwo6HS8/1iGxUvs9QSbu1n
	c0b3Y/nwH9DD2c+Wi88bx6zAqVuNwq2UE9gEt92g5hC2TjIpvH7u9ZaadDV5KC3t/wgYbyHOcDA
	wmujTIXSFymfNhQ+q3CfSMomeFC9VJZRIVYLcGweEJbTJq5Th3KahXGakx4WPN82I2o2tszT4Nh
	aCsCgAJioa6Ps2z5Qk8ppPH2ak6OFOVbudR2LTuey5kbZcZ6/VIZ5zwYTaV+8KW6SRvnl/voTx3
	OikagWg7t3qx9zyAV4gP/wP71cSarRPIgGX2AdRNDf4nPIHrVK+66YAQCutYR+XukFONEUEwNsT
	8jjgPq8OXeMc/xjUddQ9CPJXB64kVkORj+HSpeQQvGQWVWrTRfejnkCrcccfn3b
X-Received: by 2002:a05:690e:4382:b0:675:6f9d:dd5c with SMTP id 956f58d0204a3-6768352a136mr1509388d50.73.1790867462685;
        Thu, 01 Oct 2026 08:11:02 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-676917cee9asm1171933d50.3.2026.10.01.08.10.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:11:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] doc: Add commit message guidelines for AI coding assistants
Date: Thu,  1 Oct 2026 11:10:52 -0400
Message-ID: <20261001151054.2422165-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Require commit messages to record only the changes and their rationale,
to follow Rule 2 of the maintainer guidelines, and to have their factual
claims checked against the diff.

Inspired by WirePlumber's AGENTS.md:
https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/AGENTS.md

Assisted-by: OpenCode:claude-opus-5.5
---
 doc/coding-assistants.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/coding-assistants.rst b/doc/coding-assistants.rst
index 3a643527fd65..778b3e6d81b3 100644
--- a/doc/coding-assistants.rst
+++ b/doc/coding-assistants.rst
@@ -45,3 +45,25 @@ Basic development tools (git, gcc, make, editors) should not be listed.
 Example::
 
   Assisted-by: Claude:claude-3-opus coccinelle sparse
+
+Commit Messages
+===============
+
+Commit messages must follow Rule 2 in doc/maintainer-guidelines.rst.
+
+A commit message records only the changes being made and the rationale
+for them. For each sentence in a draft, ask what change it records or
+what decision it justifies. If the answer is neither, delete it. In
+particular, cut anything that:
+
+* explains something the project's developers already know
+* restates general knowledge about the language, toolkits, or codebase
+* restates what the diff already shows (e.g. listing touched functions)
+* narrates the reasoning behind an earlier, abandoned attempt
+
+Additionally:
+
+* Keep it brief; use bullets only when listing multiple distinct changes.
+* Use a subject prefix consistent with the history of the files touched.
+* Verify factual claims in the message (file counts, symbol names,
+  paths) against the actual diff before committing.
-- 
2.55.0

