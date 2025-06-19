Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FA1FE44D
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347882; cv=none; b=fbcjTZlv+sy5vW5jNi7CpHWEfLY8rLuRYczIMc0czD+g80Gok27EDccN3uebrzQraYQ4T8tUS/ed9rhpr3LkT5bK2FhQweaymlB86rCvukLVvJpzavZPr7pc4ibnDmruRdqXWScDRGuika6/YzI8BIdfdxrc56LLZZ2OdzcMZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347882; c=relaxed/simple;
	bh=VW1f/fkyevV4iRjLCB0VonqI4gore5Y2lL35UOmkERs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gdRSIRyqyKjtiQL3Se8gUQaa4rspwoyMAh+iyYFhe//Rw7iZWLeibeKPu/wLKxvv7aLnfW2p1RhAz/pCQth1IpQbIhO7lrjvgWQKrrre3qGPNL9Db1WPw98bI/qUJ5t/WcfqugYJ2hALQMlg+PReNRooD8uUF2jyP2KekUul7Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=exQK3/fV; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="exQK3/fV"
Received: from github.com (hubbernetes-node-1214c93.ac4-iad.github.net [10.52.139.37])
	by smtp.github.com (Postfix) with ESMTPA id 2802C6405F8
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750347880;
	bh=bkKV29n/aDfZEXgnUThsxD67hkc3wuvvS87LH1JlRPA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=exQK3/fVEaf36419/3va+52UqFlI4iT10XBFX+NGR0lVZHiqgXG61yQrGyS0u2sot
	 gH8hkjmQpmcEq5UI15/BMZkRrNG3aIqEk0PDUpuDfGCWJe0C2jaz5+xAj7WQ1IzVcv
	 A4cmCFWNTCEubv5PTJqwh2+bsBotj7TpoWKslKjw=
Date: Thu, 19 Jun 2025 08:44:40 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973896/000000-4f4f7d@github.com>
Subject: [bluez/bluez] 216b17: shared/tester: add ability to shutdown tester
 IO
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

  Branch: refs/heads/973896
  Home:   https://github.com/bluez/bluez
  Commit: 216b1725387562468a071da7f676dc5bd68823b1
      https://github.com/bluez/bluez/commit/216b1725387562468a071da7f676dc5bd68823b1
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-06-19 (Thu, 19 Jun 2025)

  Changed paths:
    M src/shared/tester.c
    M src/shared/tester.h

  Log Message:
  -----------
  shared/tester: add ability to shutdown tester IO

Some tests may require the ability to shutdown IO for proper teardown.
Add function tester_shutdown_io to accomplish that.


  Commit: 4f4f7dd583ba843392ccb7451e1e2ee3eb4d4c59
      https://github.com/bluez/bluez/commit/4f4f7dd583ba843392ccb7451e1e2ee3eb4d4c59
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-06-19 (Thu, 19 Jun 2025)

  Changed paths:
    M unit/test-vcp.c

  Log Message:
  -----------
  test-vcp: free server-side bt_vcp on test teardown

Shutdown tester IO before freeing bt_att instance to trigger its IO
disconnection callbacks. This detaches bt_vcp instance created by
vcp_get_session function, and executes detach callback registered
through bt_vcp_register that frees memory used by this bt_vcp instance.
This prevents the test from failing in some environments.


Compare: https://github.com/bluez/bluez/compare/216b17253875%5E...4f4f7dd583ba

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
