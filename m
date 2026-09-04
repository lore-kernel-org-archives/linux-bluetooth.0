Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EB50EC0D
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540830; cv=none; b=ZffNTKWc3Bn9/aqJl5qZ94kY1ldvhNc2UB8YP7ZJ9kxSq2ifVHjnE17E/E5g+IT27vuSo5vIXqmkxuEVTp77Gns1P2g3EWMhIWq8FXe6947SUfgk/EtPllb+GFmFpk3WbPtsehYJKP/ZDiMp2ZjgQrTVNWrAMmBokhcMKiRQ/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540830; c=relaxed/simple;
	bh=7Q5T4zjo8IXDdpXbRSincIkG0VzfYzGCFsAdwudKOl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huUHE2mrTKvQhomDY40dgTMEfkoKrd26cOdo3V7R6vHkk2lSlB0sgME6vDc6dfIMIZP5GfGlILyrViB3/xhQ8r9flRgv3ZfgbodXfHumIw6bZ4zuLWShFxY5MYFXp9/8vkm5b/HPalRrdlVjcEmoJkdJfDmVQCEAC953pBn17Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LfEgXdzd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LfEgXdzd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788540827;
	bh=7Q5T4zjo8IXDdpXbRSincIkG0VzfYzGCFsAdwudKOl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfEgXdzd0JDu3TegmtoesrAddhQ/NrCo61nDgY5NOLXTH5iLgdnT/NUnQ4QLuIZ+A
	 KCrqNyfHR203KYLf9B5LF8wjs1amKyIRHkhsvl1SMuPCk0drhweNY30ptGipq7n0mJ
	 5GmeBSiTOqCOOOvNLfOLJ50KI4UY3BK3CTzrQwaR6vpcKUvj50Qrjjxm2gUft1WjTT
	 ckZHyoD0lt80cILSO6Yo6h6E5TBx1CnLbuELUZI+JSMSg5SsdTzBTavUsZel1KwQjd
	 bMMAPB+3cxbFZ58eCgpyHiX8F8o76/x5LK5DJKJg51qFa5r1wl/bNPmhc8zdXmbQMT
	 92+u0Yv56Wv1Q==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 753EC17E092E;
	Fri, 04 Sep 2026 18:53:46 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [PATCH 0/4] Add MCS fast seek and track position write support
Date: Fri,  4 Sep 2026 22:23:28 +0530
Message-ID: <20260904165332.42046-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1654183666f442926c1301e1733567216b307981.camel@hadess.net>
References: <1654183666f442926c1301e1733567216b307981.camel@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are needed to make MCS PTS tests pass.

raghavendra (4):
  profiles/audio: Support MCS track position writes
  profiles/audio: Support MCS fast seeking
  shared/mcp: Notify unsupported RFU opcodes
  unit/test-mcp: Test unsupported RFU opcode

 profiles/audio/mcp.c   | 71 ++++++++++++++++++++++++++++++++++++++++--
 profiles/audio/media.c | 32 +++++++++++++++++++
 profiles/audio/media.h |  1 +
 src/shared/mcp.c       |  2 +-
 unit/test-mcp.c        | 14 +++++++++
 5 files changed, 117 insertions(+), 3 deletions(-)

-- 
2.43.0

