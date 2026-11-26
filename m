Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695547;
	b=l5EZqBJi+jNK77E9YOUAU2rabwXsaq7sycSQkc8eO6GUGK1iSGe/Gnk0xdoJXxSaLHGb
	 o1cN073nY/FWWHa/cKZxAJSrcnGJGmQlgRbbpUcRmE3aBk1z+zx6gdwYBPZ5/HO6iAcpW
	 cuiRbarkulS/j09ZGw6/ENvwk73qTqaFcK9rQ2m9HIosr5ajOr2jctvvLkt/wJ7QBKwHH
	 i39E0NN6dAlEWGe5unpDWdRmevIRQzXs0iQMxZuXT6DCgalP9FMuLzU1rvH07rGzLWhl+
	 noZtd1CENu/u3WASPK6SybLZYUAAtwT0TwB8uEyIBrUIEgV+YIwh1O/CO7jzPBO7a5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=B9Zn9rUIEsdGYOkWKBrdmKaJ//yjXTonKx5H7LyaUPo=;
	b=q0wgmCkCzYlyyJFzYXXV9FM68QlTP+rII+sfzYTX3IsLWP+eguutDd8qsu1G1zNwCCql
	 Nsw56IT9GlG8aBSpwQdDlRvrFtm+YE0flRDGA0jnj94z/Z4TrPiTdGAYdr1HE8JF7CuvX
	 ImhmpmP+RKGE6SHOMN8235i4u8PIqzlp/3kgozXCpKQ9f7/9wz3oPhi5biVNEAV6M2GFu
	 z+upCal//m4TFfgAgv4SVmzEjiDzeteelsz3HMbb4topITlkrQ3eFfyZaXf583WCM0Lz7
	 noyzwt3qvhlRkQCxF+ygMf6J9oTYakDxsCluqDUgVGnupy7NBK+8SMGSEwX+y1sa5mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c41wAodG;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91E606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 12:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD91E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c41wAodG
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-94962d80d34so411475185a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 04:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695546; x=1796300346; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B9Zn9rUIEsdGYOkWKBrdmKaJ//yjXTonKx5H7LyaUPo=;
        b=c41wAodGe2Xq0BzV+vmax1TWqPeVK1vLgJG0IJ9v/lBB3ItwngwOyAQWpDGeIJsBGw
         pA5uZ5/P6nSIZmfwEVTzVKpwCO7EdOlGQz/ylRqBC7aidsOfNswlAw5yaP50MaHS9Kue
         hx9L5ANjnk4mdMpXxorA/Ndd8R/IQ6k58ScioTJfkBOVxbqNJrg3FlHD3Wj9wZmxVvar
         1mSG37veUIXJSH8/xMejqFYscohJ4E47eG2WcEqoTzktMgPJKl0C2OihcrWGgXVlgr+4
         aNucMRLsaqjMSicUtaRJDyjmtIYG+Zp+IkjKAgDfSWzARfVSfuzzT5WFm8yEh/PdmBQm
         x4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695546; x=1796300346;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B9Zn9rUIEsdGYOkWKBrdmKaJ//yjXTonKx5H7LyaUPo=;
        b=KNGvkRpkE2Vh7cVm/Y0BCzo+0z7vqHq1Kb/iVxAlcclE3tVcL1R2y8KCADbCJLdxrJ
         biTAWP/v6zjAQwLR5YMv8rkpuOkHM8269G6iBiWHc0r/X1OWeGjBWh4tGfyrFYb/arTV
         0eWl3egd3uxJ6npi1yljiXxhYIUuSTLN/1Sdc3SNgOdfUCLOuYjTuOl1HQ6vWStRnpD1
         vrH0rotL4/GRBiuHVkwxeAayIz627BHrXKa0l85ocKX26+VkYUAcXcZsShrBks+11c8Y
         JUyNsKrhe6+NfJsF7Glf47cFByAc2diKD8IQ8X3AWhRVbX+Fp3lh3rJPSZQJSlZRf/7m
         7BSw==
X-Gm-Message-State: APuU4Z8qSDm3/qn/T8dIQGyaVrPNru1hYSYsc6kq0hBkPBpcv/C8AYaG
	b7eTae17fPYOkTUjh2HMMTyn7QqeqFG6SO6P//UVbcLpIJuEi37t1WP3fggH7oWj
X-Gm-Gg: AZFdTZc9B862CxK1psy/k3F5LyxyhDVBBQjdKk8tp0J/DPtvj94eU21pcN6GCYwg1qD
	NOMJm7G+aQlfyf0LwCWg3whvzAZ4E2G5S6OKmf8LXCP/coe5NVqTVlW78hcNptMKczeuA7TNzNn
	5WFekUVQ10EzwdYEqSFMz18lQUOq2Rlvqm13LQe5qv6/6ETYXCqKVWAOH/f40KIL+sc7e+G6Y05
	MaDYr6+sT++i2joOnT6bvavdevG4Jma6sUHSj9TPUby6Cdhx5u9frHK+XTraNqmcR/Qgj3KpLSn
	oHTIcEFCG5zGJ1dLa6I1GUxhRdbIgEoiaIjkk2se56VV4eYCIX10nNjjrzjQ9X9AvG2owew6FrC
	htxn1PJtPiy02FNZMB7DETQk/1gXjtgFoKbQYNYafnh71SZmirxbfvh6/rouUs7MGEei71jFp6W
	vDQbp33m7I4+gQofR/IBCBZ9nNZpDq3jbeEyFhA5+euDSwSeeMPUrskSwt6+9Mt15LVY/HvQZoD
	Im8Ufl69ykWiGZFXY1fk0qBSdT32lQZ0/kbI41B/8rVQ1StluuwzrcWocZRgw==
X-Received: by 2002:a05:620a:880e:b0:947:a431:adf2 with SMTP id af79cd13be357-949ba8246bdmr3308553185a.1.1795695545719;
        Thu, 26 Nov 2026 04:19:05 -0800 (PST)
Received: from [172.17.0.2] ([40.75.14.236])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm1559782485a.17.2026.11.26.04.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:19:05 -0800 (PST)
Message-ID: <6b0823b9.154b9e68.25e3e4.8f86@mx.google.com>
Date: Thu, 26 Nov 2026 04:19:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6772002658817133066=="
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
To: linux-bluetooth@vger.kernel.org, junzheyu1@gmail.com
Subject: RE: Bluetooth: hci_core: lookup hci_conn on the RX path
In-Reply-To: <20261126075554.106-2-junzheyu1@gmail.com>
References: <20261126075554.106-2-junzheyu1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6772002658817133066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_core.h:843
error: include/net/bluetooth/hci_core.h: patch does not apply
error: patch failed: net/bluetooth/hci_core.c:3865
error: net/bluetooth/hci_core.c: patch does not apply
error: patch failed: net/bluetooth/iso.c:2424
error: net/bluetooth/iso.c: patch does not apply
error: patch failed: net/bluetooth/l2cap_core.c:7895
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6772002658817133066==--
