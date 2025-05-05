Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805AC801
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478241; cv=none; b=tlU3EOKrPJ1MgwV+oq8kSnGXqYbHusMmRdvVrQBh6ur/mGu1ZDACyn+Xu6KzDp/srLnSy8/BkwkgpjLpP7LLIeZ3+13eiDib29+GGA5nen+paMkZtLLGEwjCxJCMElwnXjCdZP3hAU3jSDH6uf3lMHFdZC0ycoBSIAOvQYZigsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478241; c=relaxed/simple;
	bh=nRZWbQ1i7iB4tD2+lZSVtnsMWICtGSICoNS1oSmpG4Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TlEmMjhVFsq76p1gc5djBib5SRqVE4AXOiWuZBSU6vDH8C3+pQSJGLK8UJLoNk/39NDQNDtHgllG6ku/My6xlq81wHLVVufGcjAcSWfIMB7iXYlWMn0BVMIVed45xW3iPyskxLNDc9f3MigQMCSYrz1NmDUdt7fjRAKFmayHTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZnU8+x1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZnU8+x1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223fb0f619dso58418005ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 May 2025 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746478239; x=1747083039; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7u7nfXf5zg2IH0XFRphR74ED2F+l87Muab8QV0Oatyo=;
        b=BZnU8+x1eXJiRscy8OOwWfpDr79TnfAi8QZSVGkkuwGr+SkN8PkDm603P7H8UVZZfT
         k21eS8Kezh7lKnKDk0G7Ke/tLLKqEQF2gFgLm0+lwvdx96nHdO1gnfUcuOQymUS2YbbT
         jUMl6qTq7e4AyU0XKHfSaktfpJFnGtjL+ssYUPTynds+WDdjrleO1kxB1hb3QsKYmqOf
         yF+jdyUBiYQLBrbDyfdZT0KNMcAtGLrRdLWkv4jHxDlWSl+RcxJYwG/45wl3rF0RHICl
         YVtdr37MAv9sNkwCc2S8ZPCvrugdsmoWE8mMP1DD4vPEw/n/2DZxGGsPObIeJpQLXdQT
         RUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746478239; x=1747083039;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7u7nfXf5zg2IH0XFRphR74ED2F+l87Muab8QV0Oatyo=;
        b=R7jnG1so4iDrPWXJa/x7l2pUAYISo4JIySgjuoFqpsQ8u1rRM6X5oiZ78B2iCG7yCz
         IHK0bu6d1jvEH8y+PBvhVYH67JI/aOPoDKrovygUy7i70IGwUbartNJtt5+LmRj6TgMN
         /0sRQiVq70B4cbbZalSeXUHQmCztwPn7owpXFOfmgYzMwLv4slL+Q/3kgWQsWOY46VaV
         cQiz3Pb0Y0RDrtFnmd3fK0liFTbV2CWbxo7zelam34NAoTfkGlhUeONkVFMSSLy0foLd
         69JOJkegItdBp4Q9NhsepkJv3e6UhVZ2BVhM7TBYM4JggjqPjUmlgQWPcJAxIfbSfRpS
         /5dQ==
X-Gm-Message-State: AOJu0YzfPnVWqn04unPzVFu7ZYLmKhQaMDsswEva9XP6Qs6ReXw5e5Jj
	mbOXDZk/Oy1vSbNew5w/1EgV/fbxXrlp3HSQkwS0Mh/NlYgyg/MzftsSTg==
X-Gm-Gg: ASbGncvyHDhpX3yNgmz3gzrW+tvZWsLpEYLA75wza0txEJYyRuX765PlvSHZRgiIpyn
	wH8nAgTtRocpMV2aVXBl5vasxhngLGKkN9UTBMxmocO8DK+y5lBOQNH6FeOnbjwwqii9Hn4rjv3
	M8cFt+fVcXjMDmJg6pcNK554BbMfcidstCpi3RmEzfjJ9/fNzi89magPOoHjx0QXOYVuf0tcHEl
	vpSvF2JC1NE6By5D5cwAxURoufajfXR0NNLHxH0rIQ7jzvF6G4OYVmiGTFzbQDscJCvTqBjKQea
	fj45iVwEe4kFyL1UwEEk97QhSYjGvhrOlWzLUI7ZynYsraSrLgNxlwwl
X-Google-Smtp-Source: AGHT+IHzTpbDlBew031hO46MwvYQ+OmUnCQhWLWgd44ULx6GdQ11y/QWcjTxl5r/8DTQrkB1ElR9OA==
X-Received: by 2002:a17:903:17c3:b0:223:26da:4b8e with SMTP id d9443c01a7336-22e102b8506mr212264655ad.4.1746478239471;
        Mon, 05 May 2025 13:50:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.14.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229474sm59684385ad.184.2025.05.05.13.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 13:50:39 -0700 (PDT)
Message-ID: <6819249f.170a0220.24b086.9e90@mx.google.com>
Date: Mon, 05 May 2025 13:50:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2027604784046174176=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Fix handling of ASCS_Codec_Config
In-Reply-To: <20250505192336.3191098-1-luiz.dentz@gmail.com>
References: <20250505192336.3191098-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2027604784046174176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959755

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.70 seconds
BluezMake                     PASS      2872.27 seconds
MakeCheck                     PASS      20.90 seconds
MakeDistcheck                 PASS      205.69 seconds
CheckValgrind                 PASS      284.64 seconds
CheckSmatch                   WARNING   310.23 seconds
bluezmakeextell               PASS      132.14 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      939.96 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2027604784046174176==--
