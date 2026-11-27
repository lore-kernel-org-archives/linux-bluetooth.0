Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795815034;
	b=oS1fl4GIXr3VfkHKHqQYeQFSpmOjVxvZydsEyaC845nj3+UhnFGBj9gOneG7q33uX4Oe
	 oJVeTOnkTKxQo2imEB0w0DjpaiU7XR6rqbdqw8FfxZTCXXh1ewKLrgmkDMghamcV0Pc1Q
	 AAaG9vzBl768/nKLr1KiaKbjZgCjziH6iOSRuEFzJ4EOBppUfil8J/PlcbdjrZ2ZQkMjo
	 8UAG10pTiBbYKYxywtE6Y1fmtSWEvJUMEAfj42DmPXOnZVFI9rPYwsc/Eb3OmEYH/OUUW
	 3oa9goMn1QgonTBsV6hZOorROX9GCtjBLwD4XF/uLrPyIjz9ylxtzklYmC44FelaA9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815034;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=9AAlZ/tkEuSh7J77Ifp5hpaBQX0WfP6FbMWZ+G/eil4=;
	b=xlRbU8ySoyLDe3bjm/fvDGe6uFYPzSf7D4T8Q2+Xsfhdw7JVDL5kKi8PaK1/W3jwsn7i
	 vCTWWyxEdiXoa2trI9t+M1KQZGV2yOY8RUtYwZHV3ZLeVJgMKQYelYSzOEa5skPwI4iNJ
	 WB6HpemRZxLHKl+zuI1zARh7JkonY5ZTlza1K9khZGgTuoSufAWdNiO1e9K1ZToPYjhrv
	 bUuuEksEgvESDUpdBISHmXsA+tk7m+rkN8JNYsGx8+DplJbjyCpbsPnhxBfPmPIypqmTw
	 0b8n+gj3/xbBe+TjG5Ss6rvvpWv73BeeEFF4MUGak0J5H0oTvsTWzouOjV5q2K8WP7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0ymh8EO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC91606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0ymh8EO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795815034;
	b=XJl5aBOtvgzbTUAdRFv+I4Ow215vENrkjOCqtVUobKFllmQuBS7bKUfraE96h94h1EGA
	 hsdpFHtb/UJiKzv3RkJymdVUyNHM4uQIpbyQZqIacDoyQl/OvZW5H2MP4BK277dSi2uOt
	 C/5CTW3hfzslhbXIw4nh3jfj2KZ7ka93oqjSVNbxCo5f2IgMhRHkotgZCg9TphRoXaGTv
	 8jdoN+Dwkalr2BxhX9yD6sSlZgPsCwrm7+6HgtbLOYVQ1NZFZwcwnDccGO2fE7XkAcHQb
	 mtUGByQyuyPbD7hqnVBCZaiqi9DJSsT0X1lNwuTrN9hQvnUHsuH6Y6eoq1jkYFK5vIg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795815034;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=9AAlZ/tkEuSh7J77Ifp5hpaBQX0WfP6FbMWZ+G/eil4=;
	b=E7QtNCaTDiqYfgCxvoexnmnIYLDphszWbaizsB2Wfd4/1BaEbZR0x5se0sfLcfX52lu1
	 4RK5kFfRADwchOdaV7FBEx61HkGSCT0+CTZA07pgclFsNJB1I1Vl7fe8IoRMwy7YYoqrr
	 zt9YHwD0QAKImamg51tJF6BjGs0oOGm7EXJ3KPptIofRA9/LMAQomlRjLiH1xXIhfJolK
	 2ClAyJlGI6dFi6fZ3DnW/zRSySUmDa50djxUcAQcRdtUOfkyNfEBpOVXeQFdHz/jBZn8L
	 DdkvgNFdCsjE7Ixa2FhaDyhx4esZC1ofX4LqWfyanh/M4YfNZ2MX4JQyi5diF2XVTRQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E00141F00893;
	Fri, 27 Nov 2026 21:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795815034;
	bh=9AAlZ/tkEuSh7J77Ifp5hpaBQX0WfP6FbMWZ+G/eil4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=P0ymh8EOXttGMz7balZYkIOBi9YnIePUcupRbeC+2TC3Kv72L7Wpyyw+5s+o2D8ko
	 bXXa/t9lWXj4SPGq+YjE32yyJRGOnGGKdfVxemwWOVitPQwHQq0brt1r70I08Y/rPU
	 qlFY+4UxVdlT0uP0Ahhk3EQZ9oT9cNF49AeX4kxVqNKjBUoFLL1gxqTlKGZ/Kc7ibh
	 URebQdsrZC1hDZEGuVIP1+NW6kYQlZ486xZfqXZ7lBMfkxvAun9kstJ6/jiaWaSm/y
	 jeeDQpUngtRA98/njng714LZv+nRvbVFA8JESTxkAuwJlEKxsV1tTcgti8eT0xmR+s
	 9hNvDidTmfTYg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 72B214DE1A;
	Fri, 27 Nov 2026 21:30:33 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Subject: [PATCH bluetooth-next 0/2] Bluetooth: SMP: keep pairing keys
 private until pairing completes
Date: Fri, 27 Nov 2026 21:19:16 +0000
Message-Id: <20261127-bt-smp-n-v1-0-e123c04c15be@certik.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANTzCWsC/yWMwQrDIBBEfyXsuQtRaJT+SulBzbZa0k1wTQiE/
 Hu1Pb6ZeXOAUE4kcOsOyLQlSTNXUJcOQnT8IkxjZdC9HpTSBn1B+SzIaG0fBqvd1RgLdb5keqb
 9d3UHP61U5rlEZNoLPP69rP5NobS/ZngnhD47DrFFQjxWZ8KWw3l+ASo8Q0qcAAAA
X-Change-ID: 20261127-bt-smp-n-880c682a5778
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795814356; l=2169;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=02FxCK96bQDMry6ZNVOOlcvZDo/u/NT5xXIMJ9SA1Nw=;
 b=W8VmTdtMOSzDAPbmn8hZ/MfaxJlHMqc1+jMG9uVnn8vfQfw2YjN2bCpHkIjY8xCFa0h2dUQLm
 SWujmAOICs3CJHH8mCYck3kjEWgC2AwNM1mgOCsw+3/M3o5Yf2VnL88
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

An incomplete pairing can share an IRK registry entry with another pairing,
then free it during teardown. CTKD can replace an LTK retained by an
incomplete LE pairing and free it from the BR/EDR pairing context. A second
LE link can retype a retained LTK as an STK that the LTK Request handler
frees. The series keeps received or generated keys private to each pairing
context and publishes registry updates only after pairing completes.

Tested under UML with KASAN and a VHCI controller, no radio, on
bluetooth-next f57f78086ab5 and mainline 9437ee8b6cf6 (patch 2 needed
context adjustment for mainline). Stock and explicitly reverted kernels
hit slab-use-after-free in list_del_rcu() from smp_chan_destroy() for all
three cases (shared IRK, CTKD LTK, second-link STK). With the series all
three pass, and so do normal LE LTK storage, CTKD derivation and storage,
LTK and IRK replacement on re-pairing, and RPA resolution. Patch 1 builds
on its own and net/bluetooth/ is W=1 clean. A reproducer is available if
it helps.

These need a peer whose Just Works pairing requests get accepted, so a
default bluetoothd with an agent does not accept them silently.

Patch 1 is near "Bluetooth: SMP: Use pairing data for IRK notifications"
on the list, which fixes a different Load IRKs race in the same IRK
notification code, so the two may need rebasing against each other.

This was found and the fix prepared with AI coding tools (OpenAI Codex
agents, with review by Claude). I went over the analysis and the patch
before signing off.

---
Dickson Wu (2):
      Bluetooth: SMP: Defer IRK updates until pairing completes
      Bluetooth: SMP: Keep pending LTKs private

 include/net/bluetooth/hci_core.h |  5 +++
 net/bluetooth/hci_core.c         | 76 +++++++++++++++++++++++++++++++---------
 net/bluetooth/hci_event.c        | 16 ++++++---
 net/bluetooth/smp.c              | 73 +++++++++++++++++++++++++-------------
 4 files changed, 125 insertions(+), 45 deletions(-)
---
base-commit: f57f78086ab54f3b3122fbaeba2c842ba7bb6d00
change-id: 20261127-bt-smp-n-880c682a5778

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


