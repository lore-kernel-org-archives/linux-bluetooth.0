Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D163B8D67
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765487654; cv=none; b=DpRpwxcoEBUcXItY6rVLHHcW95vD3fdEeQu6sr9FoqnJjwc3L/V4YoNtG3ufIMp8VEhKQX5Qgdg7bod+Ze7cXwKCf94DyHdHyCQbG865OJYlk0fH03afBoF5amzfbEWTnsqLCP8WO2Y6J5q0SjGPX/rf1b2qTVwfzzmCO/IHd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765487654; c=relaxed/simple;
	bh=TB9+nzucWDrd7zxhEecaDRFwTpOhI0ZUA88+4Dy1U7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cyp0RobGti9kBe4COzuwU2Wpv0oZ7Ks22vPVkcCPUI5UZ3dYTBYEVCQ5llXb5MCvkAeEET0Kpx5SiugGGtlgBnVaBnS+xlJXFwK4ZaLUlgXFsc7fE8/rZ1tcl3ctEYHKL9s2+9ihVDjxAIFjbIXDdcN9wHEtpATAFzkPhtVaP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AaYRUN1M; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AaYRUN1M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZnPTzScSEAaWZoZuyv9OdJdv4lG3ge1Yic8fwFZe3Zg=; b=AaYRUN1MTpexdVrax/6ORe9eET
	ferEgv2gtv9eT7i7FcvIy4HSoCwpefFycF+3lRBpPST+cCrSKQkbvBgSUwGHkjs8wFGwb58BfOM1H
	sc8OIqDXWMUfpKdaMkYcyE9LChqgVU5bzFXkXtTJuoszA4S1KMkp1ubpEdCaYW5eqjCsCZJfhPm/Q
	GyXtH4N+v1vYncxQHybFby+MHFXCSocu9jqaF0wB/QBBHK3q6mXG60ag5BMFiWSn3Gm9kkv+/ZRWC
	ytecnVdU01BiPiXtzM/5n+MIkrg88HW7+jilOo/ARpKR6fCFONByv1ZssIZCcs+N2fb3QqLWwengy
	fTdsCjTA==;
Received: from 241.red-83-35-220.dynamicip.rima-tde.net ([83.35.220.241] helo=breogan.igalia.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vTnzD-00BeTh-Em; Thu, 11 Dec 2025 22:14:07 +0100
From: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
Subject: [PATCH BlueZ 0/1] Support for config fragments (conf.d style dirs)
Date: Thu, 11 Dec 2025 22:13:55 +0100
Message-ID: <20251211211356.3842264-1-mafm@igalia.com>
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
 acinclude.m4               |   4 +-
 profiles/input/hog.c       |   3 +
 profiles/input/manager.c   |   3 +
 profiles/network/manager.c |   3 +
 src/conf_d.c               | 177 +++++++++++++++++++++++++++++++++++++
 src/conf_d.h               |  77 ++++++++++++++++
 src/main.c                 |   3 +
 8 files changed, 269 insertions(+), 2 deletions(-)
 create mode 100644 src/conf_d.c
 create mode 100644 src/conf_d.h

-- 
2.51.0

