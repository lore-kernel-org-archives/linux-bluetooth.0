Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840172D7DCC
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352861; cv=none; b=DzlL1y/bjRY0Js4P2DUC/huXNGJ31S39z3W9yXrSDeckCsiAJvGvYILQZXHwd4iMHagOI4+DBwW1MKRQhzwisbX9su83gRBJcyML0N3IvR3zmXY4DBIzyY6uNAJvmN01r6GEtfh9KKJCmNZPtQngKOSxQnfApEfiHfAK+2zUyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352861; c=relaxed/simple;
	bh=BsCav5toCvRokZfLTOxTaxIGB4lRl5PIcNhPFr7vVb4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rdZ2dKQvfh21d3w7WGd/HVzaCJKZ2kSAn+j6dmA+vc3nsaNdWhj/5AaOtBhfSFBQnnlqnd4ZrVE9rA17tAArH8jm3wzsvkHfxRTbczXRp4mm1SNy7svTs96TCRCuY1oU0UB9Ko7tLntxffyAGE77lJ7hY2py32CriL59qvsC3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UismCsjs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UismCsjs"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78af743c232so406606b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Oct 2025 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759352858; x=1759957658; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zHkqmDqmsvrsFQya+zVqEhz12ulY86/WaR9kH6OIkLM=;
        b=UismCsjsyXNa0VuEVNkJdM8ly1JOWE5oU3ODLbxY+OnYxEJtpcX8v4+5E89KyMdEWp
         A+sdhnGekxzv+I+MAuMmLRIx3rueuFk6eNYcrnPy2ZWUdXL9g0yvXkcZxCPma8iE9PuP
         geHiO3sSTf/mTWe40XNqKjcwAmkw7r/cdD9YBxy6Zi1uTMwYCEb1rlSotnqmj7PYwBLu
         S4I7FlQLoRdOPKJdc7VqlfeifqG9Y59X200HSDfGBvSfpgC5QzsX0QP8+92gIlOsIjO9
         Exfdr4nTnvwy/5Aj5XMd8aylbaDxD7qXxMkx/5Py1eVwYIhuDHONmu0qZf1SKwqoBjOp
         8HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352858; x=1759957658;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHkqmDqmsvrsFQya+zVqEhz12ulY86/WaR9kH6OIkLM=;
        b=Ewb0aKPAio2XR6oMSYIsCkb1MfdtMNbHj3E3syqxeyBfVYZ2Pc0KAzsyVMvR/CXw4O
         oMWOME2Ikj8nfJRfIpqXkeO0ktXizixLIQ2R9VrjUmlHYvtbY4c4LBFZRAvPzNytxomR
         /gBb1sTVIz1rUsOzusQeo+LhK787MUOA6ypT+qzwYBSAM8rxwYQnagS+MK5zaajeceUx
         XqjUnmBgJvC/JrKzfd5H+04oBvjJvCx2L5zLjDYn0GoLQPn3pnfj88wcYs31r9uDnPY1
         CPJyh9UbRCVuod994ILAwoQjCkn9rzMI3WISp4BMp2bylnZgllGUyqBrJWRtK0Soo6n6
         PMnw==
X-Gm-Message-State: AOJu0YxilrQO4L6dyATex6SwlaY8xh/XeZE25oeHHTA/TEikhFR+X6we
	XeBhrpSM4CtcnNf6g1py4CuLH4NGwIvCRkkRtqq8/9ysKs6q1lH+wrzVt8SZ5w==
X-Gm-Gg: ASbGncuK/UiFV8XZw5w9mTvWAakFS8EhQ1KoBsDMX1bsEp5rvALT1WCnf94YC4OPVSq
	k+SG6jHGmYaJrEJAs00uNePxY7IEfKR7yyXQu8r9hFrMBeYy2ny8C1TY9pi2Nt/b00CEJmSe/zs
	9uzwhY92oUVgDxWhqyWa8iv3RO8kpoTAMregBkUkEldDidOI2gwb+BsnsFkBL/af1AnMkRHjShy
	IGfrVKTqfcNKeklQbU0RxEKVmSj0PPjG+vrM/gfNbm8hq6hwGaojy90GePTmf9Fu+ADUPWXnwbm
	wGFNOmHiYREJWTlOWB4Hta4NQv81asuXuPr1VUBbiue78Io2Gcks2rE2te/8S64x5elsGTMR1MT
	rlAqDqSaXqCx2JkOwP0/kQODkAvkSjnUErx/DB+nLY4rx9c/Jo5VcENpLLCW9Kg==
X-Google-Smtp-Source: AGHT+IF/UQyiqlQFOa+53LQBviG4ObgVMSTx/02sO2XJIfTGRt8YlltNMKTlAlYhEpB62fpxDLcPsw==
X-Received: by 2002:a17:902:d58f:b0:25c:4b44:1f30 with SMTP id d9443c01a7336-28e7f315aa0mr62576785ad.45.1759352858305;
        Wed, 01 Oct 2025 14:07:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.41.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1dc00esm5085565ad.117.2025.10.01.14.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 14:07:37 -0700 (PDT)
Message-ID: <68dd9819.170a0220.bd212.2ffa@mx.google.com>
Date: Wed, 01 Oct 2025 14:07:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2210860527756770963=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] lib: Fix headers that are used to interface with kernel syscalls
In-Reply-To: <20251001194049.86963-1-luiz.dentz@gmail.com>
References: <20251001194049.86963-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2210860527756770963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1007812

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      2874.26 seconds
MakeCheck                     PASS      20.44 seconds
MakeDistcheck                 PASS      191.88 seconds
CheckValgrind                 PASS      243.10 seconds
CheckSmatch                   PASS      318.49 seconds
bluezmakeextell               PASS      134.05 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      954.14 seconds

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


--===============2210860527756770963==--
