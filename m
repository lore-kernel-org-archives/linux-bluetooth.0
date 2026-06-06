Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD724A05D
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780788596; cv=none; b=ED/v15frhL4SKmeUWoINUglTyTKbohM8eo9xEC8vpxqd3x98epypaBvt51tAHxHNkyFwFlLjMfeRxMICfhiJ7CYcJIfm+tD9OBKBLjjDur7xBAmlassbpHhpVSUvqCOnY/6KHxEZlGAA0Elda1mgJxE2TKyNn+XC60ODWuaPsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780788596; c=relaxed/simple;
	bh=FgSn4xaI8u3BB+mGCwBBEzVjeqgPnMSfR4bRHdgzcu0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uhtgc8LRyuYfKEKJyn9WjOST7VAvoClICxtCLVjgPqDVvU+b1nOCiAyXFQtBFkYQLfuIAdO5s4BSLGqUAFjeijVnq27fG54VaCIvUnw5P7mTdfhUJQgHKWDYdr4KbBb9rs+medzZK2MJWAv8xkjdvEgpU1ahxku6yin6KuWveCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf22ZrY2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf22ZrY2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A25BC2BCF4
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 23:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780788596;
	bh=FgSn4xaI8u3BB+mGCwBBEzVjeqgPnMSfR4bRHdgzcu0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lf22ZrY2LsSDau2SwPuHkhVCf0HSDWeGx9TuqofXtm89hhWTpDHl8ty9h+ubVhzrr
	 Jz3MERfMwEPaKI5bqHP0XVLXs3HaB1ZzN7Gr93y6GCdn4197qddzJ37vCLZHmhRqDP
	 L8XZlQABnjwmgZw/Z04+jwzxK+1n9WIRSXX0o4sLA5LKyNp4tuckqyBAfnyjP3CK0b
	 ccsq70xCQmvvpS0FLE9nLPRyECu+YpD+eGCrbSb2S2AS79pe6xYZR5pB32I2WZbAnx
	 2x3HaIdrC8P2gkZqvWaHpW2p9DGE8v9Rq6eBhLPWlNo3ig8xhFuyUIqjVeUgE6RVj8
	 3pYIQS8c5uKlA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0654DCAB780; Sat,  6 Jun 2026 23:29:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 221521] Bluetooth: btusb/mt7921 - Failed to send wmt func ctrl
 (-22) on MediaTek MT7921 combo adapter
Date: Sat, 06 Jun 2026 23:29:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: p@atiq.xyz
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221521-62941-xmeD9EdnOr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221521-62941@https.bugzilla.kernel.org/>
References: <bug-221521-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221521

--- Comment #16 from Solarized (p@atiq.xyz) ---
* pertinent kernel module on this device is 'mt7925e'

```plain
$ modinfo mt7925e
filename:=20=20=20=20=20=20
/lib/modules/6.18.7-76061807-generic/kernel/drivers/net/wireless/mediatek/m=
t76/mt7925/mt7925e.ko.zst
license:        Dual BSD/GPL
description:    MediaTek MT7925E (PCIe) wireless driver
author:         Lorenzo Bianconi <lorenzo@kernel.org>
author:         Deren Wu <deren.wu@mediatek.com>
firmware:       mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
firmware:       mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
srcversion:     A85F45784A6D298A162C62A
alias:          pci:v000014C3d00000717sv*sd*bc*sc*i*
alias:          pci:v000014C3d00007925sv*sd*bc*sc*i*
depends:        mt792x-lib,mt76-connac-lib,mt76,mt7925-common
intree:         Y
name:           mt7925e
retpoline:      Y
vermagic:       6.18.7-76061807-generic SMP preempt mod_unload modversions
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
