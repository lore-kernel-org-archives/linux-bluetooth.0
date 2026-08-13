Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656894519A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614300; cv=none; b=JnTP62FGHUGRwxYvHyYD2g//r+MaOupO6YrM+CzFqTf7g6hbasSdPd8AWCaDqIOzQ686tQBdYY35C7LTMFz8nDvueDm99yt3UPUSdNjRZQuH16w24LLo2bIDyGCqTZz6kUhAHj82g/Ye+DYiabbIioq/IRolIkJGqvVPE4TJZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614300; c=relaxed/simple;
	bh=cY+w1PRJKjKL+rxlzGMcmQ4IKO4RgMJP2Sov0cW44Vg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jprD8Ae8rKN3ZBc9+C3l3zel9gnQ6aiL+gGswfEDnkkpOIU6k2YufA5NcGgZTBHNitwstIapKs+UJOV4ZPuM63of1E68FqQIot6SAJHHBKUakILMwNWvizd0Y7fz2uQrw/qw5Ggdk+mvqtg452NxPVIz4x63Z21sLs7n9x9NXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SjmaIMjh; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SjmaIMjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786614298;
	bh=VUyHKzuO9srFpIoVHU3sP22m/Npuu8FcAzSprnGThsU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SjmaIMjhFAL8h47LmVQFNq0VVGhaUpwHy9Z0hW9w7q4upGK0bkCVdbYwgIweZXwBS
	 gZY8HIR3F9xwPBYtlm6Wvvq316shWrPitvn3xRrRI2S/mpQFYjXgXvHx13Mfv73C4S
	 rn9whGSIg1Pjg3XkZSonylzpbJ0R56wht8swe2I8=
Received: from github.com (hubbernetes-node-eacf2a4.va3-iad.github.net [10.48.142.41])
	by smtp.github.com (Postfix) with ESMTPA id 7E66650128B
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 02:44:58 -0700 (PDT)
Date: Thu, 13 Aug 2026 02:44:58 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1145281/000000-3a78ed@github.com>
Subject: [bluez/bluez] d44af9: adv_monitor: Fix buffer overflow caused by
 integer...
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

  Branch: refs/heads/1145281
  Home:   https://github.com/bluez/bluez
  Commit: d44af9f092d716951accca6ed95fa6a80a96e2d2
      https://github.com/bluez/bluez/commit/d44af9f092d716951accca6ed95fa6a80a96e2d2
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-13 (Thu, 13 Aug 2026)

  Changed paths:
    M src/adv_monitor.c

  Log Message:
  -----------
  adv_monitor: Fix buffer overflow caused by integer overflow

In src/adv_monitor.c, merged_pattern_send_add_pattern(), and with a
large merged_pattern->patterns list, it's possible to overflow cp_len,
an 8-bit integer:
pattern_count = queue_length(merged_pattern->patterns);
cp_len = sizeof(*cp) + pattern_count * sizeof(struct mgmt_adv_pattern);

Eight patterns require 273 bytes of command storage, but assigning
that result to uint8_t cp_len wraps it to 17 before allocation.

The loop that follows does not use the truncated size; it still copies
all eight 34-byte struct mgmt_adv_pattern records into the heap object.
The mismatch between the wrapped allocation size and the full copy
volume produces a large, deterministic heap overwrite.

Fix this in 2 ways in the function itself:
1) increase the size of cp_len, as 8 patterns would overflow it, and some
   typical Bluetooth devices can support 16 patterns
2) Store the result of the multiplication in a 64-bit integer before
   checking whether it's bigger than our 16-bit cp_len

A similar bug exists in merged_pattern_send_add_pattern_rssi().

Reported-by: @ax-nnlabs (for merged_pattern_send_add_pattern())
Reported-by: Aisle Research (for merged_pattern_send_add_pattern_rssi())


  Commit: 3a78ed23d7d4f8110aff3306703753c1c2dc6dea
      https://github.com/bluez/bluez/commit/3a78ed23d7d4f8110aff3306703753c1c2dc6dea
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-13 (Thu, 13 Aug 2026)

  Changed paths:
    M src/adv_monitor.c

  Log Message:
  -----------
  adv_monitor: Ignore additional patterns past what's supported

Ignore patterns beyond what the adapter supports.

Suggested-by: Aisle Research


Compare: https://github.com/bluez/bluez/compare/d44af9f092d7%5E...3a78ed23d7d4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
