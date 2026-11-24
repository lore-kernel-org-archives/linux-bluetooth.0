Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538485;
	b=SbuMp5oZ2ow2aL4j3DXS73xxFQ1NUROGBTe5MX5k3mfqqF4z7NFtSeAA6v+BSKyQEZvc
	 bvQgH5fMC3R5Fw7p16qKAHt4YaXd6HY0EYpVsL1oePyI2ZPhBwVRgNm3n9UGobl/BSasM
	 gyxpey0k6J/kpTSLrFoKauCJQyFsydc8XTNexgfpN8Xjdv+LsO+egesxiwkNZySHGiaCG
	 IOQVtA/PhxiAkDRRk0FjDMVEjzYlvb0vdzw4flHp6f3nmoEZ7lrpLAr5SqyvfZPC8kq2F
	 d5b3G5kefuzyaOiy8volDvxjlY6jGjRcZUHDzQGigwdQ83KpGFQ1RbN1inOT9qaedBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538485;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=tvT80kEbaLSP8F0lY5cuR3xMREpAJgtzQlx+QCS0jmw=;
	b=tiwK4eUoFMS+sr/FGIHHTgr4+cax2umwBMApPLpKlKmTiFGqrrDdKYoNgHjgpJVNItD4
	 MpCQyVKiOHZx8xd/7okcoQI3rRCIczCX3Q1Vh47kRUVm629vhcFyIQyAj/5sq7T5H2t+w
	 EEQqNSnEUPtl4Sk1KVEISlf9+jp7EDB+0ebm+hOR1AG4c6J5dSU7ZNxxoxfrqJZDQiBji
	 Mn/ad3agREpHeEPJIMrvxY6ncK7z5JeFN2IhC+XxktCeHRUUt0UKCIHxI4zpkhtlWF6lo
	 uRlfKmtRharxTko1BGi/LCN8hi1oawRXG58nC3cx1iljM5k2cVxGkkgkXZJVC0jOK5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=N+NOpHkL;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55356606A329
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 16:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55356606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=N+NOpHkL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795538481; x=1795797681;
	bh=tvT80kEbaLSP8F0lY5cuR3xMREpAJgtzQlx+QCS0jmw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N+NOpHkLWC5XlcAi6/E8l/UXg5FNxqh9WnVVjrh/bXLFitbWh4C9fY/1xtT6vvdDq
	 sn3Io0mdf4epBofO5y64dlIChvnxIIDWaTkJ2i2K3N16njya4evaOD8vIw+mTn1tPl
	 AXrMIfgtnTxahiDe4ZTNYetBQ8gS9G2iXUNydA4Gyg/SLsimWzihMMZznt23NBV26e
	 wTg7oGYry9xXgqToK7FuzYsT8qlyWap++tueNphhD7JBwVB7PjbxKBd3GLjCSw+Z25
	 dFkKBRSfVff9/NuxVtLNpoaD9sDT4qh65RhwNWC+Axw3O5/kC83T+4E3Gb5wfyMDRL
	 vNcsWGt03Wagw==
Date: Tue, 24 Nov 2026 16:41:19 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com
Subject: Re: [RFC PATCH v5] Bluetooth: l2cap: prefer compatible local LE intervals
Message-ID: <20261124164101.5880-1-cochcoder@proton.me>
In-Reply-To: <20261124140405.3096828-1-cochcoder@proton.me>
References: <20261013033118.501182-1-cochcoder@proton.me> <20261015043336.47734-1-cochcoder@proton.me> <20261015181041.42873-1-cochcoder@proton.me> <b6847b841127362e423b49f9e48118f97985865d.1795497229.git.cochcoder@proton.me> <20261124140405.3096828-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 8abd9dab334518d496a04aa4875109b986e4dd9a
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Please drop this RFC.

Sashiko's VF1 is correct: hcon->le_conn_min_interval and
hcon->le_conn_max_interval describe the initial connection range, not an
independent local policy for later peer updates. With initial bounds
[24,40], this patch narrows [6,24] to [24,24] and [40,80] to [40,40].
Those narrowed ranges also reach stored peer parameters and MGMT reporting
after a successful update, and can seed the next connection.

The fix removes all eleven added lines and restores upstream behavior, so
there is no replacement kernel patch. The companion BlueZ interval tests
also need their overlap expectations corrected before applying them.

Source-extracted GCC and Clang ASan/UBSan tests reproduced the narrowing
and verified the restoration, including persistence controls and 397,723
parameter cases per compiler. Controller, queue and MGMT I/O were mocked;
no new native controller or hardware validation is claimed.

Review:
https://sashiko.dev/#/patchset/20261124140405.3096828-1-cochcoder%40proton.=
me
Previous version:
https://lore.kernel.org/r/20261124140405.3096828-1-cochcoder@proton.me/

Codex assisted with source review, regression tests and this reply.

