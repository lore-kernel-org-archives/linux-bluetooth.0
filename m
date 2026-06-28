Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F523ED5B;
	Sun, 28 Jun 2026 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665402; cv=none; b=H+D2F1jgwPiJV1KfOLkTMTr/DQUU0frcDYaqJjHzUkvex0wkAwrS+jCD7tYFA16/SL02O2VxNT8bG25g072y4dS5xeQRPLgaYwTbKnFYF8dAgFJQCSj8etGL7YWoXTAvU7gLg88V4+K7nmFku8uVhP9b8BqHcZGg+D7kbSm97zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665402; c=relaxed/simple;
	bh=se2niBpMSNOX2w1eFlrVb4amVz3TmX71rPzQ8ZOg80g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4lnBOHgHe9fc9nK8xjWah1aAlJHiP52RJxlT2YoKTTWXTf+d4875K4cxgkaMWT6LJRG/Ciu1us1/mHtM/vQdyq7FNl97oscvnF2/Onc/K8AMCQO+SJ105Le/Sn85Ru+ieAvFHsl8SKFCOFWUx81LcXd7fZYrZHrf9UvUfUCgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=vNZdivUQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fS0ankCn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="vNZdivUQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fS0ankCn"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5FE1B14000CF;
	Sun, 28 Jun 2026 12:49:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 28 Jun 2026 12:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1782665399; x=1782751799; bh=Aohqya3n72C0oN4pVy1jddVD2mFgIBs/
	95yy3WBT8uM=; b=vNZdivUQUf0S2oi/m9rguxFNKfdxC2dqHGwLRpykUFIHxcJI
	BSHXHW1j+stbhxxB+hZ12oDAHr68WDGsErdBPfEfqJLNHwRdHwp46PsPowA7jevF
	llMdWfFfILQM0drZ229psH/sJP0ACO4dEkeRfTK7Ot7mMgvDYpHyrMwC92/E+xRO
	zDbAAyaSqQfUquk7LhjUsEdlqBJloJrGEn+5vR4m9rMbZDNx/mJBJofhvPr7tG+a
	IHIL7gsSiA1sn16SwxsdXy1KuafrNGR5XNZnvGKiqGZhm4lJIFkdOzAkr+37tsoW
	YFoa7os/zfzNxbrC7eY48xV1nCvQF3CVzoQxPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782665399; x=
	1782751799; bh=Aohqya3n72C0oN4pVy1jddVD2mFgIBs/95yy3WBT8uM=; b=f
	S0ankCnmwof63CZrx3OptVM9V+gFy/wdGyseFLr9oC/PYyhGn44xXdeUzEenORP7
	D6S4S4Nhy05CEuh65u6CrmdxzUcnW5frq10psfSuOmmwuArH9b7ncO7lkm9bCPTQ
	2Oq8slHDirnn6BVAji/KbgBpYyAX56EEGa+OsfXB+IhQ4bm3pEOPKI//OPs9fNWI
	e4JYMYv1r4FPjJ9sKfBiM+ORvl2RH1yq4N3cqa7UExOYRS2ksbgo3MOiwhNCYREi
	M5cNe+ZTlt5O7zMMTom2vAGwzQgdrx0xmAJTk41nVGVCbE8JG8CiE7uMnLefWdl/
	vU7HlEYGeh/SRcUGdzhxg==
X-ME-Sender: <xms:tlBBavK29PZEWFlUAQ4sY7uv1T7T-WmGj1gcfJt-UNdhSJoLwgIUMg>
    <xme:tlBBapLIqV5VJVaIaZOOBZxorYvHAdfSvIAL56Q8ew0T3ajbwea2PXoSkXSiT5XDu
    AG-DZQoz5bzo5r9MBoA3lkc3qnj7U0yJoR7dk0g2GpIbTTOQfGOhcw>
X-ME-Received: <xmr:tlBBaij71e4MX7cKEAt2GabyEmASvWUSmwm3EOgInfdx_wzlf3nL2bJ5d2rC5gy6jAqGABTSP1tGvE89Gfc>
X-ME-Proxy-Cause: dmFkZTFp9IbH9HW8AM1WkjtDh10e0B9qAsYtq8Fa5LLnzibcJRuNnSNfvU/9juu0zMrz7A
    EpTAA4Dz3EOdt4AcVxP9MX+os7lOdQ/rPqezIH42Mr6r5BybTap6TUPZ6pSgDuNvTZS0x8
    xrpluk3gnwLPMKcHedfHX23k0nGVD5mUPZi9tOgI9IlWqhUIMbFvs9jHd2xr3YkufQOo7c
    Ez/MBS/iqlYN9RigZ0L8N/x0omSVSp1HlFJS2qsdFYcJFTZkHyfbyCTNPOcsoPTb1DzxEZ
    iGYbt4acO/BWW4RkMZuVtuc0Qd5E2i5LeUtg9wVYqfen5wyl6WH341NgISRh/8kbqYFMdD
    yi1EeFZDIMW2ci6gkpD5TSta5Fx4qPFBQHNDlk05cKtm7AvZph7xUMLrY8z2QgfIwEs9Oa
    rE+WyL0LG4v4Ewin0loP0GdJThiMa6OSnoQkPRx21aA1u1YP/36HQFWYUsoJmEYDb1onr3
    wN4qgf4Zs/XYCBlFnymGn8+LFoXQj5ZUWm5PjblT1yh3vluOdlSDa2IMx+QDUdkh7cPs3L
    U7UyYYqacYK+dNWqgAQD+CWKX1dutDOwt2GpO2NCfDDs7QhJ0pSh8QxFCmmtmET3gjMctF
    GxLRV34LPh0W8IMDV+z+qbskVPSW6j9+1rkzFJ1wG5wjpjIMxM/ry+61hXZQ
X-ME-Proxy: <xmx:tlBBarPwE-x2ZlMJSJCjZexv68kWzwiVFNIEUJwPim8J_Mh5gqGLKg>
    <xmx:tlBBaloQPRe7K5ln_sD77v08LU-tHNExL82E2sJadNxpanhP1y4foQ>
    <xmx:tlBBal5YIUNsPt_h5Jc2Dmjo3mPpopEIo-_blq6FqmAHX0GqaJUcew>
    <xmx:tlBBarhXjXwKsfYu_bl4D-k4cRT80deXcJP0lvPMg9JqGjzUqVJLnA>
    <xmx:t1BBar5TcN1gZYdXvx805me_cNTLMy1vAZkJw4PtQEBag92m5572aLZw>
Feedback-ID: ib8c04050:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jun 2026 12:49:57 -0400 (EDT)
From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
To: hugo@whynothugo.nl
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linusw@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	robh@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: bluetooth: broadcom: add BCM43752
Date: Sun, 28 Jun 2026 18:49:13 +0200
Message-ID: <20260628164915.19580-2-hugo@whynothugo.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628095500.29810-2-hugo@whynothugo.nl>
References: <20260628095500.29810-2-hugo@whynothugo.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 28 Jun 2026, at 13:57, bluez.test.bot@gmail.com wrote:
> […]
> ##############################
> Test: SubjectPrefix - FAIL
> Desc: Check subject contains "Bluetooth" prefix
> Output:
> "Bluetooth: " prefix is not specified in the subject

I followed the style of previous patches introducing
similar changes to this same file. Should I include
this prefix for this patch too?

> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.257 seconds

I can't find any reference of "mgmt-tester" anywhere
in the repo. Is this failure unrelated to my changes?

-- 
Hugo

