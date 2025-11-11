Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1536CDF7
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877918; cv=none; b=bjl6ZksK3XDUlzCXAmxYQonI5C5cybqWm5B6kZhum3xsxIee/N3TnY+lGS33osFtGTJ/7gwt8L3iWcu0qphZ4ND7bUGUc9B0Aq9m2PH4yk6SjNQzY2iZG6HBa6h8R3WAPQ5xJcB52l/2YJqMub6v3V2PbSalvBQjPCAK7Dk0y+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877918; c=relaxed/simple;
	bh=IqxoKgt11uylNbwNk8YuvuhdqLW/TajTkrlDm2YhTNs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FWtVEMOk5W6MtbtMG2Qqs9OHjJmaQhhcJI2xHrVz1rAPZ4EtlSRyimxYQyTBEGo33xK8FuFYq/jf4LPLH6uwq9K3y4GlFGFaGO50+WxDeP6dTxOIpFnOyOZjz490QtiHqstkucnDRPCML4358nlDCIAspUlFEq7KYTbsO479Auw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ssd+UohJ; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ssd+UohJ"
Received: from github.com (hubbernetes-node-88c8389.ac4-iad.github.net [10.52.222.58])
	by smtp.github.com (Postfix) with ESMTPA id DFF43212D8
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 08:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762877915;
	bh=3eMXCDDB1gHjKgs4bnSFj8O7YM/JPc7FHKoMJ9oU/dY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ssd+UohJkDFz1ApNLiq6cHNFw6oN6fOvWoG2ki5aE2ltbDePdHyxcmXQ/aQvCcTLO
	 12m7VzXNa5l1KkESGUxEqtnypo+LI4k6WVMV/OjW9rcUX/wMACyawrkYSBsSDqS5t+
	 5wbkw+892NomP8rCaUPuIiqWVVY0U2L/GPT2Rcxg=
Date: Tue, 11 Nov 2025 08:18:35 -0800
From: Alfred Wingate <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1022135/000000-cc4d4b@github.com>
Subject: [bluez/bluez] 6fa1d7: build: use AM_DISTCHECK_CONFIGURE_FLAGS
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

  Branch: refs/heads/1022135
  Home:   https://github.com/bluez/bluez
  Commit: 6fa1d7bf09439d74bf0f457d5288fdad656c712e
      https://github.com/bluez/bluez/commit/6fa1d7bf09439d74bf0f457d5288fdad656c712e
  Author: Alfred Wingate <parona@protonmail.com>
  Date:   2025-11-11 (Tue, 11 Nov 2025)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: use AM_DISTCHECK_CONFIGURE_FLAGS

DISTCHECK_CONFIGURE_FLAGS is meant for users to be set on the command
line.

https://www.gnu.org/software//automake/manual/html_node/DISTCHECK_005fCONFIGURE_005fFLAGS.html

Signed-off-by: Alfred Wingate <parona@protonmail.com>


  Commit: 0247f1a6b9012b20e5f17a42da9fe34da12679e9
      https://github.com/bluez/bluez/commit/0247f1a6b9012b20e5f17a42da9fe34da12679e9
  Author: Alfred Wingate <parona@protonmail.com>
  Date:   2025-11-11 (Tue, 11 Nov 2025)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Fix distcheck by hardcoding non absolute paths

Pkg-config gives out absolute paths that don't fare well with distcheck
that needs to install files into its own prefix.

Disable cups for distcheck as well so that only dbus needs this
handling.

You can learn more about this type of issue here.
https://bugzilla.redhat.com/show_bug.cgi?id=1123963

See-Also: 9cc8b97b8 ("build: obexd: Fix make distcheck")
Signed-off-by: Alfred Wingate <parona@protonmail.com>


  Commit: cc4d4bd91ec3e25b15cdafdd3f3b688c5702eb13
      https://github.com/bluez/bluez/commit/cc4d4bd91ec3e25b15cdafdd3f3b688c5702eb13
  Author: Alfred Wingate <parona@protonmail.com>
  Date:   2025-11-11 (Tue, 11 Nov 2025)

  Changed paths:
    M Makefile.obexd

  Log Message:
  -----------
  build: obexd: Revert "Fix make distcheck"

Bug: https://github.com/bluez/bluez/issues/806
Reverts: 9cc8b97b8 ("build: obexd: Fix make distcheck")
Signed-off-by: Alfred Wingate <parona@protonmail.com>


Compare: https://github.com/bluez/bluez/compare/6fa1d7bf0943%5E...cc4d4bd91ec3

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
