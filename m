Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC955FBF6
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756541; cv=none; b=Pz7KaYfAgmIIyMsA8NELLBDeYTtTvPxFq89f0Dya2aBS5rDONvemi63z0dnVJbFgDF00IZ9Zy7DPlAJE3WblFfpjXdWBEdwGhDIlsHjgq7wBtQGg0HP9ktb508ctINoN9iZSB2ld+oXwwgWBBJhmPtclwv6ZOWzOrWb9rGnxjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756541; c=relaxed/simple;
	bh=VngpqmAeRc6c0nKMVBgAe52gMoHwl9J8La+vwLTlntU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ijx2WXfV5XQPJDfRIhO8H+HNwuBTXZYudaUIHGQER5d2CA8Em7ntZeExiPQfoN+0N+kFW6BbDZIeRDL5YmxvVLRNCeN+BZFnOEBxSG4S3M/MImA/fUVhgCQPbjVj7ArG+RsT/HE8wdcKRXvOJHAGw9YBDkXARjxcyOEd0a+XQ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sv3/XndK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv3/XndK"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6eb531e13so147262485a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 14:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737756538; x=1738361338; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wXeDXs1XhbZza41f0hG9xB2/b0bHIAlv2LCpxGCTKTw=;
        b=Sv3/XndK73j8Et7S1mgvvRQQ7/0BNDR/3MP5WKVkUsj/3kVid6JT8hiuMo8T64WHkJ
         PlQ8LJ8Wj2HgfCLrWQQIH2T88M4j8Nxy+Qt34D48HG87URwxATTrfA2K1mpe7fOBxSLe
         i55/bBOZgJmLb3o1IVedEI+RcawQ3/NiPTLeo/mjKCGTgBWo5jjItGW7AdGUuQ67poNb
         CetP2Z3YCON2cA1aJnfNDZikNMk9rKhu8ZWiqLFBe+N5KwxayiTrX+XvoDJ1VrN6/F/2
         ms+bHWneaqJNy0m8pC1bGPUMM8p89e/eUsXlvVkyRt2IvlwEr5Vi1XRWz06vhpKy33wa
         AxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737756538; x=1738361338;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXeDXs1XhbZza41f0hG9xB2/b0bHIAlv2LCpxGCTKTw=;
        b=ppbM2c0h8zq2yChCPl2DN/DlvkEf3iOGvbJ+vZ7Naxc+RbEzNGDMNDKPdPd8xs433b
         BHeySx3dNgqhJYTcZGda4Bdq8TkYRWkJE74fhtUiPFwO6wvC3peTauYAu+yADb8u3NSI
         eUk4wlmqbuFaBiO5e4s4hOlRiv0djEG50AB+Iwg8mGj1WsqjS3W1GGcMN09BsfeO0xv8
         SDTD7L4N0B7cMmNwKSIOV5L6TgG1Y2UHr3SeUWW5230lpn+Oxv4oqxwWDS1wl4s84PdV
         mrOzy7b9EGQe00mMT1iiUNAqja3NoyoZtfKYzSW3aXJ5S5zPHCVHr+n16s5RclXCqrFn
         u6Iw==
X-Gm-Message-State: AOJu0YxHweQYl57Mum0Zg4NeI/GvwFGr51JZjdYwDYHhVg1Oic2flV9+
	PpyT3DIHGPn2MJ7z9OWNLAB19UCVcohaaUU0QQk/hdS1mgG6Wc1I6tdAOg==
X-Gm-Gg: ASbGncvtbe4QHNgoD1ihHzOgXv3JYQ/bi3cqD/CvWitIJZbKS3USzZhj1QQeoCh8v7M
	+KpMbR5MRvsATypGr7x0m1G9hsT7cT79TkYdsz6OXLCCrP4wI1AYS7wh+BoNaCPibKnMsmlcny2
	ATSuGBnnxJdqmVISQvFYzz/yYrTglvOPb9MySw+ZEH0qpEo1Am5VkZsNXiRkBKfzKyhvmc0ibMc
	cLYLDXpbHRT06M4EkUEFai5lHc52s9tLzdce+GwU93lCW6VWHaVhSti+ViRlO4BWUqWbJiek0Q3
	pLb06vunF5k=
X-Google-Smtp-Source: AGHT+IGarlPO8xvt9W8mbizVvQ0pYjhx3iCoxrkHucydM/2NF1ASpKDtdaVY8vP/fIcOXTU/vM1CNg==
X-Received: by 2002:a05:620a:1990:b0:7b7:28c:dcd9 with SMTP id af79cd13be357-7be6320cf9bmr4614849885a.29.1737756538416;
        Fri, 24 Jan 2025 14:08:58 -0800 (PST)
Received: from [172.17.0.2] ([20.25.192.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae8aa00sm137708785a.41.2025.01.24.14.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 14:08:57 -0800 (PST)
Message-ID: <67940f79.050a0220.1f51c3.650c@mx.google.com>
Date: Fri, 24 Jan 2025 14:08:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3273538376656450151=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] gatt-client: Fix warnings when reconnecting
In-Reply-To: <20250124205700.511446-1-luiz.dentz@gmail.com>
References: <20250124205700.511446-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3273538376656450151==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928239

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.54 seconds
BluezMake                     PASS      1569.00 seconds
MakeCheck                     PASS      13.66 seconds
MakeDistcheck                 PASS      163.18 seconds
CheckValgrind                 PASS      217.77 seconds
CheckSmatch                   PASS      273.84 seconds
bluezmakeextell               PASS      99.39 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      869.53 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3273538376656450151==--
