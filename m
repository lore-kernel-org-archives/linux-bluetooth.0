Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB2296BD5
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314941; cv=pass; b=q4AyOJZP44HT2TnygPX/ZpF6jQZ5V41Jc5zmM6aFK8ivrtDnZRLM9BBd5sqeuHy+C/o4LkqVw40ndR+DMZ9TMbuxXwi1mwnvaQQ4BMdAf2POTlJBFRNV8oxOkAoefotDYEfFlV5o9rRG5fWW/QgNBoDF7oRM1PRef7bpvW9pJBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314941; c=relaxed/simple;
	bh=Rg7bDLxMMwGyb7Q1gvfUp06naTwMNjpZ/6mDPpqCHBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kgn0b12CSUrHkpkpTfsiaxTxiB+EFjOUOwJ3nU31cYk0Nv2WjizwD0CiMYxzB5xgplImovBIs3Xbnjij9UEg8wfPIOcohBzsVDMH5AzqG65ivSAzM2aDH4JPIJyOKShUnWah/NqffDfKxmLioEASPxIeHL31k/v+k6hQYryhfLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=W/ehgjqz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="W/ehgjqz"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dQs881dVNzyQH;
	Tue,  9 Dec 2025 23:15:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765314936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y4YSgUkQO5ErgOclzSTmgVeVFYskbzMPt8byu6aliDo=;
	b=W/ehgjqzM7icTSR3esR6Fu9az+JzJK93+5LrIR2lJQL+L3aW97MosQ9E3YRnKJK/2uNxVc
	Upmu0qtQMbOkriW0y9HgOZFfEKz4PT7MejMu3ie0k3aN1CwrY0NfFsZ9rdnVGjPC4cG1sd
	34ALy/gPGjVxFdOM0X4yh8k39CoPd4E=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765314936;
	b=Zgxoz9OG/8G9S6VAu0GgaZ6R81iJa2kevqF1y56D2VrWbhaMYJzgze0DUCykhD9Oc4j09S
	v6h9LBYnwd7wiAHTVrbKoFeKymCSNfyHrFz3PYHM7EO8ZAnIy8yn8rXa6gc9UXNIzXVIe1
	Ku3zmAzp7B168fVShlRWrqi+DZyutrg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765314936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y4YSgUkQO5ErgOclzSTmgVeVFYskbzMPt8byu6aliDo=;
	b=wSmbbjvnat7G+TSqO4p0SkiMTplUEBwD0AQLSBuLvIJmPpV4vauHNkURWkN0O3/cX4k1uH
	HqU4Ns3PrppfUKtaEog4+DxQoRlcSOu2GniYTKvYNiWaZNHpfnsbkPCgNVi06ZS9XEUjdm
	8RxcS59QM6hhBn1QGID1ug5xeoAKHng=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/6] mcp: support multiple MCP and implement local GMCS
Date: Tue,  9 Dec 2025 23:15:17 +0200
Message-ID: <cover.1765314903.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Media Control Client, add support for multiple GMCS / MCS services
on the server. Revise the API accordingly.

For Media Control Server, make it a non-stub implementation (OTS still
missing), and add an API the profile can use.

Add tests.

This changes the design of the previous MCP code, so it's mostly a
rewrite.

The shared/mcp: commit doesn't fix the API in profiles/audio, that's
done in the later mcp: commit, as it's a rewrite of the API.

TODO (for later): OTP/OTS parts -- requires design for OTP/OTS
implementation first

TODO (for later): MPRIS integration to GMCS server -- this needs some
redesign in media.c as it's hardcoded to AVRCP there.

Pauli Virtanen (6):
  shared/mcp: support multiple MCP, and add non-stub MCS server
  test-mcp: add tests for MCP / MCS
  mcp: adapt to new MCP API to support multiple remote MCS services
  avctp: move uinput utilities to uinput-util.c
  mcp: add local GMCS service that emits uinput media keys
  shared/gatt-client: fix notify_data leak in notify_data_write_ccc

 .gitignore                   |    1 +
 Makefile.am                  |    6 +
 Makefile.plugins             |    3 +-
 lib/bluetooth/uuid.h         |   27 +-
 profiles/audio/avctp.c       |  119 +-
 profiles/audio/mcp.c         |  802 ++++++---
 profiles/audio/uinput-util.c |  144 ++
 profiles/audio/uinput-util.h |   23 +
 src/shared/gatt-client.c     |    3 +
 src/shared/mcp.c             | 3223 ++++++++++++++++++++--------------
 src/shared/mcp.h             |  186 +-
 src/shared/mcs.h             |   51 +-
 unit/test-mcp.c              | 1807 +++++++++++++++++++
 13 files changed, 4654 insertions(+), 1741 deletions(-)
 create mode 100644 profiles/audio/uinput-util.c
 create mode 100644 profiles/audio/uinput-util.h
 create mode 100644 unit/test-mcp.c

-- 
2.51.1

