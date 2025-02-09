Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F5926ACB
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739097606; cv=pass; b=KDlxnJ10TS8j3sNh/90Ti5Da7vPEXMZ7dpKRxDT6VBmL3YT9ruPbMBGEidmUXIgDW3Jl8GUpx1XnH/5ybX0fT1o++BPGFVj1lKxe+b+NT0hur9XMT6uI0GNF9L5S6zBp+nCbM4xZPPU94ag1suLSUGKE6PEElbetmqxO+K9nPG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739097606; c=relaxed/simple;
	bh=P4NzXYD5AxVe/lBhHIV0tudKqBuBZjZi962xPIqYQeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/UvXKCmpKtSvpp+1Pmq4nVzS3D86g6Cuqno0A2Cqcx8R3Y9ndP7z2mxd9P5BUwhYIqPy0lwE4rsvtIDlYoqjH57AYHKdVWBPT6VExeF0oFufL/+o8pelDSbxAf9k++asQ1CVcuKQYCNG8qz/vove7Bf99GFAtSFQbJFpquXOG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=fed2Zkq2; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="fed2Zkq2"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YrPNf0C51z49Q3p;
	Sun,  9 Feb 2025 12:40:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739097602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l16BDlqGe+CnrAjUzpSUBI6XoY1HslQKjeUoTAJLHBM=;
	b=fed2Zkq2BGoDbSVQqzqGt6HqQ4Gvql+kogpvc8blYw8kEpZFGys1vL7SeWG2OfIAyBRUcc
	TXf2c7npWVoOWm0vlHT6mP7u0xmmoixGxEyudcIRbJQdAL5MHHGdJA9PBel+4Rmd4wCI2A
	g888D8dO3IxvfBN9tDmwcQshVBoYKhnpVzjlLL2DO0zekoJgApHilmZVwprAgaN9GXcotZ
	dH2ExG86x39ArjfdZXwAfyQG8eGfsRupBNrr1XofsLl1j1M495Zqr2eFFgxLbMb+sSyfdI
	MDlrbnfFAHFmYf9edbF7yFTx5GQ1FZ6AKc8XbJefmbhFBpJenZnVHAJmub5aXQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739097602; a=rsa-sha256;
	cv=none;
	b=TK9Tz+Ux6WtSkOiO1D/5QaNp5Uw3GvGWXsV++xxOJ3IQoIlXIidte2HsoVFYMQXoj5KSHA
	P87LUP0PIBFvvCT9rM3RZCbLcqzScbVJS7pJZz01t0dRuNLKg9jPxE0C+gCUmzOMCJaZvC
	+Lu+bQqNXDbT4Q5oHr1KIISVPaMkYmywdoacIdCBfMoY6cST61H+LZEdXbUhnceIDpkGto
	+PR+yQWKb/DVlMP7GCeubnGszQBe/biCVsD1Ro5F3etJreEqgTohzeN0GqKfAx4ovvmv+A
	g2Y15d9UNDXAMQbMhuJc4oEu+a5h2t36EfgJpTtnOzm4WKtVKSvWBi2lCZoZrg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739097602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l16BDlqGe+CnrAjUzpSUBI6XoY1HslQKjeUoTAJLHBM=;
	b=lqVKex1L12NexIqjScyDYWGT/fJg/4NE8asP4v57kwHACVJcFraaJBLF5gEiCanprBhMt8
	bct2T51CDb8RtORt1TBDDKWsZhO6tS5KA6tt0qUXk3/V3mDcYuHltWlTdy0HfGW/vItbQJ
	d/ujPYMfK3XHWduAP206hfmWKLF0wQ7jtSNHMOkSFO3tND7QeMxrQrKFgkoMmeojjP0tcM
	KCZ/GPByvySgZcDVWjuNP1Xn9EYDNUNPpgQWysJUOzI0Y51mnD4wXtVrDyPb891qF2nDfK
	RdvELBqkRXlyM0rj6spkUaWJZ+F6Roj78RdCUzngCqMxGzHCfCYefNkSYgKOOQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/3] tools/tester: update TX timestamping tests for COMPLETION
Date: Sun,  9 Feb 2025 12:39:54 +0200
Message-ID: <cover.1739026302.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates TX timestamping tests for the new kernel patchset.

Pauli Virtanen (3):
  tools/tester: test COMPLETION timestamps
  l2cap-tester: add test for stream socket TX timestamping
  tools/tester: enable TX timestamping tests by default

 configure.ac         |  7 ++++++
 tools/iso-tester.c   | 42 ++++++++++++----------------------
 tools/l2cap-tester.c | 52 +++++++++++++++++++++++++++++-------------
 tools/sco-tester.c   | 18 +++++----------
 tools/tester.h       | 54 ++++++++++++++++++++++++++++++++++++--------
 5 files changed, 107 insertions(+), 66 deletions(-)

-- 
2.48.1

