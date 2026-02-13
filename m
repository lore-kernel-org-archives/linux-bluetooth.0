Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72BD21D3F3
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770962677; cv=none; b=PC0uigCocUzcV9eDbjXj+jnl+80Z8jSDhgbcUyuxXqoIrW04gx1NIGUB0DUuFNMme7RWhnqRfgEOlZS7rwU0abj3B7phe4UXy8TeNYoCcYao2BBYMmaKt1LAu0+2LTEb4WL4R5/POW9Byi72atzCJveP5ZfVRXOQE1OZVIpQC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770962677; c=relaxed/simple;
	bh=7vsa0Lp48Q4IXP+m29R5EN3hQvkX5vWtPSpkWLiNfwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0Zy2fJMOCNxLexamf1qN1OuruZ1z/lzO1HJPNXe0DWV+RKQuef4494JQtwO3N79OseFRapeiBqmxGTZsnQ+OvfvqXuLrlGYqtnTlg8T4JGMyymdGe4IysgEVTJW2LI/VEPmF2jcYyCSr4QTbP0I1/Mx+Yl3PDkNUoGJrho3Cjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMxlgHj6; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMxlgHj6"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2baa098ffc6so513858eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 22:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770962676; x=1771567476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+enXbF7eaIZ+LWVLPt5M44cliFk5dK593jDtHTsAqM=;
        b=IMxlgHj67flgMM+LOaJJ2rvcPy+PAh0CHdxl14/mcdE5GesXHKyHxRv2r0SbWukiot
         YIat51ugaE3NCYnhtk8Ytp3swl0OI3bYpZufduNJTHaUtJ9AriOouf5cByka3xUZ+nFf
         XPIQ5cqqupezldsPQYzEyG+0abkyjpciNYQozPnHzHZjXPrBv83kzYXLL0CPEmcPMTgW
         o7BO0KL2qkIHaSJXgOSNQCYNNug0fS8Qi0e2021pUAWk6SOcCvDmKsIQD4LPWXV5X6Pt
         TpEcRXBET1Qgdu78jwRU5JrAQY6EvL5ONN+SlFo1b+/di3ieWklFYex8QmzDPQlPDJ/S
         wiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770962676; x=1771567476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+enXbF7eaIZ+LWVLPt5M44cliFk5dK593jDtHTsAqM=;
        b=KDpdCxrtdcOJRvRfMPfCn9wxKmaaKBGsTzj1hPtT8sZuTLn2FkdVi+tBlADDzuHeez
         WrtxACRB2jw+h/+fJBUR/0EksIdiiOBfvS4JtGafM4VYPDr81cT+KB+mPMVpJbnyPyod
         RzyjyZforjcJCIE9qQDKB7xIEMJBQkN0s1ZPZrww78COLvyxxUR1huJ9er1tMaujz1fY
         +sWiIcfTAxC7ACmkdiUH6CSULlpOa16JMrun65olPP3wOnE1qF5n1vz5KH/Tl/Aza0bv
         orpZDKxiPU+ZX4P74NVfrY1NKkpku9VhJzjrDppihoApOqkj/9bVQvSObBsj+rDN+Alo
         16xQ==
X-Gm-Message-State: AOJu0Yw1lsRInNLkGPkClsnipxRvawez6J4Fr7foQLvb7Gc5p5Sz/3KY
	4QA87PuXSoxo2WiVrYMJBTmzq77PlLgxWoMTFIaG5BoN42bkonhFMEcwuLkzMA==
X-Gm-Gg: AZuq6aI5wAhjTM4uyaSiKLaJkaT51kVlhwdnF2gCOPm7MlV4r5LFvm9Leoc48rdvN9A
	KMaNS0loAU5tctM/L16sZ/ZZvt1aOVxOBLUqEfAoz9dfxN59AWIlQgMEAtzVVg711cp1iKiTWdp
	70ITxuz/w69Wp0abmmQP5l7GDBxoKCuTZqU1S88A9jQYO/A6rgNwRhVXMy8qn+KBhK/fHhULVEj
	+qv1XE3B2t1sFpU023r+zaMMBOX6KwvmfgtpbmAZYPf6KOa/Mpzlpvt7AQinfP+pw46dwGgYhJF
	dlNd/hZpklUoI0RP0LR0zdhgM/zMDejXjatz0PcZFgPkMcEJkQix51181893EY+JAwCRZzcqY0k
	m8B1DhaGz0IiE17XmB2UxyysRqUP2VLLj4TUhP2iFwyVklPCM/NxvUeOKN9rhWUHG/6uktPkkyN
	UAUSKSiv/o2uhjsr+sDxJU82CNr0o5DmTjRull+6/pGpduDRSsHRaVCR7K1UpT2IKpUuyf41u+H
	LxkTPYFYl4jo5wKevE5cTmZmQ==
X-Received: by 2002:a05:693c:2c93:b0:2b0:5306:1770 with SMTP id 5a478bee46e88-2baba0ddfeamr540498eec.22.1770962675627;
        Thu, 12 Feb 2026 22:04:35 -0800 (PST)
Received: from kernel.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcead76sm4803025eec.27.2026.02.12.22.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 22:04:34 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>
Subject: [PATCH bluetooth v7 0/1] mgmt: Fix heap overflow and race condition
Date: Fri, 13 Feb 2026 06:04:00 +0000
Message-ID: <20260213060401.14200-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch resolves two vulnerabilities in mgmt_util.c:
1. A heap buffer overflow due to missing length validation.
2. Race conditions in list handling, fixed using the existing mutex.

Changes in v7:
- Rebased explicitly onto the 'bluetooth' (fixes) tree instead of 'bluetooth-next' to resolve CI bot apply errors.
- Added base-commit info to allow 3-way merge by CI bots.

Changes in v6:
- Rebased patch onto the latest bluetooth-next tree.

Changes in v5:
- Combined both fixes into a single patch for atomic application.
- Switched to using 'mgmt_pending_lock' (mutex).

Maiquel Paiva (1):
  Bluetooth: mgmt: Fix heap overflow and race condition in mesh handling

 net/bluetooth/mgmt_util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: 1b9c17fd0a7fdcbe69ec5d6fe8e50bc5ed7f01f2
-- 
2.43.0

