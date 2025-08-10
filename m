Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083971C8633
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754809039; cv=none; b=ucX50clDkGuslk7W2ftvvQN7KbWJo06u8aQs9QcK0eKvPEGbwalHovLLDn1bERbje0mw0Z1wSpzgY69PrcfxpNXXeXWThYAjWttC8oNoJFn1z8IfERmYDzzjWB78eI0o4GuV66B1e9dI5dwcF8XmnPknYQfAylvu6ixwPWPun2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754809039; c=relaxed/simple;
	bh=9VRfrzBjnZRCR+V7VNgSOkl/YTmZ3YgokdEksVMbjJg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qASpsG92RXMH0YFnrx3b2ZBF4qjdAl03YDiYeeS+LYSGhU/zHo19gIwFqZFSShFJq/BXVhtgrf8NlfVVFsI38OLhQZVdiEG4DEmnhtT0IG+Teye/PNJNVn91j2fI3ub7J4RtD7q1pq96CATopbUctEcdEzriVjyTcHo8PHJHICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XwQRsW1V; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XwQRsW1V"
Received: from github.com (hubbernetes-node-fb73324.ac4-iad.github.net [10.52.160.57])
	by smtp.github.com (Postfix) with ESMTPA id 1972170039A
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Aug 2025 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754809036;
	bh=ZENVdtRhNQP+BVeAZkq+k+xsT2EtYWh3TJuYkkUDr9M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XwQRsW1VeJcn3KwIr+jvJEhQ7p6Q/p1xwT5PaHAoiyvnzUWdfACMoqI/z5mZxaeN9
	 WfgT8HDWuwEfWDNinqTemJCrR/RGOVvg9i1MR6Ctl6ySehPVjlNFvA9yfwLtuny9OS
	 eayWJ3hsMzo0WTG+BvZ4mleGVBQ60ngrPJGS8Eeo=
Date: Sat, 09 Aug 2025 23:57:16 -0700
From: Oliver Chang <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989673/000000-4eead4@github.com>
Subject: [bluez/bluez] 4eead4: Fixed heap-buffer-overflow in
 `compute_seq_size`.
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

  Branch: refs/heads/989673
  Home:   https://github.com/bluez/bluez
  Commit: 4eead430b267e1a06792cc9fa90d91a7b7ef75c1
      https://github.com/bluez/bluez/commit/4eead430b267e1a06792cc9fa90d91a7b7ef75c1
  Author: Oliver Chang <ochang@google.com>
  Date:   2025-08-10 (Sun, 10 Aug 2025)

  Changed paths:
    M src/sdp-xml.c

  Log Message:
  -----------
  Fixed heap-buffer-overflow in `compute_seq_size`.

By adding checks for sequence/alternate types in element_end to avoid a
type confusion.

This issue was found by OSS-Fuzz.

This can be triggered by using an input of
`<sequence><foo/><text/></sequence>` against the harness in
https://github.com/google/oss-fuzz/blob/master/projects/bluez/fuzz_xml.c

https://issues.oss-fuzz.com/issues/42516062
https://oss-fuzz.com/testcase-detail/5896441415729152



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
