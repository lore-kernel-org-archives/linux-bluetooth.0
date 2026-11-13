Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541330;
	b=SXFnVzc76n7MmObolmRR/gbYrP/vQDvvn2zbd8dHzWHh31lZ/6p74sZycUO4NYJpwAMM
	 eKLvECq/c1Jl8xuyXZJ0fk1VlAtHImqTig3GrQwyfpG6gEUltPXpINlRVI0q5kez0uR4C
	 C8qoLNj9EB8hSAINvyReNgBMU7NlTcAyzxqJspMieolqD6yac3qIsP9wBSuX2jXiHrLpz
	 GU/M1M5f6kd3Gk6eIrg9CLTinfPgV1r3LN42J4XQ1hewAYAPAR4emmP8pmmDw/RGObNKq
	 G6wrB+eXUkHoaRMFdmqgXhQ7j+jIc8JYIVOJoMSeDCs/8S/SddEWQXDxZS1/YAqBgeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=0IGnqtD7AY04EWEXdTu67Npg7G9Q6StLoFcqfKhgE/E=;
	b=OrpSx72KCtv1iXhfAV/tmcBMXEved1jzcrrKt/Gi+88bo9bBRcWUIqsIOdAwPbIz/iNH
	 o1tpxcgYUmjrjo4C7H1KIDjY2yB+F6OuiHvm2sEL4A/sxizgxzVxaNWOkFh0cn1H4txhd
	 n/8dUlz9WdewEAtq28HckBljPu8UEv+MNaFeb3Q2m76QsXbVOOjvQHZDpq4NJYPpfIAth
	 6uTlSbj/gaD9JWn/+jDrToP2TvVxbl9zQfroA0KfkA7R9zghBBr4EvKdb0bvA0RGQCaMO
	 X53LC3jVSDqWXcIn+XWEUo1HBM5XB9wIrgWLI7gDfRyX3TNoqbmrdyQ+rg9tkQrdQ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="M/3LaEuk";
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A4606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 03:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E58A4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M/3LaEuk
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so663945a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 19:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794541329; x=1795146129; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0IGnqtD7AY04EWEXdTu67Npg7G9Q6StLoFcqfKhgE/E=;
        b=M/3LaEuk3tWSPuXuw6Kr2v8POlYE9HS7yQ2gFBjxgwF0/B5LoWRQXVLUUnQhOQlyj9
         SXV2yW6raJV6kAo0gMwAtWl57pOxI7q0q97gpdAsOaNsQZodj4Jks6I710ADVdBaXAza
         05h87uqxgQvzSPFjiI/vU4eKv6qgeCVYHt9u0HT8d7di0m68HgEo7ajS9ZPDi21sytkJ
         QhdxrDgzU5b9FrQVFHq9kZ0z2GaB0aYf5X9UxaNqp2Hr2vt2gQHF4XYByi72+n8GemXn
         mzS3oZW8fYpeyq7jt1mFKmusbuKaaOdGoq9hPUlHkuImPSt07xV3TukqGyR/ndLR9X26
         Itng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794541329; x=1795146129;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0IGnqtD7AY04EWEXdTu67Npg7G9Q6StLoFcqfKhgE/E=;
        b=09kKBFuOLNUdvbjrrNQ1OMBh7d8tCHiQHoUP4wW6zBIwvyAnq7EEOf+g7Omry3iASZ
         eQXq+crn73Vd1+8C2t936r81I7VRGAPccXQPT1EC7pX0JuH/YwYZk11DSMqsJVLtUrMt
         boUwt8aDsi0WAx5VUU7cILLjdN1zfEJ4Mp+hcPQ7NScuZk9Pj5cfxlW3kNyZTbpL5ObN
         BHBKfXPlPBTHv80b9q7ygKpaqCd2VjDNhZBzyrgt+VPMeoIrfwV4Zze/Ic0EKfl8GoSd
         0E1WAQdYfUwpsNv5CAd1vtCnAGm25brLINY5qFURE3A1IPaigxbbbmDE6/1FgXuacRTH
         IHLw==
X-Gm-Message-State: APuU4Z9ujzS2qv9SbQ66OflAv8wdNvKSxMbshUnjYeB2n/dzHaD+hJIn
	7twFthUmLZ9nYs0N6sQeuVduNoMANog7lEc95qIbmyKEMqQ9Y2onE2VryjJdcA==
X-Gm-Gg: AYBFou3M0zUlbS/dVGEF06SwWERFUMlj21QRL9PFQjT9g6Wkh9uscOMZ0rwj9ZJre2z
	/YSCjIoJcMWzCzfua3GLkRmpSq+gd8Yg48pwu+Ysg0u+HsSXgEspr/fehsTgQc3d8HtHf9bkM0h
	9ubREXtXb3K0WR+oCxNysHtQecGHTgT1wRck7T3/W4rM+H7nuV9MWLBKo1qCNzOkvfWfJFayx3s
	FZKjz9P0nnJ/N++vaBXhiR+GfKIqyGVn4GwTk9IIcsmYb4sCrBH8QSpI2CIt02OOzYHHMzU5RXj
	npNUFWI8sF/Vv5FhauSG1KJMCcJNdX+wl8OWgTe4yDfzT1vd46VG/jOExp1zPTd0AMRit8rTp01
	5tQI8kD1mKK8lDEeivWa+RY33Y356nlVk91kznQbGVbvOQI2D5MBvkAXVZeU/IeOFCwjp1AAuRu
	o3t+LzTHsU3d56o/Wu8/NMAUrHpwUm6gAryChIlFEIAIE6fH0FXPZkjlc+ETA0c+zXi8nBNFeC1
	2NFwCZZCsewGMyz6LMxSgZoKEK0IMGBAKDaG1HsGrLaLVmE3UCOcbUZWinO+rQ2
X-Received: by 2002:a17:90b:5546:b0:3b1:2ba7:cdba with SMTP id 98e67ed59e1d1-3b1b0a46b13mr1011093a91.50.1794541328956;
        Thu, 12 Nov 2026 19:42:08 -0800 (PST)
Received: from [172.17.0.2] ([20.115.146.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18b4e68sm525683a12.25.2026.11.12.19.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:42:08 -0800 (PST)
Message-ID: <6af68710.cabea7aa.180f57.44e5@mx.google.com>
Date: Thu, 12 Nov 2026 19:42:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7270981122761371771=="
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
Subject: RE: bap: Release cached ASEs on ClearConfiguration
In-Reply-To: <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794515788.git.luiz.von.dentz@intel.com>
References: <f5fd668c6dc3b7a9044f218935da759b862e54f6.1794515788.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7270981122761371771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1209955/

---Test result---

Test Summary:
CheckPatch                    PASS      1.97 seconds
GitLint                       PASS      1.26 seconds
BuildEll                      PASS      18.05 seconds
BluezMake                     PASS      270.18 seconds
MakeCheck                     PASS      13.54 seconds
MakeDistcheck                 PASS      136.31 seconds
CheckValgrind                 PASS      333.30 seconds
CheckSmatch                   WARNING   246.65 seconds
bluezmakeextell               PASS      89.26 seconds
TestFunctional                PASS      1098.18 seconds
IncrementalBuild              PASS      293.34 seconds
ScanBuild                     PASS      942.69 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2818

---
Regards,
Linux Bluetooth


--===============7270981122761371771==--
