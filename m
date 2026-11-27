Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786190;
	b=09azvHkUw7PbDI0jJyMbIiohJWVDWasxm7AzrIFUEwh+GuBx/e5A0j+IYfeA0QNwXW9R
	 0guj75WdgYPafAAbsG7uxX4QF7h517bKLH1wbEKHUyr5JdC8N3JQZXAY0IhF/F2WCYS/i
	 /apl4wECGCIUsK4RByzfKOifm4OZwrg6ya8xmgaL7+YQnarJCLVPYKsLq40dvBeZC7qmB
	 sobW5f8wTaQj0ZPmjK8OS6WZioV8V0NyjOGzzIPRYkgMHaUQsn1/KHabkg/5rLsgDsAzP
	 h6iDGk7RcKNBqbx0ZXlV/1Zj+1gqw5remunGal0txJfMTkjIoUO2uRn7DlI3s66lOBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=zpgo3Tj55tcUu4XxqKzbo29dod/lLXm/ex40fETWUMo=;
	b=dI4tRhoHxTTjCrNg8zo0s4FluhbLtbiLysDEFl5MbhCuQU6AtKqBK57p5p/d03gRYJSz
	 hVd9NaFuoOuw2KTT7Mf7e4IUbcWRk0KNqCPxiG7OGE/vWd2BO2ycL2IsxalphFTiX99A6
	 ryvPqZGZWLbr9OUEifpE7mcFZIBjGk1T3LIR+2vwjnS0d0clqZQE91yos3HENHCEUNiUA
	 wKT5znSe4fI/AozAYIUGFWB+CEI/znFY1MZhjefGQdeDSfeYLbmnpfYAnmKEn7iaNmOnV
	 U54+tN6zGcMdE4jL3fD1bdJNQD8xXSyVhpFjkr1LTMFwbAnxhZmMLUaUoC/syS9z5IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ScV7YY8s;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C09606A31F
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 13:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C09606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ScV7YY8s
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-94962d80d34so467972085a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 05:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795786189; x=1796390989; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zpgo3Tj55tcUu4XxqKzbo29dod/lLXm/ex40fETWUMo=;
        b=ScV7YY8s3jAE0qZcapT2EB4+mTW95rbgsuJ7Xf4KE+3zWlBLVly7VxCtNYYPP5t8tF
         aq6It11xfb5+HkoneuYDwH0YjnVUJtJplsVZLIK0Hw6fqBHETfk0Oue+UrEUw+jUQ2ko
         CZ3nJxOJ/c7HPq2AAEtslsWCFfjH2Aj3CEwefjOdXnGsiW3bZMS74pn/COfAzxqqYO75
         y9KMt+eFd59YMEc3AM26kN+A/6qXyowGwrGca0KPqBWHouiJv3+aSnoOTIOJGNLSNvVU
         gKSuDm983bovQm/GT/6NHMf4Tf5bYbhhizX8z7JlSlhF31PojNufV/YkV3VSVg/3E196
         DdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795786189; x=1796390989;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zpgo3Tj55tcUu4XxqKzbo29dod/lLXm/ex40fETWUMo=;
        b=n0PRNer+vGEMjRZnu/iPAwksJUQUfT8pd5M7qFVrx0MZA0IhbD6s5jVSElQpGgESBn
         kPjvIGuy3Z/PvyjnzXb3DXBbDAhPzsuMdqSVdAKaSqurXbZHN+AaJyHkpZSRqQSACWH4
         U/Xk2TWBeRalOw8+n2tjuYNr3u3JMnYX1HsgTKTZN/DI6regBr1gM76rmw6jEyH1XLv/
         YeQbn6LBDuoDIx9hbgO7IKCxadnDlaUMG8WFH4vSszx1qfH8MNOq7FJmcKifUiGAe8UJ
         EWQz0to8kHswlyblvs04SB3e/T2YsD5ntA3bgAJRtIO5yjhEcn+rgSW1/D8W9vfFlYCX
         7ZTw==
X-Gm-Message-State: APuU4Z8VIZTtZYIhODjQ3uKTrDbYsv0fUez4uuuJEISuMgPb5jxlw3U0
	+0DUMLnRfUCm+y1tz3NpnyXU1TwwiQOVhAMfPLCUn74Vd4nUQA2ZwwHcuTuZIA==
X-Gm-Gg: AZFdTZf7vLHfKJWXMVWhdflG7F0PtszDxsCeSnmjXnRqe8b4Nkco0LmdjxEJY4s9Er9
	bkPs2ap2hiqsRY9MGsSDeiyyfd4mobO99Z7KDjHe13n5PeNUAnO5+6esAAkPbP4giw+gtwJosRI
	VQjJVU0TIafa810H/vgiGXqZ/hfQm3BBZR+uRwk4b1UQgVFnT5Ep81yxAy24Rj8pI7gn/ek+8xk
	r+d7CRnDTdHxMumcl4ChYXx5FXbFGuzZlAESEwkXtEpX0bRxknGmkt3N6KfjHu7Zk5Z6TAE/9xF
	sgXN9l1Z58MeYgZ75Be7sepO71STIGsKGmUiqnMEIgqynoCz3/kHngb4wAVzjEvGOTnj0DRlBxO
	zQtzM1A9FLTP83xdQyrAyKJqMN+YUz/xielGsTSwuVLw69VoTjaA23iXf134fovg00dvB+I5tea
	WRQpLfxO2LPsdPPI3jw+5xjqH52u2EgYh19xjF3ZEOgv0QAsZ+0Qf356LzJ9az9PCilCjnH9Vtr
	D3sKPcz+Lr7jCT/Te6r6aNBTg8I2+ccafJ0Ei40/0jyyOXTKp4L+ULz/VguX5CV
X-Received: by 2002:a05:620a:4012:b0:949:3365:7402 with SMTP id af79cd13be357-949ba9b8ee1mr4370691385a.17.1795786188789;
        Fri, 27 Nov 2026 05:29:48 -0800 (PST)
Received: from [172.17.0.2] ([172.210.143.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94a017cfb46sm782431785a.28.2026.11.27.05.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:29:48 -0800 (PST)
Message-ID: <6b0985cc.3cec8c74.32ff63.9845@mx.google.com>
Date: Fri, 27 Nov 2026 05:29:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8483288770253086222=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dominique.martinet@atmark-techno.com
Subject: RE: [6.1] Bluetooth: L2CAP: Fix corrupted list in hci_chan_del
In-Reply-To: <20261127080307.3214776-1-dominique.martinet@atmark-techno.com>
References: <20261127080307.3214776-1-dominique.martinet@atmark-techno.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8483288770253086222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/l2cap.h:666
error: include/net/bluetooth/l2cap.h: patch does not apply
error: patch failed: net/bluetooth/l2cap_core.c:119
error: net/bluetooth/l2cap_core.c: patch does not apply
error: patch failed: net/bluetooth/l2cap_sock.c:1395
error: net/bluetooth/l2cap_sock.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8483288770253086222==--
