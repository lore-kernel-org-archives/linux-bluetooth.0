Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20312F745E
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612396; cv=none; b=OlUUESWvj/QMUS9aGc0Htk6LE8+KFWNiQXh4UlN/kn22POmcoYrzVvvprc2aqQx2mp5PGmPTn98pvb822sjwOOsT3IGChnManqzO43htAuCLXNiP6EM0z94fOAKE812Zn4ldBnIcY4Vc+C4TWPsODKAJgTcsE2FQECSotWkSgbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612396; c=relaxed/simple;
	bh=Kp/i9RHo9spsmsoh4ssrAaJZoU+XTDpPLDMn5Cleptw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g/bpqsi+hcf8jRkYPaYEwbIpv5icxrNzA/7fz/OkCy07Hcg10oayyIIElMYrAjKxpeK7DQBKOP71Z4sRcaPEDeVnSL14FB47E9I6xKOTW1rk8mooT7h3mnlIsj3L3zDaOsd3hAYcTrIlz0R843Ygox+cZcG41p0lb7WC1hkMD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EF0VNPgb; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EF0VNPgb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781612394;
	bh=IA8TGBYVYSYSUjw3o6/Kg29EXSmr+09oTtzlAWcUIeQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EF0VNPgb4v9fDs45PwsAcKRW4KO6fvfomm0QXXeuXXE7Ot8S1f1mmeE/sPYUqENyC
	 b9HEmX0yO+ceAdKJwKvZhJ1UVL1jYYNQT25F7yMPiSLzdsKMa5c5EyYgRqWSgOGwiQ
	 8pU9eGYDjmDOotw46Lco4KEqWMEhB9IxM2QIoB20=
Received: from github.com (hubbernetes-node-56ef1e7.va3-iad.github.net [10.48.210.99])
	by smtp.github.com (Postfix) with ESMTPA id CE13C280CA6
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 05:19:54 -0700 (PDT)
Date: Tue, 16 Jun 2026 05:19:54 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1112149/000000-fd0161@github.com>
Subject: [bluez/bluez] fd0161: hci-tester: Work-around possible string
 overflow
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

  Branch: refs/heads/1112149
  Home:   https://github.com/bluez/bluez
  Commit: fd0161f8f6af60019a11b003772a5655ae05c632
      https://github.com/bluez/bluez/commit/fd0161f8f6af60019a11b003772a5655ae05c632
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-06-16 (Tue, 16 Jun 2026)

  Changed paths:
    M tools/hci-tester.c

  Log Message:
  -----------
  hci-tester: Work-around possible string overflow

Quiet overflow warning by checking for a non-NULL destination.

In function 'memcpy',
    inlined from 'test_pre_setup_lt_address' at tools/hci-tester.c:67:2:
/usr/include/bits/string_fortified.h:29:10: warning: '__builtin_memcpy' writing 6 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
   29 |   return __builtin___memcpy_chk (__dest, __src, __len,
      |          ^



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
