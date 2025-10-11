Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A307A2940B
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Oct 2025 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760225493; cv=none; b=eYOBXvoRRgDmV9zAHePXAEQrRvbmYsEAZL7gZS3HGPrNtRMJYqFzZ/zMekM02c9tVJ+E03XHaFvausa9NdjOgZUYYHzneOEBI+JDT1nW5oK7FGeacwDMB97PLL1/ZHoMKp1A7nOjhHCg86JjKKzRvp5/rna+pRjy7ydaK3DLar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760225493; c=relaxed/simple;
	bh=SCllP0Jj22BPywP+62a9BWg3XWrxqY565gNhVqAvEkg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nFjN31abCfyKcnBKcU29sZ/8QCdmoGUWMX3UCLc7Hkboiu1Cgaq8N+ACCVsFBaEXgGYmItLje1soAG8Gxa0aahF5hG1tgP5gwDRO6FykivIynatY7rFt+wObeprG7ot2d6+v58QZhKZj86pPhtnsEKRrKk5jq3eN0sElq8MWTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KewBbYh3; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KewBbYh3"
Received: from github.com (hubbernetes-node-b19dffe.ash1-iad.github.net [10.56.163.44])
	by smtp.github.com (Postfix) with ESMTPA id B5BF01401B3
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Oct 2025 16:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760225490;
	bh=gkAtTG/wSnXV130LAef13NW5orwXo/0Afq3bbCs+Txc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KewBbYh3tqUbgGw0RzmkpECiFJn/WNyIg6QnEql4nZN5+UtBAfWD+P66h9L5YsrCa
	 n3irQ7YIcMcZ0gZg4Dkb9boLwESF9cVOkhPc3VlkGgX1AkEgdckGPJ7Cnogj27uRcX
	 SFrmE56brZZc2GO5oIp9Ti5J+P8+L7vZzT5xcPwo=
Date: Sat, 11 Oct 2025 16:31:30 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1010398/000000-b5a4f8@github.com>
Subject: [bluez/bluez] b5a4f8: shared/bap: fix crash when setting initial
 metadat...
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

  Branch: refs/heads/1010398
  Home:   https://github.com/bluez/bluez
  Commit: b5a4f80bfe7d44d4ce4622b812d640abe26fed3d
      https://github.com/bluez/bluez/commit/b5a4f80bfe7d44d4ce4622b812d640abe26fed3d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-11 (Sat, 11 Oct 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix crash when setting initial metadata of a stream

bt_bap_stream_metadata() when stream is IDLE causes IDLE->IDLE
transition and crashes due to UAF. This occurs if SelectProperties
provides a Metadata.

Fix by not updating state if stream is IDLE.

Log:

ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x7ca9d83ec448 thread T0
    #0 0x000000927dce in bt_bap_stream_metadata src/shared/bap.c:6525
    #1 0x00000056ae75 in setup_config profiles/audio/bap.c:1790
    #2 0x00000056b865 in bap_config_setup profiles/audio/bap.c:1831
0x7ca9d83ec448 is located 8 bytes inside of 160-byte region [0x7ca9d83ec440,0x7ca9d83ec4e0)
freed by thread T0 here:
    #0 0x7fc9da2e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
    #1 0x0000008e3481 in bap_stream_free src/shared/bap.c:1259
    #2 0x0000008e4586 in bt_bap_stream_unref src/shared/bap.c:1342
    #3 0x0000008e4b6e in bap_ucast_detach src/shared/bap.c:1366
    #4 0x0000008e6b63 in bap_stream_state_changed src/shared/bap.c:1496
    #5 0x0000008ec17d in bap_ucast_set_state src/shared/bap.c:1857
    #6 0x0000008e75e4 in stream_set_state src/shared/bap.c:1543
    #7 0x0000008f268c in stream_metadata src/shared/bap.c:2250
    #8 0x0000008f2801 in bap_ucast_metadata src/shared/bap.c:2274
    #9 0x000000927d3f in bt_bap_stream_metadata src/shared/bap.c:6523



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
