Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C52931F1
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786828648; cv=none; b=QlAvqdTEoYERLqKYdecU9YffnQTSjuOPZ3pxmyfOPIbQwWqQp1XYprSdUmAOQ6vJkKKAB6GMwqQF79lll2JwJ7v8vQcvnMo3MrjXv1uaR/c8K0JKpQRiiCgFiRgRu3efJ6hy5VoXPQOVpfUywlMBdsj5T5qz7xOBGhmHWk1QdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786828648; c=relaxed/simple;
	bh=b+dzhS09JsZHqmgKKcwpYRWgG78mX2ggcKaxb09FinA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NhyAFimmSiDuWSa5hl9zJ3FRLqdcJGcD59ijFWQnZryge+jRXdUxglMTujXILf934lujJ8WOYlnS7It4T9teKanF9yrzBZ0TJqRqCZR9339+8mpWX4kYAhd3+BzFCcSvi2uOm6kNZekG5ctpOp3L2rbF9nN1RlcstDw1fO6VAPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=W20o6Y5L; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="W20o6Y5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786828646;
	bh=hXIIF9HFDsuwP/Vf8D/MlldujlPCdnFy/4vJFDuta+Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=W20o6Y5LdhqotsRfFdVscWxBNroqODXENhCNW7hSFeEYhI6II864dboMKA13P1t1l
	 Yi64V1tIe73wyPmFzbb4ncRZwHRdQae+v5ruu7ZdqVOyUn7bvOAYoe8h0ZQyOYKbrc
	 4UDKGyoUXt0CKueIN4qzTBg7e+kuD92miQ0UdzI0=
Received: from github.com (hubbernetes-node-362f921.ac4-iad.github.net [10.52.152.35])
	by smtp.github.com (Postfix) with ESMTPA id BFB6B780A52
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 14:17:26 -0700 (PDT)
Date: Sat, 15 Aug 2026 14:17:26 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1146603/000000-582ec3@github.com>
Subject: [bluez/bluez] 582ec3: media: fix wrong argument to lp_get_uid() in
 avrcp...
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

  Branch: refs/heads/1146603
  Home:   https://github.com/bluez/bluez
  Commit: 582ec38249f11a91e1300b61a7690b41ecbdb773
      https://github.com/bluez/bluez/commit/582ec38249f11a91e1300b61a7690b41ecbdb773
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-15 (Sat, 15 Aug 2026)

  Changed paths:
    M profiles/audio/avrcp-player.c

  Log Message:
  -----------
  media: fix wrong argument to lp_get_uid() in avrcp-player

In track_changed(), lp_get_uid() is passed struct local_player although
player_link is expected, which is ASAN crash.  It takes void * since
it's avrcp_player_cb callback function, so wasn't caught by compiler.

Pass the right object. Fixes AddressSanitizer: heap-buffer-overflow



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
