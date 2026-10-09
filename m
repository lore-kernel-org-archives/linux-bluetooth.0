Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA92D77F5
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557341; cv=none; b=BzXW/cbhwqUr2ZUVY0qxlpzYMroN7FeO9kn4D2su0d4SaxMiR0j4dHF9w+Z03hKTo0ASpSD4xnuq0DQigQd3AOxr5lqf/hjoWNi596uxX2ERHvGvf/Qhf/KzCN60E0ETrW/xznm+oBV1ffwEpWw5QV/WzXMktYfzesuTqvW2B6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557341; c=relaxed/simple;
	bh=YMaE7xjtO9olQTAe2651P3O2teKKFE7psqR9YWmXWfM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FftqzDjmd+M38R4hoE5lUwLgMobSUEJW97Eu90PF8wex1gJ43svQjC0MPlwMW/59qXsPeCF2QildIw8q7tEwOg5LX+7aSoyJgKYhE4tpnRMKcS57wjrqodnwUV2m+cEpq2q/heLn5mJ51wiy/7yCtbVV3UlS3cSGjlDk1j83GoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=cZnkU83H; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="cZnkU83H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791557339;
	bh=MKsnVbqCVfnWAqkwkQQKGFhCMv9GfesP2vxLpE9SN/o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cZnkU83HuFcQqf7BPlaiYfHefowvs/PAj07KU0to0QErQirKyuNoym9qIE3CDCgv3
	 +z86LhJ0zB/FaUXdoTNtR1E6oZpKNv2H9U/MTk0yzAM54Em+tw/YVLn/KhHe0zX9qy
	 6KEz6wE1ypGwWPBqJUhX5SXGtKrf/vpy16S7SYVw0xsaKgDKG96N6bNhdYR1p+p8I/
	 1uZK+8Wz/y551D5xVAdiE2BJt5R7FsOJJpW1r65OibwvIORBn+mfr+odcbcImfVd4A
	 FWuOjZBEUjQq+NYQoJT8hA+rOOoLNqmH4l+msuOvhpxnEt16aki9ln0vhWwSL0G/zb
	 uL6x5cd5h87ZA==
Received: from github.com (hubbernetes-node-e54636d.ash1-iad.github.net [10.56.128.65])
	by smtp.github.com (Postfix) with ESMTPA id 65D851804CB
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 07:48:59 -0700 (PDT)
Date: Fri, 09 Oct 2026 07:48:59 -0700
From: GBerfield <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/866b0b-a57c6d@github.com>
Subject: [bluez/bluez] a57c6d: client: Handle system bus connection failures
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
  Commit: a57c6d52e7cc87e30768d09aadff4c7b3a736938
      https://github.com/bluez/bluez/commit/a57c6d52e7cc87e30768d09aadff4c7b3a736938
  Author: Gabriel Berfield <gabriel.berfield@gmail.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Handle system bus connection failures

Report the system-bus connection error and exit before attaching the
object manager when the connection is unavailable. This avoids a libdbus
assertion abort in restricted environments and releases the initialized
shell state on failure.

Fixes: 8a05f2b1ac91 ("client: Add initial parts for the command line client")
Link: https://github.com/bluez/bluez/issues/2446
Assisted-by: Codex:GPT-6



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
