Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201674756B3
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201133; cv=none; b=YKX/357T9FtHR7ATEetg9+RCF8Bic4VCx+OU8PxWBc3pGHSkEgWgHVJEC8liyCPiVyYUk8680Pee9eMrr4joerDuf24ZjSUcA8AtX25z4+n+pWUe+5dFp/53Bk/lvpt/d4QA3ceoO2HgdhbsHTaNezeR/aMpxY+xvCu5Ckim2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201133; c=relaxed/simple;
	bh=1ARJRQ+w/j9vVwBXImNARLq5+AmytkuQB9OP7aOsIVI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WMgpw9d5OufwonFyZIC+hz8FIR4OaqsnGGf5KuK66xjqI4xrIjAPfcWUmdvn9vXuFumWYjb5BX0yZ0ndhxbEed102wdWmUUJfxoM7752w+3bXHcyAqHGeJncaQlleY07JTl2EKApPScHPCeMVlnRLf/vOcGaHYMoY6gQVaNn1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgXug8hw; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgXug8hw"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52ff7e275e0so21524651cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788201131; x=1788805931; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1ARJRQ+w/j9vVwBXImNARLq5+AmytkuQB9OP7aOsIVI=;
        b=kgXug8hwcOYTMXs6vJedZTCHUK9W4MbpwfoAhQ6oZyjjRSdDbqdZegC+1yWXRWr22q
         cTkRZB1EFwH4/lLDjKwQvFqBRE3+tj0S3rF5vNfQy6qnw4wVtUsS82DbziUCwZogsj0c
         0j+G8sEITubA0gi6Gt7jwKwtHWkE5ry2FCDSqMCDMjszpYlK18Gzcvx8/B4h1Ak2/23h
         l2w8V+o5OaqT3NidUF/CfGBiS2CSb+IGplJDsLSEJzHg5Hz7sItoITPPuD9HrjLj2LZ7
         iVEh4dau41uDI7jWHXpnJ4+5kiBzSj1iCAfkdQF2z03QXX1K3pD0V9IGnIU/EFQHj2+C
         m16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788201131; x=1788805931;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1ARJRQ+w/j9vVwBXImNARLq5+AmytkuQB9OP7aOsIVI=;
        b=rqOTzeQWF63d3mkltNUIIsbYVzZYC7n30A+zTRWHEIGbkhebvS5JNhY3b/exhFwQME
         /jxdR/eRuMthGB10OQBFF5b2eOdBFJGNq6kShea251pKi1OE02vvHWu3uODVSlg9/o1b
         ANAKdMsvHDL8A8RK7IvcmO4wPinXztUeQ7CPF9M+OMrRTLYhBUu5pklx3XKo7RwkMxsj
         4E5raYynR4UCGnQVlZf9mtsug06Cv1zbiEpzea932TLMQvVGo6tj3ILfxWNJ8kSEH+Uv
         0bp91FKEi/EweiXn8N+Slx6OPqRoEYYRj7r47dMB5Ade0kn1kt09uKfQlKy1ICUk8VYj
         Qt3g==
X-Gm-Message-State: AFuF++ny/61N7xLgoSPl44DlLPBe2vov1xWq7j7INkPu6bmJKuHAsWT1
	uiBmMYO0jnSp4RRgFzpSIS390a2nBrN5D5mIkrn7PWIwvl8UOjThs+LL/Myo4xpI
X-Gm-Gg: AR+sD10TshWhUHh65Ggr2/4Bjg8axliJCcP0JlKTyfFd6woWYL5V6JPY/ai9Xm33xjt
	xOLFY2x9fJQZ02IOxLj/h5mhmkkDGySrIQHR43g/T/4di5/WaBtT1SljLPU3phmKub0GZuyhgIN
	CxZQaHm5OVYKvEVb0dxYbHHeC/5c3GMLHM/id02mHGj7YHPDfvAVtumf50OImbRAHuMZe5EAOpG
	I7UuWgcq4Mfo7fSbjstDILbeSz9O6t7YwLsPvuRbfxCKARexWRYc1fyv7w0Y5Gnd9+8fguY/4v+
	oWcTzpW1713Z+RHt4ad386ZB6rwhFawSANlNYCmKd20onAO59Xt3JeFgO2ScTTRBDLTUZvforox
	1rLFF7B6wRlBH560n3Q2pAst7mph58u80b1rXNo9s4XcMbpkhxYMcrV1F1tnLoBn+9qiOfdX9JF
	plVYgQgHodaEHKqaRZvK1Vc61mZgtKFUg3TV/Dj+6o8StUWWGGwbmaZZ5vRrIFIKEWx31j
X-Received: by 2002:a05:622a:82:b0:527:7813:a439 with SMTP id d75a77b69052e-53021d196e5mr33486031cf.27.1788201130675;
        Mon, 31 Aug 2026 11:32:10 -0700 (PDT)
Received: from [172.17.0.2] ([52.186.175.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe54a568sm77995041cf.4.2026.08.31.11.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:32:10 -0700 (PDT)
Message-ID: <6a95c8aa.3c73b1f2.61db3.50af@mx.google.com>
Date: Mon, 31 Aug 2026 11:32:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8506284177981587412=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luckd0g@163.com
Subject: RE: Bluetooth: KASAN: slab-use-after-free in hci_chan_sent (chan/conn used after rcu_read_unlock in TX scheduler)
In-Reply-To: <4bb3a1a0.9e61.1a058446b14.Coremail.luckd0g@163.com>
References: <4bb3a1a0.9e61.1a058446b14.Coremail.luckd0g@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8506284177981587412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 75
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8506284177981587412==--
