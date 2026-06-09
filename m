Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1037B003
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023112; cv=none; b=HnCvNIi38nOmtkjvoyW35zNVPEscSeVokEw+t3NDoEZ2J0FKzEWXjWKlcwW6Hqsnb7kQ3Ibec+RVhkHaKpDwqayyAKO6hPIIHBOjOQca/e7f/j+JJ6EHorycMgPdzVz1EtJvV3gAQzSIkU8ZaKse4KxdEAP3d5IsgfTaCYKLdec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023112; c=relaxed/simple;
	bh=xRCxJpI0y9t7FOk4HIAjxhFsuhOSkUqXXOyQRs3Ni2g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SyZE0Jgz+29ImHQ2quSlqkR/g4V6UWXwTWganr0kmFM8rXSC+/LWxl9XEQj4al7PS3fLCZ6RT5O8wH77QeyLaa6DS4aq8nXgmxOV8TLfo3cPgTDUDLuq4k0Q/cNYY9qReOZDtjrqQkv4MzSgcwceF6Wu4JKGOl8PS1zOU6z6dEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EtW5esKq; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EtW5esKq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781023110;
	bh=qvCsdUGke164WX2o5/nEDctW2ehECAaeCiXsy7mZvRo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EtW5esKqQP2rRyEnxJSK7NDrR1cNwsdvzyJg4pXJ3BGA+aDigK3LF22T4qLrjjmkm
	 Zmz3QI61b8Ne2tJ3ANGZLmSea2PDFa8/bDMxDti2nGlXv7r+EEkauwEgSS2hweQV0i
	 Sn8X+VnW5bSQgIK/K+M/8CmMzBN4dK8zTnG6WuNo=
Received: from github.com (hubbernetes-node-30d569b.ash1-iad.github.net [10.59.97.39])
	by smtp.github.com (Postfix) with ESMTPA id BB46136117F
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 09:38:30 -0700 (PDT)
Date: Tue, 09 Jun 2026 09:38:30 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108616/000000-e22bd8@github.com>
Subject: [bluez/bluez] 2fe40b: shared/util: Fix warnings when cleaning up NULL
 po...
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

  Branch: refs/heads/1108616
  Home:   https://github.com/bluez/bluez
  Commit: 2fe40bee6c48c4d72506d98d3283b8d1e981a75d
      https://github.com/bluez/bluez/commit/2fe40bee6c48c4d72506d98d3283b8d1e981a75d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Fix warnings when cleaning up NULL pointers

Don't try to free NULL pointers in cleanup callbacks, some of the
functions we use to free pointers might not support being passed
non-NULL values.

Fixes: 2e0533f977cc ("shared/util: Add helper for "cleanup" variable attribute")


  Commit: c58eb86c244e8fbdc32f9d58f395ad387ca67f09
      https://github.com/bluez/bluez/commit/c58eb86c244e8fbdc32f9d58f395ad387ca67f09
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Better type-checking in _steal_* commands

Replace _steal_() and _steal_fd_() inline functions with macros, so that
we can have better type-checking. This would have avoided crashes seen
in the original patchset, where we passed a pointer instead of a pointer
to a pointer.

Example usage:
CLEANUP_FREEFUNC(GKeyFile, g_key_file_free);
GKeyfile *load_config(void) {
  _cleanup_type_(GKeyFile) GKeyFile *keyfile = NULL;
  [...]
  return _steal_(keyfile);
}

static int open_file(void) {
  _cleanup_fd_ int fd = -1;
  [...]
  return _steal_fd_(fd);
}

This is inspired by similar code in Pipewire's spa helpers, as pointed
out by Pauli Virtanen <pav@iki.fi>.


  Commit: ab59047bfee892cae87896575ad65c8b6944e7da
      https://github.com/bluez/bluez/commit/ab59047bfee892cae87896575ad65c8b6944e7da
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M doc/maintainer-guidelines.rst

  Log Message:
  -----------
  doc: Recommend using _cleanup_ and friends


  Commit: b6f94e7d47b312ab1d373abf9a7bf1d7d32d50b4
      https://github.com/bluez/bluez/commit/b6f94e7d47b312ab1d373abf9a7bf1d7d32d50b4
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Use _cleanup_() to simplify configuration parsing

Use helpers to simplify temporary string usage, and cleanup in error
paths.


  Commit: 09fbfb78eb0834cdbe9f7353b186d481b17321f6
      https://github.com/bluez/bluez/commit/09fbfb78eb0834cdbe9f7353b186d481b17321f6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client: Use _cleanup_fd_ to simplify urandom access

fd gets auto-closed before exiting the scope.


  Commit: e22bd838f275c5144501bbbf961b91a28871c9e0
      https://github.com/bluez/bluez/commit/e22bd838f275c5144501bbbf961b91a28871c9e0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M tools/btattach.c

  Log Message:
  -----------
  btattach: Use _cleanup_fd_ to simplify error paths

Use _cleanup_fd_ and _steal_fd() to simplify error paths, and only
"steal" the file descriptor on success.


Compare: https://github.com/bluez/bluez/compare/2fe40bee6c48%5E...e22bd838f275

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
