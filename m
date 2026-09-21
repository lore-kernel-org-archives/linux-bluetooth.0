Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34114515998
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024502; cv=none; b=EEqc8yA2/5AbzhHJBf9DVK6zrpCzGvCQb6pueZ3zK/ojtFQ2eJZCXFX7/ZJ4nXcjr+h7AA3g5b+vxhZVNoov92JNNAqz4MGd81KKKSfmXKtciycM2bWFUBdg22k/fNWFEYAEYMgkVvAs3o/hSDT/UxhzbiVqLtBw6iBx6XsAelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024502; c=relaxed/simple;
	bh=Y2+6+XTnM5xaPTQE+fsxMobOEM+qG23KhNolFqitxO4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l8ahv5EO6TsP+e8m/nXuhK1/v1ncisNkC737uCdVLo2M/bD3JAF5wv/ml3FFackFZW5Qa6rvwSiiPpOIUncTTP8sxpcy7qeciCvOEf3wX1Um/OCArOwq7XvtCW/vQK+nr6owKNfVBw91Nt9NP9fHI8WCE6a+xZTLTSPWFkUeaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkOVa4t+; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkOVa4t+"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c83be8db39so1992502e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790024500; x=1790629300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XU+w1OduwTAu/hJ+BktrRdL06HWFCfE2ovG7OUFV79I=;
        b=HkOVa4t+OxSnHdt56xKQk1MheLE8fNpdy8MwTyR/VAUpVidX/CzAN7jKoLSvtPz0rH
         G5b7bFuglgHsoMdkywjyLGsOUcd9zwycEkwXe9FDuW8b/p9T9zMtmv8VF53wgzNa6mHI
         58PVwYno+mO3xfW3lsB+P2dq4LGZehyLLdP3xGnf7CCjuOXLk1XRc3z5oMY/n3TuFoCY
         zSHwziDDw+i0/l6EqE4dKDgPzKyKWJCw1LIQsUIpA69FVBplzm3dteefbw8/cfj2xQEb
         rr+/Mxn2r5A57vefVpDpFwzUXux58N9OPpfRrmGr3gqapIn3qr18yyj/DybnSRhC4KWQ
         3ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024500; x=1790629300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XU+w1OduwTAu/hJ+BktrRdL06HWFCfE2ovG7OUFV79I=;
        b=1bUVbJa71cuGcxNiMNgxAfSnu2qumDVE3kiFLVFTYJc8e0BzZvC5CjQQCTcIR2q8X3
         BeMh/xru8tDCUNjM1yUMt7W7qiVE9ObCije+QqEUeJq9xksclxa+dk9kEkUEGaXwZfAj
         8bsJSXlFBlJByzapEVOXy9UDyNBVDvTOkqhQBnlQoPaGL8ppzW63dLvB9LAYNvBAn4o3
         UjG+M9V1SGiruC30C35CxnfPur3Sz83eZun3zSd97SH7uDqjhwSJwTh4TgJp+5wlx/N3
         qH6Uxb8gH81x4rJHDdUez95y8GKaf3Albsy4VAGzz7qvIynVMaA20YXqlj+ZC25iiX/m
         /Siw==
X-Gm-Message-State: AFuF++krFM6JyAcFTDyd5b2ouCbbqQ99SrOFpzwRD7qMtoczzCbtRdvb
	YGBedYSEbrIaa+1+wxkZfpI3r5YyBMfEJtTwiZdqVpUS/7DIcFMeTYytneE71OIK
X-Gm-Gg: AYBFou3isrA4So5GjJbsLcSnj2ARygam0zHQhw/8254wUAlYlmnAQxtR4ZtkSQqzmzR
	vI55zW88TRwIWc0tWFlgswAuWpcN4P1uiJRm9EdWit69jRY8jQ9sSQlfFdJNECuW3EDjetVqoiD
	5/9WB6AARCX2olMjV55S0VgvA7Ix0cvgcLRF7Ml9st0Wh0xaphxT2V6C5c0FPg1WRzppFFtdbwe
	H2WAze0fHiaKEfQZ4SFhKS2LmGI0IOD9iulaNq6B8QlBVCO/GS+AZ35yG2q/SEhH8ojbA1Od74h
	dr1gdIc6DogykTTk2vSEipTT+OP2JktsIa5EaH6MZH8VzQMweZ6ooOtZUNqN2d0I4tiWaQHzysZ
	2WLv/au/Z8DcNaMkCs7K2kO3Q5lMU0YsZ3gjQ+5+5jghq+7InHW9FeUHKoVgr3KFzRExbV2c1jS
	1vPCqNWLPJ6RYdMuRktr5HfC0TJRKRdvKhCCNSXdhTCq1lD7TQ7FhZGcnfN5cW20iSx9LV/Fp/e
	Y506R9FxgLsczAc2fln16cn53iSifCaC6aQNpZ53Z4LtfUEc0Yo8guZsZYFv8RU
X-Received: by 2002:a05:6122:1c02:b0:5bd:71cf:e97e with SMTP id 71dfb90a1353d-5c9b58caf66mr6447800e0c.5.1790024492960;
        Mon, 21 Sep 2026 14:01:32 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9850c318641sm83527241.9.2026.09.21.14.01.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:01:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/6] Add true wireless BAP broadcast tests
Date: Mon, 21 Sep 2026 17:01:17 -0400
Message-ID: <20260921210123.3690449-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds functional tests for broadcast setups where the left and the
right side are separate devices, as in a pair of earbuds, which so far
were only covered with a single sink taking both channels.

The source broadcasts one BIS per channel, and each side registers a
single location, so each of them only gets a transport for the BIS
carrying its own channel: the sides are told apart by the BIS index of
the transport path.

Two topologies are covered. In the first one there is no connection at
all, and each side scans, syncs to the periodic advertising and reads
the BASE on its own. In the second one the two sides are Scan Delegators
forming a coordinated set, so the assistant discovers and connects them
as one device, and pushes one BIS to each of them, each receiving the
periodic advertising sync over its own ACL (PAST).

Writing the second one turned up two bugs, fixed here as well:

- Every MediaAssistant object of a local broadcast shared the bass_data
  of the adapter, and a push stored the session it was pushed to in it,
  so pushing to the second side replaced the target of the first one.
  The Broadcast Code the left side asked for was then written to the
  right one, and the left side never synced. This only shows with more
  than one delegator, which is why it went unnoticed so far.

- Pairing a device that is already paired was rejected with
  AlreadyExists, although the documentation described it as re-pairing.
  It connects the device instead now, which is of actual use to the
  user, and lets a test run against hosts that a previous one left
  bonded, as the hosts are reused.

Luiz Augusto von Dentz (6):
  doc: describe the true wireless broadcast test cases
  doc: describe the true wireless broadcast assistant test case
  test: functional: add the true wireless broadcast tests
  bass: keep the push target per MediaAssistant object
  client: connect a device that is already paired
  test: functional: add the true wireless broadcast assistant test

 client/main.c                               |  40 +++
 client/scripts/broadcast-delegator-left.bt  |  32 +++
 client/scripts/broadcast-delegator-right.bt |  32 +++
 client/scripts/broadcast-sink-left.bt       |  23 ++
 client/scripts/broadcast-sink-right.bt      |  23 ++
 doc/bluetoothctl.rst                        |   6 +-
 doc/functional-bap.rst                      | 246 +++++++++++++++++
 profiles/audio/bass.c                       |  39 ++-
 test/functional/test_bap.py                 | 285 +++++++++++++++++++-
 9 files changed, 701 insertions(+), 25 deletions(-)
 create mode 100644 client/scripts/broadcast-delegator-left.bt
 create mode 100644 client/scripts/broadcast-delegator-right.bt
 create mode 100644 client/scripts/broadcast-sink-left.bt
 create mode 100644 client/scripts/broadcast-sink-right.bt

-- 
2.55.0

