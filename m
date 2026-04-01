Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FAF331222
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055972; cv=none; b=mEegRLIZO9agvTpjK+LEMto+RVyQA5D28vKNuOeE7RtvRVAUOnyeIptqmTYAedQ3QGxMEE1apEvVhnBB4pgQeCXjMTlyVImRFIIwgqd9N3GWfdmh85MNI1rXtzvCQBZJtLcD9ZHNINn1v1SLHHVNtPB5mtKemU9/RRQ3mIMHrJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055972; c=relaxed/simple;
	bh=hNuMR7RAhP2TpNOFio7ssRR1PklPSCmQOqkwpqmEVqQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mqpX67kPr11tLqrZ0e347YUwahkW6BWTvlUPgm2qdAXQliSvyc7s/s2oCQGI8qsx7sWYomycWKDnLWaRLUtw9QZqia2GPV3XHsT6FNSr/s3Fs5EnkA/WCHGdc6zwLvT7rCjDMH8tnnrl/alRna8C5C04ER+46j9lxflbuq1uWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YTvZe6Y4; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YTvZe6Y4"
Received: from github.com (hubbernetes-node-c3e27d2.va3-iad.github.net [10.48.135.16])
	by smtp.github.com (Postfix) with ESMTPA id 9AF484E0A22
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775055970;
	bh=JIEcoIvBGndHGP1Hk1kVMS3vx3WmzR+L22P+d5G1ROY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YTvZe6Y4eHBdQHNS/G3dUgFGEh4idgtBKR4vFcJr9FPjAAWl69wLSr6nSufdt5uAP
	 QnQKDyL/2WH1/b3s98J+guoNtu/DZD5nD58jEHYxq7YdqkRndibQNCCS42jy/twB/C
	 kKmkDMlnNgeGZ5QXQ1c6R+67XVvDk3mk9f0Uz4T0=
Date: Wed, 01 Apr 2026 08:06:10 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1075892/000000-c0812c@github.com>
Subject: [bluez/bluez] 2dac8e: shared/gatt-server: Add
 bt_gatt_server_set_permiss...
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

  Branch: refs/heads/1075892
  Home:   https://github.com/bluez/bluez
  Commit: 2dac8e2807154c42f16c3157801fc00f38940d0d
      https://github.com/bluez/bluez/commit/2dac8e2807154c42f16c3157801fc00f38940d0d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-01 (Wed, 01 Apr 2026)

  Changed paths:
    M src/shared/gatt-server.c
    M src/shared/gatt-server.h

  Log Message:
  -----------
  shared/gatt-server: Add bt_gatt_server_set_permissions

This adds bt_gatt_server_set_permissions which can be used to
enabled/disable permission checking before operations which can be
useful on testing only environment where encryption/pairing is not
desirable/needed.


  Commit: c0812c538e3f197e2ad0d96400c4ffd4a2be9de2
      https://github.com/bluez/bluez/commit/c0812c538e3f197e2ad0d96400c4ffd4a2be9de2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-01 (Wed, 01 Apr 2026)

  Changed paths:
    M src/btd.h
    M src/device.c
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add GATT.Security option

This adds GATT.Security option which by default is set to auto to
detect if encryption/authentication is required on demand, but if
Testing is set enables the user to enter a desirable security level.

In case the security level is low it then proceeds to disable checking
GATT attribute permissions for server operations.


Compare: https://github.com/bluez/bluez/compare/2dac8e280715%5E...c0812c538e3f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
