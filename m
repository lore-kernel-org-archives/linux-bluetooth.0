Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358BB3E6DD4
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312682; cv=none; b=Mjt9mkQMOB56GFMd/OR+psgOva4iu3y25Ax0HS4sRmmmVBqoL7SQbLakxawkr5YWBb5grN/TaEpoM0Fpzya2IZ32Ug+ZxLkHiE4UWdt7rDCZZHZOyam9CPEQsGZhvQGwikqFkHLeWu5rfb7f4GwRoq60nhohtV+pFPX+PGlPG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312682; c=relaxed/simple;
	bh=EjTSj7NTo9ccGUTaxDFHdohGYInIUMtk+4uFhV01dVY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZxudmHawnXXqsgU8ILdYJfXSui3oC9egxyu867d4hWhxXG0PvOSBA4Rl4t/Ypy2EGURdWzJlQHBN4SXjH0vWbwE0udpuqRzY6zlARaQOc4DvHk8Uhft+uQCxzDZuFHySf8xPJfvaqoW6N3HvzAUH8TKiuSOLubeFyowqHe5NNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E0H6DqIV; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E0H6DqIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777312680;
	bh=Z6SXPZP6neFfvcKAMrlDLjvAnhKliZsbtvTdwyirUwQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E0H6DqIVtr//j3FSdMHtes73zjBKZ8bX37qwAD2t8ZhmmTKiKd3WMTMTktZpcY7un
	 XnIMvprmXGH/ifTTy42tNAYwBRzkV/T8wvnQuFhJTAixr8nIB9c6CKTLQG6yds0SGR
	 FF7TM23qv1ETijDqGY2YrrQ1ohJ7bDThWk175sqk=
Received: from github.com (hubbernetes-node-2dc1abb.ash1-iad.github.net [10.56.178.34])
	by smtp.github.com (Postfix) with ESMTPA id 46AF784119B
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 10:58:00 -0700 (PDT)
Date: Mon, 27 Apr 2026 10:58:00 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086284/000000-318956@github.com>
Subject: [bluez/bluez] 5858e2: src/shared: Add RAS packet formatting and
 notifica...
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

  Branch: refs/heads/1086284
  Home:   https://github.com/bluez/bluez
  Commit: 5858e22147395b6b6660c241fadd9c221292e086
      https://github.com/bluez/bluez/commit/5858e22147395b6b6660c241fadd9c221292e086
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-27 (Mon, 27 Apr 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  src/shared: Add RAS packet formatting and notification support for CS reflector

Implement complete RAS data pipeline:
 - Handle HCI CS subevent result/continuation events
 - Serialize ranging/subevent headers per spec
 - GATT notifications for real-time ranging data


  Commit: 3189561250284aade1a61715ddf85052531d3842
      https://github.com/bluez/bluez/commit/3189561250284aade1a61715ddf85052531d3842
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-04-27 (Mon, 27 Apr 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles/ranging: Read cs_mode_one_data members as per spec

Rearrage reading of cs_mode_one_data struct members as per spec.


Compare: https://github.com/bluez/bluez/compare/5858e2214739%5E...318956125028

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
