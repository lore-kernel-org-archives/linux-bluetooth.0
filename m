Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D54432F5
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498938; cv=none; b=Ohe3gPsh45HNrPmhIVx4DhmVQScBcNX/YwZHZnrVeUh050K0hrIPMe+DK1TXbybAUw3v0wMyFUwHD/OjDThx4bcTCg65MPFzg1VXdnXV7nO8vf1KG7F33qpsMy+EPSmnnDrgdWBpgMNQUjzXo7YZlISmQ36BrrR0xnmjFgJfTm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498938; c=relaxed/simple;
	bh=GQ5gknzGBd29undXgFqHShcTpaGJzHqCcyu3WH99ziw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bm3KgImF2teVgRRAF5Ryjy2YhWL1kiK8AWJVkG4rFZNe4By/EhiadCDIR/MUDQ4TEt90xUAnsDaT+s34kq1k71uVis3gdKHJM+jyj+z8YBJIKbRRmIRaydGEXUhg9c5yfefWL70gWrgogaQW4YAXUX+JG/VdR0tQb4mpRbn+YLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWGwD0om; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWGwD0om"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so3017215fac.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 15:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791498936; x=1792103736; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zdazSfKmpyedRxcBsDGVhVxSGVSbRk7KXfU+QNZNvmw=;
        b=HWGwD0omxBnC3QSHTyBgwnEH9G3bMfl/lIpq9F4j3jhQALrsvhZ801ZQhOZxphyVYX
         n6hLHmRvrczQfGG0w1AqNFlQe3E63V5L5ATvIrS1mqeHVN6G3F+7alRJ8AtSohNkZU9V
         Zfoo3KMCmycdDfiJF9a8aHEEev4Z1tF3ZojiKF2M7B4d5/KZu20JJzuvnx61qBL3duW5
         dmDpY2EiLqQmfd5AcF14DFIdbmxAdyrOfcM4hh7/ylGtF2/Q+ijh/FkuSpeiJdaEAnBR
         Q1cUjmK001r9/6yZukkfjKjdDx7CLIFBCZDZgn6oZTtcTvaa9Diro1+qRJeAs26UPBq7
         VSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791498936; x=1792103736;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zdazSfKmpyedRxcBsDGVhVxSGVSbRk7KXfU+QNZNvmw=;
        b=kvZF1IL8EkyplU4GQ1Rmdvc67R2+CE3+PpjANjv38dezQZcGRC4bZ3LBv5pyXH6aEm
         cZFLL3e7/y7GJYi9Gqd+2inAfuTYlrkeGmzYJW7LY/THGdFFNiK173daeWzz2rJ2IYj5
         hmkvxG6s96KP80ITRMCX3p5s1CmeMet04Hb+r5uQ4C6+ZzOyiWuebuRdFlsV1JKIAPWX
         +WieMX1MuBdkJ2ULIbunUJ7DNM7K8eYop8cKZUrr4cn+5YrAgCviyYAFWN8meIT0xFIv
         a4S2rKWoro/OaWddVMQ7Aehg+N68G68SifPa4n0ByMO8d/r8uplRuURSabwX1WL9BWao
         3rGg==
X-Gm-Message-State: AFuF++lI6VUmyS8ugR86N7QkqE23JymGESVTd6kKCgF3aeFWV5j47aUz
	qNp4vKP8G+5zjDjShlI7hvKLAbO6OjO7z9pXt7xCx9xZsHVlfk+qxfzvul89zg==
X-Gm-Gg: AYBFou2mhvZna6DGq7bX3+cvZc0BC367wXRYCjIczcT2wAFWUP8UYbxKXCV1wiCNVkg
	KWDB3yyXBLWtc/DDeEMgM02jZBnga/P1jqZ/RMIXoRxqOWiHr3USxsckcdYpsaW7J/+tUBavkOC
	NMhd20D8vrpqirDVzJW3xAZTyC5j6PY8Iz+3UHphwSJKfHFW/7hg9J96fy5z6GwoZS1hGCB5kWF
	IMotlItVOkKqcdHYYhA3etB7EvAseBsw32e3aVtV77IrEC3HOeb7ld+dldtRQi3zST40Moh5o8t
	cs3AsIUSI3slMkH3rGYydEfod75A5RgfqqA4/cysXfIRQ4dbkC4w7ds4toYXpQGXUXOA1Z9fAUK
	xanmPnxMUj6XywW1IdrnuaNt4rw836yzhWHl/uOaxbPfWEXKbOsDELP3zc8X9R3rfzvcSmpdAZS
	KzT5VRVXStlolEzr+SnWkZUbINivkeAtBq+ZnnJnkz8XG9eBl8sLIHPgA/sQ/8SZts0xuBHcbfJ
	lu/vnw=
X-Received: by 2002:a05:6870:cb8f:b0:469:fb51:b351 with SMTP id 586e51a60fabf-4a2a8964307mr241970fac.17.1791498936296;
        Thu, 08 Oct 2026 15:35:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.219.194])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a860102dsm279784fac.16.2026.10.08.15.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:35:35 -0700 (PDT)
Message-ID: <6ac81ab7.99d0dbd8.110e96.ebee@mx.google.com>
Date: Thu, 08 Oct 2026 15:35:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1076636766377671004=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Add Role property to org.bluez.Bearer.LE1
In-Reply-To: <20261008173000.3615-2-kevin@simpleble.org>
References: <20261008173000.3615-2-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1076636766377671004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181777/

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
GitLint                       PASS      0.79 seconds
BuildEll                      PASS      16.14 seconds
BluezMake                     PASS      281.25 seconds
MakeCheck                     PASS      13.74 seconds
MakeDistcheck                 PASS      117.94 seconds
CheckValgrind                 PASS      188.17 seconds
CheckSmatch                   PASS      202.45 seconds
bluezmakeextell               PASS      74.32 seconds
TestFunctional                PASS      961.44 seconds
IncrementalBuild              PENDING   350.27 seconds
ScanBuild                     PASS      822.65 seconds

Details
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2637

---
Regards,
Linux Bluetooth


--===============1076636766377671004==--
