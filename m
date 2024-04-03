Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB0D1E520
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162766; cv=pass; b=QCJKJfCO4mGdLfJsg/FJRCqZMJRdzf2OfvCItnb31ESjjJwkVv+fSR+CE0ZTTwYyL4uaR1QnAJ9ehLMeg/LfUEA+xDIAjizH2l/9Npfpy9uHRxzMcCJGMNKECJYtRF6jr+iI1HNs9Pwylo/o2+z3uyQ9MPEVuDGsvPjpJM8melM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162766; c=relaxed/simple;
	bh=FhYFuDvPU/hqlJtgPz6OQE0M4yha6KjiGrO0TI1ipqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOjd9xU/p+GeqQyC8FEqT/wwtsQlWVyFwkemJNUaquhS7EUEa3XQDFn1oUsTfgaRvOPiP/CLINDCQSkwCWnR1EWpcFDJKcm66LVvacu91LbHQ+GZqPIBbbLhsJabslwmXRE7UWYx5PnGpoJQwRDO/Rz3EVogxc0Alobc2woLDkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=CvfLjtWZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="CvfLjtWZ"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8rGw51wtz49Pys;
	Wed,  3 Apr 2024 19:46:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712162760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w2XiMSjkmlA+1wEEC5Se2yKd8CdqYvDu4BPTzKPRgF0=;
	b=CvfLjtWZscbnsop0m8y5eAHrj01kqjPsccOao/HE3SkT0DHECDDTa198jUSRqSmL+SjPoR
	isbV/u97vQUbDKHD9nNAcdS6ttiz1liL1dvbxNHRfH72Hd2EbKbVDVFIR4EiqC7mQBnsIm
	MpzZrhb9MQUeyFBdjBXF8eIUsEQ6ofIzv9uZNmHXPd7xXG4rf/6oxWZV1ZQfzQ+u6Z60xH
	VqmxOdPr6CMEZdSSPx4O5qp4cliodAgs8/5nRdQ1oz4aaybiacTXzqzF/Lr+UAM6pAOCvB
	b7j78P5Xm8xz7iUBiCL0Ci1fEJQPyRfqE4heBIRjH4eNYs8TP/NG/Z3ukm9asA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712162760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w2XiMSjkmlA+1wEEC5Se2yKd8CdqYvDu4BPTzKPRgF0=;
	b=gTkYEOIoy3YIXGgkbFkMjaFaxHr4a0cYdjGAcq74OUBh9QuVXwiwKmX/X6t8vulo18ZbYA
	/9lPXrazstOJAiiMP2sP855u4jPn6/7iCNNrkRmc5g8j1+p2KNoPjw54TQa++wNxts1LFl
	vt4/V+nK03R7SAc885lsLJ4BujBNZ7lzel6QTvyxsJG3W05DZd9rjSZKWHt6W6DMYfhFBO
	GzOjk1nixlmpSc6pfcxypuBptSxK6BGC7ZVEqZCBRn3tNv/dv3OrncIMeZZLLBwRedvW2x
	SAgYpJp+X0QaN9Jo0b9EhHIm26WTsolZk5X9Iz1kD3fzd1NynwCAs68WKjzQaQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712162760; a=rsa-sha256;
	cv=none;
	b=XrshXBy44OGSM1YJsyp2gJolCbZMwCYcRMw/W5TMj4W+w8JKd3E+uJUkdf6RnxUkXBAkDI
	xXkAtrf8JY/kmMAz1S2Vyz3BsIHRaM0hW8h4LantlVCYxrMZqkB400bXKC81XnGGrUq5GG
	14mqp2iIDgJ/F0TMmjf6IIr4nKiqaAM93LQnNwstyX4uiSkpFDUVGvKhnNq/CpA0xJdYxE
	jg2m6TLcD05JqINfr65r6MKeXtFEYmbHc8BPF+hglP+xxSNIoiEkKWbH3gKw9RLwuWCbvX
	rhkHdVLoR8z5KWHMHYRXDwPXSrnXx1Fc3p7fWc+AE41l/tjwmbOo0qYyJkDZyw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 0/7] tests: add TX timestamping tests
Date: Wed,  3 Apr 2024 19:43:19 +0300
Message-ID: <cover.1712161649.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for TX timestamping

v5:
- Add comments & rename send_extra* test data fields
- Rename tester-utils.h -> tester.h
- Use int, not struct so_timestamping for setting SO_TIMESTAMPING,
  as CI seems to be running old environment without the struct.

v4:
- Drop BT_NO_ERRQUEUE_POLL test and lib #define

v3:
- BT_NO_ERRQUEUE_POLL experimental flag enable in tests
- Drop tester cmdline patch as it's unrelated

v2:
- L2CAP LE Client tests
- SCO TX timestamping test
- Fix emulator bthost L2CAP LE credits send/recv
- Fix emulator SCO send pkts
- BT_NO_ERRQUEUE_POLL test
- Tester command-line option -n

Pauli Virtanen (7):
  lib: add BT_SCM_ERROR
  iso-tester: Add tests for TX timestamping
  l2cap-tester: Add test for TX timestamping
  btdev: set nonzero SCO mtu & max pkt
  sco-tester: add TX timestamping test
  bthost: handle client L2CAP conn in LE credit based mode
  l2cap-tester: add tests for LE Client read/write/tx-timestamping

 emulator/btdev.c     |  11 ++-
 emulator/bthost.c    | 205 +++++++++++++++++++++++++++++++++++++------
 lib/bluetooth.h      |   1 +
 tools/iso-tester.c   | 182 +++++++++++++++++++++++++++++++++++---
 tools/l2cap-tester.c | 148 +++++++++++++++++++++++++++++--
 tools/sco-tester.c   |  96 +++++++++++++++++++-
 tools/tester.h       | 163 ++++++++++++++++++++++++++++++++++
 7 files changed, 760 insertions(+), 46 deletions(-)
 create mode 100644 tools/tester.h

-- 
2.44.0

