Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501B42E8E5
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558378; cv=none; b=HjFf2VPWDkK4Qfk9ktFleW9JhS6El06r0Y0lfGbeOHg/3/63061WklJ86d2QNYfrio3B3MNTpCHeinTLhym3pVJmgOWQOBPa+ngOyWY5EUuswV6zJZX22h0pvWqF2CLCKy1KOLzdxZex1X7qk+sjvxjkwqJiMT/jnwBnA7tL91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558378; c=relaxed/simple;
	bh=1L2Mhi7nhuHwr2RHvUSm5rKMtMYBYe6ZRKj3Pgz0DDo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U1uZWnUGAreFxHPtkjIPFBYedOpCswgjkqVHG73KXGwOIM6gL7C7y+keKdMKCCMQaQaAcKQS3J1XTvrguWvpEucKqTcVHXIcU/t4DHDe9XnG0ROE/czhKy80ufZs7gZpDtj9Y5tD9FLQJDtVdPJZsmb6JhrLVDc73ixxlBe1JqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BAD/O8oV; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BAD/O8oV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784558373;
	bh=Fhbj6AcVkEiOFsEfgH6NUEfBFNGeEgWcuPj5HpIQtTk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BAD/O8oVbNJS4jigjktVB3fr1cWY0t1GL8lmH98JM7otrnKxdaEz6jj3ZvGEvg5eX
	 y0N8HgBnjyfiaGsUuElxMA5cqzMs4lwfEhd3peKr9S4lq1PEAO39VQHtYF9dw+PtKs
	 O6n3RtG2kkQ11oTI4urvV0/anvOJzdCK+AawYw8M=
Received: from github.com (hubbernetes-node-0904c3e.ash1-iad.github.net [10.56.76.27])
	by smtp.github.com (Postfix) with ESMTPA id 23A87360AF3
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 07:39:33 -0700 (PDT)
Date: Mon, 20 Jul 2026 07:39:33 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1130938/000000-294a72@github.com>
Subject: [bluez/bluez] 294a72: test-runner: use virtio for the default kernel
 con...
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

  Branch: refs/heads/1130938
  Home:   https://github.com/bluez/bluez
  Commit: 294a7255707265bba4a97b5ea93c55cf793db826
      https://github.com/bluez/bluez/commit/294a7255707265bba4a97b5ea93c55cf793db826
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-20 (Mon, 20 Jul 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: use virtio for the default kernel console

Serial as console is slow when commands produce large amounts of output,
e.g. for the -d debug option of the testers.

Use virtio console=hvc0 as the console, requiring
CONFIG_VIRTIO_CONSOLE=y which is already in tester config.

For capturing the early boot messages, retain the qemu serial, kernel
will switch to hvc0 during boot when the HVC driver initializes.

For: time tools/test-runner -k ../../linux -- tools/sco-tester -d
Before: real 0m32,094s, After: real 0m8,967s



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
