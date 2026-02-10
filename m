Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF035C1AC
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719398; cv=none; b=NJHbbe4TuOQlh+NHrCpf5n3fQLl+8I38mWCxJ8+gt5Iwq1qqfA9BbMwa0myhJ1hN0XZQ6tGlIEsnxufpktImtxYew8zFJ3Foxm2AM4rlfpSDVnbED5sp9Kky0J5d8U8yqm5qkXgBHkrwcaPX/I4yrwVQIQg/Z5L6tCSo+j4txZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719398; c=relaxed/simple;
	bh=iLxGioLLHwSvqS6u3mxyB4GQN8p69h+wnke3zPYLRKs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Sr0TPngUbWWg9FJZhCfeLo/RWLd5p0qtpdzoew1Y/mBUM6JoT7ahAjqXnvUrZDdxi20yHUxMmkBj2Ew+XESx2jrWmuI6z3LP7eQRoghkePsZ9sqIyUwPeRBKNFvWLkK8GJtyIm+RJe47Igy8UhdTd84afWv1Efv0O5LKPwQ5jvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jAMfAubo; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jAMfAubo"
Received: from github.com (hubbernetes-node-e7ca5b0.va3-iad.github.net [10.48.210.59])
	by smtp.github.com (Postfix) with ESMTPA id 3F2783C1279
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 02:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770719397;
	bh=H1crPKrGtvGNg9n50QdIqjlpWQekvIAQUj4slAaJrb8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jAMfAuboaMqp/YePmK8PgFxPmkOI5RZOanQ25gSDSPJ9iINoaYTGiFbnNUyhgy3gO
	 eMwYpHQ9DKhL8CP4Lnq2r0yqCJmhB67wFTZTxObbvx8n6Ie5J0tRU/MZVetnWYY4kW
	 YZXpIstndPe6Zpk98VSTjAdIITsotsKdZ50i5nJ0=
Date: Tue, 10 Feb 2026 02:29:57 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1052631/000000-e2bb5a@github.com>
Subject: [bluez/bluez] e2bb5a: emulator: Fix compilation on big endian systems
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

  Branch: refs/heads/1052631
  Home:   https://github.com/bluez/bluez
  Commit: e2bb5a9cd38cae80490fbd12cd3861ed8180f3a7
      https://github.com/bluez/bluez/commit/e2bb5a9cd38cae80490fbd12cd386=
1ed8180f3a7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-02-10 (Tue, 10 Feb 2026)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  emulator: Fix compilation on big endian systems

This fixes the build on big endian systems like s390x:

Remove the "static" so the array doesn't need to be initialised
with constants.

emulator/bthost.c: In function =E2=80=98bthost_setup_sco=E2=80=99:
./src/shared/util.h:43:26: error: initializer element is not constant
   43 | #define cpu_to_le32(val) bswap_32(val)
      |                          ^~~~~~~~
etc.

Fixes: 85888a8357ea ("bthost: add bthost_setup_sco() and accept
incoming eSCO")



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
