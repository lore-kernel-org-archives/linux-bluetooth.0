Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03D54704E
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318785; cv=none; b=fjaPvOGFgWeGV+DFRMRtsTxPy2cGLyMsP/I6VzWOPJd6tqK28Z7H7oaqjtZBr1eo0e5AJEDgJwUaZmFuek38vE2rSfId5bqzosUgiyMJwtdkuj2odg/Lf39wkov+0y+ix4n+Z0i1ku3DgF9G4Riu++52Y5Au8RTtGPu10EuTMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318785; c=relaxed/simple;
	bh=cTOGVJaN7rB24Y8rtXyNCdPxObgFwNkOcphUw0GyUbw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oi0xP0+fnuzXeYHWQbxHgnFlwRaEj9YAwsfHhISd0P9Iwq/3+G/bx8WG2lEbrnMvrwoLHthzdxpBbuv2EddbH0nzZWgvToWM2lkPhpDwJdYt4dVipP9vub0LjZW/WdjSwo319ZmnH1bwjS9ITYCHpEozzOa3WvBT33cl3slr0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=ha9YeQV2; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ha9YeQV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791318783;
	bh=ui1r9r0yptFmTYV8bN1lE1QaxM07cwYvVCaHGty58Nw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ha9YeQV2uzSfc8jwV7zos5bIhQOgAER9kPWipUSkH7uDVam8b+7O2yiA5Gr85CnVB
	 lftPGD6M+oiJ2VuTG32Uy1jMEi7brDck4AzYZuFprTOm8+Luyd5jZDdnnYJb/lC8hP
	 FWEJG8Nk7r/juoWUcZeNXxa2Lp7ngWSuxOFlHP8nw+0DfQZBVHdg73lNNdFJqI+V6u
	 zAwIVB+lskjYQmlcW5m5yUtOiNkzhfPuYAuGm56bLPCFbzfRGzcctYmgpXkv6oBaqO
	 BLgf99LuZQObJNgc2+ypbAEk+JveaG7kL+UUh3+CatrJ56paLy5xrm6QSPpOPpaIdc
	 /UT0sa5TRRKHQ==
Received: from github.com (hubbernetes-node-8d30bac.va3-iad.github.net [10.48.66.105])
	by smtp.github.com (Postfix) with ESMTPA id 38F01800B2A
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 13:33:03 -0700 (PDT)
Date: Tue, 06 Oct 2026 13:33:03 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7edaa6-f8f352@github.com>
Subject: [bluez/bluez] 9b18cc: doc/mgmt: Document Advertising setting as
 Global A...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 9b18ccef2c09c3c33a81a3e7e4a8284e6f3553fb
      https://github.com/bluez/bluez/commit/9b18ccef2c09c3c33a81a3e7e4a8284e6f3553fb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M doc/mgmt-protocol.rst

  Log Message:
  -----------
  doc/mgmt: Document Advertising setting as Global Advertising

The Advertising setting always uses instance 0, and with extended
advertising it has a dedicated advertising set, so only instances
sharing that set are overridden by it; the others are advertised
concurrently and removing instances never disables it.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: f8f352d133faadefbf1c6c476c0d9272f64d8c3f
      https://github.com/bluez/bluez/commit/f8f352d133faadefbf1c6c476c0d9272f64d8c3f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add Global Advertising tests for extended advertising

With extended advertising, instances are advertised concurrently with
Global Advertising, so update "Set Adv off override" to expect only
the set of instance 0 to be disabled, and add tests checking that
adding an instance enables it and that removing the last instance does
not disable Global Advertising.

Assisted-by: OpenCode:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/7edaa6140339...f8f352d133fa

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
