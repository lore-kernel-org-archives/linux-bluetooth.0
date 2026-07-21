Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C663FDC06
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649773; cv=none; b=QMaSOrv0Nw1dUsTT4pVF8RYHcVOtot7TucK670lNvsBhyFLy1nL+vzDi8a5OglE4ItmrJsZ6aGDxCo+3YoFj7mkXL8L/hyFkIHkCA16u2ncsbT3y7mB0ZzjNlHEpifC5wVMOC+vfiPXPnBAVU00bRzK0lqJTR66Egoa0l7/4p0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649773; c=relaxed/simple;
	bh=vhhWzyN+I0N7rNZjufC3YRpB5qa/zvBfQPTyWRUEH6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1sz88v/a6FN7/5hqXSN7AIAupYhl9QjB7zTjpqUMkROoaB1cn8+qT+MjGX28j0tXhzwvt+ouY5ZefcbrwKKOjs931F+oIntmzVgeeuLyDsjoRMIYxamxyj2mi05VxXgHv/Hk/3zNjkKJpMLMZePHqM7f+xBjcFfsJNrD5ZsZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaKWe8Ut; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaKWe8Ut"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-963a722ed59so1947586241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784649770; x=1785254570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wE5VX25D0QUPiT5vUwaJH5UHOU0aSZrWQyQNqql837I=;
        b=XaKWe8UtPYvooOlORnjrklQYM4/qHBwoyuJ4a9WPP73LKEQ7e5xmAdXiCccBgFW6Mi
         LKqzAUSxd96RLiVuFmxS7LegG5ZvH3EmItV/ruYT/s0t14mJIng9E/WPzR1fPZuR1W4F
         gt7DuTtgRw9SuDp9Ksh89K7zmg8KEW8RZbkVfXUSvJMiVQd3GoJuLJ7rj/411Ft0SVO+
         FoypJc3v6jFxUKwFF/5GACHnb7abPC7oqJCOUivgZhq8etwhN89iZ6xM1V60diLRSgSx
         f5kI1qdEVw4eZbPLMbraTktqJBIQwYoJjUij0KRXkkU6Vl4DK/DIwzviZ647gsP+cIkh
         BsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784649770; x=1785254570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wE5VX25D0QUPiT5vUwaJH5UHOU0aSZrWQyQNqql837I=;
        b=r9OoUiiXRHroFDjshw7G/sQZw1xgb2cFfCwJ5yjZcMP1OjUrvoP8aOvMvwgX7HieF3
         oWBqgBkY5h4A9y5rU5DiH0K6swk6VQlH5KXHxo//GluYZTuH6IvWkEaUYdBdvMRkvGNi
         ZRaY6vV4aUPycJMDMQLCYemi4YAk/hpVGn7uvNyccdoukbSVD53WaTqK6Ns+L/s3o9sb
         OdHVTSQTH/FlzK5DEyoFx6/s4ps+OtQaQ/X4tizkEjsTgMblCAJin6GrEuJ48uEYCW/e
         b+jNadX/Y5xf/cXKL1aNPAoQkmUZIInZlyfvUIDD1pmuMPG4wSH3O2qG8l3WzFk32JR5
         ZLDQ==
X-Gm-Message-State: AOJu0YxDe8DUDEM/iM9VWjv/3CSX0bzaBlLXpdmj/cIVZV8hX66MCAYX
	BCgw/tcPj/O6ZRtBS5cTUMbVfZLn67NNBlma10JCV7HaG6oCywj72hmF
X-Gm-Gg: AR+sD12P7lYv4PXHIXeE5H0ien55fTnE8Lhzqw5Pk4qOX7fQGhN5irG+pFE4GC1+NWJ
	sNwkr1cN99Mb8bZWY5FZn3zEQnA2AhAucxrPQjiP4k68jnIh0LYL3G/cgHgaB0snOIwRHHGKedr
	h3ZU3dsNoI4txInhxUsnXe4EtIsiOSFG1d79auHguJBNBUGQEzlpB7CeiRm6dsEWDOwKDpM7vAH
	a2UjzTvhBdXDaI6eFVMjWS+/wCwUzT3Z4odB0lPYrLy0cWIP2MEFoTkZtmiPVKuHI3tcA6zYaNU
	U7tT5MyiITdKwwPqCgvbJD/w1DZ0R21787zV+mu2RN4iUuqNH0gzTm+XD8twYKWYcujXJmNXFfK
	NIxRke6xppgxioCZEWFSaGVN5uDe5HcaoqdyrD7w2WOGd3mdor0Hnoifkkh7Adzv6aVmB9olb/n
	eva2Kfjyp2FA/aDc7XNzLH7d80d1NZcefNO2+i59uKa+icXErHrhPkiCGgFxYQ2vBT+KEzapzjn
	c6o21g=
X-Received: by 2002:a05:6102:4486:b0:739:4fa1:50af with SMTP id ada2fe7eead31-74753469470mr5448540137.2.1784649767844;
        Tue, 21 Jul 2026 09:02:47 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-74757fad039sm12389612137.5.2026.07.21.09.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:02:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-07-21
Date: Tue, 21 Jul 2026 12:02:40 -0400
Message-ID: <20260721160240.884274-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e13caf1c26587434f0b768193100440939c0fb91:

  Merge tag 'net-7.2-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-17 10:25:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-07-21

for you to fetch changes up to df541cd485ff80a5ddc579d99687bc7506df9851:

  Bluetooth: btusb: validate Realtek vendor event length (2026-07-20 17:41:28 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: Protect UUID list traversal
 - RFCOMM: Fix session UAF in set_termios
 - btusb: validate Realtek vendor event length

----------------------------------------------------------------
Chengfeng Ye (2):
      Bluetooth: hci_sync: Protect UUID list traversal
      Bluetooth: RFCOMM: Fix session UAF in set_termios

Pengpeng Hou (1):
      Bluetooth: btusb: validate Realtek vendor event length

 drivers/bluetooth/btusb.c      |  4 +++-
 include/net/bluetooth/rfcomm.h |  3 +++
 net/bluetooth/hci_sync.c       | 13 +++++++++++--
 net/bluetooth/rfcomm/core.c    | 17 +++++++++++++++++
 net/bluetooth/rfcomm/tty.c     |  7 +++----
 5 files changed, 37 insertions(+), 7 deletions(-)
