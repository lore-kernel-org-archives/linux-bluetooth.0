Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279558;
	b=loLefZPnZFLEXtTNffRaaIgtA+bntMvAHY3PXhQ79hbJ+bxf8lAb2Gpa5IeF9fDtCrat
	 zs9W80yJMvT00tSIDAgdeNW7dCJU9GfcV17QO/MJOro4OLfmRqyiEADoIa6NHvYct8UR/
	 telZvp/ljeu/n5VNmCpTWuUSgMxHh/dc6dZ3D2SQTj87ukKxWQ2IcTgWNqqsQDQ7gYHZ1
	 89xxJ3+wiN/C1KmLl/DriKktEYGwfIBDcBB+OZmdqyn4Z8P7UbteYzQy619R9X97qjat0
	 e7Efv6gwY9Y840hMCIWYCetSXnvo0JKcPdCQ917/fUT1qESYeKWCqSJjD/Kj2xuIGMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DjZU+GdqFfRghr8ivEXQmw5FGmh1wu7Sy+QCcEjKDCU=;
	b=0vUFJ/wbq0jVw3foIBKIfnOFHToKNpZ0fq++a+dduEQn6rtRn8n/eNu6cJzhdSOXDqpz
	 RmpJK7GXA6Sg2QMynZvKnly3nVMXZ+dG2e3f+q1FGvgPwEloPaGKL6ZTdU1pgwSRm7VZq
	 TsXjwFUbdvTaMHz2SY2vMkp3vmGbMe/cYRvloVGvVLKfwGgoJytiS/TzoJFnmEvRqAKpy
	 JYK4BMmPEZ9fO+FY2b66IbvBEODMHCaZZEbwUcC11omhBEPIYzZWiAsRwgiHkU9rCJOpl
	 ih6lfW+1NTfuj7aBP+AWsXUSUMFSsL6xgU0azLsO2oYiEcSzwf5yUyicqD5vLn/BUog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H7Y6oAmi;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D7F606A31E
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 13:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1D7F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H7Y6oAmi
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc751eddf25so1432214a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793279556; x=1793884356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DjZU+GdqFfRghr8ivEXQmw5FGmh1wu7Sy+QCcEjKDCU=;
        b=H7Y6oAmidjacGix85LBwbQL68Hm0G5p+X2mCCNtspf+lGlgOHODyLn1vyFcNqFLXAy
         cO8kreUaI/lctpK5t3gQUYIlsJkevK7vJi5COlrIWz+4fFX7HxtBkezzHzLjNnv+Wtz/
         knt2HZFPpmBCz2HakKYbPsCf7ttkSikj0hDJnP7oBvyUuhLJU6D8+qCAKNnPPZ2DiC8y
         xD4+tG+7IbrVleKPHgND+8OSFSm6kj1REBpegbR+9HcgD7rjQdDmaat7hj3AODzxe/Mw
         7NDQjaD04YKqNLvlRXakQxT/7Gws4/7MoJLMwj1K2RrCALfuHVSVz/QDvdyyxdRv77v0
         rkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279556; x=1793884356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DjZU+GdqFfRghr8ivEXQmw5FGmh1wu7Sy+QCcEjKDCU=;
        b=ljV1tUmrzieTOs/Wbv4d2eVKwUY5MxoI9Mi8ZeD1jB93b/nf7JXbLaQOfG6MvV0yd0
         edzMBrEw2909RzNySdIgdcm9epsYznoFOpa33PifI/DS2pWGZCtip0Beu2uAKcNU9Cik
         fsCdbnLzsETgnWttHWiaXudPsenov0v+lHeLU4yuRMeVLL6vrsIig/282Az1GhSc9gbL
         5HUz4wqgvSi9TWWGM9ddByqxDzjxZMP2rp1/AKzBrPytZ169VVpuvczxjD8DT8MHbEGv
         crKaTKvsOExYam4eQov1F8zi9rskq2b8traJSuL+tRcpHdjI71bcU5Rtfu8he9KXKVt9
         I+kQ==
X-Gm-Message-State: AFq9FYIoVNsrTBCHoM6hC6LSR07TYuOEq0JEbeWZiajcLj75kzTlxdmF
	q7OKyagQepImWTqcjs7LBdaXI/c8cTLX1K9BVuzT8VfITuRSKAyxLr30
X-Gm-Gg: AYBFou1+hGNNAOb9ja2pR3GfOQ+MoBV4pgMbkyPCitosgZQTkN7xAfivmzfFNci6kse
	/OPsqedorIcz6yS2RyLalge5j9ATKlyPA57h8AhndV6Ur7ip9VRLs1YR12k6QFJwZiSj69UkYqU
	3fSN0OP/GeKT0DfDsfR2VryANw3svdid1rFr3AZuYu/TZBXDLoYAOdp/DAKxNR4ae8g4OJjFuE6
	ztlAZUA8cAb4flvaNp1GdaiMoIPiZaVhUdumhuWB8TceEco2nWe78LnbtuOaRqsmuVC0DGuBZG6
	tiE+wqyQpl3HLMfmc4s2pvqKRAwUiKb66p/T6KC6COAoiR0CLDlu4O83vmeYc2TGWwM801yL/Js
	dQqXCfb6nGrnhA+qQeYUtgGq98HAXJAg4dQph41PaxO9cn4P0e82IVohC129ibxGwG87LXdXq1n
	InH9C785nCpUHJWfOZTjV4wemlmsNZU+m4kzk6srcG3kU+QOVUMEX1SQ/uA6G8jU7ulVl726NBK
	foND6q5FUGB1U1qxdQTTEex7lHF5h3/pIcxGI290JRRpOvDd2oBPndRjgEPQSYpwKhJEm0Y+7k4
	hIg1g0jpVTBNmpqQf+hl4Df5
X-Received: by 2002:a17:90b:3810:b0:3ac:eeb:e0ed with SMTP id 98e67ed59e1d1-3ae5828771dmr4642335a91.36.1793279556148;
        Thu, 29 Oct 2026 06:12:36 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d555d4sm4090445a91.1.2026.10.29.06.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:12:35 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 0/4] Bluetooth: Keep borrowed keys inside RCU sections
Date: Thu, 29 Oct 2026 21:12:25 +0800
Message-Id: <pm-bluetooth-objects-candidate-0122-v8-952ad9eb0ef59367ba6a-0@gmail.com>
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

hci_find_link_key(), hci_find_ltk() and hci_find_irk_by_addr() return
entries of RCU-protected lists after leaving their read-side sections.
Management clears and reloads these lists under hdev->lock, and
kfree_rcu() frees the old entries after a grace period. A user that
does not hold hdev->lock must therefore keep the returned entry inside
its own RCU read-side section until it has finished reading it.

Two such users have already been fixed this way in bluetooth-next by
commit 817cbcab91fe ("Bluetooth: hci_core: Keep RCU protection through
LTK filtering") and commit 4b76fa362110 ("Bluetooth: hci_sync: Protect
IRK identity reads with RCU").

This series applies the same approach to the remaining users that run
without hdev->lock:

  1/4 hci_find_link_key() checks the blocked-key list after leaving
      RCU, as hci_find_ltk() did before 817cbcab91fe.
  2/4 sc_generate_ltk() derives an LTK from a borrowed link key.
  3/4 smp_ltk_encrypt() starts encryption with a borrowed LTK.
  4/4 hci_le_add_resolve_list_sync() copies a borrowed IRK, as
      hci_le_set_privacy_mode_sync() did before 4b76fa362110.

The other callers either hold hdev->lock, which the management handlers
also take, or only test whether a key exists.

Each change only extends a read-side section over code that does not
sleep. Every section ends before a synchronous HCI command or a
GFP_KERNEL allocation. The patches are independent of each other.

Cen Zhang (4):
  Bluetooth: hci_core: Keep link-key filtering inside RCU
  Bluetooth: SMP: Protect link keys during LTK derivation
  Bluetooth: SMP: Protect LTK encryption with RCU
  Bluetooth: hci_sync: Copy the resolving-list IRK under RCU

 net/bluetooth/hci_core.c |  5 ++---
 net/bluetooth/hci_sync.c | 11 +++++++++--
 net/bluetooth/smp.c      | 29 +++++++++++++++++++++--------
 3 files changed, 32 insertions(+), 13 deletions(-)

---
