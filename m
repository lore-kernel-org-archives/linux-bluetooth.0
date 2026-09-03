Received: from out-1.smtp.github.com (out-1.smtp.github.com [192.30.252.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A41639F184
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477214; cv=none; b=L20wf8YpKKKJHQDiZmGoXrahBTq2opVg3v2h6ksn8U2COCgHO8A1qlUJnLMw7NX7xyeku2HBXyDHRziGgmNZke6R424L23jsP0faWgnQWHTR2HQh5anm6srlyRmrHrs64oaqFvszkOlUhk0QoK48nnpcCdQQSfDVV6O3I48kR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477214; c=relaxed/simple;
	bh=WYCHju0fokymIeI/liINw3LCH6rQlSf53q9OgyWE4m8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hyVSLvTetzmf6Y5zqC+4XB2y/KiuZzwHS3Hp06V4rvmLjZSmhhC2KIHxy+xANbBZvGXYrtJBMSNqsSIR52gOcZQXLvfQUrkCVcyUoi2mjt7kNxZ9+dRQUrpelRam8GLT0unhhhuzMelBhdfswHRajsvK5AMu02nUm6rmlorQXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WDyx99ZY; arc=none smtp.client-ip=192.30.252.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WDyx99ZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788477210;
	bh=Tn+2qSKsqre7y4pfa3O2O5rB7U6TyLrijIV/pO+25wU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WDyx99ZYGU2AfBnHPL4e0Trv59z+foDqQlWWg4Xqdcy93uJftVJQYc7h6+RF4PCfc
	 9Mt/eviTW5bEJGX8nJLlA5C48RgLLssha0FKUVpJjqymZkc1RyNWxr+DLdBvDdYOfW
	 HDFnKf4kFn5TW9ONbWbGv8X1qCFYeIXmTJEcWhBY=
Received: from github.com (hubbernetes-node-154b116.va3-iad.github.net [10.48.75.95])
	by smtp.github.com (Postfix) with ESMTPA id 6AC0B340624
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 16:13:30 -0700 (PDT)
Date: Thu, 03 Sep 2026 16:13:30 -0700
From: Aaron Brice <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1157441/000000-897d4c@github.com>
Subject: [bluez/bluez] 897d4c: btattach: Update for glibc 2.42 compatibility
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

  Branch: refs/heads/1157441
  Home:   https://github.com/bluez/bluez
  Commit: 897d4c2f6221c1bc284a8a57ea06085a4d85d088
      https://github.com/bluez/bluez/commit/897d4c2f6221c1bc284a8a57ea06085a4d85d088
  Author: Aaron Brice <aaron@embeddedts.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M tools/btattach.c

  Log Message:
  -----------
  btattach: Update for glibc 2.42 compatibility

btattach is not setting the baud rate correctly on systems with newer
glibc such as Ubuntu 26.04. In glibc 2.42 the baud rate termios.h
constants changed value, B115200 was 0x1002 which was the struct
termios c_cflag enum bits, but in 2.42 they changed cfsetspeed() to
accept arbitrary rates and not just the baud enum values, and B115200
was changed to the value 115200. This means you can no longer set the
speed with c_cflag |= B115200 and should use cfsetspeed() to be
compatible with both versions.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
