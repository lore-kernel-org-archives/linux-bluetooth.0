Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232846;
	b=CwBA7K8Fz2+gNQaeqT40FUZhzbQrXAJxspQJvu625IwrvZIYQ+bgWVTnsep/skPPVjsc
	 jnP74LPAy5SXdIAZp7wGOXfRA6hw/8k89B3oXY/wMNoBdId6DoloRfoww9GkxCnx4crtU
	 oTnEA3HV9/n5pH1XZWkio+4a0nbNV6HMQUYSozs0fo762ZY0FAvKaQgvZz6Pwc9dzi8aP
	 iuV331BdaNVt2kbU2zr2cfD6uFzD9UzgXbpwPRkSJIEgT8Pp2H0LKooRY+5Jmw6yVhOBS
	 +V9HaJnjIOjbCv7Tkj3kQATMAVYnl/lqVMjZRa6gcaHbNDfs3LlGKH+V9ABwffZFJoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232846;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=D4C4vAmzl1eQgWL9x+mi9V4ee8DV3yTfcj96A4ftIzk=;
	b=3fwx9Tst5h9fDfV6u+SY11UcjrKWppQMNa/Jirj/is+0N5An+KegLb4KVblwAMOiaIcz
	 O5on8UM6RFKnz2W573y+29wk+cN/X49dicLpC+H+fv9m+tu1xJjLglkRflV/2bVJ6PsPj
	 9taUYUGLL2c7ZBZw0KK9ZpRu8/MpsL2MEdFv7WyuIEP0mQlgJUdYBtCDad5wbeXmnejte
	 liX6cBIZYvZwAoSoujgTElCHczPY0WLUpiCmvECRkDr5TwSjePnl44rxfM4/4c29xASwV
	 RQTrc9cvcNMC4o32gEm0bH3/Uk1E3ZmwDz/p99TmOlBJfwrmbYVfCvwdmWnKljQJkFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="UXAzvN/o";
	arc=none smtp.remote-ip=79.135.106.121
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D860606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 00:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D860606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=UXAzvN/o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793232840; x=1793492040;
	bh=D4C4vAmzl1eQgWL9x+mi9V4ee8DV3yTfcj96A4ftIzk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UXAzvN/ojAWxaAD2cVE2BpCBTwlVQ2nDyICprS2MzElPmXATeArtuCF2MQOJ4UpFD
	 17arg4frkSG60lmwODEvJSIpVrUCceQaXoTssR2FQTGnvS8w2bnzF83neuxQhjW+aC
	 OcScUfy/+HkACBdISDJNkye4AXX6C+VZLMAPZGd0kqsct0CBPToJrRMJTVXC+zmPDz
	 JSVciTn6DY5DjJDhuOxJH8o32RXONZdsosooFSeMhwHCMwSdfRTPERvVFA/wlOQRvi
	 vrO0LeWLkrX07l8o8r3nnpULGWu7XW1tNGB74a2TC8fAf+XgAo1XFJQ8kxkSx3SI7W
	 BeACDjraC7Rog==
Date: Thu, 29 Oct 2026 00:13:55 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v2 0/1] Bluetooth: btusb: UB500 MTU-only revision
Message-ID: <20261029001349.1031535-1-cochcoder@proton.me>
In-Reply-To: <20261013032742.497402-1-cochcoder@proton.me>
References: <20261013032742.497402-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 590ebf96d2b9f37ba335b46f1e137bf6cd896742
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

> Are you sure that is the case, or did you just assume it because it
> worked?

That's my bad for not reviewing the code enough. Turns out that the forced=
=20
BR/EDR buffer selection wasn't needed, only changing the UB500's host LE=20
packet length from 27 to 167 bytes was.=20

I tested your packet-length alternative on USB 2357:0604 with Realtek
firmware 0xdfc6d922. Initialization still reports LE length 27 and eight
packets. So I removed forced BR/EDR buffer selection and changed only the
host LE length to 167, keeping the reported eight LE credits.

The 60-second single-CI playback sounded clear. The trace contains 3243
whole 167-byte audio HCI packets and 3269/3269 completed target packets,
including control traffic. Maximum outstanding was three, with zero
remaining after the transport suspended. The unchanged PipeWire socket
requested 672 bytes and received 4608; all 3243 audio sends succeeded
without EAGAIN. Increasing only that socket to 8192 with HCI length 27
previously crackled and delivered about 37 audio frames/s instead of 50.

This shows packets larger than the reported 27 bytes work without
changing host LE credit selection. I used 167 because it
was the length already demonstrated by the working ASHA stream; I have
not established if 251 or 1021-byte LE HCI support exists on this firmware.

The accompanying RFC v2 therefore replaces the shared-pool proposal
with the size-only diagnostic. It deliberately retains the TEST ONLY
log and rejects unexpected initialization values. Feedback
on determining the real limit and firmware scope would help settle that
design.

The acoustic evidence is from the existing Arch-based ASHA 7.2.9 kernel
I've been using to test this and the other patches.The mail workflow=20
separately refreshes bluetooth-next and builds the baseline and revised=20
btusb_main.o with W=3D1 before sending so it should all still work upstream=
.

Changes since v1:
- Do not clear LE packet/credit counts or select BR/EDR accounting.
- Test only host LE packet length, using the existing post_init hook.
- Remove the shared-pool/exhaustion explanation and report the limits.

These changes were assisted by an LLM.

Kyle

Kyle Pepper (1):
  Bluetooth: btusb: test larger LE packets on TP-Link UB500

 drivers/bluetooth/btusb_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)


base-commit: 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9
--=20
2.56.0


