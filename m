Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420562;
	b=Sc2Oc2XnwGaaqJt8l6CdQbmlVhHPx/9o7HH6xfnQRnVSnEJXS8+Witr0f1fOhGKKuSYx
	 +88LmFi66/X5WvAi/6xQAUfR6fMZmtbznfBFuPj8xZvGsrcHXxdRJirqMnZxHfvCIJ6WQ
	 iRrtIwthD2FthVt5M8xAl1YFYgopQMAKfXeMPyI37v6LfMf1+9aXgcRib27md9uRb8Xda
	 kdemCwyjbaCtigJkr0GT1R/PYepTjuF2/r4i/fQOPRO0GSdtqCi6BrCdKEq5S/Vo6yOnI
	 kLUvMey7Qrxf4staGv1/ynqebNCdqa3NApF90U8Zz1ER9518ZezFByyQDEcoJXf2Q/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=yfWoutBY4rqHXcUmAUZFtwumftrBFfSE8KVfeD+z4Dc=;
	b=fx5BKovG7obMyv/CsFfVsdiQN7WUUCWj//wOJLEk1PTr26mXs3HgVi6j1vn3lv4vDqrV
	 YZmZeJ5TdNJFlTpYk7JPo6U+1Gv+dhhhbBniv/oR6s2wfcpO0spUlFmPsppv/0WKk3Ma3
	 6V5czYx8zzjte1Gf7jEUC3gpztQ18pSvkREyBcSgKGJ01pK3nlftzr+vQFuobohC0mgvU
	 9HOwHQKv0Uj0efZE982Nq2jOp5TKrtj0n7Fj1uMRtf5kDuYBRXN8FiF9C12EJgNu0rPsJ
	 Xq5XJEEmdVBFY05+oHbyrVsXRDmWH9JyO+rhD+6R2XTAiDDpkYWbV7KPNkZCGX+JeXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SxcHq2k6;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88A606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE88A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SxcHq2k6
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso40430226d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 10:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794420560; x=1795025360; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yfWoutBY4rqHXcUmAUZFtwumftrBFfSE8KVfeD+z4Dc=;
        b=SxcHq2k6HLJHjqLkzxG2RhCWL/yhsIgIlH+JyTJ/XlktxVwYqvj6bIwZfay66Pb5dI
         ENIk0grO7mC5zEwLYTRfs9N0V31n1Ue7Uy2/STDJjh1kPZE3ruQ72T47+tyyVH5kau6v
         wdgovpg9XVV1Ok2yw3e6rFEV7uaseyQASwLZiGZNT9c2B7kCDGgakaLHnUlbL6BwKmd5
         b+a+uNsE4gv08kuP9RIxcnUnJoe1eU/Cvc7il8RKk7MJR5FKdueClNqP0hup2wYhfqx6
         imjnuuI7B9j05ua4MyPEnNNBVfS5MZoalanhr9bhazdja3OzAzruta89vjN+pzRoG9Za
         hoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794420560; x=1795025360;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yfWoutBY4rqHXcUmAUZFtwumftrBFfSE8KVfeD+z4Dc=;
        b=XvoBelZjsmc6ll2O7FgVCzMhmjTQw63Tc/+iTr3kCwcRHXl8kJLdMqk4hRkFMC9EE7
         1ZiJOc7ypnGVP7Nz4ZDViAPlKxuRfnvsewF90nui9Z1cv1z4LJ88tC/S8I0eQUbDN4p0
         QqYHLwlZfFQsED/sP1gRL4dcx0ByF98UHnJ10I/e9Cg5V/K3ekwR9UD0KTnGEDp9IYJM
         lTPY8a4DyGAnXGqKzWInezOUtfXNAAvR298yqNKrKL/mMme9VjFBmtbihkW8mFqqf8CB
         /kH5GPU50ZUXBDgsnYByGgS/OkdZKa+hrpSWshLr994zTFvMtHzoaucM1iOFxbIbx1gg
         Gj8g==
X-Gm-Message-State: APuU4Z/IYl3R9/TDCv2nxbFASs49ebd4XfUXC6VXXlbkqm2K00TSg6Iq
	ggAFUhVy7jS4AQuvQKKP6OhbyBWhkZ7CK6UFmGnw9SavE+fOBXPZDWk7m9U5bYS9
X-Gm-Gg: AYBFou3LE7C2oKUanhOXhBghJRH92zajIiUhMJYVcfDCwnpiI39OG5EOirzR9CMiqrO
	MHXWwHLOntR3kld9eldd73KQXij6FrplQ1lK9euYMPWnCJHpZD3i9+0J1yZ6IjdaK9u3UgbWmB/
	oVbrcVIm9JSongguMriaCTkDkCeSiYO23F4fLL6O5wVvczstjTaXFH6Q5+wUhTyHBu+auNTALj7
	h77Rk0kQ53eswWbkU5wnWjVgtme1tWcGg3DNlKW3ypdsp1eZLFwSYpN2ISW1w2Mjl+3fnCIlQsA
	QR6E8T9ZDRhBdWqDJPT2A0wSd8kWf/711TkdsMZvzBbBymuKoJu8tLm5ZsxD191TKKk5EM/V8T7
	gOV7NJxtIyC5UtSUHaLKWGtwV5wZUvSdWOR9oovMbYcK+mskWSVbkXSw6Sn2MzX8NqRNWFm9UDI
	m0mbJ+3i5iI3Xn5sKVuFJWHqtesg8BmRsjLvj/Pakl3FBltVPSfdKPj6RKEgvAa/I4/xSkQo49q
	4WAoIxfZBWioxOZS0rUIJ64EGfU7G7bMuTkSZzFNlmUsrjncbkO2WkW+SDVPq8=
X-Received: by 2002:a05:6214:5690:b0:91e:b7cf:2fc4 with SMTP id 6a1803df08f44-91f03dae5efmr62011776d6.1.1794420560363;
        Wed, 11 Nov 2026 10:09:20 -0800 (PST)
Received: from [172.17.0.2] ([4.227.174.184])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0501c1csm52004326d6.30.2026.11.11.10.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:09:19 -0800 (PST)
Message-ID: <6af4af4f.98ae5ca9.30604b.a3f7@mx.google.com>
Date: Wed, 11 Nov 2026 10:09:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1634586392855965150=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,4/8] transport: Don't hand the owner over while releasing
In-Reply-To: <6cdc89f8101db17c443fadd37dc35d4fe5197674.1794414122.git.luiz.von.dentz@intel.com>
References: <6cdc89f8101db17c443fadd37dc35d4fe5197674.1794414122.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1634586392855965150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: profiles/audio/transport.c:2458
error: profiles/audio/transport.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1634586392855965150==--
