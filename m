Received: from mailrelay1-3.pub.mailoutpod3-cph3.one.com (mailrelay1-3.pub.mailoutpod3-cph3.one.com [46.30.212.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6E4145356
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037650; cv=none; b=SLQky90OjC3WlUB3U8qjNtFJSVKBQ8BB/pm637f4wyBiPV6ILucXoAd4SdGP9rHp2cpuvQ7l/qp7DDGnezgiH0DDly3bfRVpHB0CYQGxQwSF0SCenthRBvEXFl+g1woUJCWGbsb3QpuxJCC/xjzwW4jjuFSvIQMyWlXFhNEIl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037650; c=relaxed/simple;
	bh=nRwbsX8ad7/YHlw+k842ffQoIcjMg8TrsN792KJwu2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCmCOMSFkFAH9NZt1l+EccQOsrfkLIkP1amco0F991iLpI2MppWPmHJvVEy+5cMs1yW5WkU65dm0i0NVvic5jQ9PaeYFC4xEpeMovctBgMud7huNNq2+znkw41zRDxT8qds7jQEBu+NkAdWumO5G/ugzmdQO8i0pRWr2CRyLmRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tjernlund.se; spf=none smtp.mailfrom=tjernlund.se; dkim=pass (2048-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b=NSVEOvD7; dkim=permerror (0-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b=lof1sdH2; arc=none smtp.client-ip=46.30.212.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tjernlund.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tjernlund.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b="NSVEOvD7";
	dkim=permerror (0-bit key) header.d=tjernlund.se header.i=@tjernlund.se header.b="lof1sdH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tjernlund.se; s=rsa2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=YRufhuuPZqGdvnEf/+WL6WTlVQGEVG75R1mJGzs+n2s=;
	b=NSVEOvD7IjlBJrzk+Q+Q2v6dcyFAMjpeMRFqZXSoCFthjvvxPVleMNFdCI256oXZUDu1pMyvZrWvX
	 xmUyzJIVZdGAmOXB2VTewlen417PhjTVaDscBkBvuc0yS1OKo1MGSAA9LGovH337fBiHIH+OH7qaNN
	 YWQGl4s7t1aKD/UPfRyfFz6bhjb/qSkdu2UUoRASj4BHecosnAZAvx4GPrCxcs3LR657N+fMdx9eqe
	 5guV7nl9IJEIPQrkXTi0qXYBtQa2NIAhA/6qrsVMGnyBd2exsMWQpv5YQsYGKjjfohcro0oohyHPwG
	 ggzPjXAi96kDPvWkga8CiUJauru9h2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=tjernlund.se; s=ed2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=YRufhuuPZqGdvnEf/+WL6WTlVQGEVG75R1mJGzs+n2s=;
	b=lof1sdH2f9hiANcOwagJQqD20kvMza32XQbpNTP6yruftru8coHu2tvILiLZfYYPBmimBtXZIebuy
	 n4rC3AGBg==
X-HalOne-ID: f5f43d2a-cc54-11ee-996d-1ff1563c5748
Received: from jocke (c188-149-162-176.bredband.tele2.se [188.149.162.176])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id f5f43d2a-cc54-11ee-996d-1ff1563c5748;
	Thu, 15 Feb 2024 22:52:57 +0000 (UTC)
Received: by jocke (sSMTP sendmail emulation); Thu, 15 Feb 2024 23:52:57 +0100
From: tjernlund@tjernlund.se
To: linux-bluetooth@vger.kernel.org
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: [PATCH 3/4] bootstrap-configure: specfiy exec-prefix and libexecdir
Date: Thu, 15 Feb 2024 23:52:14 +0100
Message-ID: <20240215225249.16242-3-Joakim.Tjernlund@infinera.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215225249.16242-1-Joakim.Tjernlund@infinera.com>
References: <20240215225249.16242-1-Joakim.Tjernlund@infinera.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
---
 bootstrap-configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bootstrap-configure b/bootstrap-configure
index 1c26909b9..d927ff9c6 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -8,6 +8,8 @@ fi
     ./configure --enable-maintainer-mode \
 		--enable-debug \
 		--prefix=/usr \
+		--exec-prefix=/usr \
+		--libexecdir=/usr/libexec \
 		--mandir=/usr/share/man \
 		--sysconfdir=/etc \
 		--localstatedir=/var \
-- 
2.43.0

