Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE9371CF5
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155652; cv=none; b=uWfCvwZRdY+iJ0/LLMCpMeXtztu76jCNDdsuBBJT0pqDoeSmTHpVCndov+77LBTkjp6PEv4cNsgDXtTgb+SrMZX/1XDMn45HV7vAJmEcoOWpdwR8CuPxlb2L0Mae7dire0JqQy7UICskIMeQF3jbkABibWze+EFwm75jMLvsd/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155652; c=relaxed/simple;
	bh=RwxN2MfipCgR418UuZSsP8mrLaJ4ASbiNxzJJ42mQLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPUatodszfaEwVcVOiaYFRtvaAB2Rcvif879VdxyUSRZf2danphgFUdaAlUbBioJTxPGLYVOAz/cEpj9Gj84utaDnUIRAqDectn0aSkcbttAzScw9Awo38kFKhr29UeVhPG7FJPKkkBJ/ctD/bdPDNNu03LF4vzLIAvAsAnYNiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRyCmxc9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRyCmxc9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48704db565eso12935835e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775155648; x=1775760448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OODqbL4ANJzyaR6iRPGqbWeycFnxpu3cwsIO8Dd0p9M=;
        b=lRyCmxc9wRlMWEtUP175D3F6l00Uh4XsnrdJuHJb79PK/lNoYn3QNz1bUo6L2tHStB
         7J4/8ac93+oo1uVhlBtekQCt2pekNTIJRdWmb80qKlClduK1MyBGpDLlqPkppPNS+Keh
         Rc2Vtf36rcg71x94irz/YsSo0NE9+CNBu1qhPjdDTIyPBVbfet5K05acyGUyHH4Td0Lz
         HSyUqvexFnh/tww00KNp17IbSABegLdPyhw7MExCMRkUZd75NWNNmauAdptbqAjnxNlc
         tTzUcjQIwZmDgN2TpP9rU4OOgq3QNECn0V1nK6qsoRNuMhN98ObrujrY0lGr4QYgNU0T
         Ym7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775155648; x=1775760448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OODqbL4ANJzyaR6iRPGqbWeycFnxpu3cwsIO8Dd0p9M=;
        b=YW9WqH9MJbO/dWNFqejVYRom6HbagXgXiNOC0uyym87n15lJgXLBuTqSvqSlfnR+EV
         4Ncv3+Ql0W6yXRaeH/sN8Q8vXlC0BT+ZiebwGeJ/v8dI5OUta9h4QG9yFo8Y2CdmHqMu
         NaM/b28BRvKXgb21Donaq6jftgJmurxt6TK7IMUWqiXU+fEoQu0daxb5JIPE39Mbx7PB
         /XY5xvO6fvjrNMCtpmF1dnR/qL49MmOkxVYvzt2Lqd/fe9lDdSQT3HnVDrK/KE8DB5rr
         Lx6CAsySge2jFqSCsYi3HfWfJyZmkVAk3XQoIRktT8xBLgvtfycVlPPKCMgkyDZN+ySv
         I7/A==
X-Forwarded-Encrypted: i=1; AJvYcCXN3Lv3wqio5zvbCaqyk0huLdo+wOfGxFnC7BSaVtT1Wsse2C9mm/P+yuZRKP+B0uNrqL7b9Ka9qXRGTeDSfjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeu7Iavcy1l8saePq1juGcVH/z8P0dGs9DJgnHXOKHRPAZkL9
	rtgvPGMZN7ifAZO/wVGbxkmI0IjjSc7r6oJb+vWnN4h53Ek8vaE666XH
X-Gm-Gg: ATEYQzzz4BfSONERY3SnGjTIF90ZZDV+8MfpmcaAb2/j5nfpR02+YVIOph28Pp6qbWY
	t/wvnLtufeltNSlnIkbnAy27GkEvpj9naJNCgdEOzm5oGG1gWJrFNMM0dRNltDcF4xZ4UrVD7id
	6Y9ShIc1EKDqlRtgGzektfkz0HnYCY8m3keZvC8l+27gyU3Hhdo8UYsBDRIKECV5YN+votOMx1t
	UkV5WSInV7eycbaoOc4Piiyh2sj9xp+qxuSqHVg7dpywxz9xwZen+28fBjvr56HOc1lS/E8pJvL
	x5Q+01yKydYC8lFgCDO1uNH//PB99SjqaUl5xovSTi7c5H9bAjNy1sV4KBg0hEfstcmXagdCuil
	TBvwdO6lbnheTXUqLP6hRz2A6niri2Y5FsNyIVhUu0BuufPN2SDkbjoYsNOcJvGDX8VO/1yXCRW
	T9igj7eHdLW+/UOWT1Spk+ijizbSgLLwt22vritOU6DzUEzBd24q3Bs7jYUTkiVTAHWbbbL3+o1
	G9+VyJEQQFK3FJOEtxawcqO6DzLFDhxJ3haqQ==
X-Received: by 2002:a05:600c:8b03:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488997d3188mr1542835e9.23.1775155647914;
        Thu, 02 Apr 2026 11:47:27 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-144-20-233.cust.vodafonedsl.it. [93.144.20.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488983db4fbsm2153705e9.13.2026.04.02.11.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:47:27 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 0/1] Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
Date: Thu,  2 Apr 2026 20:47:02 +0200
Message-ID: <cover.1771930508.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260402184702.5KeHjNNNy1I-vibLgyIMdMMdU6tMcc-O_Ij2_h9PEhs@z>

While validating SCO audio on a platform using TI WL183x Bluetooth
modules with the hci_ll driver, we observed failures when the
HCI Enhanced Setup Synchronous Connection command was used.

Although the controller advertises support for the command, SCO setup
fails in certain configurations (e.g. BT_VOICE_TRANSPARENT/mSBC).
This matches the scenario described in commit 05abad857277
("Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk").

Initially, we considered setting the
HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk unconditionally in
hci_ll. However, this would affect all TI controllers handled by the
driver, including configurations where the enhanced setup command
works correctly.

To avoid hardcoding the quirk globally, we first proposed a DT-based
solution. Based on review feedback, the quirk is now enabled
automatically for the affected devices by deducing it from the
compatible string instead.

The issue has been observed on WL1831, WL1835 and WL1837 modules,
therefore the quirk is enabled for:
- "ti,wl1831-st"
- "ti,wl1835-st"
- "ti,wl1837-st"

This keeps the change limited to the affected WL183x family and avoids
impacting other TI controllers handled by hci_ll.

v1->v2:
 - Remove DT property, used compatible instead

v1:
Link: https://patchwork.kernel.org/project/bluetooth/patch/db4c7eab9d0c2f71eb61baff240957596f099401.1771847350.git.stefano.r@variscite.com/

Stefano Radaelli (1):
  Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x

 drivers/bluetooth/hci_ll.c | 10 ++++++++++
 1 file changed, 10 insertions(+)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.47.3

