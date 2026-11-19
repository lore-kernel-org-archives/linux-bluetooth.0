Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048374;
	b=sdV66CdbsecOoUsqzuS51Zj2ujk1r553Wu8GkvT3PEhjUUTZEC+CBBPHsbouQds6Iaag
	 2NFMbn5Resq0smq4UPRpeNcZHUxAq3x7z0o8WvZUfzNfH7mFAVD4h6qrpiBxiLXxJLyL0
	 gJ81AO2Cz0ONpCcpaTmZDm5aQYTWMQ83maxWaMvADIvmyUVV5JKvWo3oL+l3EMLC9ynHh
	 7BYgE8GZ0LR9dQPfqJ2Nvypi2aNRgPXvvVBEQM5EBerQNnEuWjw9bqLxyKK5ONnhNOZJ2
	 PYDVi/4vOiGPO5sn7g4V7fdflWNoBhR5qU6yH8n1CYVxlDVNmhonK+ac1s+rHuK0ZKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HnRk3fx7u+jQY8R+1pp+cMuEBmrZFokwGNCM6chCNnE=;
	b=DgunNlMlGSgGYpOm2a/BdmRLBRhpSnewIucFVHXoKTl6fauV6aJ3HNRK2g2X+2eEjab+
	 xBPFDRYaL2doUWD7txpiSUiSSGH0Iiw7zzcnzRomlSwkzSrgfm9/YBMZrMUAte+fAyfaJ
	 4Aj2qC+E9RiNHZ41W+cSelkvpTOkXagQ4UxBZ2QJ/rvgtrn4Q30+6I4LBtEb6SnmY7im/
	 bTXJ3JPI7q//osXjdeIIDn/7diCn/gwQr6gEaJjubjlBbkop6lsn0T1fpYbFXJrZ8BypW
	 DSBQ15+5zbnXSTio9rn7l4eRHzCaRKnn9XHnCuCk0P58mF4SQUC+0M13pzUUyeYR9lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OnEZLQvm;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9846606A33B
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9846606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OnEZLQvm
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05b210703so983274b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048373; x=1795653173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HnRk3fx7u+jQY8R+1pp+cMuEBmrZFokwGNCM6chCNnE=;
        b=OnEZLQvmypkXI0fCPVOTYeVsYe04BE/wZwfijxBKm+wf1XTpsWoFLSKyn1/ECm9RIm
         74s8mPa+jbznMVZnl+MXtFrnPBozlh0sslG/hB8csWVv1e7metma2CCxtnkA+a3IXxTe
         kEVIqFsqexO1tep/NN0wCuNj2zDI/aBDiRRIBUCXFBpMz5reJ4/z3SClxaZ0opV6/uLT
         CAPXSxGIVG1KskfhzRv2mhZdkxLlAoMgvKalYm3b1JQ/ZrZg2E/FFVyNoSf6ltwVolyz
         YY94U2woXU6syO7BzHGFt2AtxrMWcfPmMntPz5SlBqSNyrxfvmKNDXmTqwS+Q8RKdpWd
         u1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048373; x=1795653173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HnRk3fx7u+jQY8R+1pp+cMuEBmrZFokwGNCM6chCNnE=;
        b=aizcgkyOP7/1Z0N0XiEgpffDyLduu4hNZvmXv71NLfcUIIj5h9vY1ceGcVgepvTXae
         lsegqvW4R8jl/3+Ghkhbc2Os6wkERYr9aiizwvGlZmJEG7uGOq+agRtBS5UKvRqpbbNZ
         DfcNAF2EKNiKsETFl/W6nO31/Shs/r4Cz48bIPNRad2/HWWl24YRrWyCM6nwbr7JICFd
         TW5vKiv9JjE6vqQa913SVdnmQ7CvRARIndoIWQLxloQbIzkpNeFWFE8tAFcfqayFr4YK
         SO7yk+JBsSN5jKudwgr4OIV7zm9dI0upqqy7PNqwnZbttj522ijvhlyKcEevTfnWuHE9
         40Ig==
X-Gm-Message-State: APuU4Z9yF0ObjQbm7ht46+q/nEZFQhgG23yKvSf+Wf4tlML89IxSRDPo
	oXyzYjxJeGOIoXKDxxBEtTQliez6RGExahx5wOILq9Vw7cHe5uKX5zIc
X-Gm-Gg: AYBFou1KMqRLcGbLv9Jplx/A+00sIR68deeBADBd4wodxiofyPVNmZkcXKcH3rWr4NQ
	NhsjXNQMElFkn6z4pONOxgoIdlbMEKXGyIN3eDuL60Z8Vj4aCBoCxNJEHDdXQf6L1pvLa+blJQQ
	qTKhIWtPb7+ad3TixscTXD+Y/vX0l56ambDX23DRCycnC5Fs2lUj1A/EwiCZxR5dhWqCNfVTkK/
	lq/Nx36b53GBFf29DJv3QM/uioXsd4q6MjDs8T2sDFCsaA99kgQdhS7kzYRS0QIuT1JGom54Sup
	wzTfr4XjqjdrEumRC/LZ/73rQVSpDt4uMCn5mKJAjUxoSHHTlEAKRF2+uJ7mU8JqteFWHE200KI
	rBCcNNlQrD6xPfqa6qWSn+gYj7NKy/Wy7fM9gP5Md9NDvxcIH/CKt5xlKfmp6TW574HdN73e0hu
	hXASvJELX6Lb1PiPbM9yYt7vZPK/CqdsFyKRj5lUGDLOWQRO0SGW8P4OG9//1FBBpx7XpjD0bq9
	GeICg72SompKzeR8ZIsESyfr+K29WHC0iSS0LnvS2RadFaoZr9Ou6Iu+72Q6niYxbJUXORKa0O8
	JvG1Sfa4/3g7lpFCCUGoRExdrg==
X-Received: by 2002:a05:6a21:71c1:b0:3f9:bfa2:6067 with SMTP id adf61e73a8af0-3fe970faf9fmr3662178637.21.1795048373034;
        Wed, 18 Nov 2026 16:32:53 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cba3313dsm1975051b3a.53.2026.11.18.16.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:32:52 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2 0/2] Bluetooth: Fix advertising instance accesses without hdev->lock
Date: Thu, 19 Nov 2026 08:32:44 +0800
Message-Id: <pm-bluetooth-objects-candidate-0245-v14-e37270232af59a877004-0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Snapshot advertising instance data under hdev->lock and keep instance
numbers, rather than list pointers, while waiting for controller commands
(patch 1). The resume and power-on walks use a 255-byte stack array in
list order, covering every nonzero u8 instance ID without an allocation
failure after the pause state has been consumed. Widen the timeout
conversion before converting to 10 ms units and clamp to U16_MAX.

Translate management instance numbers to controller handles in the
remaining periodic advertising, BIG creation and advertising set
transfer commands. For the shared handle 0, update the intended instance
after the command succeeds, since the completion has no instance number
(patch 2). The remove-set and random-address paths have already been
fixed in the current tree and keep those implementations.

The former patch 2, "Bluetooth: hci_core: Initialize advertising RPA work
only once", is already applied upstream and is not included again.

Validation: GCC modular and Clang built-in Bluetooth builds, including
Clang context analysis; every prefix of both revised series and their
combined tree build on bluetooth-next f42f5cae154b.
No new kernel runtime test was run; the quoted report is from the earlier
instrumented test kernel.

I used Codex (OpenAI) to help write these patches.

Cen Zhang (2):
  Bluetooth: hci_sync: Fix remaining advertising instance UAFs
  Bluetooth: hci_sync: Use controller handles for periodic advertising

 net/bluetooth/hci_sync.c | 343 ++++++++++++++++++++++++++++++---------
 net/bluetooth/mgmt.c     |  34 +++-
 2 files changed, 292 insertions(+), 85 deletions(-)

---
Changes in v2:
- Address the advertising snapshot allocation and timeout/handle concerns
  raised by Sashiko:
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-0%40gmail.com
- Use a 255-byte stack array in list order, and widen and clamp the duration
  conversion.
- Add a separate periodic/BIG/transfer handle mapping fix; retain the
  remove-set and random-address fixes already in next.
- Drop the former patch 2, Initialize advertising RPA work only once,
  because it is already applied upstream.
- Rebase onto bluetooth-next f42f5cae154b; preserve the connection-work
  shutdown changes.

Link to v1: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-0@gmail.com
