Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE141C2FE
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544127; cv=none; b=NyAdbJ1z2yc8JbNJ0cA4+5nGQ37FpRgYPkHk6mgYr2KQWwedWsVOv0qNKCOgUN529B9KPlS7klx3swCKRggLeJdHd3s9qUo6qZZly4lx1Ko1WzF/l5SPr5Us5lZ6SmVpnCweGdcMlXCcvfMSWQpx8gy8Q0jlgtQbuQfYwYpiXLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544127; c=relaxed/simple;
	bh=cgGcFPVCiZMecHWStUbXWkq4yaRys1nuOMCcANTZz/s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=V2igCBg75UUjKJDMSRe03CC9mRS5lTA82uOigD1/uUsUBzrd1kPP1bWQwkhdx5nBNhRy9oy0adH1GW9nWBD4vg1xFs6yG4Ej0TbQOuIVQfoQz/afdOrqob2I8daic8Fbuzn6hnvkO+eLb0KuvbAl2VN2kzpezvgM/Htn7uEZXCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kVAuJPF4; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kVAuJPF4"
Received: from github.com (hubbernetes-node-ecc96a5.ac4-iad.github.net [10.52.147.30])
	by smtp.github.com (Postfix) with ESMTPA id 95C3D300B3E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 09:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774544123;
	bh=G4SCEzIhbMkq+18St3D1zMbhZW7X+uUkD3uD8HWw9BM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kVAuJPF4QYNe+rEGo3zXnomLWlY+880L/X8GctN0X3JrLq3mJDy5MgjagK2JtBQUw
	 8WIeNEEhnjLA0ZkjvI7SUW0jahaK4Y+qVHrCS1qtH7FNIRFJettB6XvXcUmFqxQ5Ue
	 Asb/po4vJeXa/9EjZw6raeDu8TRZnFpndYv+fwoY=
Date: Thu, 26 Mar 2026 09:55:23 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1073069/000000-583400@github.com>
Subject: [bluez/bluez] 583400: mesh-gatt: Fix JSON files missing from dist
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

  Branch: refs/heads/1073069
  Home:   https://github.com/bluez/bluez
  Commit: 583400c7a19f5eba82a3a63eb9dc1267d3fca145
      https://github.com/bluez/bluez/commit/583400c7a19f5eba82a3a63eb9dc1267d3fca145
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-26 (Thu, 26 Mar 2026)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  mesh-gatt: Fix JSON files missing from dist

Moving EXTRA_DIST into a conditional means that if the dist isn't made
with the deprecated tools enabled, then files will be missing from the
distribution.

Fixes: 1f6553edd8a5 ("build: Deprecate meshctl tool")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
