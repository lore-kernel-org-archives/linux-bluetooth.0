Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B53A28F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017501; cv=none; b=CRIqqCrli4qryXHJGQ7ZGp+4vTSP5OqEseZOMCLN7fg2H45RAfQJGv9xv8SPWuhFCTokR298hc0MkJwoF/Wt2mSFWCQ4p2APmF3EET+iwqTyB5mYy8AzeU04qyjxSdHYkW5Z2Dx1hC9xPhiKa+fTg/MWdgM0AgrViU4eoczN/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017501; c=relaxed/simple;
	bh=B0hXhuZwdHD//seEzyiifPU5lNUM0FOQm2zqSUMkNmc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kojQUj3AA2rg2/hWzzGLjbEpDKwzlbxA9qxiAyHnp2kUjExmo7JIdSBZkKE1Gm2+h0y3Ls91sIZ1NNpChHJoRPWO06JtK3YzlbW91FJHYaqqsb1ohMt1aOI6YyhniOafgv5JT3CnloCcGSO6ic91dE8LM4XaD46cx7t6fdrfHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSnKodnE; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSnKodnE"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d3ac0fec0so174932241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743017498; x=1743622298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbG5/qn6Aaovj4UrxoQyYlxlm2FwRE29diAU15cDfJ8=;
        b=OSnKodnEZt8PPCHvrriaViliwrBx/risEHH2HWzbbh+CCBVW27G4z9alQQ1J6gnBQI
         Wf7e5wz2nJ+TAMAROTlncuDSt3b+mUMonVI64zNw7LADPhOEY86oBXvFOQFGoF+f40FJ
         zIH6AKd0PWguG1zSYp9vdHHk+x/Fnnuuvc5BorQtXPWsmJ9krwZyLqQt4TF0f+CaNoOS
         kqXDEicXyPktWE5x4dXe0MT5uLsn6obUa6rrUBJgTg1xLSqR66FFjsMj6QBSDPgIVf/o
         6Vzdy65FFjHOGFQkJniYX9W/ScfAZmB37OQ/UptUWlFrLC3NAPScs9MdmlXZkE7RB8oB
         l1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017498; x=1743622298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbG5/qn6Aaovj4UrxoQyYlxlm2FwRE29diAU15cDfJ8=;
        b=ZOfyjAK6YHFGArnjrNfUCLwmNka33ZBZJtiSeLkBo+8gTytzHjFVptwZ4XI2RTWAmf
         qfnH0jCOIbsrUfq2aNcBiUkUh6ff6s8SaQrYcDYCIdbXARYuO/xJRYd+Y+tsxV5v8dz3
         IiADYzfZS2HJK6mTBQ39qr2ctxEOh4F0dzxr4AL/hCW/9zHBCb+rrPLsW69s5D3UZ8Ae
         gz4vIK+ousxKuJiHFuSou4vTMoUxG2qQ/MX+PvcF1I6mMo3HgogBDGAnRdVtiC4lIbgC
         SrhDBftGwraNS1IIfql/YK0kAvHAEj3bkL9Qap7DI1oGYk9sGN3YBAacMgv1/mykq+YG
         gR1Q==
X-Gm-Message-State: AOJu0YzC3uxbvuz1zoruMwG6uUkrxjHC44orvBfX7DCRXMO9MsqCBanv
	GPLH1EpbwgUX+5Vb8i/YBxOgOwtO9daK6Zg7lCnIIR9AGsaDvRxbfyyKoQOGt4Q=
X-Gm-Gg: ASbGncu9AlmC4l2wPPQsyKQcvqgPSE4YinfA1v0iGLVyKRrispqkES4FZneN1VkuRsh
	KP6KtQcyB99KDzXuIUXGx51+Qn2urJPGlmyDLZ0+eOwykgT1j3Nw4IijIiBiVz2ZbzA+lnfMIu7
	Vd/2oQXsZxKT+L2qe2wK1Jz18DwUuDPmfa6qo9HRNDSshwySokUps33rnSF4uCUTSVtxCZPdA6D
	Wv0xxphz5O/QvlGti4R8h9mvrtLo5gi5viQ6BPBMtVjQhTlQO7GjZyGsRarbBOHn+uCgD93jvBu
	cdcBeQQqobpFwkZnm5DIoFTgoeGN8csxmgcxf4jPWolZMDT2NfsN8K2DN9aBohXP6q+0wyEAlFD
	AMWXhFWYt17yEeA==
X-Google-Smtp-Source: AGHT+IFRbHfM7KE85nGlXnIitiSS1sWRimH0WkGKr1aohsEuVIgEGX43PCv5qJ2spHHK/ObrDNcTFw==
X-Received: by 2002:a05:6102:3f03:b0:4c1:8ebb:400e with SMTP id ada2fe7eead31-4c586f55074mr1532847137.8.1743017498281;
        Wed, 26 Mar 2025 12:31:38 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bd75e84sm2497804137.20.2025.03.26.12.31.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 12:31:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] device: Attempt to elevate security on Pair while connected
Date: Wed, 26 Mar 2025 15:31:29 -0400
Message-ID: <20250326193133.2718934-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This would make Pair act behave the same as when the device reconnect
and bonding already exists.
---
 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 9774b5bf1b96..f76c1ec3eabf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3194,10 +3194,13 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 
 		if (!state->connected && btd_le_connect_before_pairing())
 			err = device_connect_le(device);
-		else
+		else if (!state->connected || !bt_att_set_security(device->att,
+						BT_ATT_SECURITY_MEDIUM))
 			err = adapter_create_bonding(adapter, &device->bdaddr,
 							device->bdaddr_type,
 							io_cap);
+		else
+			err = 0;
 	} else {
 		err = adapter_create_bonding(adapter, &device->bdaddr,
 							BDADDR_BREDR, io_cap);
-- 
2.48.1

