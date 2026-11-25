Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612150;
	b=Cyq49KyiEg3BKwwyVVohk/wXwPBnnYbRAhavS+YfpDz1+mhD2dpTZ95bKynrIe6rEpMo
	 Aly79Vc0J6SIEQT4QrtcyDjPTMYVz8RqAvW9PW3YSe411Zi9ZdG4QcmToF0+NrsOAgigY
	 PEkwAz4FqWhFxaV9i55/O28hc7aziuaJdcpLrFJ/1mfPYi0zZgnMCi/HCm6IebBtZFvmy
	 zC2pqFDmBNWhIOSc/QOogRlrj77YEY8exajHvqpMFcsqm5W7ovAkeFwJu+lf2+gswwCYL
	 kGo/2AdsGF2pVNW58/ElTPqsCTSO+DqLpBtZLHVGySpKHSDi8PKWSPBNVYRhSQaJLpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MJicF0N40L/p8mJ4Pm+onD5txxDN49WzZBXuet0XzS8=;
	b=NGadSGQqAcoRR9zlhoynDqHKwcF4a7kR8QPbX4MnvL99jFqWfwJDoLAsZ5c0acF+pb/J
	 jZxBXUUKmwPw/9DOoZT/RzCcll17EuSKNZcsiJGDmW2m1PSuNKS1mrqFkfqxJUPp+mTv/
	 EDQ5NiO+BYnphHdIE7H8+niBNz/5/onnVFGzyCue0uwt++Hibn9KmkEJnbZkPrACWI87r
	 0Rv8KQXHx3KpKh0BlNH3Uu6XaAqPcYaxt+lsz204CEx71r5RRjXDp8f+aFeJoKqlgHMOx
	 4tAaPCWVoO4XlzmEn2dN8+YsCa9Tr5GEWV6lilurKmMDSbY4zJA02lGxEuZ1jLkVM1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yW1xMJUh;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D32D606A329
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D32D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yW1xMJUh
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so1559301241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 05:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612149; x=1796216949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MJicF0N40L/p8mJ4Pm+onD5txxDN49WzZBXuet0XzS8=;
        b=yW1xMJUhIaNsmWIeNH9jopmG0amXarJ6nK80pYgmjOWaaKHkVo8ef8EY/+0U7Ib2aE
         Ln6hkyO9PzHiS7+MURY5RbHUQnu+lEmLVGGEx2bhOEOrM4a3EUvLrckeTPCK2KBLxO2X
         svUwpx+UUWPZ4QJszfFODL8V052zjSS400sqA/BfVBwS0CDyrBhDy5WulPF8SNb0DabG
         F08rYjrNOzLBtnU8AH/iMVo8QJZJ83w8oxo5eFOA6OUDQgKN6PB5C+TUMzS5WZinDxq6
         W334DofO/9Y6v00Yma16C/EmMQvOtagA+Sn/EVLDKoCf+fFq7J+1BxdSjUczGLbLWLdL
         DL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612149; x=1796216949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MJicF0N40L/p8mJ4Pm+onD5txxDN49WzZBXuet0XzS8=;
        b=XlWoMbWzHA04mS2lWM8+MxoE28zOKj75AZZxqmXP7a67Tmvn5DW1hZWBd6AkavB22w
         cig3OTUZWoKoqsvAGO2Q+vOcFXlxGrVvkQTM/mID81rcNhSdSWsBI7XscRKcmsx428PY
         DoTCN/w3a2YGULUvllGbOMnWmc0h5kR3kY8ajLk8K/+iSyhuDufxd8oDYp0/SBJD1h9F
         5zqdL5R1kmEkvztAVhDj8Z8jWuKPfpN+wrWBArNmIY729exn/Yk+aAAaA4JK0b5j/753
         hLf9O6029Amv7JBg6ioDTEUDuPR0VSQTsAfAOnWOgItB73n1l08S7DhZZMnFb2pPApWS
         8OgQ==
X-Gm-Message-State: APuU4Z80w2nkNyLLz+/RSbEHvAjR8b1FqsUfJKFY1ciRwGuRRhKvlDHl
	0y+HGfHQ2Klz00oeiMBdlcHNFB/OHm3fp+80DW03lRnxeP+40lxQtsBXfdEbou4E
X-Gm-Gg: AZFdTZeZ7W9QHnjp57a2uouQo6rBW0Y0YY9IA9kV4pZsQ1K0ipTaXWm0IdWgZKiMMzA
	IC2OIqab9qK48hJsgBXVslBSjY2eEicfYlfYVVSpBE7zQbsNmbwXZ1SvgaA2UNMVEGuBElYaIj1
	LJg/8niFkW6coAmQ9Q/gsbbs2d0Hjwych5W7QsMZq+L3HW4jB1fS1EPkY0/X4UUAk35DBoqDlJO
	aFZnTwdpx0PcTvlv62UZ/VOm5l0mkvyK1Zl+bROgivv1ddisfzfE/w/YCjH7sAPVphv9eLjoJOl
	I3MifrMYXrbO97IPaUJHVtQ5MqTxfhp/WPTPsUKxyDnWrm1el0CUFIOrPgfwzlRkUjXYOpqCi8a
	h+Gr7ncUhOFWwcgf/76qn+IISX29AfLx6YCRs+sYomwk+6P9M7snV5ye4wG2moTTMy+oPwamwYd
	lItWvQniRcPOWjJrNP0kgYFGhMQdNsPDT6LRgIeL5G1FSP8/XtmzeGEUSWIKzr4PsCBiR8FMQNT
	3lhHy43jLDhHrUP8N45PZpzg/4awkivgjhegWhKCy0Lju7tIfQAmKFZdM5dn3rnVOcxaczv8sIh
	nP1IymXlScSlFwgjKMwP0nuxijSbjMr7Gg==
X-Received: by 2002:a05:6122:1d4a:b0:5e1:c1c8:9ff9 with SMTP id 71dfb90a1353d-5ee8adf5aacmr9174197e0c.2.1795612149095;
        Wed, 25 Nov 2026 05:09:09 -0800 (PST)
Received: from shine.local ([168.196.221.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b60b201sm17299447e0c.14.2026.11.25.05.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:09:08 -0800 (PST)
From: "Andrei A. Bykov" <andreiab9019@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Bluetooth: fix bonded LE peripheral reconnect completion and holds
Date: Wed, 25 Nov 2026 10:08:26 -0300
Message-ID: <20261125130828.18441-1-andreiab9019@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two issues in the Bluetooth HCI layer seen when a
bonded Windows central reconnects to a Linux LE HID peripheral.

Changes since v3:
- Rebase onto bluetooth-next at f57f78086ab5. IncrementalBuild reset to
  origin/master, where the newly added MT7922 data-length block changed
  the context of patch 2. Keep that block intact and apply the same LE
  setup check below it. Patch 1 is unchanged.

Changes since v2:
- Rebase onto bluetooth-next at 6a40daae69b0. The Bluetooth CI bot
  could not apply v2 because the key-refresh configuration code moved
  into hci_conn_refresh_key(). Update that shared helper in patch 2 so
  both Key Refresh Complete event formats use the same path.
- Preserve the LE setup abort checks in both feature-complete handlers
  on the new base. Patch 1 has no functional changes.

Changes since v1:
- Refresh the saved synchronous request after timeout or cancellation,
  preserving socket references across controller reset resends.
- Keep the LE feature hold across encryption and key refresh. Explicitly
  abort failed setup and prevent later events from reporting success.

Both v4 patches apply in order with git am on the pinned bluetooth-next
base and the GitHub workflow branch used by Bluetooth CI. I reproduced
the IncrementalBuild sequence on f57f78086ab5 using BlueZ's ci.config:
make olddefconfig, then git am and make net/bluetooth/ drivers/bluetooth/
after each patch. Both builds passed. Local model tests pass 152
command-dispatch checks and 66 connection-lifetime checks with GCC,
Clang and ASan/UBSan, including checks for the MT7922 path.

The v2 backport to Linux 7.3.5 passed repeated bonded reconnects,
approximately seven hours without observed connection loss, and Windows
Bluetooth off/on. Those hardware results are from v2. In separate
Windows suspend/resume attempts, the test HID application could still
wait for an HID subscription after BlueZ reported a connection.

OpenAI Codex assisted with analysis, patch preparation and tests.
Sashiko provided the findings addressed in v2.

v1: https://lore.kernel.org/r/20261121033104.441146-1-andreiab9019@gmail.com
v2: https://lore.kernel.org/r/20261124140956.15296-1-andreiab9019@gmail.com
v2 CI: https://patchwork.kernel.org/comment/27404265/
v3: https://lore.kernel.org/r/20261124211127.41609-1-andreiab9019@gmail.com
v3 CI: https://github.com/bluez/bluetooth-next/pull/1221#issuecomment-7151355640

Andrei A. Bykov (2):
  Bluetooth: hci_sync: keep unrelated replies away from event waiters
  Bluetooth: hci_core: preserve LE feature holds across encryption
    events

 include/net/bluetooth/hci_core.h |  9 +++++++-
 net/bluetooth/hci_core.c         | 16 +++++++++++++-
 net/bluetooth/hci_event.c        | 36 +++++++++++++++++++++++++-------
 3 files changed, 52 insertions(+), 9 deletions(-)


base-commit: f57f78086ab54f3b3122fbaeba2c842ba7bb6d00
-- 
2.56.1

