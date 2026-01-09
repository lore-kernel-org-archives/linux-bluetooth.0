Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A263596F9
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951817; cv=none; b=Xs95u4LfAbceOpF5kiFzHIIa/wGVdMS0No5sh45RCM7yX4oS3n+SS7dv7xVrSMavN1WjN8kwZlVHdDdUe4Ulo3ZJ8qSrbkeYYpJnfpUUyWkvrlQnuA+HUnYObxZJuQVqDMf+8X8yd51HHG784zh0bJUHCWYTGLp547rKkfKGXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951817; c=relaxed/simple;
	bh=TwEz7j1e4ty15qES8c31QaCiPEKPBWEG+z3lxSVhAYI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lBFA3qhOtI2mi9/hi9oqSEGYbd8im7rM6HEfV7bvoB6SbhblhGvG45XP3GaYgR/ze5FaZVBSGhqmRkIFo/V5M/IiF0UzH+baj/ON6UjOtddmZ2MNwjuDvnFMSeuN00jfzJ9RcA6R9czWBMTC17I81Rls5uuNpdEAxQxKRgneKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I5+iRstf; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I5+iRstf"
Received: from github.com (hubbernetes-node-0267f65.va3-iad.github.net [10.48.204.25])
	by smtp.github.com (Postfix) with ESMTPA id D8ABB3C1156
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 01:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767951815;
	bh=LA4XfPoUToy6Sfd3XYSeyJUueO5kYDPEuAmuLUEgiAw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I5+iRstfbg8yaoZ8JFB8FO8FKOpPZ6EtHIifGpHS+7s87Ka9KkJVt+iS8Q4wmpjMs
	 GPQFTH8O/v7/H4oCQMYDFS9IRcfOtjRGIW1gD9P+2ZDP5oaOUOJkxBZiy/WoA9wy9c
	 EeYhFQlvhBChtzq/EH1AzwiUZ/HE98z9cfmhjj5Q=
Date: Fri, 09 Jan 2026 01:43:34 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1040361/000000-4a4324@github.com>
Subject: [bluez/bluez] 647e30: unit: Speed up unit-avdtp test
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

  Branch: refs/heads/1040361
  Home:   https://github.com/bluez/bluez
  Commit: 647e301b2ee3ff6b7b7c8b542d92e8233e582701
      https://github.com/bluez/bluez/commit/647e301b2ee3ff6b7b7c8b542d92e8233e582701
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-09 (Fri, 09 Jan 2026)

  Changed paths:
    M unit/test-avdtp.c

  Log Message:
  -----------
  unit: Speed up unit-avdtp test

Speed up /TP/SIG/SMG/BI-02-C by reducing the timeout length from 1
second to 100 milliseconds.

This reduces the runtime from 1.5 secs to 0.1 secs.


  Commit: 1eaacefd4da786b1ed7353dd10e0ddc4a1ddb92f
      https://github.com/bluez/bluez/commit/1eaacefd4da786b1ed7353dd10e0ddc4a1ddb92f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-09 (Fri, 09 Jan 2026)

  Changed paths:
    M unit/test-gobex-transfer.c

  Log Message:
  -----------
  unit: Speed up unit-gobex-transfer test

Speed up /gobex/test_packet_put_req_suspend_resume by reducing the
timeout length from seconds to hundreds of milliseconds.

This reduces the runtime from 1.5 secs to 0.1 secs.


  Commit: 4a4324b4d0cbdd6b79ef45002df87f07bf59318a
      https://github.com/bluez/bluez/commit/4a4324b4d0cbdd6b79ef45002df87f07bf59318a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-09 (Fri, 09 Jan 2026)

  Changed paths:
    M unit/test-ringbuf.c

  Log Message:
  -----------
  unit: Speed up unit-ringbuf test

Speed up /gobex/test_packet_put_req_suspend_resume by not printing
debug for each of the million of iterations of our test.

If we carry on printing this, then either the terminal's output speed,
or the debug capture from the test suite will throttle the test.

This reduces the runtime from 3.3 secs to 0.007 secs.


Compare: https://github.com/bluez/bluez/compare/647e301b2ee3%5E...4a4324b4d0cb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
