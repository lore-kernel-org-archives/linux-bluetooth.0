Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989662417D1
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162732; cv=none; b=srvmlDuBK/uuE4oRfZswiZnRM7eLiLPxLw8KUY1kye3mG1+n8iDuWDmPFpD0ifj+uomFQrc76Wl/NhDcOMJbhMW7XcJ8OUh2dIpl5q/eFPAbcs+JacgEfRVZXy5k/C9cdhyPScCbiqppJaw1IFAwDl6BHZtN/8WEiaEz9BDDj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162732; c=relaxed/simple;
	bh=GgOeH5GQtnQd+R33JSxS3wHJGHh5d+AdkqOPpxAy5Rw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=t/ZOESrQciDaN+soaoNES6fl2TJWtXtroISttUdikVanuLM+Cyfb3y9volG6AGebayuCNlPUA0tMm3enkLtEHqhOY54rZihm2OSqC3xt1aIwjQG08grQ0mKUtE2kA6HnMjL5C2HOS8tQ8YIb8INVVPh2Tg2JCKTYGhS+uz82Fg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PkJ4IedS; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PkJ4IedS"
Received: from github.com (hubbernetes-node-6086f23.ac4-iad.github.net [10.52.180.32])
	by smtp.github.com (Postfix) with ESMTPA id A616420830
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Dec 2025 18:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765162729;
	bh=DQm8bM6WtYGoF0icG/RgJLIvMBUWkyaqh15WwdV73ss=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PkJ4IedSOZ6cCBL7GHRnG2WVtFI/vLVQrKoVUvfFyEwdEQ1MUb9y/U89Kfv1XFURQ
	 YL7wHqPM2EZ2xmF6i9fZhHl50dzG/+cxAVCyF42TiQ2L09IZzMXuKQ72tTQ28btoMf
	 aVdEde0A3qPtg3XN8xWmkJQbgx6iejKaD/bFza24=
Date: Sun, 07 Dec 2025 18:58:49 -0800
From: Achill Gilgenast <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031211/000000-273e58@github.com>
Subject: [bluez/bluez] 273e58: build: Allow systemd unit build without
 libsystemd
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1031211
  Home:   https://github.com/bluez/bluez
  Commit: 273e5838fd6010744b4325ca33135de2603b0705
      https://github.com/bluez/bluez/commit/273e5838fd6010744b4325ca33135de2603b0705
  Author: Achill Gilgenast <achill@achill.org>
  Date:   2025-12-08 (Mon, 08 Dec 2025)

  Changed paths:
    M Makefile.am
    M Makefile.mesh
    M Makefile.obexd
    M Makefile.tools
    M configure.ac

  Log Message:
  -----------
  build: Allow systemd unit build without libsystemd

Decouples libsystemd and systemd units from the same option and allows
installation of services without systemd.pc by manually specifying the
directories.

This is useful in Alpine Linux where we don't ship systemd, but allow
systemd services to be subpackaged for downstream distributions like
postmarketOS.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
