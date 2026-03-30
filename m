Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8141A8F
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882992; cv=none; b=KP0hKOUY3J+T7NRIIwT/e6KAW4XXHay/Oox191GU7ISBOBb2TL/utVJnNUkqBH56mcxXKJONC+477zFDy6pThBGQFnNAyKWIqRE6fMxB77kb1zabLIh8EcDtiJ8UarArM/wJcD/7tDiyLQm6gJ5OkFay3LJMhm5IQOzmE+gbTrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882992; c=relaxed/simple;
	bh=c0f8guQkHX7zILSp99xzvnKfqCF4mcchPcgvrIhhcgc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JVjrb+QPVVzM77s0X3EUP/U9kSj5n0md4lCpffSTJ4wIJ0Vmg6uRf7sHeyttun7rz8OP7fu9dl7OVXH+GCiyWrqEw0ENhsdlkJBI2CPCS0cMLhCyYBCQTE40bQsNjaFwDoPZR0FkZfzEOwu8Zf0EuJtLwxMKLOfWO/fIOt4MEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dELEJAqt; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dELEJAqt"
Received: from github.com (hubbernetes-node-60413e9.ash1-iad.github.net [10.56.184.34])
	by smtp.github.com (Postfix) with ESMTPA id 4D268920257
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774882990;
	bh=29Xlfll0cevnTYhuKZ7VtsRmmFWGspYzPw9dMsUwgj4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dELEJAqtLe7G0rh0FlyWIdB6hp2Bs6Xii/KkK4AUojoa4KkTyzAcafnG8sUiXkIs6
	 6JPaDd3VFOTPbd9LSNVCWCTf5XtanwneNYIHbdgmAv6w2yCHm2k80ecrcrumg+48m0
	 1W7S2GeMeUnfmCj815VP6NAeYm9epbi/MQWUl54M=
Date: Mon, 30 Mar 2026 08:03:10 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1074645/000000-bc752e@github.com>
Subject: [bluez/bluez] 82f7f3: shared/util: Add MIN/MAX implementations
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

  Branch: refs/heads/1074645
  Home:   https://github.com/bluez/bluez
  Commit: 82f7f35df3a9a35fb1ffdbeef1fe083e4a3a96fd
      https://github.com/bluez/bluez/commit/82f7f35df3a9a35fb1ffdbeef1fe083e4a3a96fd
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-30 (Mon, 30 Mar 2026)

  Changed paths:
    M src/sdpd-request.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add MIN/MAX implementations

And remove it from src/sdpd-request.c to avoid a redefinition warning
at compile-time.


  Commit: bc752ebcb542a23f1efc1c688bcd92976be229b3
      https://github.com/bluez/bluez/commit/bc752ebcb542a23f1efc1c688bcd92976be229b3
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-30 (Mon, 30 Mar 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Remove compile-time header only glib dep

btvirt relied on a glib header macro to use MIN/MAX, but didn't link
against it, meaning that it was dependent on other programs in the
project using glib to compile correctly.

Remove the include and use our own implementation instead.


Compare: https://github.com/bluez/bluez/compare/82f7f35df3a9%5E...bc752ebcb542

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
