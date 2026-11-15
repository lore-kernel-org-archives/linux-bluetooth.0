Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774885;
	b=RIhVN6Z9RhVpdSnV+G5NWgvdQIfA49o7Xw1QC+DZlyzqf7esT9Ct03X+lfrvNOfzBb12
	 c05ysu8PdnOQsdMv2lF7Cl5ElZFdkFs7q6gv00D5mtmvtCo7SfSneSGfk8xfq/5fJRyQF
	 zRLqI8H2Q+SgrrKxVMND/2SFE4P4lHQzuPtI/boMRJBdqBntAe5yZzES+nZxalTsXON6o
	 BtETanonDMglsXDo9gQnMIQ0dgPvfyJUIxO36d6CrCqw3faonXsGUkbNZni/yrfvYLc4j
	 hcv7M/Qb90uLeI/uzeIvVym6I98aU/Znsw86eZeMit9zDrdhgWIztW2V1aPygUgTemQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=mEPXfr6Jd1/j4WRpJKHmDjPIHsGOyGFbgY1Rhpbebcw=;
	b=sPDlHxSIfj/wtIT4bQD9AAFQVWNuXdya35kQ0VA6qiRYwF+u1hfDRRfaFiE/wcSOLJLb
	 r0JTHrnL/tfUSaH41CXxph+ip9P/XZ5VFup8bLZWNWhb0hEDxQKfSFq3frvN1BBNvwhA3
	 bsuIMO0U8b/Ufc/2C6P8a71937+i3pGZ6ht5/5FoQLEl/I+3L11KdGhjRBIVJCcc3Gih0
	 mGCK2AMLY4+LJThhZuie9W4bwNe5fG7ApNTp2MCWxMb5GH6d3pJrsnSAS2b1dnEhG/J2r
	 3/CsLjGvurmKciJMuJOiBWi4iP2wZS8r3MUHUcWEGugFc0wE0vNq8wrAMLOd3aTFQIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlCXSdfa;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F24606A329
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 20:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0F24606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlCXSdfa
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9496473b511so172989185a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 12:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794774884; x=1795379684; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mEPXfr6Jd1/j4WRpJKHmDjPIHsGOyGFbgY1Rhpbebcw=;
        b=hlCXSdfaYLFYk+5Ya8GQt+TD4JOQM8gCiFcs5B+cldPWawk0lhp0U0k6o8ScqKAax5
         xoCcBF+W0MV1yBsQTe9H4HK5oJTMdj5wx5xDkUnFu6mRJzTkaHiMLSNHlqUGXsug7iRM
         D+lmEMHhsH2SICiE2UuGb/3PAHyg6t6LhG44CiA6LBWHQ9PQOL+q0LcIywUORt8Na5Qb
         7LLu3pp/io7Nzf0pbm2iW6QCsHC4fM/DQ8XEGDPiM1LxO3RstKKiIy7ZCe5Aepjdo+dv
         btOYEkAFS58dn3AfGY5zZ/Nn/uuogsUeeO2iqzBQyRSIGpltqXc1KoMnmPDXURup31VP
         8cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794774884; x=1795379684;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mEPXfr6Jd1/j4WRpJKHmDjPIHsGOyGFbgY1Rhpbebcw=;
        b=jarxN3Oc0pNXg0Jkt5BQ8mCUTxKrok4I2L0kjJZ++qwnG4gT0z3RddGCzG7Wooy3IN
         V8UtEtIRcTzXfCd7dWRC+g8jNvOTh64wkDzmqCNMR2A7QAOrnSLn0ggJbP3/4j1mKiQe
         z8KCwNqsWyLUD8HMrz4CD5EHowxffK9jWCKeFqa5pPYAjuarWkqTcw0oliMZF9FDnbAu
         SgOjZWG+SHoNI2ZtSiX16jSJDLPta8XPs+QO44CEFZnSJZ9l1kBGvmaaXXVP98Qfjw0v
         MSAQzbosr8bpXfaAS5e38aiFvgq6M9zz37peiUXi27T9sT5+1mu9+ZxsrZNhVvVy42Rl
         +Siw==
X-Gm-Message-State: APuU4Z9vp6+wil5C8HfofnJEEHjUvYcwnV7vkQ7RsDM97TM2fHjkTYbZ
	g4lNT+9lkfzDWFy9rplMRmwb2BzfkCkHesIEjeyof3JYTHgIKqG07q2zGMd3kret
X-Gm-Gg: AYBFou1IGQcyaYgCRroSBPdi7puKjXPzTKWjrjpzKFmzIRod7lHjd4QyN7cqGk3KqEt
	49V5xKksvrNZzHJD5SdXoVUcsgW9Z0UQ2z5jgzGSQSkl9AR8ez6sVIuTAYg0Dd76tCZ2a7US81J
	i9RAYf+huvM6e3eLSTCkxJNig4Vea8eevLzg/qAk4BLnW8wpbstyFFjW2Wn6vUVk9/rYYUAm9Ir
	8dhholujf78AqirASPsdDGj9pa820BAbkRZVoNnvlnLq8aQLUY5e2dX6dyuWKs9IbHph5ArSWYK
	Uf39JGzaDsdBfp0bmWJErvVlMByXdPDBf62fqtOJojYkLk0UfV83FLYnx3FkgO+B1Wxjnli1avE
	AJzCuwN3AL/jXm3Ygr5ZNkupcI4cLSPIOWwiwgjI+bJ737mt6XVytYqZLNwtJEWqSka+xySZiYb
	Dj3MgIk5Jl3dbNe/R39i6Prev2gi/cKuoCJ0b+ocaSnm4n5ihoeABnzD8WL1W08aDkQ77kEMlG5
	yFR++JoGV6JLOXcFwn7MdX9r7PL7LmCScLgD8b+3bf7ujueHPSY36zbAJiMKfg=
X-Received: by 2002:a05:620a:1727:b0:949:6e10:b8dc with SMTP id af79cd13be357-9496e10bae6mr592561485a.13.1794774883858;
        Sun, 15 Nov 2026 12:34:43 -0800 (PST)
Received: from [172.17.0.2] ([128.24.34.168])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c835b45sm696067985a.16.2026.11.15.12.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 12:34:43 -0800 (PST)
Message-ID: <6afa1763.a51614f5.ccab6.9fc2@mx.google.com>
Date: Sun, 15 Nov 2026 12:34:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1301576139404098554=="
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
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] audio/media: Add hfp-hf supported feature flag
In-Reply-To: <20261115101946.69033-1-frederic.danis@collabora.com>
References: <20261115101946.69033-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1301576139404098554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1211775/

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      14.67 seconds
BluezMake                     PASS      197.21 seconds
MakeCheck                     PASS      2.57 seconds
MakeDistcheck                 PASS      106.04 seconds
CheckValgrind                 PASS      105.95 seconds
CheckSmatch                   PASS      184.30 seconds
bluezmakeextell               PASS      65.14 seconds
TestFunctional                PASS      901.54 seconds
IncrementalBuild              PASS      181.39 seconds
ScanBuild                     PASS      654.91 seconds



https://github.com/bluez/bluez/pull/2830

---
Regards,
Linux Bluetooth


--===============1301576139404098554==--
