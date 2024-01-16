Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC61DA24
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432334; cv=none; b=VDdSxXf4xCQEOcJqPVxPuzdFsM1WcE0+4mOujXfb4SIvYHTeqOODasKAZ3NllAx8IINYW3rXZoKW++2ykqgVtL6JcbmlIUgdB90BOWQAJYVYjOpRXg66hXDeAWdejp3gd0poooIG/Yu+ZFIoVfxMq8Aza0QHTOPToeOgiXvRXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432334; c=relaxed/simple;
	bh=35ULWa5SYpSNQZQkL8y9vDTO5oRwlUuDRNWTP6w4KAw=;
	h=Received:DKIM-Signature:Date:From:To:Message-ID:Subject:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:
	 X-GitHub-Recipient-Address:X-Auto-Response-Suppress; b=e/Hpp+MYAKWlGhYGnFPpTjJz0yFGx1bOwMlFH4RWHREK20IXBp3cvVQoc+3U6sh3bMJ8Nppe0R6QYllUtMYzh3TipMgFfMmT/ehoaCF/LGfwOfDMnk4eU7hj1Lq5MmkSQe3U4vqmIZ0w9ev5l030aKNO6KlQ0e/P7wm5+w8TfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eoRvRnSt; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eoRvRnSt"
Received: from github.com (hubbernetes-node-47a3d5f.va3-iad.github.net [10.48.134.44])
	by smtp.github.com (Postfix) with ESMTPA id 33F4F8C118A
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 11:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1705432332;
	bh=dHNJuyMTJMat+s6mlLL/C5IOFcBhnXpI+9JDCHfDpBU=;
	h=Date:From:To:Subject:From;
	b=eoRvRnStHoMYEgxZK9QL9aEHQ9/126Y5BCoxj/vQMqra2ke4m3+sakgtaeSY7p9bv
	 W6lCd0fkmgHlIIKmq9fNcMupjUERcdTlF7LxUH8ACd6rQ9F/4rHp1BPOZ5mS0fgw/M
	 cc8cm+XTHyNsv+UhZHx2cXIeUUSa2cg3XEy+lJVg=
Date: Tue, 16 Jan 2024 11:12:12 -0800
From: Emil Velikov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2a3e93-3f490a@github.com>
Subject: [bluez/bluez] 6d6294: build: remove unused AM_CONDITIONAL
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
  Commit: 6d6294036c398d2c0e7aef7e86b9f012e1ea4555
      https://github.com/bluez/bluez/commit/6d6294036c398d2c0e7aef7e86b9f012e1ea4555
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-16 (Tue, 16 Jan 2024)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  build: remove unused AM_CONDITIONAL


  Commit: c07fb1fcddadeb51c36b6adfbcb8cf0122766348
      https://github.com/bluez/bluez/commit/c07fb1fcddadeb51c36b6adfbcb8cf0122766348
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-16 (Tue, 16 Jan 2024)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  build: tweak PKG_CHECK_MODULES calls

There's no need to call AC_SUBST after a PKG_CHECK_MODULES call, since
the variables are always set. As an example: the produced Makefile.in
and Makefile are identical before/after this change.

Similarly, we don't need the "dummy=yes" and manual AC_MSG_ERROR() call
- pkg-config (or pkgconf) will produce the same and in some cases better
  error messages.


  Commit: 3f490a69cb55a4bcea1f4cb51a053d7f9f8237e5
      https://github.com/bluez/bluez/commit/3f490a69cb55a4bcea1f4cb51a053d7f9f8237e5
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-16 (Tue, 16 Jan 2024)

  Changed paths:
    M configure.ac
    M monitor/hwdb.c
    M src/oui.c

  Log Message:
  -----------
  build: require libudev 196, circa 2012

libudev 196 (systemd really) was released back in 2012, which introduces
the hwdb API. Bump the requirement, since even long retired
distributions like Debian oldold stable (aka Buster) include newer
versions.


Compare: https://github.com/bluez/bluez/compare/2a3e935f3f65...3f490a69cb55
