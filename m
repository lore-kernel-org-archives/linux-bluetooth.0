Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61818368D70
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378537; cv=none; b=Vqg9OOnsLc8ZsMN0BAEtTob4sNn0mUDuv0KrN8sfv3bg2k24ceUk13Lmk9qS9ougvrEX8lYyNWUAiWXsPyswmaOwXbDRpU1SdQmhZZR7UkXqw/t+BkqMNx/7Z/aEp5hF14Dz0FJUXO81y123tDK1KePY2rENpWPW6KGGNETF6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378537; c=relaxed/simple;
	bh=K3UwH8YOcZMihTs3Vdav3Z5LNw3o3Dh4EzAkVvcWoWo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Jl3MH+xNHjH7PEbKZ9S2MC4Dg9MWiAhMh6my90XynzKPCilumE5r3UKSYEmh4NxOS05jGJwkR1wI2THURgEpf0917vO/+QJeZZYwvbaU9etcm7Ty4ox1cpbM6X1I0kycbiRk+i+JBBIDqXelo4NKzGUA0DJAHXjoyAV8azWg930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VTvRQmA9; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VTvRQmA9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779378534;
	bh=wqmHw1+j8LykOtEDImsEmg7QHEook1RU4602ID7ljj4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VTvRQmA9oMMOjWvE9iGPIIXcZT+/h59Kw3wYS8S0m5KZyThg7GBEa+5dpe3dNWD0o
	 JZAWJ+b5AeVuT2Ts6T0JuB9UPIZSDEFWkmCYauUlGAy9Yg58NhTDdSdU5BB84F74bP
	 Qr3XV0kzmGCKnyi/gRfnXibSb0gwJdgHeZPXKskY=
Received: from github.com (hubbernetes-node-3180c8a.ac4-iad.github.net [10.52.145.58])
	by smtp.github.com (Postfix) with ESMTPA id 259E0740FFA
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 08:48:54 -0700 (PDT)
Date: Thu, 21 May 2026 08:48:54 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/80ebbf-c1b86b@github.com>
Subject: [bluez/action-ci] c1b86b: ci: add verify_fixes and verify_signedoff
 checks f...
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: c1b86bca7cacc936bea82b3ca8b2ee4b4fcb6e74
      https://github.com/bluez/action-ci/commit/c1b86bca7cacc936bea82b3ca8b2ee4b4fcb6e74
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M Dockerfile
    M ci.py
    M ci/__init__.py
    A ci/verifyfixes.py
    A ci/verifysignedoff.py
    A scripts/verify_fixes.sh
    A scripts/verify_signedoff.sh

  Log Message:
  -----------
  ci: add verify_fixes and verify_signedoff checks for kernel patches

Add scripts from gregkh/gregkh-linux adapted for GitHub Actions:
- verify_fixes.sh: validates Fixes: tag format, SHA existence, subject
  match, and ancestry (removed external Linus tree dependency)
- verify_signedoff.sh: validates author/committer Signed-off-by presence

Both run against origin/master..HEAD after checkpatch in the kernel CI
pipeline and report results as warnings to patchwork.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
