Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793404706;
	b=0Y2vMN0MRaHzpru5+aU6PyD9M8+EpYxtFITay8WkQcUgQ04vKfcTOA5UTjX9sTOBsC1p
	 eQEG5YpfbUTTZzNLi+eh/AmaUFHxJFNz5IBoOAYwVxvAOq79o+VaiMw85QE59gew/Q4ra
	 u3T8BWc0zQToqPrVAe14BuniBvW11b8JHPMepEPlrXg1853Knl7glOfIThxFEWMOdDuSE
	 0SypstQS0mvz32w28Rqa7JAn6b/+700JTnhoMGlP/GBNchp8LW+r0A6jQ41mvBUE+4F5h
	 DKgDwiEHROjD4k7sCa8iChor5oVVeiB69eGlwobGq0yvK4HV5CrKhf+upNiviVKbHjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793404706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=i02o+ifdSOtQZfX3lBtwZHA+fNNShVY94/CHPl79h1E=;
	b=4Fw/2i+mX97KOnXj9XTl7ZfOQrw/HWUr8FKCMaH+uCtZQ0H1ogOu8HRGGSe8uFrFghqe
	 RELORW5leuXFbn1hc6KQqJOtIiLaFV3HOHfAegblxvyWbejZfzWyJr4CuMowyyu9KfevZ
	 fp2ksMm8RDHLGcaKNWYGxtLDEeN5qhrxGgkAuacf/ij3A/ysIreDP+1uUqXFLvTvNWZ0w
	 HxAET4WayOQsWYkeBCklpPBJYK0SbiJE8qZAkcYTjCTZadkbjdrBLkJxvk5tb4DCh7QNY
	 /HParqWuwwSSIy4lo6Yo4KIUXZbCfztrMDRGp/HSLwxpZ3GhF86UQnPT949ta34hbkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=auiNVo1C;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04AA606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 23:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A04AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=auiNVo1C
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-19305bcb72cso1040285c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 16:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793404705; x=1794009505; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i02o+ifdSOtQZfX3lBtwZHA+fNNShVY94/CHPl79h1E=;
        b=auiNVo1CZtNZzhOGA5ykDEkAmAI7x2dEBTjd2OaW5a8JamREFXag9z6S2d719iNG4S
         6O4+nA5+dezKmUeJVDPNt1mSOe8e9L7IWOI/Pd4cF4AbI+by0zSMX1eMiVE219i6Q+Cj
         F9UGqOg6DyZhR2CY06KjrN6GMwPWu5B5xKmXFm4rLVBH/thml2eRcjKNhA46hyfJrHmj
         7OXzrj9rZb922tiib7pE3mitoe0lRNrJyMV6NJKs1H2o10dX07hZQh7mKu1xL3HJ6lsu
         3eMKnlT5jeycNz3i1KJhVj741uHNsr6fzPCeWNUlTa5xo80BpTJ6+ZAKAS/6zav9FmEk
         tMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793404705; x=1794009505;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i02o+ifdSOtQZfX3lBtwZHA+fNNShVY94/CHPl79h1E=;
        b=J4cZXLn/g9UHyWBUelvR1/qDXkIO0NAHRrb15Ls2SljQOac3fSdJCpImZh606oqhxT
         bllJ/mq73m/mLV63Ka7IWfVkuGwxGos4gRi0d0EXschEJ+MyF0ECoYNLM3Kf1LbTFQqw
         J3BnNcYGx8XK7NvORjSlWF+0b1/AJFuBPev6XHz5s3diJ1A1jtaXmTVVwlRn7g5655DO
         /JLHNnafNDpMXwCorLqywylOYTyYOjHJplbcxxtSGCec6u/FY2wLzgyPSyU2d6UtDBI1
         41uyemhm0GiKV6iZGa4VdfQ/zDGNvGS7qGTr4MPQAgj/gW14jqkN9JjlMVh7GF0sCmNv
         EvZA==
X-Gm-Message-State: AFq9FYLyb2/hDwFHo1Mak/+9MOXFtuS5TRTKWkUQgzwBzc3XErcCqwo+
	Pb4N4WyYdBsrMMF/2uPjFo8SkTV+/hHK/cjQhSaVwJBLGFAE1cpxEjVMm9UJeQ==
X-Gm-Gg: AYBFou3mXYDAcjEJ6E3mKsD3wQSSxdvRRYxP8b3LNoxGvQBvcjGss29Za2TGkQy/1Ob
	rgDICfK9rQd9VLW9QHFwLtFgSWREcYvVT1FRuVF+00IcJCu6f3hLDDdBuGJQCu9wOUHhxb25Fjl
	Xr34+BsnVVq11xDb2CMMSyS1rE9tJ17Dl04UGKDii40NfB1jQze1z7FzuTZ4/pn479lFGbuCiKu
	L6Pa7+kjnJti6uddmXGWcy+VtuknhjQyfu7XfziyvcaIYIvdyy1k4Sc0NCEPYL0a2a+AxMXNWgR
	Buzh5STij4tRxYntFSQ+f1ZrYakizy8cyIxNwoBl4XsQLuuSsj/uCOmQwJhCvZXQ2Q1eFgxhxl4
	4A7/zG6c4hMT4Uq7/a+9L6iLT0UvgIUpoT0Mu3W8dcic3f0lSYEFPsDXKK+oR/YTaUsvy0hmpD6
	R7Arb8PJt3eZ0wGZwCgtSStscovlCu7JdRj615lHrf4xRDWAEMu34Sh/gh5ZJl4pRga7qxG9pcA
	seELomXDVlU82xuYHVx8kAWFrBLsnx/syMLmwS+jihc5FJ1sL2c/YDDIfa2Mg==
X-Received: by 2002:a05:7022:294:20b0:17d:7b45:f91f with SMTP id a92af1059eb24-1ac5c273f92mr5116642c88.32.1793404704601;
        Fri, 30 Oct 2026 16:58:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.5.243])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a13652csm11149323c88.17.2026.10.30.16.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 16:58:24 -0700 (PDT)
Message-ID: <6ae52f20.14693a91.142f35.c7ec@mx.google.com>
Date: Fri, 30 Oct 2026 16:58:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8276937133920216923=="
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
Subject: RE: Run test-functional under User Mode Linux
In-Reply-To: <20261030212940.753771-2-luiz.dentz@gmail.com>
References: <20261030212940.753771-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8276937133920216923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197502/

---Test result---

Test Summary:
CheckPatch                    PASS      3.06 seconds
GitLint                       FAIL      2.21 seconds
BuildEll                      PASS      14.42 seconds
BluezMake                     PASS      181.80 seconds
MakeCheck                     PASS      13.22 seconds
MakeDistcheck                 PASS      101.53 seconds
CheckValgrind                 PASS      155.81 seconds
CheckSmatch                   PASS      177.16 seconds
bluezmakeextell               PASS      60.63 seconds
TestFunctional                PASS      843.52 seconds
IncrementalBuild              PASS      223.17 seconds
ScanBuild                     PASS      642.53 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,02/10] tools/test-runner: Unbind virtio devices before powering off UML

1: T1 Title exceeds max length (81>80): "[BlueZ,v1,02/10] tools/test-runner: Unbind virtio devices before powering off UML"
[BlueZ,v1,04/10] adapter: Don't return Busy when a pending change sets the same value

1: T1 Title exceeds max length (85>80): "[BlueZ,v1,04/10] adapter: Don't return Busy when a pending change sets the same value"
[BlueZ,v1,06/10] shared/mcp: Don't drop commands before supported opcodes are read

1: T1 Title exceeds max length (82>80): "[BlueZ,v1,06/10] shared/mcp: Don't drop commands before supported opcodes are read"
[BlueZ,v1,09/10] adapter: Don't cancel requests of a new link on stale disconnection

1: T1 Title exceeds max length (84>80): "[BlueZ,v1,09/10] adapter: Don't cancel requests of a new link on stale disconnection"


https://github.com/bluez/bluez/pull/2740

---
Regards,
Linux Bluetooth


--===============8276937133920216923==--
