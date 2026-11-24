Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795486022;
	b=Jm0+bG5cWTgCDbyKCaTwFqMBNaDShKFn0+4M3NWyXv9LHCPHR0J84BXPEV94kPEyYgrH
	 GYvCZmDRHMQP/jGa/bPs3FiTTv1m+HAI5LGmYzE1FVsCxPO9wl4X5rvcOuXs5UgdbrRD6
	 O3oBPGU+J+oHCiVh5UZrD/eFDO0nCewWR0bH2gvCvFVh+1amSWkCt/xuKnDxanGeFSj2g
	 b0DHIahLI8jtCAfGCDZ3vISAkrQwhUKsYVr5+M3u3xBHT5kAHNcaIvoHCFQWCc42AowHu
	 ARJzgle6GqyvUVN/NCYqWnkuOlWXmjl1ifcNuqCisOsWv0sR96/q833y/4DKrvpVKsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=RdwdvdcTV7FnS6ehmvvAZhrkiau105NOc6Rc2tt0xqA=;
	b=nS82qc9SPSAj+6sTO9OjDnn8Vz43gvgTBJiY4kkersBrwZwIsD5ZlzHDkU8hy/XN5n3/
	 iIsTeL9AHkpwy4v9wpHipWssedO6mcfaN2YrtiqUZqWEnUUuBNMYpPY8fvIqMr5JSApMm
	 WVyQJUB+ACpeUkGsDEmAcYA7bD5WYvilxFGaDi7icjO22u83sPrvN6LfqPBhc1i9rusuN
	 8j2Mqyb6JueF+uNgnjOeGL8ro5rVfwhxTBKVzH+65dNbx1AqbavnllX1Gem25/oGU880s
	 AhkPwV2jeeLqpji0NSETrA8IfW8AzotBa1pf4yyXMJSGCvzqneorWxPYI2znbJegQvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMZcG+Ma;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F82606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 02:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6F82606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMZcG+Ma
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-386c336eab8so82484eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 18:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795486021; x=1796090821; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RdwdvdcTV7FnS6ehmvvAZhrkiau105NOc6Rc2tt0xqA=;
        b=JMZcG+MaP4Ryxwa5pcnENOtUbDVH4/vvXaw/nkv+S/M10ecx7SWOyTNFc6RXYb5gqP
         GtTSrvGur11q7Cb/YJUajmY/fXkH1b77Opv+DvKsBgivxb7FNHH/TZbZFG6p7Vn+4WIJ
         Kz+lfJyT4zcy1WC4oS48PWmG+NcE/gYNpHUcG4pfL3UU4GHyrLeyPLl17sfXCXsUHvtX
         rKgD77AETEPW6stwY1ldDJMFaC7J3TogJrvodmkXjEOoD2nk/pGhXZotA+ZGmgRyXVtv
         3kZa2GkJI/yhvDAYEKig8AFdCZ3+GzgsKBqUvI1iDOb4xRfr/WpOhdofPztOYdPQgTle
         n+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795486021; x=1796090821;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RdwdvdcTV7FnS6ehmvvAZhrkiau105NOc6Rc2tt0xqA=;
        b=DouI2RTshLDoNTG5rStTllT846S81ou6YoVI0yUFdmUHpDYwy9C34FQe1F8Ks/eFIq
         aYjZTEFXMotQiQSyqZxQl80E30i+IZYW4rXvaX53W9BtJc/buLNC+O3vq5oFDYHDxph+
         N8umLa38+mWF6FGZLeKMJ16f0QtfFZrKVuk/xjuwaCLOzKXVC1QBtYpfegrwYnnAIzvj
         znVEhL04nAXg/xoJGjem5PLxxPAGhAP6dChasCgShgT/u5oRUr+iL62zwH//4XfbIG1o
         LrWBaaJZsSEBSlSzoEUWkd78xMoySw+ijlGvhBWeFvJ5+dFvpijctiVr0C+IN9CpGTAH
         VwUA==
X-Gm-Message-State: APuU4Z+ffPU9qMcuG/6M201vdRC90qLzWBu528pfMcjAqQNNH9Z+uFUQ
	DJISdlqhZxIc2L3bs93P+CLrep8Timc/ChTVJjqqUV+gzep1MP5HK3w4dqHm7g==
X-Gm-Gg: AZFdTZec35gTKL6o0ERpz1cig9xrZE/UyVzhQ5910q7bPt2cv+948MD+5zvtCw4YjqM
	LBcxzPoeujckWv3W62wbGQiQJbM7LujgfOiOB53gn/AQdv4WBxuKRahlMx18AFtJEOf40+DI+X2
	jKyrfHFZe9Aa7yrI/MvqG6HZFjqIf3Gx6zD9EaYQzvdFJRAdZusUnEpkLguYI/z8x/vnXlOOVUK
	zlKZYKOiDBUH/AbpGRJikZFrY75kA35NeiBL73MuewnqdXWBlSBZkHYU1wZ7qdhTRhng5o57ZQj
	1qg5HNumC1mk/W5BgWD5nxWUZK12liw0CRPikFICsSadrWBU2fP3KHhp/sQ3IGoedFF32nnrC3k
	MjvOuqdJWbMuuzODMZxij7OX+dB31ZIZwMjnqzPTanXxcgrc4BzXxWyQgn2okN/+Tt+P5s6EsSQ
	28DgoBHxT7XcE5jpgvoz9i0lws2xBy1U8z++wlz9De1Prgs8mz89TXmIU8h2qikOYcsccYx/9FC
	wevKNaSPjbQiuV59ulc0ufMhczn0OI7bjbdhZX18impR/Trytpm9+f1U7FY
X-Received: by 2002:a05:7300:e003:b0:386:a75c:4a78 with SMTP id 5a478bee46e88-386a75c4cb3mr6714037eec.15.1795486020752;
        Mon, 23 Nov 2026 18:07:00 -0800 (PST)
Received: from [172.17.0.2] ([20.171.55.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm39290432eec.23.2026.11.23.18.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:07:00 -0800 (PST)
Message-ID: <6b04f144.848bc18d.222f4e.d1a8@mx.google.com>
Date: Mon, 23 Nov 2026 18:07:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1560777468952070739=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: AVRCP browsing fixes, and browsing and cover art in the target role
In-Reply-To: <20261123165932.470612-2-simon.mikuda@streamunlimited.com>
References: <20261123165932.470612-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1560777468952070739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1219871/

---Test result---

Test Summary:
CheckPatch                    PASS      3.03 seconds
GitLint                       PASS      1.94 seconds
BuildEll                      PASS      20.62 seconds
BluezMake                     PASS      315.07 seconds
MakeCheck                     PASS      14.83 seconds
MakeDistcheck                 PASS      148.66 seconds
CheckValgrind                 PASS      355.90 seconds
CheckSmatch                   PASS      321.17 seconds
bluezmakeextell               PASS      100.99 seconds
TestFunctional                PASS      1237.81 seconds
IncrementalBuild              PASS      348.25 seconds
ScanBuild                     PASS      1221.55 seconds



https://github.com/bluez/bluez/pull/2887

---
Regards,
Linux Bluetooth


--===============1560777468952070739==--
