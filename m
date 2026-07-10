Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10A3D8133
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672562; cv=none; b=JnhzJ7ds3z0HlABhe4iHX/uooduF1Z2IZ+wk00EKA35/AOvHRtOt0BUpcMwIKXkkrVtv8zz5W1rKoubRf5hhBryx3jCch6zneBsQUAcWhHKU3Lr2cfp3dwitNdclxFiiGuNrIj3lMW2bVI2LBpvPJxE7NFKQ6FCR7UOaEZMjIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672562; c=relaxed/simple;
	bh=DJyzu+e8fVaERReAussf7aU/JfuAvqRdPd0R6fQ8hNA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HDpV8bkq65qDSYRXD8k3B3SgyK4NqUN6y9MBKbWEjTCunyMN2PKHwYHV1ZLIbPTi2qeOnXk1nKXcSwGytE7DcIzTgUFgz8XTMcReWsmq71PtWVPZzLUJCCDNVzMam7B7qdo2wPZ0UjurLACHHpW766V78beRUt0tEui90hWPX8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PYAbaNHx; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PYAbaNHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783672560;
	bh=v7GqzZV8kOwM347n0Yo/CT1K0YGPUQP6pNGemUn83bY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PYAbaNHxM9gAH8zd2sWQfI2ELSPHwt0k8otA5ht8tkmsTBABTU+XELaCIE2q18vmt
	 zrU/Y9UiRyPLsH8PzczxHgsMRAldiIaiN0G7db2NavRk07tTAciq6Wve4H9KIWhaQD
	 xqLxIoVDh3OYnIlkIBhO0lNIQ+tf3w0zhuHT5q2w=
Received: from github.com (hubbernetes-node-574c5dc.ash1-iad.github.net [10.56.158.28])
	by smtp.github.com (Postfix) with ESMTPA id 1E587520A77
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 01:36:00 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:36:00 -0700
From: Mikhail <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125195/000000-3f0cff@github.com>
Subject: [bluez/bluez] 3f0cff: a2dp: Fix loading of remote SEP from cache
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

  Branch: refs/heads/1125195
  Home:   https://github.com/bluez/bluez
  Commit: 3f0cffa8df578a9ec2a133f896113c8a02eef250
      https://github.com/bluez/bluez/commit/3f0cffa8df578a9ec2a133f896113c8a02eef250
  Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Fix loading of remote SEP from cache

Commit 912f5efb0dd9 ("a2dp: Fix handling of codec capability storage")
added an 'i >= 2' condition to the loop that parses the stored codec
capabilities. Since i starts at 0 the loop body never runs, i stays 0,
and the subsequent 'if (i != size)' check discards every endpoint found
in the cache:

  load_remote_sep() Unable to load LastUsed: rseid 6 not found

With no remote SEP loaded, avdtp_discover() can no longer take the
cached path and issues AVDTP Discover/Get All Capabilities on every
reconnect, and a2dp_setup_remote_path() returns NULL so the transport
ends up at /org/bluez/hciX/dev_YY/fd0 instead of .../sepN/fd0.

The condition was presumably meant to bound the writes into data[128],
which the original commit did not actually fix: caps is read with
'%512s' so size / 2 can be up to 256. Validate size up front instead.

Fixes: 912f5efb0dd9 ("a2dp: Fix handling of codec capability storage")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
