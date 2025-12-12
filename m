Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE3245019
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570989; cv=none; b=oJhgdaZBTR/q0Wg3mfBKz2FNNoJqOl8nG+90DFqSJrDF5yJS46JqwCd71IMmBn2z2QGLhw1Hx2K4ndYCVXpPUjphLIWG4D/H0k6qFnsrj66O2SwNIhVctCxgtbWvo1debgxBhHS4UR/TzVRhnLRewsoYMZPx3BnOuAk8B+OH1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570989; c=relaxed/simple;
	bh=eVVnPliD2dAdhUVLnLr7hI+WueYX9GOnx26wqncsvMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pATcxqJFgSAae0CmPfWRaTuSM+gThZIO+1GJbnWBPGuXsFScOcG2Yycai1LEJvgCD4vKwTakp93brFF1mJqrlqNKPSpJeA/F3mmqWVUfIUgzVGMORaazdnh0/a8/bb1gXgm6rb8PAKd13lCDs3c77RVE9HSHPGccRcEB1ueBub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PuCBYY4a; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PuCBYY4a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=owXFN5JRdobUX6IAqN59Ob8HlVxd2JCnYXmOG4guum0=; b=PuCBYY4ayk4arN1o1jc76WVkX3
	D4XTLN9XCElYRsFyvvplAWPm7K/4VoQNQ89Z+InjfmKWOWBcUZ1bzeoc7updq+J1ILeiaJM7f5ipd
	aCG3Zc5e4LqYFHhICZgPT/Ebn3McJvYFGbY0urro7tPPgqfK/+hdJBFh3HHnxFA4A/QcLu1c99/Zm
	nu4fERefVRzHy7m+Rzg7r5u49SSNIU+9s2GAVPlKS2sK+U66KAIFnQWrlWvmza86GBxEvHtxaX7uj
	Mn5VIPCIb9CW4XlMmartqQPmIvws//XxJAbiTFauN+MCR1ILAkxqu3uLU1VWo8bdr1izAkIng2ZLA
	IvxorADA==;
Received: from 241.red-83-35-220.dynamicip.rima-tde.net ([83.35.220.241] helo=breogan.igalia.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vU9fK-00C9aJ-1p; Fri, 12 Dec 2025 21:23:02 +0100
From: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
Subject: [PATCH BlueZ v2 0/1] Support for config fragments (conf.d style dirs)
Date: Fri, 12 Dec 2025 21:22:39 +0100
Message-ID: <20251212202240.4057163-1-mafm@igalia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support config fragments, to read config from conf.d directories.

This is commonly supported by other tools, as an extension of the main
config file(s).  It is useful and convenient in several situations,
for example:

* distributions can set different values from the defaults shipped
  upstream, without having to modify the config file

* different packages or config-management tools can change config just
  by adding, removing or modifying files in that directory; instead of
  editing the main config files

Manuel A. Fernandez Montecelo (1):
  Support for config fragments (conf.d style dirs)

 Makefile.am                |   1 +
 profiles/input/hog.c       |   3 +
 profiles/input/manager.c   |   3 +
 profiles/network/manager.c |   3 +
 src/conf_d.c               | 202 +++++++++++++++++++++++++++++++++++++
 src/conf_d.h               |  76 ++++++++++++++
 src/main.c                 |   3 +
 7 files changed, 291 insertions(+)
 create mode 100644 src/conf_d.c
 create mode 100644 src/conf_d.h

-- 
2.51.0

