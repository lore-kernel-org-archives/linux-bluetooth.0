Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC1547073
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231536; cv=none; b=WQ72DNdj8AbDBY7dIhbrWmUsoKe4uiVQv7BNSueo3GV9VVGyKxdLQk8LQPACziluPP4hViKzV+YgJLocjHOEY3bWZ//c8+dPOJ5L78VdVKBDx19ADeemGlI9dEhaflGryBvE1aoh7ewqODc4DfH2gzHbMm/rZ7BiHEF+iZKsTcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231536; c=relaxed/simple;
	bh=vpgAyqVV2ff9H5aNtbmY56wnPqYIEujJe1rOp8/IQbQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FVBH+rAyR1E8Fw6+6MEMb5LuAGSeNK2mvrhgHg/ScgYBor3UbSyuR74rMmENVKiCARx7BPW9BjmpOXeqMKSawUwd+lLTDC3YiCK1YxWqAVef7pX/v3MjvV/7SGATw5StVza83DoYQCDzA1IJ8qmgQsU9RpubW+imD1/QhJ5FOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgEmWAUB; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgEmWAUB"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e441e14a1so174060285a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 13:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791231534; x=1791836334; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TaCs06jrMtJ+JQBwxCz1V5LHw9NLxDzGt9LCWzTnZZA=;
        b=pgEmWAUBUq7HUHEhebrnEwfLYfOZf9ybttPrwjIX6qaw/CDyoAq90Qza79qCJtjJdX
         er18okSZlZmF7E/jQcjsobjPxb1H4rJKflMIt6Jk5wa1VtC90xaWYPFhChnzEvmtSUrN
         TB3ZZz0ZguWer94CVTyNm9ukSe/E6A2KRyUsXnoA1nsrvoUuY33g3hGQ9sKPCyYYv4iL
         nkfgt7MGuc6ZTFhmCEtMh2DPrQR2hL5CuH/Kgvdclb6cmSLvNfZN0sw5U16kCd0hk7Wd
         yAK3IZTpQlBWjPbcqaCBsLNxURAM+T07LNLNXa0blI7NOD9tG+bKBJ9MFS6qAXVnYb+C
         KHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231534; x=1791836334;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TaCs06jrMtJ+JQBwxCz1V5LHw9NLxDzGt9LCWzTnZZA=;
        b=nSOByVQSZgUzPYEC1D25sg4cNRnXJ+DO89PUJxBLFtlpEFj+pcQ3tu/Fd5YPElqUcC
         cVYDznepVA6KcQIvkZh4Jl12uBe/dcSwQKxb75R5hvwykw2DofqQEh3Agr2V1pAQqfaD
         NicTt6S6Ccf5CcsoOL/cgWZRmYA6FVMH8JFNJmj3ny6XrBrl8qMgrVvnx+z0pKNEgn0A
         aT9VCAQjpB+cs1mD9Ia0G72LTlXWCXFw6VWhZv9H5zPkE6e3IRbfjqOa7PxEXrpkSIES
         zcjn94a0cUakM9rHP/aK+H2xjJQOXPTBhQw00i++ND5UtxN0c32Je6xJf1RwsIY+hBy9
         MSEw==
X-Gm-Message-State: AFuF++mrUwIO78AsWMiKfHvzIbbTUdQvmO+XwKHh3UurDftYkWRD6yew
	1JTX4CETjQz6albfEUF0Z7y1IINXbb3b01rCvpqC+HdIcWYPKKjKSwW1QJG8No0J
X-Gm-Gg: AYBFou1MFsRpYL+Aloi4y4/irR4CvY4X8thMhS4YUxQQBuvBpu4Fn4+lxOTdnvb2b28
	n8qpoA30WgyJj+TE8Xosjr1mP+kPD4mUWnVNBQzWP8feVHkYFTc8vQ2E4dO+xA2Zge+OvTBVb8A
	JnmvoFy6XratnYU8vtNyovI1q6GhpbjYxDZgYKQQ/jJznQskgr3QMY+D0vONOQeduffgWQPKjhE
	cdEIRWqTbpnExr0ZGselBtlb0znfmRbb3avPDtM34Zw0PrMWhKuJn/Ky6rOdA+Pq1dPZj8CsK+4
	yoDvLwB17el/7gXDGD6WUsqFO9oqpcdbxVwRN0onYdjlp5GEvj6fOllGzDcPkots3KrO8mUlZx3
	GuGx2whSNoipSImKkGkHIOjHOMzTrtze2vrapF05N26boNlxw4wdVVXZmYTpOWUBcJMwrpqu/+y
	ShfuP5u7+H90UmwgISYFfQsU/sty6HG1hGlYxTBaZsOuXTUIkS9JDBBPoyOaP1/M7u3q4Do32Iu
	Fw5rQ==
X-Received: by 2002:a05:620a:4088:b0:93c:853c:1f96 with SMTP id af79cd13be357-93e50fa7eebmr1427044885a.12.1791231533841;
        Mon, 05 Oct 2026 13:18:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.44.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca1a433dsm958972085a.13.2026.10.05.13.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:18:53 -0700 (PDT)
Message-ID: <6ac4062d.19f6222c.16bf66.43aa@mx.google.com>
Date: Mon, 05 Oct 2026 13:18:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6332364609968280980=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] doc/mgmt: Document Advertising setting as Global Advertising
In-Reply-To: <20261005152111.3419786-1-luiz.dentz@gmail.com>
References: <20261005152111.3419786-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6332364609968280980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1179727/

---Test result---

Test Summary:
CheckPatch                    PASS      3.18 seconds
GitLint                       FAIL      0.70 seconds
BuildEll                      PASS      19.71 seconds
BluezMake                     PASS      387.42 seconds
MakeCheck                     PASS      14.37 seconds
MakeDistcheck                 PASS      139.06 seconds
CheckValgrind                 PASS      230.47 seconds
CheckSmatch                   PASS      290.67 seconds
bluezmakeextell               PASS      94.96 seconds
TestFunctional                PASS      1098.63 seconds
IncrementalBuild              PASS      394.26 seconds
ScanBuild                     PASS      1114.41 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,2/2] mgmt-tester: Add Global Advertising tests for extended advertising

1: T1 Title exceeds max length (81>80): "[BlueZ,v1,2/2] mgmt-tester: Add Global Advertising tests for extended advertising"


https://github.com/bluez/bluez/pull/2627

---
Regards,
Linux Bluetooth


--===============6332364609968280980==--
