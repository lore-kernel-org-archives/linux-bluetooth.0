Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475628726E
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008030; cv=none; b=loO5K+eOryvGdLg1Va2ga2Cm1wuMc5BXGvdv/w+YbCl+cOC9OBH/th2GbkP6l96W3LeR4kCAyqJWi4r8SSzIOIXIGhUudVaswg96T8x5RRXf5dkfQa6fJD3SyiU3fJZWV3o8TyxSMZNESbV4mB9fOzbwMvhSuJKcN/kEB7d9Qy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008030; c=relaxed/simple;
	bh=i0R4+7mgujp4tAlPmR1qP+2/dWqAs3XVvZrU/uM22pI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=emUos1WV9k726hmNG4PxoE5eisFl9znP79NL8CmDHC+QDPEjEgomUJboHZyBUvFxofAMAnEEEGApu0AngEucHZ0SOM2l6IrTicTTcZ4tFm7XaruJo/g052Vfa/XNjNrJe+VRP+5mFgSaik7pbgJCZ69WrVoiMPwuLaq4a8p08IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dbvijJM/; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dbvijJM/"
Received: from github.com (hubbernetes-node-e36b032.ash1-iad.github.net [10.56.173.27])
	by smtp.github.com (Postfix) with ESMTPA id 66EF81411C2
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755008028;
	bh=pxg19sbbCMxcQjWXsKXvGxC6E9MccSS/BAXTqNjKy/g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dbvijJM/Z+ABE+UA2Q88XaNMfXissROHt1NIwuxMEbmhURFuPb5nfH2TTQsBbRLxl
	 fOX0pSW7TNaRZljUIenUaA/wKJcDhRGAjcqnGY9iWA6FSfppimwniKLh9D8u8Bpvno
	 UcYZ1qymRG7IOBxX4tgpznC7sSgMiw637fc5PL1Q=
Date: Tue, 12 Aug 2025 07:13:48 -0700
From: Stanislavs Nilovs <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8a304f-0491cd@github.com>
Subject: [bluez/bluez] 0491cd: Fix memory leak when adding GATT Characteristic
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
  Commit: 0491cdf317542c09d7c8a5d80578560257289628
      https://github.com/bluez/bluez/commit/0491cdf317542c09d7c8a5d80578560257289628
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
