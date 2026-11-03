Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742673;
	b=4Cg8GeVO5yPA15xduyMktCauWbv3CxgGpB9TTOunv+5WchK9oPM+KhjZ67+XL6U0sJwC
	 4gYT5KtF8xlk7+BW6GKsianuWEHXzTy9hPGbLphGtfbnqzVpS8mO5W/34mlzKmTknPuCz
	 yXSEwmPrAzxxoJIHDa4MOJZlkmxSgOKKFCw824Qm5VEPIZqNJhIM8JDJkonwFJRJ/YnsD
	 0nme+Gq1LNQcf3ztVyLrLJsJECcUIjELQsGj6zJsXQ1IllXEw3im9Z9SDLRhu7kcpiDeo
	 uLjvZjN6UIrMXkq6RZgAy6vEZHG7kIjRCj9EfJ+jhVSQ+RfJ2Ps4oml3VvWmyB/Nxdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=VTUKkCfJ4oVoHBL0FCD9q7v+lTbQtdZTyttjr8iHYM0=;
	b=OC2kok5Go+vSkesBh4uZLpLVBJD9wzq9NgJ8iWo38Hr3c06ky9rOT5swW1v/o29GzBTR
	 gmHhHWR1EANi2aJk9vWD8D/jQFW2CsjtrtaHxAil8sVooRsBVJpgw7CkED1SGz9J3Ge9q
	 wtzCvTjKipIGO4WTvd7YtTe99fzd2SsVgnaN5myLlXYvdY72ofEzH2EuUAZPYWQdYNkmG
	 ykz8BB9hMDTER+DSMWUW2VmJ2njRUZeAStmdtgC2lHxml2KZdqlV0e0+3Adr18EHPeMao
	 fymdhpz0svkmP2WYCeY0iw2tdJGPeMUQx2vqxYfE6lZxysiqHoxXABKPslzqb2dwkmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQierqbJ;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300B606A332
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 21:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8300B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQierqbJ
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-43bf9548df4so115183fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 13:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742672; x=1794347472; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VTUKkCfJ4oVoHBL0FCD9q7v+lTbQtdZTyttjr8iHYM0=;
        b=PQierqbJYZBuiEX9ZT61IQnKOrgiyTXDxuhGLZ4zVjt8D7UQWrIm2dp7Py8/B6opb0
         dLJ/jx19SezA3ZrLbIHjcsy1cveLlSR385fA9xFdeBauXtqZAceEbOHQjbCNeRjRnnp4
         HFD7fiUr90NEYdT2S5TSDv3FsI7RPL0XYSEMAmJNh9xvYs+xTGVTfDbWgAJrGtYfLI2L
         HgAjFtvHSTiNY/4g/zz2DG/cBk03g+aICoiXPT9dVfEP/sPQUIex8Kkqr+RE/7/rOecB
         dWU8HApc8+cSsZrv2CO3rEn2NGbddzmFDOGey+JbESgm8M9K7n6DHj78M/ZBcuP+pGwZ
         EtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742672; x=1794347472;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VTUKkCfJ4oVoHBL0FCD9q7v+lTbQtdZTyttjr8iHYM0=;
        b=G3J9tiPAunYECQvYQPQ1ug7Ax2xfq4VIMppFNQ9XmMFlpISdFluyLM49u8G4X4Hwuv
         Mfb/tnzoBZk1cM1bhGRF9fieEJBVf7Tvbcr7D214xrZjGlf0HnNoFIsmQNdQjGCgalLb
         xlK3/4YkUIOlb7aOmWHdtI7GQmrBYlI8/ct4oFvbCk88UmjeyQAllUTDguM+/LkPVPdJ
         PvNjDgEcB+R9xpqzTIWKjNJh1HWzXeDuI0IKnUbzYD5L3Agrl4Irg0fmiArJm/9wcMj1
         ig972X6q1OAwSlQBmuoP6QStCfEj0VcbdSVtbcLMucCUUx1uJ6CQbHa5beEAiS7cClKV
         /nOg==
X-Gm-Message-State: APuU4Z82X+1ddm9e+xOxOqX2geCgKgqeSkVTRcKtZ6OmJ8hLBK+HjC7m
	YDE7CzButtVTQQnybuaUmQXWGrmS5Vx8ReKnK6azHmO1WGpco1R3uOej4cWciA==
X-Gm-Gg: AYBFou0RxmzX+TmSyidrrIE1YLjhuGaW2CuO78H4NOJjVnFNr7PSdvr8XpgHushLrE8
	NlrXABOYAQ/vbbaczXwwQqWaKGl0rWyT9mqV+6vOwxZUY+pldI8DI7ItAWkYDTqpPcIJeiIMS0d
	FohcwOACYsAdiOeX8rOS+eib4CYgy7m2SbTW4wbkzPsvMtxwGLeMsYOXSD/3D4TGGJP7TWOKsEN
	xP32MayCsxBqOTyJuvPVoIJbMFBubwY11/6oOVAYSz/TAJxlicKHJo62lxq0pkdKPlAulOluAVr
	dWRHzpVhx9A6so4MXN2O/2UKxHJicJnswDai8aN01vkZMSt4qU470wIdLjYeX1YXKTsPKg9vnaX
	SWIhwqmCQ/frg2M9ZcyKE5l+SPmOuN3o0BRt7qozg5J4qKfP0qwj8Xcwp69A8J+cfgUA9zqM/W9
	iXJy02g3KfIXZL2bkqymLEugtLSipxzWlA9kIviViG76xhzCZg9MNZ50E0f/YJ8H+K0RzSSuApl
	grjyJe5GsYsWLkZg3glBirGH3QSIg15gqVTEY9CC2qGS3N+aW2/V/NyYsTek18=
X-Received: by 2002:a05:6870:c69d:b0:49d:c3f6:4194 with SMTP id 586e51a60fabf-4a90764b95fmr8828536fac.9.1793742672356;
        Tue, 03 Nov 2026 13:51:12 -0800 (PST)
Received: from [172.17.0.2] ([64.236.200.98])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm213617fac.3.2026.11.03.13.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:51:11 -0800 (PST)
Message-ID: <6aea574f.efea58c9.a2a61.ebe2@mx.google.com>
Date: Tue, 03 Nov 2026 13:51:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2743303522539258849=="
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
To: linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: RE: [Bug,222234] New: btintel_pcie: unable to recover from 8086:e476 (BE211) hardware exeption
In-Reply-To: <bug-222234-62941@https.bugzilla.kernel.org/>
References: <bug-222234-62941@https.bugzilla.kernel.org/>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2743303522539258849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: git diff header lacks filename information when removing 1 leading pathname component (line 2)
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2743303522539258849==--
