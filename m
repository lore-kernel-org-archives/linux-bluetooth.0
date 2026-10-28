Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203342;
	b=Ck3XcL+sdjpWESvPjWUanI1w1rhtvjPR8GCX0yPckHZqNgs6wZVCqG46b3T4XLcPnhJo
	 vEqA9Nw58GSJ6LsiE5QYVe62uXAhAi4x4ErQIQns4CmQGbeuNj8zY4/ZOJzQYcF4OeNZQ
	 N/fIvJAOGSHJ2KAw6eoUdOWrbhrVbG/t2DVMWcoOIBc6FxB/SkM/i+ntDdiBN8MRiap5a
	 QMPB8q4xwdVRDZOwLeq4wQYDqong0M76iBOvGuCYZUh6DFhZEzdxlQIm8PPfM8sMyl1EH
	 byVrNw9SUa5RHgD0go9G4deyU61gkSVTy0i8Vkn4ZfyD5I3WV/EmW2UlbRmhSxg0V+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=1OsU8BlmrnbvK/K9pdCS+GTqHKoKgC5Dsy9SAzFeaKI=;
	b=bkTArKuvy46dVXHf+XIyVTJp+46mWTq9LjHI7/qb85410ReJ0EyB+nZPpx0/VMod7057
	 iJc6IzQNL04nNYSCc2iNq7WhNo0MYcZWhFKBDpOWOhyM+e3BPQkdqOrgoFVT5sNkM5n0c
	 xHRmerDWSgcmPzj5qo3VySR577xmSlGZSZMOXaDeo4SfvkfVsQQXCuA1077UROo4943UQ
	 ZwUo7leUMNRAH3mkh/IPJI+95ivqaIYH54mRerlYTsQqoTggREOO/oQpAnrjvKOCrZJ+C
	 FPzDtO+9+/RdfGOrYj+MdIWIPWGtNY37W7KD/BMP0cXSsyF7Ctk0fuSgxkUZRi/wf/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HG5iE91P;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E189F606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 16:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E189F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HG5iE91P
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-702dedeb70dso821755eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793203341; x=1793808141; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1OsU8BlmrnbvK/K9pdCS+GTqHKoKgC5Dsy9SAzFeaKI=;
        b=HG5iE91PiAo7Mh8k8QphW9bnii0SJfTWKjoV8Ndt6ndQBJLfwb4sO+gi7DcRzvQk0b
         Zq4mU6YIV6WSXJWpdT0rXt5wbSru4P3MnEzNqrC+7cdesrrzailFbPCQFwBu5v6xgnZT
         FT7NGvildEvM0S57b5R5FhApss53PkJAzBG+GDWbGauQyX70zo0GqXfmtE/GNHJJ0tQP
         rw/C86ZDOytQ2JFuepab+mdBaEq0RGTxx8+GB4aYpUBQ1qt0yBTWmGSp5WllZgyAQaok
         UF5geTkRJTt4HeQH29zfn5VHpmoHf4W68idcMr2fr1Dl9IGc7nUWIxsoMAIX0e+BppM9
         4pWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203341; x=1793808141;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1OsU8BlmrnbvK/K9pdCS+GTqHKoKgC5Dsy9SAzFeaKI=;
        b=x8fOkFx4eImFB0LeGt7Xn/89HI+pbIVGfyHVucAzMCnhWMgjvcUhOfbP45guU3AWuL
         5ghut62/u4JwHUiZj2OM3aQ4fnHY4d6G9gHNCDCJL8CkuNoCKqLnchNc8HGMELoCcQYI
         i0CTFdMrIiPmjvZ4J0vsidrUdcdvrxEYAO88yok3+sqbpHim5kw/bTWlJvEx10fUcGXI
         4v5aFA38fNR/P3em9QIrF6FUO3eWPizoAXscZf+jLuymFAF61QnMUKzaXH1KlfgDR1E4
         HEl5Cfhwz/zDlfB2DbERuLpS99RuZsnQ41mRP0rJ+X2uUiLMYxzcBZZUOj/4wiMxB9Hm
         V53w==
X-Gm-Message-State: AFq9FYKPfF/sZYL27tPzsmS7ye21Ywi69L0Ev/42Od0MZVCFnEujE0CN
	XmV3kpOYdi7oJFD4nMUEe/QwdLSrWB/eTGGc1lDdbpdkMaz/8fZhqbM1SwMOpA==
X-Gm-Gg: AYBFou3gQbKA3rmD3QHkmr7KNSnx/Z/0Ft3S41VQZIptW6Jaip/8cuFdyQ0w6ytK77L
	5ex6K4BmolnH2YOaWfJAvXf1/HqQf/HL6uwurPlRs0l8vh3aAeapCSIRqQpETOB3PAUgNgjIe06
	TbyrhORNf01abvMuaK6h+sBvHQFzNVJ/Vv6yzU3f6UoFHd+m61OtKpbLIkY3Iwwy3oDhOmeERsv
	JiAv0YIHxLVF9quM+uCRH8UnXID85B5J3Z2S08DX0pnzgbftJ97H5qXAkGkxYo+FnABIiZgtzId
	OXz3sbz+HQHR64+GpC1dzvblglqSUA29HlqqmxQlvYYMut3Z5aU+nyG1nD/nZ1H3yo8QZaDNEpg
	ETNYK2JyEsZtIB//CZDf9wNUexA6onPeAunRxjnyq9H6C4+d6W9De8MgYVrjygAGqvc2g8Er0Dd
	/SxOkrxKoai4dr46oWB7pePvZNh6m/SaTdTj900A8qM5l301SS3Vazc7sUL2qXIlRvLubePWzcM
	zj4M2lVZ7lYczT+Tn3V6CRqW/aq+VzzbifrpHguJrfgFkjWfvujgKkQioJx1JA=
X-Received: by 2002:a05:6820:a65c:10b0:6f8:fcce:a410 with SMTP id 006d021491bc7-713ef9289f8mr1111030eaf.55.1793203340840;
        Wed, 28 Oct 2026 09:02:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.142.200])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7142bb7942fsm1975914eaf.5.2026.10.28.09.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:02:20 -0700 (PDT)
Message-ID: <6ae21c8c.963fedab.2a0d42.475a@mx.google.com>
Date: Wed, 28 Oct 2026 09:02:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2935732200895522238=="
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
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [bluez] doc: Add CONFIG_POWER_SEQUENCING to tester.config
In-Reply-To: <20261028-fix_tester_cfg-v1-1-e965db9c3c09@oss.qualcomm.com>
References: <20261028-fix_tester_cfg-v1-1-e965db9c3c09@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2935732200895522238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1195485/

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       FAIL      0.26 seconds
BuildEll                      PASS      13.23 seconds
BluezMake                     PASS      173.70 seconds
MakeCheck                     PASS      13.56 seconds
MakeDistcheck                 PASS      97.68 seconds
CheckValgrind                 PASS      151.07 seconds
CheckSmatch                   PASS      172.52 seconds
bluezmakeextell               PASS      62.23 seconds
TestFunctional                PASS      843.77 seconds
IncrementalBuild              PASS      190.27 seconds
ScanBuild                     PASS      611.85 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluez] doc: Add CONFIG_POWER_SEQUENCING to tester.config

32: B2 Line has trailing whitespace: "--  "


https://github.com/bluez/bluez/pull/2732

---
Regards,
Linux Bluetooth


--===============2935732200895522238==--
