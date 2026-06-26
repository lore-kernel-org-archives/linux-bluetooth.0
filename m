Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9B29B766
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470775; cv=none; b=r67mVYzhlYo2bdKMglVKHowm2vaD07oySAh329SZBDA8TJ7qsh7oJiiWQ3ZfkrzoloVYYJh4KPfd2nYFampPGH/y92MwG3aEPjHLfQ//rDQOw9J57VQtL9lAgezgThXsxe1Wi/61SgIwzcX8YjGyFUbzv4rJvxYL+7Amd3oCQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470775; c=relaxed/simple;
	bh=Kr2B56j+YXQcnhiNkNd5xEnnYZxvJNIH58SRYO83s6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wf8nc2IbguAdWSk7UqU8k4kOq8UxV/zBAdxeURbBiMUfjM7qyxGnZQvEOCcyOVMcYk5Md4GkTSAUzJeBLYgNVDkBdAZnK/tbm0mBD81NoCsmg/mHZ5i0001/YzI3u4cRJTePE9JdJ5Y0aKWeKS8vb9YqIlrBSGY/ZiaU981g9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4yWOcRu; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4yWOcRu"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30c9c8c2697so717128eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782470772; x=1783075572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ienghRFlOKCrHTVcT7ltXLw6p3FK6RiRmVx7RZAUjMQ=;
        b=R4yWOcRuSnPL1zhhK4UX6nTRT2rEvUahAVquLzDW6a+sAbDnEnq8vQEIICH+4OM1ya
         GU+uFo/nrihgSWJmXjSFZ9n7L1toV8ygDL02/4QH3tWWa4dyEe0VnHO0McCPgmG2tZK1
         JDXLpWp9VK1tXvXxy8qSUWWYTAVE5ZXKcuR0jreSTjFDlLSF+hY1+eKDQ/k+OCudhCCK
         Mc5O2YV59RqBZV6Po3pcByOsDrAEo8G1XOxBmXdJl9+yCalBLwaCUaE1o4q61UrrIL2c
         2l22cgHhTEAknJUfa/0AOa7GPjQ6ITj+yvUfIoZKb0Dwv6uV9gdWdo//m8fxiKrrWkIn
         lDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782470772; x=1783075572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ienghRFlOKCrHTVcT7ltXLw6p3FK6RiRmVx7RZAUjMQ=;
        b=I7hedTDETCGwNEnM6LtZz1r519qSuhr7b4yaefIFgKZLo3yij4+WrVNPcUFwFKn+v5
         9To6QA7WJOoXDqw1B3a82it+Oq/Ixvf73N9ydajjDbezU8eEFo53wrKcJfxXjAbOFS/O
         to8zhBR3zT8ID2umKPKhs7RLIaOaUIYy2nwaNR0RAiwJpCvUPmGjFa4dc/LiSo7bYGjQ
         NmhltAsI+ZzRgTId6BihdUDcdtDlGB9A1IehqRRPcJR6o5h5UIpa6YOLQ0eSyu9OPiCP
         e5ZO3PjiwjpLYSmveu/dqMiEVzLcpV6POcCBy4/tIlGlqBU3Y2nCl3a33ckdc0L23aJ4
         eU3g==
X-Forwarded-Encrypted: i=1; AHgh+Rp3/o4q5jWF6btwlITVzlKpoX+g1SpYJ5GkYJ6ZJiaOJrXjFeSDSIx+ajtritHce09n+Ja4T8mjqHbdoREiGN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZ81j2ZBeT0nejfUkyN/JjBrUVsxwcE3zSEnBPvR/z3QCd47A
	KWFmhstjpLJzq/FiiF5ipWjBxbCIOp9EfpnlpGvgrnSBt4evtQ+P7ZZX
X-Gm-Gg: AfdE7ckK1rz825o7/BTLSRw+iOMPjNkvzgzYMLC0ipMw3Dgq/3f28l8IrmykEsvwASo
	5Qzt9BwWZj64YZJR5A8spKuttWt4G4TyPfbGcZrUyUy/N9Fq1RtX4jrcBlZJjPp/C02nHqNduVj
	mihGvS93aaJdL4mWnRCuzvEvaPBlIFuYSBV/4a5QBijDBCls/Nf1fo0mjCCM7hXsLoTwodxUNax
	wdP9KYgdPmO1Eg1pVWaLr0z1kVWyenC0EzLL720+Di94ddv69NnWdgCYX072UiS00MJcRnR+903
	t8v7imVhD8zOfGjKdPjjSPYZsQIVMZRUgqAPTc7eCb8sip+RP2T9eVZCGP5aahY59c+HA7Nq0Dx
	2zl7XMwAbxLe2Z6x20H6q0KBRSvqQVvahSCv7A4W9mLW8gMnZs1c30YGyctBGlFNEauHY1epLN2
	v/T6Y6me7Y0oh6Qornmh5aIR7t2BNh1t21rMTqoL0az66E1927BuE9JDhJVQ==
X-Received: by 2002:a05:7301:6583:b0:30c:7b76:9047 with SMTP id 5a478bee46e88-30c84d4a202mr6138025eec.17.1782470771484;
        Fri, 26 Jun 2026 03:46:11 -0700 (PDT)
Received: from naduvan.timesys.com ([122.178.167.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab28fasm17823093eec.30.2026.06.26.03.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 03:46:10 -0700 (PDT)
From: Siva Balasubramanian <sivakumar.bs@gmail.com>
To: stable@vger.kernel.org
Cc: tristan@talencesecurity.com,
	pav@iki.fi,
	luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org,
	Siva Balasubramanian <sivakumar.bs@gmail.com>
Subject: [PATCH 0/2] Bluetooth: btmtk: WMT event length validation (CVE-2026-46140) - 6.6.y backport
Date: Fri, 26 Jun 2026 16:16:02 +0530
Message-Id: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please consider the following two upstream commits for 6.6.y. They are
present in 6.12.y but missing from 6.6.y (latest checked: v6.6.143),
which contains the offending commit d019930b0049 ("Bluetooth: btmtk:
move btusb_mtk_hci_wmt_sync to btmtk.c") and is therefore affected.

  634a4408c061 ("Bluetooth: btmtk: validate WMT event SKB length before
                 struct access")  -- CVE-2026-46140, tagged Cc: stable
  e3ac0d9f1a20 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL
                 events")         -- Fixes the above; regression fix for
                 real MT7925/MT7922 hardware. Both are needed together.

The first patch fixes an out-of-bounds read: btmtk_usb_hci_wmt_sync()
casts the WMT event response SKB data into struct btmtk_hci_wmt_evt /
struct btmtk_hci_wmt_evt_funcc without checking the SKB length first.
The second patch is the required follow-up: the strict length check
breaks devices that legitimately send a shorter FUNC_CTRL event, so it
must accompany the first.

Both cherry-pick cleanly onto linux-6.6.y at v6.6.143 with no conflicts;
skb_pull_data() is available in 6.6.y. Compile-tested only
(CC [M] drivers/bluetooth/btmtk.o) - no affected hardware available.

Pauli Virtanen (1):
  Bluetooth: btmtk: accept too short WMT FUNC_CTRL events

Tristan Madani (1):
  Bluetooth: btmtk: validate WMT event SKB length before struct access

 drivers/bluetooth/btmtk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--
2.34.1
