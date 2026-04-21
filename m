Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13923D6682
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779810; cv=none; b=JDXYRPmhbhyhKDSeb44gN6ed8Yz8kh6RRQAtuugkmHJgRGakVqdkqwE4erynqcTz0/Mwi8ootB+2LUwTF4iGdMLn/QnEoasbLeIex7kw95TVM3KYddL+3KI6apBm/ByBOZoh9JnV1N6HuF7cP7rUWiQo8M1clE/nk3DwCxBbkf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779810; c=relaxed/simple;
	bh=xRR4YXHdNTwyaJomNKqEyxWDMa347weKXyNstaeXji0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhKYkEhwRNK+5EZnDvra71beO1KkayJcPb0zvG2X357DtAvREwqoIlz4aFHPaStxeWJ7tx8Kisq8Fe0YuOC4SUF8Q/IrbSDQCp8KD90VMf3C0bWcfSGYj75aJ8nfLzXFN3bkK+jerFYXRVgYHhJK8TMjObqr6ikDY1yHvZ5I2NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUqiSiTV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUqiSiTV"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8e895b9e7cbso404897185a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779808; x=1777384608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpRWGV/9h2J0e2y4smv95jEfx6BRtkOqUuKuvF+USRA=;
        b=dUqiSiTVJLFNcIZJS9f3M9GROVSh0fq3yXxyAktO+Bkrm48rhDyLlx3YC0YE310mYJ
         pqG69K9VEpGhWylwLTvvOhZ0SchIhA1IV4o3obyKghiKwC4i4W8TqFKLVHaJT8p16aL0
         Uyji6AMUf3kVPerUTCf2j435+M95U/XuppBSOV7bjDRyiBz7gDYfq4hzwu+AZxJXJqwH
         dCD8BlWpBPC23iltp6BuEIlgfhoJxM3K7wBwM+N31/v45p76ys9YhXhqF6LHi52HWj/3
         0c5MiloTaqtUtrxHx7luFfj16M4zDDGkG0CxzI7oBUmmZyZIHfX6PoQaUZCWsh2IgK+p
         bDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779808; x=1777384608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YpRWGV/9h2J0e2y4smv95jEfx6BRtkOqUuKuvF+USRA=;
        b=WMRGQINoTsa11WVlbH/cOZQyDI5BSxflKVUqv00maLq/6xCmB10jKaH38AlA05+eVa
         2/oo+e27oGbTEhRyqVb7oo0QyKfbAJyufhrTs/ZiO4mIJOtPiMf9DEzI/8VPr8vVpHCm
         6NI2xUTV0fk2Q+86h1Dy1/5BdHJQs2TOg8hye5bLC+S6NCBSoqIQVdLWhPbvn9GZnsLr
         vJtl3SlR9EnuieyO29SBVB7joKaG6TLvB1AMzK7JiB+7Ieyp4Iqx+snHDisz+UHzl/4P
         4KkrpwuJZIxKp5oYqt/t984T41GdZY49R/M7uF9T4WFVsPxTdpeNhJRuPYTC9r1fxbDu
         y6PA==
X-Forwarded-Encrypted: i=1; AFNElJ/3dAszy4NZ3ug+464K2+JH75GhokA0ObuqA4s3X0FbcCR6GQ1WgDijhKDzU88IugwKemLhQkcStsCni1nb8Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPD9qHRRswqXXTU1WFGtPlAS2qlJYRYQqHMwIM6G7airGxo2Dt
	5PRtGQkfIfbVhuonJ1hGRL4KzxTZvgc2GGwbm5hueLaF1qBkDbmBUXEm
X-Gm-Gg: AeBDieu0BdH8oK4Z9v7OwMIzZpXp2fyZCRgVibiuSzvuSis/W6pWHLo5RnqGka6TQ5f
	wBTsutEe5gPv1ncCKat4DGQTamOcOhMJ8xBErmHJQQO7PN2wMxdtXRJuxBL/9+J85UuIDnbSE7D
	OaavyBQtdeLMfKsz0y4NLxnAZ9xBj+haLKxKgPJeBBYPNTLX7b3Z5tPMGtcN/vBWaSBMail9RP0
	mni5zkb6to1pbOyK7Dq4cS3tOgqGIM9dpNiqpNzr/ALh3bxCaKcpkN3EIhyrVo/krs5NLRepiM/
	7V7Yob/4P2akjJFdaHCWWcI9TrxGDrmHOAodATuqoKKYo5wy2xdT0O55cGo6T6y3KU3o95slY0x
	BpR2DErAdeHKxK2Nmgv0Nd+wFsJlHlFhjz4vwzkZv+WTx40TBJoFG3uvWMZS5m5/VK8FYzKMpJV
	7noxT5Fgufk4cpuIEMtHUcvc2wdJkN9skHreDPsbw0l+qvMbfVtRPEbn7MZbhaHJ3AeXVBFf9uH
	9WdgIeZrNUoonSK11buzKDRX92DVygfsMGS2Om6Qw==
X-Received: by 2002:a05:620a:6ccd:b0:8d0:ad0:c026 with SMTP id af79cd13be357-8e78fd1ee3dmr2532149385a.21.1776779807613;
        Tue, 21 Apr 2026 06:56:47 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ad48asm1033231385a.19.2026.04.21.06.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:56:46 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: L2CAP: fix zero txwin_size handling and repeated CONFIG_RSP re-init
Date: Tue, 21 Apr 2026 09:56:37 -0400
Message-ID: <20260421135639.3185653-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
References: <20260417221628.1674866-1-michael.bommarito@gmail.com> <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

Thanks for the review.

v1 mixed the original zero-txwin fix with a defensive
l2cap_seq_list_init(size == 0) error return. Re-checking that path
made it clear the reroll should be split:

  1. keep the original report focused on zero txwin_size, but fix it by
     normalizing zero window values at the actual inputs to the ERTM
     state machine and by making sequence-list teardown idempotent,
     rather than by introducing a new init-time failure path

  2. handle the separate repeated-CONFIG_RSP ERTM re-init bug in its
     own patch, matching the BT_CONNECTED guard that commit 25f420a0d4cf
     already added on the CONFIG_REQ side

While auditing the Sashiko comments, I also checked the claimed
CONF_EWS_RECV bypass. I did not carry that theory into v2: in this tree
CONF_EWS_RECV is declared but never set, so the concrete zero-window
paths are the plain RFC option, the local L2CAP_OPTIONS socket setting,
and the CONFIG_RSP / conf_rfc_get negotiation state.

To make sure the reroll covered all the zero-entry sites (and only the
zero-entry sites), I enumerated every assignment to tx_win / ack_win /
remote_tx_win / txwin_size in net/bluetooth/l2cap_core.c and confirmed
patch 1 normalizes the four reachable input paths -- the local
L2CAP_OPTIONS setsockopt, l2cap_txwin_setup() on the outgoing RFC, the
L2CAP_MODE_ERTM branch of l2cap_parse_conf_req(), and the EWS / RFC
branches of l2cap_parse_conf_rsp() and l2cap_conf_rfc_get(). The only
other writers are the channel-create defaults in l2cap_chan_create()
(hard-coded to L2CAP_DEFAULT_TX_WINDOW) and the outgoing rfc.txwin_size
= 0 assignments in L2CAP_MODE_BASIC / L2CAP_MODE_STREAMING branches,
where a zero is spec-correct and never feeds ack_win.

l2cap_seq_list_free()'s callers are l2cap_chan_del() (channel teardown)
and l2cap_ertm_init()'s error path; clearing the list metadata after
kfree() is safe for both and is what makes the partially-initialized
re-entry in the failure path no longer a double-free source.

For patch 2, the BT_CONNECTED guard added to l2cap_config_rsp() mirrors
the existing one in l2cap_config_req() (lines 4339..4348 in this tree)
so both sides of the CONFIG exchange now refuse to re-enter
l2cap_ertm_init() once the channel is already connected. I did not
pin down a single introducing commit for the CONFIG_RSP side during
this pass, so patch 2 keeps Cc: stable@ without a speculative Fixes:
tag; happy to add one if you'd prefer a specific reference.

Changes since v1
----------------

  - Split the reroll into two patches: the zero-txwin fix and the
    separate repeated-CONFIG_RSP ERTM re-init fix.
  - Dropped the v1 l2cap_seq_list_init(size == 0) -> -EINVAL defence and
    instead normalize zero tx window values where they enter negotiated
    ERTM state.
  - Clamp the local L2CAP_OPTIONS txwin_size = 0 case back to
    L2CAP_DEFAULT_TX_WINDOW.
  - Normalize zero tx window values seen during CONFIG_RSP / RFC parsing
    so ack_win does not collapse to 0.
  - Make l2cap_seq_list_free() clear list metadata after kfree so later
    teardown cannot trip over a previously freed list.

Michael Bommarito (2):
  Bluetooth: L2CAP: handle zero txwin_size in ERTM RFC option
  Bluetooth: L2CAP: skip ERTM re-init on repeated CONFIG_RSP

 net/bluetooth/l2cap_core.c | 39 +++++++++++++++++++++++++++-----------
 net/bluetooth/l2cap_sock.c |  3 +++
 2 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.53.0
