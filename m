Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0186D2E6128
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987256; cv=none; b=UvnPnglBErK3C8QJpey5oAshC/goYndUpPqpit58m6d0YVrmTIvkk4/FeAcQyAfTO/wwoIc0WXnKjX4Ug9dhk5UQ1E1FLS3eIEmcDfhfA80Nf84KLzrA+Smj/fXuU1sObBhPnw0gM2tOp/YoGeGxYgyyZaRBpYxFkXuP3QyQX1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987256; c=relaxed/simple;
	bh=DSSbBcIKxJQIZMANuJUUjawpjklvaQhTojG8ibfdMN8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Qto2hjtpwrRE716JEoV4x7mI+465H+093QEUXj0XYZ4QpPjf/dHmhvJVYXSaDqmWG2Q6oihLG+fm+peKChToboCKkBoNbvgE32gYVQJM7nHRUOxWFcVTYnns8pAYrN9cVZbEbPKkkIptGbR0YDWvXDDyunlGN+0lQyVxyMKJPJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fRLzVseS; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fRLzVseS"
Received: from github.com (hubbernetes-node-4bfc311.va3-iad.github.net [10.48.162.15])
	by smtp.github.com (Postfix) with ESMTPA id BB13C4E1336
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754987251;
	bh=1uoKUs+cM1Q2565zoeHhH7wtgfJ2TmvL+wMHIN1b3xw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fRLzVseSjfB9z9beohp6TLZJ6XcCxWl2zm4hlSN/lmQQEQSSQod0594xo8JKDvbRC
	 hF31BOnG43TtnyFuvOa4J46Kal4b+0ubb6vtAHXrtPKY8gfqIWCEVMRmr6+xGqn1GN
	 FgUIl+qMw6MQmwixj1hlCBF82X+F37FG/Eub8o10=
Date: Tue, 12 Aug 2025 01:27:31 -0700
From: Stanislavs Nilovs <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990407/000000-d1fe80@github.com>
Subject: [bluez/bluez] d1fe80: Fix memory leak when adding GATT Characteristic
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

  Branch: refs/heads/990407
  Home:   https://github.com/bluez/bluez
  Commit: d1fe804dfe11ad92da41d3cc9e98f7e204304c8e
      https://github.com/bluez/bluez/commit/d1fe804dfe11ad92da41d3cc9e98f7e204304c8e
  Author: Stanislavs Nilovs <valorcool@gmail.com>
  Date:   2025-08-12 (Tue, 12 Aug 2025)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  Fix memory leak when adding GATT Characteristic

Commit 4465c577778d812702d752dfd2812e25a2f69b31 has fixed a segfault
which may occur during new GATT Characteristic insertion. However, the
cleanup exercise isn't done before returning.

Bluetoothd address sanitizer backtrace:
=================================================================
==88967==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 768 byte(s) in 6 object(s) allocated from:
    #0 0x768d1f8b3ec7 in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x59f0cac1ea07 in util_malloc src/shared/util.c:46

Indirect leak of 576 byte(s) in 18 object(s) allocated from:
    #0 0x768d1f8b3ec7 in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x59f0cac1ea07 in util_malloc src/shared/util.c:46

Indirect leak of 114 byte(s) in 6 object(s) allocated from:
    #0 0x768d1f8b4097 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x59f0cac75d6c in new_attribute src/shared/gatt-db.c:222

SUMMARY: AddressSanitizer: 1458 byte(s) leaked in 30 allocation(s).

Additionally added an explicit check that current Characteristic handle
is not greater or equal to its value handle. If value handle is equal to
Characteristic handle, then second "new_attribute" allocation will
overwrite the pointer in service->attributes, which will also cause a
leak.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
