Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDECD5A0EB
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942211; cv=none; b=vE9UPazXtRmgGnsHyLPQyTO1oRui4nwPZ+wGm4YMhm7EaurrcT60ZM5M0+VH97OB/cLTmI3wriu4yARse49OqrZg9Feb7XLsEyC1JabTz+obZ7fq0Pn+9O5S2M/a4YjEAu/E0uVqeCFk3Ydyo0rWR9tfcQD/ZP1CQmZkPkwc7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942211; c=relaxed/simple;
	bh=1I4ndQ4Vek+7FsT/u2SoDtLnWvqJHiPMVeKz64y8K60=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=PsPTnm0MWf81C6gr2uTj6+WqH9Ah4Fzze0/ed/ig1B9FCaNVq21FX5KVYUWEeA+a++oWcbKsSQ+PU14dzOl3WKv5w11Qbo02URhC/DzN3maZLH6RhLqDliPkKoU105vNiWjRIQQoLr/qO4oA/seI7C1YZbajiIZ5JUfa9NfI12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mfa3zRuB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mfa3zRuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705942208;
	bh=1I4ndQ4Vek+7FsT/u2SoDtLnWvqJHiPMVeKz64y8K60=;
	h=From:To:Subject:Date:From;
	b=Mfa3zRuBw+Mbfx/lzWuPH0c3iPnQL4kMRP3S4jmGeAR31H4GtsZhO1ZVDyIogMTSt
	 DA8S1+IlBX0VBUUmkXSLpiMW+LWGxBH8OoJivDlIkPtEA66SK6poj2EyYFcawKRJwJ
	 3GzlpOdBZ7/gLGa5uAhhc88z1mEWiEvuknzoa0Cm7E7YEBv4QVBFcNIdeTBqMDdti7
	 j4Xf6lmhp+m0W/OMlqPlFa5MUjqkFHwrtL36siFQoFoc0A/CO4yRN3hGOhtgDzlXQh
	 33SKKf/h0bwl0XTso8eQQtEL+JRHpjJnJ3GLJ1yJ9RFGlrVNTiddd0T0RRjAB6m5DL
	 SneS493qv1p6A==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2C24837813B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:50:08 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/5] Enhance GATT to pass PTS tests
Date: Mon, 22 Jan 2024 17:49:55 +0100
Message-Id: <20240122165000.279381-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The first patch allow to prevent automatic security level change to
allow to the security error when running GATT/CL/GAR/BI-04-C using
btgatt-client.

The other patches add commands to be able to call GATT discovery
functions from btgatt-client and get their results.

Frédéric Danis (5):
  gatt: Prevent security level change for PTS GATT tests
  btgatt-client: Add function to search service based on UUID
  btgatt-client: Add function to search characteristics
  btgatt-client: Add function to search descriptors
  btgatt-client: Add function to search all primary services

 src/shared/att.c         |  14 ++
 src/shared/att.h         |   1 +
 src/shared/gatt-client.c |   9 ++
 src/shared/gatt-client.h |   2 +
 tools/btgatt-client.c    | 296 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 322 insertions(+)

-- 
2.34.1

