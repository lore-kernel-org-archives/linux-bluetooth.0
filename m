Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A054A2E02
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733723; cv=none; b=np+ZnuI+uX7yPdg5iF9NqwsR6O01a2PEZl9e5dmWEMETQ1l5XgN695O3XZMX1HrIK4RFuBd+XlsyrSTpZ8JNrXNQ4Roc9zVsrsDNeCa8DlsoCx36zL/+U5YneCWaLB2tXsqFrygp/WRouY4gg7wM7AuKhFo+X1qFlC3PW2NqH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733723; c=relaxed/simple;
	bh=C64UYcOVbSXI/c+iLo5sxsOja9tht2y59CPMmRYf0V0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nXN0V7N/CaQdYMcA7x9Vx/G/KK9NyjNFGNpXqnTiY97zn7+oJ/2aCgT0JM3ubLVssuUNhirMpn20CAueW7tdQPFA5hF1Ia9EkhD7TLe+AEs0NLClsng2UEYuIGyk9X+NJkdtnk6hecDDoAK8M0eoVU6jdLlNkNsV/6duJKWhx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LvK3f3L9; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LvK3f3L9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786733716;
	bh=hW1T5y28XJvs8U6sb/Mwvx0lT0V81/nzSTr9Um8QfVc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LvK3f3L9KQdv2uOLcOLG+K7xDs6fGELvvMLqcxoWGa62Djbs5JRoUJpgZiF5fnff8
	 1oez8qPXnDyZymKwL+QVACFiCyrkAzKrRdL1VTbizglSzxEkf9iVjtwyZxz8GcfsZ7
	 +Mw4Cdwfet12ZZwJZ9f0teH79m5jTt+tXs1tsjeM=
Received: from github.com (hubbernetes-node-63d0534.ash1-iad.github.net [10.56.206.75])
	by smtp.github.com (Postfix) with ESMTPA id 7E02052103F
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 11:55:16 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:55:16 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1146222/000000-421aab@github.com>
Subject: [bluez/bluez] 421aab: sdp-xml: Use a queue to collect sequence
 members
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

  Branch: refs/heads/1146222
  Home:   https://github.com/bluez/bluez
  Commit: 421aab1b5c48db683d1d5d41d46acdbdf078fb15
      https://github.com/bluez/bluez/commit/421aab1b5c48db683d1d5d41d46acdbdf078fb15
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-08-14 (Fri, 14 Aug 2026)

  Changed paths:
    M src/sdp-xml.c

  Log Message:
  -----------
  sdp-xml: Use a queue to collect sequence members

Appending a member to a sequence with sdp_seq_append() walks the
single-linked list to find its tail, so building a sequence is O(n^2).

This was previously worked around by caching the tail of the sequence in
struct sdp_xml_data, which required the caller to pick between appending
to the cached tail and initialising val.dataseq, and to keep the cache in
sync on every append.

Collect the members in a struct queue instead, which tracks its own tail,
and link them into val.dataseq once the element is closed. Appending is a
plain queue_push_tail(), and the queue is destroyed along with the rest
of the element so members that were never linked, such as on malformed
input, are still freed.

The sequence_on_squared() test stays at less than 0.1 seconds.

Assisted-by: Claude:claude-opus-5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
