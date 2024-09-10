Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE11A76D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996757; cv=none; b=Zk2EzJiJA0uGve8HgcOj9Jf1wghLY1gdYfreaQy6eXvM+7aHN2PgTIMDitXt3FaWvtci4BrffaGdWshkOi7Sf/5Gd1QakoQUwZLFszE1CFm/I8GilS1TRZrm1+1EwJ/F424skFSfOImaF581uybA/1GoNJNxIHXZ7fXLffdIdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996757; c=relaxed/simple;
	bh=qYRK3eSe1mGHgC3NBKzylLzwRu8lejKkGWsvoL9eLI8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OoNp+ia0kPTDERcCM01a32C80ldRQ5Fbzt31++TknwSeFKYcyP5tzfAZhRGr3AipbxrLOa+fnmwxN4PbKwrplWJN+sgvnLgWAMIMPXpOtvHJ0y5ZFOlmAXOBRXfvfnFxfCCLZKVTAVLD9nzr2yR70LthJvIZ/kE4iHcvsuGdXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kqZ2Mf++; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kqZ2Mf++"
Received: from github.com (hubbernetes-node-bf34b8e.ash1-iad.github.net [10.56.171.16])
	by smtp.github.com (Postfix) with ESMTPA id C43B66C11B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1725996754;
	bh=vuksIxZiy3IHvAWsrOiCWb9C+Zch6Y6uk3hex0P19cI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kqZ2Mf++k6zFXMwKRkrFEq4E1eEsyno6J1tJHgJQ6lTok/DTSM+bwv0gWZm/N1vcn
	 BndM1M8S1Wjvswqp96wThZC4AV7uruXZQ2hvDgl2YaVKUmItIchACJ77Z1d2gm/5gL
	 PLP9M4GrbfurRHc80DVDO5vKwxymolQf5jeRdeoc=
Date: Tue, 10 Sep 2024 12:32:34 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/54866c-615fc3@github.com>
Subject: [bluez/bluez] 690ecc: mesh: Provide GNU basename compatible
 implementation
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 690eccbe8562cc33f33503af67beb313ca737817
      https://github.com/bluez/bluez/commit/690eccbe8562cc33f33503af67beb=
313ca737817
  Author: Khem Raj <raj.khem@gmail.com>
  Date:   2024-09-10 (Tue, 10 Sep 2024)

  Changed paths:
    M configure.ac
    M mesh/mesh-config-json.c
    A mesh/missing.h
    M mesh/rpl.c
    M tools/hex2hcd.c
    A tools/missing.h

  Log Message:
  -----------
  mesh: Provide GNU basename compatible implementation

Call to basename() relies on a GNU extension
to take a const char * vs a char *. Let's define
a trivial helper function to ensure compatibility
with musl.

Fixes: https://github.com/bluez/bluez/issues/843


  Commit: 615fc3592a57e32b42691a16b5d5cc88e378cbc1
      https://github.com/bluez/bluez/commit/615fc3592a57e32b42691a16b5d5c=
c88e378cbc1
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-09-10 (Tue, 10 Sep 2024)

  Changed paths:
    M gobex/gobex-header.c

  Log Message:
  -----------
  gobex: Replace g_convert by utf16_to_utf8

The glibc's iconv implementation is based around plug in modules
for specific translations which may not been built on the platform
and prevent to use g_convert().
This commit replaces it by a function similar to the existing
utf8_to_utf16() function.


Compare: https://github.com/bluez/bluez/compare/54866cee3fad...615fc3592a=
57

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
