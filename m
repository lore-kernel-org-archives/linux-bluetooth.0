Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D243E16A8;
	Fri, 11 Sep 2026 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151910; cv=none; b=Mo+x51xDuLi2FbkugX9oTppLpsFeRhpw5BWHiSRLWfqeSYU5cF3BURbm3f/QO/SoeWikk8kZQiA9b/+ybvPh0Sh6WWPxw8G0usoriVE+F6yByZghMepvcvkjfIMsaicVksHb8OMng8HiPs6oHLHTo1qRdHoUEdaXRp7mjZi/TLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151910; c=relaxed/simple;
	bh=heNYYVXtHA9sIE9NZ0t1aBCzec0vyzgaNikuylq7df0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO/Pece1vhumaMNsRRDgFUCI66SwFFo6dHBjrZGQucMyV70awlm1dXvnKvLYt6rwUDYxTweGKMaiVMhD7fPZdHRFWLy/aQ4gueasgetZFfLRCYZxxAJwQN2bktTm5VlRbBz6hgW+6ip7XOysEeuZ9V8Z6MVo12GcPj6MHRfHCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=deM49Svd; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="deM49Svd"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6BF8880F6A;
	Fri, 11 Sep 2026 20:38:22 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YANKyPNDcxZB; Fri, 11 Sep 2026 20:38:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1789151901; bh=heNYYVXtHA9sIE9NZ0t1aBCzec0vyzgaNikuylq7df0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=deM49SvdCRd7U6cPG/NS9I7tgYWPrBKcGXatH8f4xmBMoFARvL0PVh61pqRSyih5m
	 bVi4LQ2W+dtV0RhJFJ0eQHe1Ga0FbVc2PwViq/3t1Y0pt9VjiUMinusO8cS+X65vTt
	 qyGnEbcS7WdKC/CS7TVRCJ6zW5ps0/7ZwNEjYiFWrrtHLIeElYj992X7HVTMw1efrQ
	 Ab0/15FMrMM/C7VDIsYbztcHuUrBqR2gxNE/Qlp8vBcIpdtTZ8doFH4HrSjLg/jf38
	 i68XVcpawidqTAoG7Ogxl9CnJawaJI3cf6NLqOpH2RQ6VUkm3LgwyTE98xHUSqnEMd
	 GnEHQ4Ih7ktHQ==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	kuba@kernel.org,
	nicoyip.dev@gmail.com,
	suunj1331@gmail.com,
	syzkaller@googlegroups.com,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Pauli Virtanen <pav@iki.fi>
Subject: Re: [Linux Kernel Bug] possible deadlock in l2cap_chan_connect
Date: Fri, 11 Sep 2026 21:38:05 +0300
Message-ID: <20260911183811.374433-1-aliamemis@disroot.org>
In-Reply-To: <CANypQFabseTuRiyz2pGkc_Qj0moGDnY7KEp1qdTOqkw6gAL3hw@mail.gmail.com>
References: <CANypQFabseTuRiyz2pGkc_Qj0moGDnY7KEp1qdTOqkw6gAL3hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Sep 12, 2026 at 12:59:09AM +0800, Jiaming Zhang wrote:
> We are actively working on a patch, if the above solution is acceptable,
> I would be happy to submit a formal patch for review.

This is the same lock inversion syzbot reported as 74071deb, and Mikhail
already has a fix for it under review:

  https://lore.kernel.org/linux-bluetooth/20260904012028.77590-1-mikhail.v.gavrilov@gmail.com/

It uses the same approach you describe, queue the confirmation and let
krfcommd handle it under rfcomm_mutex.
