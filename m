Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E80384CC6
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317885; cv=none; b=QY/Gq5uv0E/EQLweVx/klM9bz++Y50zkvKyi8108A45UNch4YpQAaKW+dZDPMM6gqVdM/ZgAc4p0ABrHUSkWG4U5PwVu1J6bkx/okCsh3/3QUCZCij/mm0fZied/P5eBWzd1QkLgd9gs9I7660oxj2BdFDCJ7JceeAa6NVuge5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317885; c=relaxed/simple;
	bh=grygU7FlCAJ3iLg1pvfJrxZJMYPcKaQUG9efCsSDnsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkyV6SOcyYwkEGgtl47PwmDZj+jYJ/Q9W7M/hNJ/VStszmelTdmYTXRkXZzQsnlorI5kyNAW92F1PPCJ5/pWHmfXwgkNKk/G3k5XDD/mApgaXRdUQgTQ6xbs4GOOsv81uusKIU0Kk9oQRIiUiyUmgTsKpkal3I4SvmAoaF9w9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+GJTxuD; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+GJTxuD"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b04c53ae6so370466f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791317882; x=1791922682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=grygU7FlCAJ3iLg1pvfJrxZJMYPcKaQUG9efCsSDnsU=;
        b=I+GJTxuD/dZgc+tnVdvtOQQ/8l9jvsR5sVS7IQsTBJAKj8f+OKlVPIwOuyg3jMI2lb
         DXdmI3CG+fTUtxS1S8r49r250nkpGqO7gBPTqCGTh7dTgC6rs5URyJxgiDzwkF1eO73y
         aKXBqnQ0r4m0ZCIVflPjSSSo9nvosD5OIpOFT0UYUBkRzX7iMJxTOYV85sh7IC4tl8wi
         qXqWJ4OmSGCaqb+xJXcQQjMDNgIF8NSWXUhGL4lab8MfD1H6gT6f2TYsMC+e6FnHbWUs
         FwPtzA8uwMqyN2T5e7ngRDK+fxpl0vEHoyQeUQtuf2Z3gVmL2fMUAJApYz2+/etIPcXt
         5iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791317882; x=1791922682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=grygU7FlCAJ3iLg1pvfJrxZJMYPcKaQUG9efCsSDnsU=;
        b=m0bUhDDtzUyEUMWR0Vdi11AkxPHjSTpvWk6775FZ03hZF/QQZloefs63bUBNlCIW1R
         yK8DBL7BUSvYNsD3XVN705hDP1MJ1roHmZxXsZyHBJD7C1Ys3XNX/28hZYhcQVkF12S5
         +coHcoodE/iRcGpHWTP/fYSLfwdXU5Drab2xMjrqvV+/29KJJmq62Jq1mmTVv/Gvo+Tb
         /TR//BObE+NL0/8qLJqU7UUjz+5uN6ZuqvM95E7KWpqnn7a/IG2fLd00JWcQzmMb4CAm
         xl+XLkpiObmm/2pfyCxrxKcDYzKF58GF2AGmiU2XsJUMmAYsBWCn89RhJxTMH9KES3m+
         XIHw==
X-Forwarded-Encrypted: i=1; AKwUvBwQuL5pu2OMX1cTstjvDjddcOh1lqxc6P9i76OR6NBj32iRHsJKHNkrW8zCvxSQAnWkdCMKl8aYNld0AiGEs/A=@vger.kernel.org
X-Gm-Message-State: AFuF++mJbYI3fiUXBEGD3eMX+n5B8q7gsz7/n4nkRnKeIUBG3mqSIGz7
	x3ee0FjDSwtVVzt4Kdod/yG0u3XfB/11Z4hgCYNKjl8y84Hc2kJ7jdwA+BGqqEn/e0g=
X-Gm-Gg: AYBFou1xJ5zeiXdE9v0+TlMWJ0YvQJMM5RnAKkHjHaoitn/9HNSfni5Sej52XuEZMyT
	j5eN6ebcnJMMvHwEfyS84mLQwDUTPEilw0ChBpTK3a0ZqnExRLjJxFvQvhJQ7VmXwjhMp2uQSt4
	PLW4B631h8cO1yWSsLeKuzs0lsLvEV/d7w5F+BCbo/Ul4AdYK5OcAyBZ06Z33yJKg3jG38FSWvb
	a6Yt9WVbYgSz7mAD6HttxSQQa3yQp3GMKFkSlmfK0es02NbppgjT/veIiPOGt7ddND0HpB8c0p+
	SWF3GS8AvHOGUG3eW1+OcmyevLKSjRmVhauX2e99HV4xlwH8E3MaXdamhIsVPmdOoOb4TzeuUVQ
	bn+limNAqP/9HbaxWPY8x356VlQWTP+dkMZtjwHBPxrNc5mSCEzplu5zISZuTXf/xwUrQ7ZYxtb
	e32I/IIreAgapp4uqk2w8ddCdJi066Z3GSAWd9CU8AKAfrdG7UU304TIiA0TYnsKCyFns5oSNAR
	jJXPrQcrv1W5NZesEAAB1Vcy0k/E0xVHBaI19O1WGz9IJd5rAASSM+1Y+VAj2yfeQ==
X-Received: by 2002:a05:600c:524f:b0:4a0:1973:f05a with SMTP id 5b1f17b1804b1-4a1802e92aemr128075e9.2.1791317881623;
        Tue, 06 Oct 2026 13:18:01 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f795f29sm9366805e9.11.2026.10.06.13.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 13:18:01 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: benquike@gmail.com
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	lee@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: MGMT: fix mesh_tx leak on hci_cmd_sync_queue() failure
Date: Tue,  6 Oct 2026 22:18:00 +0200
Message-ID: <20261006201800.3597400-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260919115436.3998954-1-benquike@gmail.com>
References: <20260919115436.3998954-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hui,

I reproduced the leak and confirmed that your patch fixes it in the
tested cases. I applied the patch as posted on top of bluetooth-next
036d4119079a and compared it against a control kernel built from the
same revision without the patch, in QEMU (BlueZ test-runner, emulated
controller, KASAN and lockdep), with legacy and extended advertising.

The leak is reachable without fault injection: with LE and the mesh
experimental feature enabled, a Mesh Send while the adapter is powered
off reaches hci_cmd_sync_queue(), which returns -ENETDOWN after the
kernel has assigned the request a handle. I also made that call
return -ENOMEM using failslab.

In both cases, without the patch the failed handle stays listed in
Read Mesh Features. When the next transmission ends (in the
powered-off case, after powering the adapter back on and sending
again), a Mesh Packet Complete is reported for the failed handle, and
the next request's packet is started on the controller twice.

The leaked entries also count against MESH_HANDLES_MAX. After three
consecutive failures, three handles stay outstanding and subsequent
Mesh Sends from that socket are answered Busy. In the powered-off
case, once the adapter is powered on, a send from another socket
causes the first leaked handle to be completed without ever being
started, and the other two failed requests to be started on the
controller, although their Mesh Sends had been answered Failed.

With the patch, in all tested scenarios no failed handle is listed,
completed or started, each accepted send is started on the controller
and completed once, and repeated failures leave no outstanding
handles. The powered-off reproducer gives the same control-vs-patched
result on a 4-CPU guest.

Separately, with both kernels rebuilt with CONFIG_DEBUG_KMEMLEAK,
kmemleak reports leaked allocations from mgmt_mesh_add() on the
unpatched build only, for -ENETDOWN, -ENOMEM and -ENODEV, when scanned
after the test program had closed its socket, removed the controller
and exited. The leaked entry keeps the MGMT socket referenced, so
closing the socket does not release it. It also stays leaked after
the controller is removed, although the commit message says either
should release it. The -ENODEV case needed a
test-only delay in mesh_send(), added to diagnostic builds of both
kernels, so that the controller could be removed while the Mesh Send
was in progress.

No KASAN, lockdep or WARNING reports. BlueZ's unmodified mgmt-tester
passes 503/503 on both kernels; mesh-tester gives 8/10 on both, with
the same two "Mesh - Send cancel" cases timing out.

Reproducer, kernel configs and logs:
https://github.com/ivoitovych/qca9377-bt-hang/tree/ccfc358e2cd866948aea3ec81bfabd5298e30618/retest/mesh-tx-leak

Tested-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
