Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB986309DCF
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089299; cv=pass; b=ldlc+TSVLBEGQv/9lSAQbAsXU6bml9dMtT10uzqsIdkph2CsstQkcmOSqzyc2uHfixKwzPzNREILU3wfuxpB6Wf5WjM9AD3itGaPq3rpepwzkx0GvcTuEYgMTUwJBL7TgIEvlUx8gmE+VVmRZ1g8hTscyuqWaFX3mgYOntlrlPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089299; c=relaxed/simple;
	bh=w2P21e8Xrn00dZ0P+iuyYVl+3bMyas+UXks6Iy2oCiM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=txzlfBs+vTXJayo9GiG9pA8wHBc/WVbOsVtSvA6hy6E5xaDjntq2k5js97FDlxA5WCaucM54rQhcn+DUDJqN2ELFrrZuqhy5cs7p+VZsdOQDnnC8zzmLakNxSQBqew0vekNDsMNYd6zHQ208Cppr5+lW4h5vkhiyay4n1QzVi5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nappairam.dev; spf=none smtp.mailfrom=nappairam.dev; dkim=pass (2048-bit key) header.d=nappairam.dev header.i=@nappairam.dev header.b=fFKJ0F6p; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nappairam.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nappairam.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nappairam.dev header.i=@nappairam.dev header.b="fFKJ0F6p"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79430ef54c3so4825277b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 05:41:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769089295; cv=none;
        d=google.com; s=arc-20240605;
        b=JL5gjjnp405tqsQMGaZMarbNS0N0kSZDbp9QJdS2m2FGjNAxd1n7GZUv3dDOX/sIDh
         G3CAloPV0YMCTD8T7JytHKyFDVxept9A/fa5PrkRgJEJGuDnm7IOyAHPhfGn9sr3DwzS
         pzwFKc4kZ9l7tl2Zx9d0qSy+y+jZhh7oYKmQyXdPhTAadJJf/bacqLTvxir1zBvUswu/
         1Cx1vM5X0DhIl6jCPoM0b/DyVrR9701/5f6wSVdNfXyz2mFOUgkosJvIYbt3p2BFa3+y
         UVMWuibsuToaS6cP10rDE0wBbh/O9ZGukIGAaxkYuDlR4xy3MzTPbZRxrwIwkv1xoCsc
         7m+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w2P21e8Xrn00dZ0P+iuyYVl+3bMyas+UXks6Iy2oCiM=;
        fh=KqPjItzF2ztS83oLq6umyWlgsBCq7hgMbif7KF+vZ8o=;
        b=IHhI8xnzkJL6HEGv8T6vZd0realca8BnVV3SPzwFlTCDThuZ+YRG8/O2yPIKf+DQPZ
         fi6d+M+IebYCxEkDzrKSzUeky0t8tv/JetObMa0JmhbgK5HsHgH2qGvgSN7Up8svP9YV
         9BaWrVgR2CMCnhvc2js2i9g2/ipSHr1en8fpozLYOuOM4fGGtU3laHR8iDvwLlDk5c/d
         LhahDSeE2PL/uuUTyknOaJhAIszkFS3zFKZsN+GWkrS6vUseTYiK/PEFzEQ0lYqZeL0Q
         PPoedMUCo8Zt5/5IX7L/y9+wYtFy8WF/o0Iqq21Ewlbmtdh1KyaXo56UpiU7G7J49wNq
         PF7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nappairam.dev; s=google; t=1769089295; x=1769694095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2P21e8Xrn00dZ0P+iuyYVl+3bMyas+UXks6Iy2oCiM=;
        b=fFKJ0F6pr5E/0ZbdZp89+o2U1hp0Aq5XSj0rpSzNcIgYLcfOe0J/dvfD71282/kVFk
         EH86CTf2QDSCB7VOwqw7BsReLtM9GiRWrm3/s7YqJCxVJwVfKpPH6gK5gPiukWwxDNed
         pdU+OwgILOk/8A5hVAm5G8nX9tPlVKRJRRplB1+uPlQ0W8D6hBJOqWNUYbXmfAZGaqId
         taTzQTpfF6eIEWBfvLzKcqbsXGrCUDPy0rAzrzVZvHs8zwBzC9FzR1+N2h9/XATqGUq5
         tpxUz3/J7A4wI4dZOCF5P59iFI8DPkFzn/BvKY7svk351WN1zCZMzUiFudBhz80sxVau
         l4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769089295; x=1769694095;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2P21e8Xrn00dZ0P+iuyYVl+3bMyas+UXks6Iy2oCiM=;
        b=QAy1zd9I03cbENwcoCgS9oqV71A9HMrZigHZcMytBy1fjS1ITPHmUa1JArZQIPIWsY
         CR4f9CTu3HZOeMoyrmIW1e6kfBX0G4ggBSWXCY/MfJpt1M0GETOfOhlfrQTt+IFtp4vy
         34yXDE2NAZxRZKeFvlHpMk6H50YQ/2oxLL6r6pigGT5paF+k5CFlQexk0zabqk2S3wnf
         N4A5nVEi7EBMKZCrCGdlCR1YlF/KrqHBnoiwOcODedPrllK6jBe2GBFkIPocfdhifhX4
         ZmTd2jyEfHK0B9EKhqOASkbfBSrd4/sdv9roZ+mB9IdtamCaJc7/HMIAfgPhtDm4v8ik
         6oBw==
X-Gm-Message-State: AOJu0YwMQzrUisMWsWNdqDzmUVSWFJgi7KGLrY6bQf3NhFxqRwURGORP
	qOQd/ypu+COzpjWC4MkE/oIHLazcEBnnkO39DeUIjfFrWK80T5nHq7MALSAhRD8mhOxV6U40qr5
	qd2Hnp2Rwz3X593CCsZ2kWGJurENVzYvI9MF4Eza+l3sNvJ7qn8kRiebn5TDGLikbt0w++VsaId
	8=
X-Gm-Gg: AZuq6aJlLubtukn45eD/Mln/AxRTUzJoNFXzUrMuKdkQAaEbMn0Pm8lrS3ZkMG9MS0z
	cD3SwWwCQGDjjPyeJzuSQFh0kkIat5YCXLDiDggAxgXw30zsnN1wR3gWU6oWD768fA1aTWna8Lq
	zKpahSO7elieYze3YbSsD2ip3Dh6SpBCyruS5ngSNEv8MFyIyFGR0chUY8f5FxctN8MWO18kjkB
	7aHaEFVXwpJB2dsEF85p6Af8vauS+loPUHLVjiRWw+g98FLLtVsmkI=
X-Received: by 2002:a05:690e:2545:b0:644:60d9:866c with SMTP id
 956f58d0204a3-64917773dc2mr12075758d50.93.1769089295468; Thu, 22 Jan 2026
 05:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mariappan Ramasamy <mail@nappairam.dev>
Date: Thu, 22 Jan 2026 21:41:23 +0800
X-Gm-Features: AZwV_QiZNeDZM11o-MKk_7KDA7mQ7yo_sasVTb9FNUuUgnOAyzlxMEQbDosuESU
Message-ID: <CAEc-AF7dobeSF+WEvZ0gZ9yS9j-6BS2pj=Ne3XWvW=SqK3558g@mail.gmail.com>
Subject: [PATCH] Please apply 1fb0d830dab8 to 6.18.y
To: stable@vger.kernel.org
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, "ravindra@intel.com" <ravindra@intel.com>
Content-Type: text/plain; charset="UTF-8"

Please apply commit 1fb0d830dab89d0dc99bb84a7087b0ceca63d2d8
("Bluetooth: btintel_pcie: Support for S4 (Hibernate)") to the 6.18
stable tree.

This fixes a regression where Intel PCIe Bluetooth devices fail to
work after resuming from S4 hibernation. It blocks S3 sleep after S4
hibernation. The device loses power during hibernate and its firmware
is erased, but the driver doesn't properly reinitialize it on resume.

Steps to reproduce:

1. Suspend works normally before hibernation
2. Hibernate the system (suspend-then-hibernate or manual hibernate)
3. Resume from hibernation
4. Attempt to suspend - fails

Error logs:

Bluetooth: hci0: Timeout (3000 ms) on alive interrupt for D3 entry
btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend
[btintel_pcie] returns -16
btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_suspend returns -16
btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
PM: Some devices failed to suspend, or early wake event detected
systemd-suspend.service: Main process exited, code=exited, status=1/FAILURE

After hibernate resume, the driver also shows restore errors:

btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_restore returns -16
btintel_pcie 0000:00:14.7: PM: failed to restore async: error -16
Bluetooth: hci0: sending frame failed (-62)
Bluetooth: hci0: Opcode 0x0c01 failed: -62

I am experiencing this issue on a ThinkPad X1 Carbon laptop with
NixOS. Hibernation and sleep worked correctly in 6.17.x releases and
broke after upgrading to 6.18.x.

I have reviewed the changes in drivers/bluetooth/btintel_pcie.c,
identified this patch as the fix, applied it to 6.18, and tested it.
Hibernation and sleep work correctly again with this patch applied.

The fix is already in mainline (merged Dec 1, 2025) but has not been
backported to the 6.18 LTS branch.

Upstream commit: 1fb0d830dab89d0dc99bb84a7087b0ceca63d2d8

Tested-by: Mariappan Ramasamy <mail@nappairam.dev>

Thanks,
Mariappan Ramasamy
