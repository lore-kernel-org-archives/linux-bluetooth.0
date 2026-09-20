Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C017993
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789936558; cv=pass; b=DRLya5qf/nkFip617JgP3yQ6KJ368wj/wmrhmdsPFt+YoTjif3lDy+6tb5YvMY62zH1Npvfv/1NJaUbhLgneYAJMP6fiH7mD9imC0meuV32eyNK9ZHXrtEAcH/h0fTLIAIeVLfzRgXX8sjW2ZQqMDfezm0YegjroIFrcYvQwqi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789936558; c=relaxed/simple;
	bh=QY1Nb0SGeotaWKaPCGQFa0oEt7yNtQeAU2+159w1x9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1T1t8sl+kn7+V4jF0wDAkTKK6BxCyx8RPDzQOc0R0/Kt/m19D7xxPqi+d+lOwgvCsVzdMaBlDOy4H3BPRKhQInFxDWjiEuPgdnjxziNFul16SOJLc35dLvukfP5FKbjhSSKUi/Mx93lZJ0jGglhuCaxYC7PNTwAAkKbYr3oQLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nnETFD/W; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nnETFD/W"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::d901])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hnymb57CFzyxN;
	Sun, 20 Sep 2026 23:35:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789936544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qZmin/Ib9BwXjbg+FKY/nbdC5lyIzMd0WeYCfxjjG7c=;
	b=nnETFD/WyK1q1usKYbeXdIxLqvLumsDbnXiGPSO/U4pXhGyp5dWEYtMyoW+JmG+UPOc8KR
	bOCSdfCeDWZDl8y39sIAsfSqUP8ziXVqTsQYdOt89cUoCSzd8uZLkKNWtaiLwfDCyI0nxH
	yAyxHdQZPx5ltQQDHmrwqd249Gzb0jA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789936544;
	b=Sxs9ksiKLuOCAwOCV6MTFVsNI1omh1F74XduICyFER8w+vX61i3aaHGkXtlBRd7173gqky
	PxaV0Z9fWIMAZOWFPO5duMIffkuNMPKo8LUvgfwGYCyQjqjw6Ip1gfT4DkWeXYzgmzqzTp
	l51kqm9xt+Cbuu4MiXEsjJi97Kcw/Yg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789936544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qZmin/Ib9BwXjbg+FKY/nbdC5lyIzMd0WeYCfxjjG7c=;
	b=J+I6T90XDfiS2G44Tprh+AD6bBTL/vOuvD02w9DPwQjgEjFfT5faZCeVl1IfTDCmZAxKId
	tAL/U3VTV7KeQ6Y1OOek17jLQNcAWZNeVMgufttsNe2hxY6pGO78I9h8Bf3Fl1qTYsQYhl
	H4C0Zc8QKvoRAF8ycrndA8Xwhlmv/YU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/5] mgmt-tester: fix test failures + avoid hidden skipping
Date: Sun, 20 Sep 2026 23:35:08 +0300
Message-ID: <cover.1789934710.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MGMT tests have one failure + 4 hidden failures:

Load Link Keys - Invalid Parameters 3                Not Run
Load Long Term Keys - Invalid Parameters 2           Not Run
Load Long Term Keys - Invalid Parameters 3           Not Run
Pair Device - Power off 1                            Not Run
Read Exp Feature - Success                           Failed

These fail because:

- Invalid Parameters: change in MGMT semantics in 2024, test wasn't
  updated

- Pair Device - Power off 1: race between MGMT and ioctl, let's just
  ignore, it is not deterministic

- Read Exp Feature - Success: simple test issue vs. Debug extension

Fix these, and make it reports failures correctly.

Adjust the test machinery reporting of setup failures, to avoid some
additional paths to "Not Run" reporting.

LLM used for triage + fixing issues, except where it needed manual
cleanup for simpler solution. I reviewed all commits.

Assisted-by: opencode:qwen3.8-next-flash

Pauli Virtanen (5):
  mgmt-tester: ignore Debug feature in Read Exp Feature tests
  mgmt-tester: Fix expected status for invalid key entries
  mgmt-tester: mark Pair Device - Power off 1 as fail_tolerant
  mgmt-tester: Report unexpected status as test failure
  shared/tester: Count setup failures as test failures

 src/shared/tester.c                    |   3 +
 test/functional/test_kernel_testers.py |   2 -
 tools/mgmt-tester.c                    | 137 ++++++++++++++++++++-----
 3 files changed, 115 insertions(+), 27 deletions(-)

-- 
2.55.0

