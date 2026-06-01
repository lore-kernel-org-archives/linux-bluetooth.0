Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81073BB105
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346528; cv=none; b=MrbkFBsBBWsbqtTNw6POIjEhN6Vejghjb/qBepFBaOPrJkiMnAVygI/KApILoz+4yVlXMot1VUvalFU1TZREPiI+fNXaNJbe9f8Dr5oqXuKBQ6fk297XC61qMXUN83O0o5AOr2yTR1ZLnLG5Sd5JGk/jCY3xATffOlxeh9Yqm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346528; c=relaxed/simple;
	bh=BAMVtak6z3NFwxTPwpSRB8F8i7eRjicBNU6B7Z+rk/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfmadsD+31nUsGBD6dtSGp07rdXilmxqUfiyIrvX14MCmVaU0yKjBjSixS0Wtt+xrDIlUmYjultHkzrze9ngqvM9v0l4hmT4k7DYAaqfNhmL46/30jndi25+JBiJg8lIApBGIJJCt/iXJlBcB59rb/RHBzqINyurLNw4fn1yS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFbUO5C9; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFbUO5C9"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59bbe027424so2508760e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780346526; x=1780951326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5HoM5TSdN4ggrcMkPOe8bKINFj47NYArDve3jFSC1k=;
        b=DFbUO5C9PCkpS8CLwn3xGrxwqlSjiLefLkiC5Y8VFF6bGmF3CP8wjGtyp8fOqHgP+z
         7QxNglxWtTrjBT/LJQCjS9Bx/VLstwwUH1bVMC5ohsCba62jHSJYbtjEHDRKy2b9hmiP
         N7mBMlcAlbK12phZbozuOYrRCeYMQ+d0yCMVe5r0z5hl/71aapv/38mxBBpbxtoPeEqm
         yDbzgwOHWOvR5aX/c7Dlm7UIrXY6tUrZRpr2gzsgPi1Qwdqf3xvfDkIvyb+mO9tB7cMP
         fnayTNVh2yKMBvw5bbjvKgL5mfdGeQ0jdgREBVDCXxcDiomSicYZfWAmVtT6u8sc9Vgz
         QdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780346526; x=1780951326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W5HoM5TSdN4ggrcMkPOe8bKINFj47NYArDve3jFSC1k=;
        b=iDPG0OCAftKSoZlC2YtOtihJSca/OceHm0srcV6TNXh+ZwM7wasKcOhnGxEw8GlfI1
         3ohLvOKUiWIJrfd9nTIs+I51j1OL8Tdw6mLWQVgiXS5yjUCLIK4GEGHT59mfLWnELU4r
         9JY5DkALTwtdS5vNy/7RSnXSuKpRLWAGeBTAHbGy9kUeqPX5PPzol8YyfnnnKWHvJrct
         vaukbDsLFGO+CcOflRFV5S3ALGtmF6OL1C6/h4RYm2+WST49ZmF8NpAjCBvI4nGq+C39
         ZZ4UTfo9dE3M0QERNt9gSzE1Zy2lsCXO7MxDQy4MpKR89gT8RxBu9+vbWRTObg/oXX4j
         rarw==
X-Gm-Message-State: AOJu0YzKPACm5w+HM6d7iyJOe9DCNtFbVaHEemuroyao2m3uLxN6wKim
	uwpET+FC4Lk2U+Qe2bJluVfmoSI4BHcoE3zw0WtDt/nK1YsnCX1esuWw8+h/JRifouk=
X-Gm-Gg: Acq92OHKkH07OlXw1WBQxcX2PjkwifO+Vo2FUbbRMG5Po2ZGEQPrIrGtU/CMtkkZGYN
	HiWIkzWh5GAFnbyPrBCu3mQHEXIrYpRIiuYVaUh2hGw9Gvhfsvll4Yzx5KvqP4vrfoJYZQd+jHq
	9n5eMicd45dBVqJNSN4N9SqTBkM99Igw4bVYL8F1Ni/qwrjVEM7pwQ9doDqH36OYKSTZKmQnN6O
	iKy/+FGGq1Yng8/FMwTt3KpR2GTPwauzZy3wTugPzHndYvDykvfJizhONBlrZTAOye+ULVxw9L3
	pUOEASoYo0UnIk3mARERwVxEdkjmUD8wrB4JGG01RSPEGpx3LNEU/jy9RmZykh/A10Zm1A4N4yQ
	FY1L/NLx6K/XjJAqIMGVWdTuhi386XZGlnADDzzXgMSNZCyz+j1KPaDug83FHbPG3UdRqWUVfbr
	2PeIRGbhZinj6ql4facrrlOFvkXzZF/u6ig67BTO3plMzyKH+Ubvah2ubS9AjTs+a1YOBJGa7tr
	mAYmTAyz/0BCHqHLC/11gJTM4lT486dxJd/xdo=
X-Received: by 2002:a05:6122:6787:b0:59e:f988:51e with SMTP id 71dfb90a1353d-59ef9881252mr2879841e0c.5.1780346525719;
        Mon, 01 Jun 2026 13:42:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a3a9818c89sm1598442e0c.10.2026.06.01.13.42.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 13:42:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: ISO: Fix a use-after-free of the hci_conn pointer
Date: Mon,  1 Jun 2026 16:41:57 -0400
Message-ID: <20260601204157.13923-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601204157.13923-1-luiz.dentz@gmail.com>
References: <20260601204157.13923-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In iso_sock_rebind_bc(), the bis pointer is cached, then the socket lock is
dropped:
	bis = iso_pi(sk)->conn->hcon;
	/* Release the socket before lookups since that requires hci_dev_lock
	 * which shall not be acquired while holding sock_lock for proper
	 * ordering.
	 */
	release_sock(sk);
	hci_dev_lock(bis->hdev);

During the unlocked window, could a concurrent close() destroy the connection
and free the bis structure, causing hci_dev_lock(bis->hdev) to access memory
after it is freed, fix this by using the hdev reference which was safely
acquired via iso_conn_get_hdev().

Fixes: d3413703d5f8 ("Bluetooth: ISO: Add support to bind to trigger PAST")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index a93269eb53b7..8c52800bb93a 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1083,7 +1083,7 @@ static int iso_sock_rebind_bc(struct sock *sk, struct sockaddr_iso *sa,
 	 * ordering.
 	 */
 	release_sock(sk);
-	hci_dev_lock(bis->hdev);
+	hci_dev_lock(hdev);
 	lock_sock(sk);
 
 	if (!iso_pi(sk)->conn || iso_pi(sk)->conn->hcon != bis) {
-- 
2.53.0

