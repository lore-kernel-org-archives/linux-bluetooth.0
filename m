Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE51CAA4
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156366; cv=none; b=rbj0BqGw/NQCVnvAOvO60+iforPS//WYrHhbmWAR2EC0jqu8rvn2fQ/V1YV7SZQW9LjKvSV84jCxC9CUYZM756xZ2lXBok3ZZ0DICuzxYNg3KXELEVq5SVRLUKImDdTJ9/i0fOCvvKjKjMABS089ZYkaIKYUmQdkLZfiGrcuNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156366; c=relaxed/simple;
	bh=sBd1z16Cch53pUmP/JaY6xywxWgS1nAsKKI89tB1B0E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gToHviXvE/gAIcFkHh98Em3tukfe7KIW2oD0DtstWXOj44ekDaTa/MEdnHURoGWSW2G+QgJED+JLmHBHUDbsusPsPSajNlI61LCGsrYUgQ+InkDnAw0WaUCfmNW+UBzD7KQCnX6SX0q4NsmjHvDCf2sI+Dq8AAP8PZtJOzdYJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bSvq7kgT; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bSvq7kgT"
Received: from github.com (hubbernetes-node-2bc5730.va3-iad.github.net [10.48.209.96])
	by smtp.github.com (Postfix) with ESMTPA id 38A08E08D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 20:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753156364;
	bh=6GSyjkS8hArxXfi2dN/IBl9rMi03aVHviEdUmh3+Hos=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bSvq7kgTvp6TAxVsgtOplapL07kDiZzCoP+22W8qXabw7Gn/TqLJJ7HwTovLle4pF
	 UD8SyCB1oO6E4cP8FSLWMJjpDGJsQ8FrybHO8hUB0BWL4rHD1VIRPbGILiNgJVaCv7
	 W9M5xKNnc3GeT5H6y1oGgr67AtjfUMsnCHOSQCgk=
Date: Mon, 21 Jul 2025 20:52:44 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/984529/000000-7ea4b1@github.com>
Subject: [bluez/bluez] 7ea4b1: bap: Add NULL check for stream in
 iso_bcast_confir...
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

  Branch: refs/heads/984529
  Home:   https://github.com/bluez/bluez
  Commit: 7ea4b198cc0195df7418ff2103d9c1865d7a9d6f
      https://github.com/bluez/bluez/commit/7ea4b198cc0195df7418ff2103d9c1865d7a9d6f
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-07-22 (Tue, 22 Jul 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Add NULL check for stream in iso_bcast_confirm_cb()

When a BIG sync is established and then immediately terminated,
the associated stream may have already been released.

backtrace:
  (gdb) bt
  #0  0x006d16c0 in queue_find ()
  #1  0x006d16cc in queue_find ()
  #2  0x006edd14 in stream_get_io ()
  #3  0x006f0bdc in bt_bap_stream_get_io ()
  #4  0x0064a440 in iso_bcast_confirm_cb ()
  #5  0x0065c36c in server_cb ()
  #6  0xf7878c24 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
  #7  0xf7878fb0 in ?? () from /usr/lib/libglib-2.0.so.0
  #8  0xf78793ec in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
  #9  0x007055d0 in mainloop_run ()
  #10 0x00705a34 in mainloop_run_with_signal ()
  #11 0x0061484c in main ()

Signed-off-by: Yang Li <yang.li@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
