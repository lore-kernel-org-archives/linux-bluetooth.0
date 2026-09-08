Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0353599A26
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890366; cv=none; b=OPwxIsoJzYv85ktqUX9hXD+sJ5cWsvTe6civEZYeK7uRBcOg7SGMDTIvUxGyXZi9yY9v8w+pnWqaweO8d5eEcK2C47yMo4ym87njyemK2qW3PGFkVJai2TWceZiv4v+nzofw0HlTehLACgD2ZP91FF6ZV0aLP3A2mVCo0s2cv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890366; c=relaxed/simple;
	bh=R2HGKzdukHl36h1c+zIwe4gR7aYbrP4nEazO3YYj7HY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aoip0EBnvUftBfntFMADaYY9nQTZM85xijtH6EdSkLe/PMeG/036UoXFcE0zL2fPQziPey8cN1f4s8bjU/EhEGGB2aj4TFQ9wo/VNb6pCb5hUj4dKZaE9gqqrmcLzGvLt0hmdrgytWdLouXYGuFnyJW8L6ixAkt9egxyWxpahp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnz5e55R; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnz5e55R"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-939adff838bso158109385a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788890363; x=1789495163; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gw/goLXsZpEeap7V81kl4+x5WfgV5oqJpK0Tlvxy9nE=;
        b=qnz5e55RhHbRf4Trv7Qe5CaqNAtRQs5b1Kx2LqeYy0egGwPX3/ZrnveODbaMPSEJUL
         JHz4Ud7VFW2qkllMxnEy2DA+j3KvQSU3/2L0VO0ZaaHwtf6GcqPw2rBWdVDFF/LEr40z
         iV5PIK2PBROPXMVSHWafQXNmL7PcFyTopPvQVPYf8uHt50oxiXrYeXu6N14ptr7G3zN5
         qCg3sUfmnCWKlFVoYmB5h6+VcCUq3+FraznFI97+fK+GTZN+/H2Xx7Hsas3/EiFmRQwY
         JE1s1S5H+Wne5qkuMbT2Gt3HkBqPsxh/0gdGs3NFo/5On+iUZDDKK5UDggGYLwB9xWKN
         9QwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890363; x=1789495163;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gw/goLXsZpEeap7V81kl4+x5WfgV5oqJpK0Tlvxy9nE=;
        b=sQaIw/0v6Eh9QvTp/tTsQW//rYCj9+wz/QbkV8ER/lL1RRHJ9vtXXQHWAcJDC+QZjo
         L4CKvKz5aHqPJ9ri+vbx4AzcnORFFDC/eFWEg2UsJsc+TTYwOxOjCPFxaOLJeMdrRIFR
         3pOUJ9dvnD9Bvc7OyUP+pbeVJAsqPuuGCf41BIPmFjKJ0+xHaQC7hWH0t2BCJV21rqEZ
         Y9pQw0IZtoDAMi9DUAnZH9uVJg0hmfSCKXo+S8qicd7wXrSzGce13fADygx7JuUqrL0n
         n70ea9j78u86c88zAxNv1dg8lPW66Cpz/ju0EY6cDirlJKzWgXSECKXiVCiEf5+7KLmf
         9TRw==
X-Gm-Message-State: AFuF++nc6EhX4jJw8ib3wk9yOXFWFFL6Y4T+qdShljVvsdqTBRZh6QZ5
	G143RL7a+XmEhDcnRnw4SVwAPYzGCu75kbSo5DbFK9jF9lkfncShQn8ahgufGw==
X-Gm-Gg: AYBFou0E6HkOhpOYYwHbTjzoNRWSsqNrHLIHFitClUz5MEZFuAzRlGoN2/uV1sApOkk
	p1R+NyKg8HkcgfT4Tt5dMoqR3tLAbkKFlGR2+MuCkUw2LfPtbViMbOPYsXR+fPny6c6txhVs5ru
	+anUCziExiPtRgPu02paAUm/VAwOIcMXovE0NA4K6ElUZYTYA+K8/yrv4MIDpBGk/O44nbqTsOU
	rx0ojYWCcNP1I9UxGSmHmwYs6Z8a2S7J7eT2uoPQhaRSQ1Tm/eIGHVl99kh4CsqxbYm/3bRHUGv
	+rIa6CbyFnNfSQC17GFtr1lq6ymRmFq5TyW9S0Usmgk885goeLNwv2kqpOsnR9fZkLiXYLJ2ds0
	yB+/XyNMSNUCfFVtktuwJzYf/I7X8pd6QMjNumzOObW/jQZdNt3LO3oVA7/dhmPkaxiwaAJt64T
	SSrGpE7B2TMedb4Sf7fExMa4gr8NkQ2luh3RXYzlzxm/r/ixiSJIrSe/M/D8O3XGK3SQ==
X-Received: by 2002:a05:620a:8083:b0:939:6dea:374c with SMTP id af79cd13be357-939804f9df0mr142825285a.48.1788890363332;
        Tue, 08 Sep 2026 10:59:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.199.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939b0aa9a29sm450208185a.7.2026.09.08.10.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:59:22 -0700 (PDT)
Message-ID: <6aa04cfa.fc99aab0.997d8.0d4f@mx.google.com>
Date: Tue, 08 Sep 2026 10:59:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9185308937744531567=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: client/btpclient: Add BAP/ASCS/PACS support for auto-pts BAP tests
In-Reply-To: <20260908170633.510244-2-frederic.danis@collabora.com>
References: <20260908170633.510244-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9185308937744531567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160712/

---Test result---

Test Summary:
CheckPatch                    PASS      4.98 seconds
GitLint                       FAIL      2.46 seconds
BuildEll                      PASS      16.42 seconds
BluezMake                     PASS      490.48 seconds
MakeCheck                     PASS      19.26 seconds
MakeDistcheck                 PASS      126.54 seconds
CheckValgrind                 PASS      179.69 seconds
CheckSmatch                   PASS      235.94 seconds
bluezmakeextell               PASS      75.90 seconds
IncrementalBuild              PASS      548.21 seconds
ScanBuild                     PASS      714.43 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,7/8] client/btpclient: Defer CIG/CIS assignment based on Client/Server role

1: T1 Title exceeds max length (85>80): "[BlueZ,v2,7/8] client/btpclient: Defer CIG/CIS assignment based on Client/Server role"


https://github.com/bluez/bluez/pull/2502

---
Regards,
Linux Bluetooth


--===============9185308937744531567==--
