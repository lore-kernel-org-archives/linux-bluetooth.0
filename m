Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE63C0A18
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397820; cv=none; b=BJRlj1XvXnB0hpfLTHRyxf1Vh2zc9S63uEzS0sETD2V+nropX/5TDk6tzFV6GXEmlDKTzGMeQKgBaWbq4mDfTXcDmit6aJcwt1G5AnmMVwB3aU480vEdLKUK1XsY0EQPYGA8EPpTxZmlKc/Vp1ckcZOmeoSRiERHZFtXXXLepR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397820; c=relaxed/simple;
	bh=1Cu2qtOFt/3izj5uzelxT+Q6HgA1Hgr81s4k4qxodnU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JL/3rwghA0M3URo3rU3sj9si+l/LHpHxj00mYDGmB4/YQwN8h5R03PbvHl8c+ryVKmsy4QaM0xYkgVNsjVWN82CQbdiKUeo10ZNu5lcSCBYGJwcteUru6oloI0Lm/2as/QMzLT5xtvtrnHlBSH8JhELsT5ngzYcKXtVrUhM4IUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TtoPsAOC; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TtoPsAOC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780397818;
	bh=umERFNKpUTcuTiBOW/CiEROJd9c3kgT9bO5VhMQtInc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TtoPsAOCPUbHmpBhKkMuuVpWmQuMHf6f3VljiC59dxcGXe2r1YBGUaCutoza5N66o
	 uYddh9fpB9BbrYncB4mubsNpNtpDsWlM808U1GY4HUgdxjUkGJuSG9DhDo2Y9t64ZX
	 qGPsCL7AtsHQwrdLTy1+cg1jA16AUZVamfBpPeEc=
Received: from github.com (hubbernetes-node-473957e.va3-iad.github.net [10.48.182.42])
	by smtp.github.com (Postfix) with ESMTPA id 6CBFD181241
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 03:56:58 -0700 (PDT)
Date: Tue, 02 Jun 2026 03:56:58 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1104482/000000-6dc162@github.com>
Subject: [bluez/bluez] 6dc162: shared/bap: add ASE Control Point error
 responses
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1104482
  Home:   https://github.com/bluez/bluez
  Commit: 6dc1625914e43d0f37a3771576afde5a77e7387b
      https://github.com/bluez/bluez/commit/6dc1625914e43d0f37a3771576afde5a77e7387b
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-06-02 (Tue, 02 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: add ASE Control Point error responses

These changes are required to Pass BAP/USR/SPE/BI-01[5]-C tests.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
