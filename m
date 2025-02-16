Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207901AAC9
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Feb 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739725772; cv=none; b=O1vXkJf7Es0EVsYANRruqio1xdB3VBbXTRk8UjuctxysQlP+OzF1VpJJaWpbkJXm2GHqjDCYKBdW3Hdw5mg+gXe0uxMgJ6XRXuDbWjObshhgXSfyk/IvdSBexQlKbu24X1gnn4B3Hq38RifhT3Bz0lUTl1H71WcYoOmaB8CMmHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739725772; c=relaxed/simple;
	bh=8jAuWfGCOfe+tbdnrX9C8mzvG5TuUI3ITmB8FW+c12k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZmOE2GltV6crmynOTB6rK1Uy1YfLT7GVUe0dJTQtFZSAPlw2Zy5z6EJ4bxFVUfFc7r8SgeyPvkRpFDoDYudfc+qQkzueB+EY2KG0/tAR0s249xoA88neQLPvs9M2UbAFEv1qjlI+kKYU8BWm+FlteonJkWZGzAXTE6p3ZbqLCk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwJi3WT1; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwJi3WT1"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0771a2f3bso308224385a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Feb 2025 09:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739725770; x=1740330570; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q1xUJxwH9YMmptHdK/BK+885+5DvqrbARaGvfyxxaAc=;
        b=hwJi3WT1P1deUulCAyQYK2J8MGBxEsdXFi1/j3ZEjYjvq6kwT74fkbl6YEtVSvV9BL
         xvbwYzBaQMOqtxdFmf02cqa3PWl70S0ZFHByGcg0Yoqv1LLBNF2uXdtZoUX/n3efse4n
         +iB+6Z5mJYKfHVhj1iLzwZC3pQUfRfOeqZZMnH3tlww5VuyXNN/dlcP+jPEYXhacOFcU
         f4DSxMbpSwxPXhmGI3KycC5n1MmKs8nTVyh39Ijd3vISzLzX2knRDOt7LiWQVMMt2x4b
         RmPsv2vT6HsPwnufTLvrty9+glljJVfMl5WCUQsn51+PP3O13gZgu+wwC0CMH5CSseBW
         Lunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739725770; x=1740330570;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1xUJxwH9YMmptHdK/BK+885+5DvqrbARaGvfyxxaAc=;
        b=VpiY4K5jDyI6OyYrjuOm2ccPP4NnP2gqfkEze71Z4hbiacek9XdkfE3nkMJA2jJia4
         aGyILMvQ1l5/5JfPp6kgvDdwhamZpbs+8SxHAQUoN2aJP/HiNOGS1aBd3TC+HfKgaioH
         W0I/LuxyuJaxsZwrUKsc4iNa/cm8nBH9YBIgsIi5yeHIdS0lZPlf4V8yQ2apQg8yUBWq
         cX9SGV/AHC9x+3sr6s8Sy77VmRzv/NLuqQ/xk4a4gNeH4zreKeTbivsIMjFCjJfdqSxz
         bf5VgxL0XAZXKA5f+BIsHxhLjluwyOlvHOzVYtrmWndS692R6BWZ7bFmGObA7T3izE8w
         GscQ==
X-Gm-Message-State: AOJu0Yzo2ehBAPtqoDmMqb6oBIH82dYo+wESm+Rhgy8goq6K5GF705vY
	jHxHU5DNI8dlk91H/iz5wg5CldTLA7qi3SuvotQPyCyuauYwYGZDacSoFg==
X-Gm-Gg: ASbGncvtdzZsLksEoBF1LfknglXSAxwouiTPXQj1vM/o2F4LLl5hjv18c4DBykN2PUS
	NMJUqOqVmN0MJ7GZLvn0bpJxrAF34y8jKukenRZxb0d5pR/xq439lEmJPDQvQsAe8ga4ji2u1PW
	C1zOmkb2VAaQSEq5KyeOpWHPba5cG1TFr7Pnh2Q/CYWcomMHfKhyWPrAem3VgVQ3qBeNVj4Dmyd
	RIk+yVXYzX6Ccad8jF/6y9KgOqtIuq2MvLTFN8nV3CMmWEBE/jJ4wU3CsFdVAbH98zVg1iyUpcF
	vEE1CT0+dDqF62CgO7YB4s0G
X-Google-Smtp-Source: AGHT+IGsFYllmd8V6MoV+NK/4OiY3O9BYV9pzpruJ0LKp2ta9+1fBDaI4hnzyFgVCc9F12rxVpBABA==
X-Received: by 2002:a05:620a:17a4:b0:7c0:8720:5fbd with SMTP id af79cd13be357-7c08aab44aamr1064693685a.52.1739725769293;
        Sun, 16 Feb 2025 09:09:29 -0800 (PST)
Received: from [172.17.0.2] ([172.183.133.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c861b71sm440883585a.70.2025.02.16.09.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 09:09:28 -0800 (PST)
Message-ID: <67b21bc8.050a0220.3c04ac.ef6e@mx.google.com>
Date: Sun, 16 Feb 2025 09:09:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6014314878166651518=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/vcp: fix setting volume back to current value
In-Reply-To: <11cdbf4619d9eda9cd40c84728a2f5cc87d42d2e.1739720857.git.pav@iki.fi>
References: <11cdbf4619d9eda9cd40c84728a2f5cc87d42d2e.1739720857.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6014314878166651518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=934417

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      1421.94 seconds
MakeCheck                     PASS      12.89 seconds
MakeDistcheck                 PASS      157.70 seconds
CheckValgrind                 PASS      213.80 seconds
CheckSmatch                   PASS      284.91 seconds
bluezmakeextell               PASS      97.26 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      861.49 seconds

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


--===============6014314878166651518==--
