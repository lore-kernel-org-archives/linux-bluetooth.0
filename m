Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309387;
	b=Y1C/O+lAudy2w9p0BIwszJuoZfSh6f7YDsa6XvIQlgcscwdoiWS9017vsrhrCrS3+mBi
	 uIO61zdrPwjoDpUIeHNpRqNDrcRRrHHjEV3UCzsrk7NlLfuWNAGV31HyqiC92QazEEIZD
	 mE6W350CKLOF8Gm1KxaFTSPR0OemGs0Xf6Gy2ocl88gcdZGzmfgbYdryFKQLXXUrADcCE
	 Q6lxkZSkz5NaUXUkrJlXrWyuh9UVwJI633I3mCWVoLUrJRt6/dxqFL3JVE2lGgw+ExoMI
	 nmUAZ5i6zOhFJVk4/H3r8r/FumL8wdCGinjU+0YBmSU7Nrm38J0xGL1YoCe10RnaPbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=gWEU4czwzJT3gbAvACVslkpBdJCIMQNhrhmz/cv8oG4=;
	b=f5QqT4Aj/LGWeCTEXZ2QFSJq2xJfVOhpH3HCk5fcSpSTgF5PeFKLZ6vOsRi27ektaUgi
	 m97zPEZ6vNCbSAg/spEgZICZybRSNv3kApaYAGWEa8Tih1VpBODC5EzSDvYAQzqr+UQnc
	 +PP42dZ5EP2pW5x+QMXhXzuYJAseugfEO3a6LChmrYcodnd8YOchOcGqzfPcZN2dApisp
	 Mw+YEsFcPwdDajFhCIlaRrqoKfOe0Rl/+cI08o8EpXPSHrVJbJcU9ByhrMH/ob/n7EcZc
	 3TemfD/wayKs0QHYeUOC+KnOh0HUrEGG/9dzMzmk3xtoyCgf+DgS/Y1WkQnGUjjsAbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jjnSlpQJ;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012EE606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 11:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 012EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jjnSlpQJ
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-930c0f9c1b1so192044285a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 03:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309386; x=1794914186; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gWEU4czwzJT3gbAvACVslkpBdJCIMQNhrhmz/cv8oG4=;
        b=jjnSlpQJGEnDZ8VKPVefSQw3B/hR5A9nu8XGwUQd+6pxY+3XPwUEph5SFguwDwtbDL
         sJx/qPjS0utxBY8p2wXI0q/ovlrDj0SegWyTkOCnQBVUYvdYopeVg0ifx/SCzTRUkwcU
         Q6ZYZpIHKGCxvK1oka1CgdC4bC8Nkp8iSGNYWig38VwJtJ/U/fxZCXgQBHPpe9xKbpEf
         PbpzevInaBopM6xjsyem4gNhkcpca6H6yzWiwnfix04/SMDtURcW8ZMyNFd1rU73okFZ
         DClZWuH5TpCsHVK/v2luhvn//3U5wLKrkowSfLSZsyP0h1mDmCvq5elGSlL5+8vh+2hH
         jgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309386; x=1794914186;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gWEU4czwzJT3gbAvACVslkpBdJCIMQNhrhmz/cv8oG4=;
        b=yUvbelD1zcywIyTVhWuUXb1Dj45VmNGkvbgNEIh0FLcpkeJ4sYJCw5cerlHTmZVRT4
         BLyngYlvCOn8tBcVP9/fO6ZnTkqOQjZsladGupvVV9rlJnlQ7GA9x1GMhb7Z7dr7cH7b
         vJazC6il+HpSwTLa5eKrRS2iQcQWy/dDb75PGqbj7yXPiaspdR46Midqxo2CHnpegf04
         n379AUZHl9ADtl27plcgE4EV+N/j2UzXtohgdQCSHFayU5Oik/K6Q383/z1uWOm8sLrA
         kbesK+MuUIzayzMr8mg1kaRHdFLTTLTTqyWd6gits6NfWxq81Se9CLQB25sW7x7+MjNx
         /Hpw==
X-Gm-Message-State: APuU4Z+c7GdOE5DSoebHLCiGip2Snp339yRPycbItg/y+C3welcH3GE1
	/LFBGAi88411I3nbclL6IP8iJEVVdfAs9rgUbmAjhuA2Behsfw46aGRIRVxMCA==
X-Gm-Gg: AYBFou18vixBCH8M1EN+h9eRL2/0aCnjMRN1+U3nM1fVzUPeqhdl9G4CsSmJQWlpHxF
	TkPep3/ZuQYkI6EhfYRig/sClgzf7ERJEEkzmEYzXWGMcq5QYfDJj0pYw+OFFDLtbBNBxlGRZaC
	XKxLbGx6v4bieLfz18UEpOwpCBWMtqHa9vIzuoACZ/yCz3lhAOuP7xccEzeZSeQfaLWc5TBZKjI
	gN9zGcy68OtSQix5ZDmM5lfAZ+jvCcCHNMaQwK21Y8LbYn8W8hMZn5ySwWYy+GpCMcBNgi4NtkE
	yXJy1M8CdjgMDUZk7J5BCnA10mZyL8gD6EvDaWIqiEpgVMXMCcstxd3Xx1fvY1+xVMcE2cscEhe
	3yWJDSFhi6xe/w0xVnjZY4Ad+RwvVuyG3VvHn6CyFl76KFwLdS4Bn7SIgDbqfnA4tYjCY76REGt
	0oLvk5PbDxJ7ZC7qhgGDSOoeMegirk95GFvRnixYOxGimekVNpwBsk8TADUSf6hPGeKGdpggI/I
	L8rmnawwcQ9OlMfupRBC+Sk0nLXFyb+P4wjCs/C5n5nY+JSyFlOpcPt/5VruQ==
X-Received: by 2002:a05:620a:4694:b0:93e:58a1:3da6 with SMTP id af79cd13be357-9479f335945mr360861085a.60.1794309385805;
        Tue, 10 Nov 2026 03:16:25 -0800 (PST)
Received: from [172.17.0.2] ([20.51.199.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73c84bsm196886685a.9.2026.11.10.03.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:16:25 -0800 (PST)
Message-ID: <6af2fd09.4001fe38.32b512.a93d@mx.google.com>
Date: Tue, 10 Nov 2026 03:16:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6689205791899789490=="
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
To: linux-bluetooth@vger.kernel.org, raoxu@uniontech.com
Subject: RE: Bluetooth: MGMT: Fix runtime config status opcode
In-Reply-To: <3B679DA76E38DD0F+20261110030756.214083-1-raoxu@uniontech.com>
References: <3B679DA76E38DD0F+20261110030756.214083-1-raoxu@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6689205791899789490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1206644/

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.17 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      23.15 seconds
CheckAllWarning               PASS      26.40 seconds
CheckSparse                   PASS      28.51 seconds
BuildKernel32                 PASS      23.79 seconds
CheckKernelLLVM               PASS      25.05 seconds
TestRunnerSetup               PASS      594.49 seconds
TestRunner_mgmt-tester        PASS      84.87 seconds
TestRunner_mesh-tester        PASS      5.30 seconds
IncrementalBuild              PASS      23.81 seconds



https://github.com/bluez/bluetooth-next/pull/1096

---
Regards,
Linux Bluetooth


--===============6689205791899789490==--
