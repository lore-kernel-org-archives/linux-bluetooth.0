Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAB3A4F5F
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322702; cv=none; b=FQilNv197CaN/MAMF/hb44r73Otfp/rGTpLC3Nie31yMWJywIsUOxP4bUYvpOfnHv7G+BMUtR0h9CnUtBdq2NjaHI8ZQc38lDwJeiV7RM1OXSlVbeqXEElI23IxBitIfMF+I2dmWhE5OmK0HzN7vL7/R9B0Rm+7D/jq8YnBfDl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322702; c=relaxed/simple;
	bh=NX6zMCqQi9fcIrqGHvPsXzuXdZh0Mwl/ruXYqoZLnyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPlV6p/XQq+V/wVaFLDpZuCb+Pu0kYvVA3yerJFU2cN7veac47bYm/efJca326iA+35lX/8IEITxDHX8zWJCFPFNlfjAPOGEAHSbfodNWLWk48O0Z0Rlz9gCz1C1iNh9WsNUWOwY/216wlMp0IgBXBpd9wFzVNWDY/wM1/C9CIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=TJQFzNPd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AlpuY/MB; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="TJQFzNPd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AlpuY/MB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D0E92EC0074;
	Mon,  1 Jun 2026 10:04:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 01 Jun 2026 10:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1780322699; x=1780409099; bh=vL+0oet1fzRZjCJMAryXC
	v2Z7vQdRa28WOvWmT4vhcs=; b=TJQFzNPdSPDBFSl64BIRhqch1OgsCjFOtqjAm
	q3wRynw4U/xSsKCaiDLyMkHXMR0RKrK6mUUhYKiF6r2gLRNBMaejIU/kjjat+Bsx
	4ahVD3xe0VRXKDdaG8HDRPyb8dUBbOJn5SiEn7p0skE2TKOHx5F3QB07O9AUnGgI
	d9k0nzTkMBYor5pmdNQsxS/0UwLcQernmfeupvwMvLkzNo02N5r3s4p13WzQI9Ip
	gj/8Y9e+XPJfw+VH90RxZ5P+1IzOBiGjSXTbhAA6O5StroVW3ihPXI5AEEvyWt9R
	tCE2HCPKJY/hxNg+DaUqK7lBUFTzEZR8RWenSqJLHEOH+Pwew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780322699; x=1780409099; bh=vL+0oet1fzRZjCJMAryXCv2Z7vQdRa28WOv
	WmT4vhcs=; b=AlpuY/MB6PfgmgejjsfiW3/KiUqivk3CEl6i47B1e+P8LvoCoBv
	IVL3eeo+nSq3Z0U1RxMPAV5nwvh5eu3PTWS6jrAdxoljKhRemXfJykGMwsPQFatA
	cSovs4swYLlvpFAbp62C0pWuVIoz8j0vkf7p5z4hRuQ/GlXN/FnHo/jYJWzDSkJf
	k+lSxxA/Ez9L+c8ZbgHnQAVye2phN1Bopxy8HHFpcRojB6wrrWRf+lN6ZqVbHrvZ
	G1pzDn765GOZsQN9WkglGvcF67HlHD/sVVaRIcKXBsxbKXOulinBjcv8gQwyLXW1
	uwWkVw5o5YTsvxKDwOiJ82eiOMpupmOK3kA==
X-ME-Sender: <xms:i5Edatne28HmjysrHPdwnETy8PdJv1j_RlMq8rDtowjGH0vlmJWbdg>
    <xme:i5Edav2YDxZEivnGxrjFnlkEOR6jZdk8VW18iVTeHNVkYuhj77u9_1a5jYCMBWy6w
    _A_EqUtG3UUCoKNk2kJifetypx9cV6fvG0xL2OgVIE3EYb918QGsgg>
X-ME-Received: <xmr:i5Edaop_PUUiNSxlmm_rw6RHOnAj7g6sGbwfRTS3o7dg9kQsSi4Yj8FPJg7ezDonFvtW8ao>
X-ME-Proxy-Cause: dmFkZTGfZRm9kWhtF58O+/ubqvLNQMTyBaM6l8LdwS4fYRClO8nR50iT8SKln5cWDB/iQO
    KYOXHvW/xQrWfOb4Iuw6mp+mPt84vYNJXCggizKNhdOeGPZlyi5mCQ9q9GhqlyWA16l6g4
    j7YQ6S8Knr3l5Xvpcub/B+od3AH4WC1k61vaPNZ5+LD1f+wkCxEjt2V01sCJRp89oG2SiI
    Xri982Zad9GUH9M3lECMCvOUi8qJJ67f01IzH+NHhRPR7MLpWJU8zy8BewGKPWGYm5u2PV
    01LLmOkQjFeRshSFGZlmCyJbpFxW10/Ty4AULMTJfMTiT0Lxb1H80ksDE3FV+D7OdZGQRQ
    uwvEtXAknPNHyOjqLJXj1exgGWx0cPCQCutZis1MgWUyiBcaOFqP4Z2Oxu3wWiHqDB/N4K
    SVCLuZwWnuKQ8w/QA5eAWeq1Jht4oecwraQkNiFFEKOm32Yk7mcSiujLJEme762P+fkT21
    BLXpLu8f9gbSPY/JpMFs6fTdr3UYk8hCOeLIAei2SvPKDYCdMo68ydO249ZI1xC2R/YzPA
    WPREPQ50YyQC3gTK6plnp6SqLjMF9nlCBvFy3hZDqR96Hx2UGw2xJwxSFTR4KKa0rMbFok
    4y94dADqBR0I31X/f6I0BL3OtfYrNDlLU6igCkg/esJUqyb9+XwkR7efQbBQ
X-ME-Proxy: <xmx:i5EdasdXHdRuuebVItPWx1o6tALVVx3NtW7rNtVHrEFvQlnn1E5TUw>
    <xmx:i5EdanpfENiHr0mJX9F730bYcegr9BggDiJn4S86JtEVb5yogFVvnQ>
    <xmx:i5EdatGQztN1R3TklLF4JvoN1CY5sn7DFPwr5N42RMvimJUJ7WzbfA>
    <xmx:i5EdanuCpgtM7kD8CGY5_lbxFi5cl_tt4KQCNpo4VRRm09xqE2Rdpw>
    <xmx:i5Edava_O0B7qiGMRKyPdUXUyQW8l7HQ4urd2ot-0AcqLC8McyZ4wBcy>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 10:04:59 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v7 0/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Mon,  1 Jun 2026 10:03:58 -0400
Message-ID: <20260601140444.1676239-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared to v2, addresses comments on https://sashiko.dev/#/patchset/20260415204842.2363950-1-oss%40fourdim.xyz .

Compared to v3, rebase against bluetooth-next.

Compared to v4, allocate the channel outside the function and pass it in as an argument to avoid the use-after-free.

Compared to v5, extract the channel init to a separate function.

Compared to v6, balance puts and holds on chans.

Siwei Zhang (1):
  Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()

 include/net/bluetooth/l2cap.h |  8 +++--
 net/bluetooth/6lowpan.c       | 32 +++++++++++--------
 net/bluetooth/l2cap_core.c    | 60 ++++++++++++++++++++++++++---------
 net/bluetooth/l2cap_sock.c    | 48 ++++++++++++++++------------
 net/bluetooth/smp.c           | 18 +++++------
 5 files changed, 106 insertions(+), 60 deletions(-)

-- 
2.54.0

