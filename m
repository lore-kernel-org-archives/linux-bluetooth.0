Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154E5256
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707265743; cv=none; b=eb3Ve8l00vVDXH5g+VrEzWSSetWWNUzPvAdjQiBvOzBeUMFTUWzYhorlq+QnLIb3UzdVsb2v7I23A8y3L/v+Hp+n+DrYdGsUt23VGYl5US1Cj5Wj/gjR3QJyvIHixwEMQ1IFLm+5CzuU6LCevtgc9zKJ0czQSJkU2aWu2KXMRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707265743; c=relaxed/simple;
	bh=GKivdibf01cDxEgwB8MCA0cnQFTHFQAnY0laQw9juQc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L6GqI77T4r8lTAPEw30h5vDwkBJCNa3DmhsjNhfNJ2o5v9MUZX4qrfZrdBLbWTr35c8dDhKmeiD/WZDlsKLw3KWWltKaABWEjq2TSqN+nPYwC/oq6hCm2MNJbOhVEv2dTjAciQdLfmYnQxVeW/kwhlw4e8+vCXsdOYt9VxILZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+3wQDBI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+3wQDBI"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so52738a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Feb 2024 16:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707265741; x=1707870541; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+mC5qS8ND0q7AMpfsYE7PGKmihjlKy+TlqR9uSXcoPk=;
        b=i+3wQDBItNLSI5f+iQCRNo0TdPiXfcpuvtA5r5F5w67GMXdtkaZMByl6mEP8LXZMRM
         1ZwY6HIP3vRk9/xEuvexx3YmuQFtmrhi79goeSuKk+RtFQQGDRy+zvZplmMs9M98tsBJ
         XcxVx/wLfKKS8ZXxfPkHRgXAriZNuqs49cdmzMPvnUrlRkkB5SIRKdmqsQgTbiktHdn6
         5PhPiPnnNXa5PtOUeWe0KZRUogUsu4b7f4i8wJpph7O1jHcr2Tj5lCZP7C/sblH5UWeZ
         q3qJYjqWf33ChPDzeK+QOw7Qc9fBrvnnc1l/h1AKAUbwvCMU6ALbQGopBxxFeWdY/Awl
         cT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707265741; x=1707870541;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mC5qS8ND0q7AMpfsYE7PGKmihjlKy+TlqR9uSXcoPk=;
        b=r8JGhhpWLlZl65WpHPKKbDD1pp3UyDzM0jlxOoEClLQ6ft3bpmRWBVAknrEHT3f8W5
         oJo/Wh3eZ1777PRWGs8vUiR28ILlgSvDQ4qLj9iaimkW4FRurB/JW1kZm9FQVzMnWODA
         cNvlid0gq5AsC6Fi9h/V9/EXWdGe8rmC8MGUpP9teNuuBgHz8un285OZpMtwVL20U6sB
         EiRCVMqIyz2YwnO+iAAH8+4FYxWnW4779EmaR/GcZpWulAU/cQWZUhxUs8lcQpIbypiP
         6R2hearauH4txb9PcosXU9ubo6ly3Y4lhBCFAm9OlfUrNhN/xWf8WoPDt3Q18ImCp3RN
         1IhQ==
X-Gm-Message-State: AOJu0YwKSqNTiQwBqzbdP0FEn5sgqgVBb30V0697/O/vARq7a6PqnyWq
	AV4WFNvkVqj2mlUvBRfkOgZb9UBl/J24VNs5Q3q8hb0f4pxDq9m2oj8S0+3J
X-Google-Smtp-Source: AGHT+IGYzYdNCkZhH7eRb8zLQq9SAatwewyFFjeTGRD4455LnsyeCKdUFUrEx3TS7kem6GgmTWY2Og==
X-Received: by 2002:a17:90a:3189:b0:296:9bc8:c16d with SMTP id j9-20020a17090a318900b002969bc8c16dmr1230371pjb.26.1707265740945;
        Tue, 06 Feb 2024 16:29:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDMtHskhRELzMpULiq7+NuJW1sq+pv5ij+yGu1/4sjv577RBzE7AUGK6jHXGsI8ZsLf9LGkIgQJMlWplK8Myh4dLWV4A==
Received: from [172.17.0.2] ([52.159.137.225])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090ac88500b0029681231ae1sm154411pjt.28.2024.02.06.16.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 16:29:00 -0800 (PST)
Message-ID: <65c2cecc.170a0220.c4977.0a5f@mx.google.com>
Date: Tue, 06 Feb 2024 16:29:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2129523119202357791=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/3] shared/bap: Rework stream procedures
In-Reply-To: <20240206223513.2783330-1-luiz.dentz@gmail.com>
References: <20240206223513.2783330-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2129523119202357791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=823751

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
GitLint                       FAIL      0.87 seconds
BuildEll                      PASS      24.31 seconds
BluezMake                     PASS      708.93 seconds
MakeCheck                     PASS      11.20 seconds
MakeDistcheck                 PASS      162.85 seconds
CheckValgrind                 PASS      226.06 seconds
CheckSmatch                   PASS      326.92 seconds
bluezmakeextell               PASS      106.50 seconds
IncrementalBuild              PASS      2009.42 seconds
ScanBuild                     WARNING   943.01 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,3/3] shared/bap: Make bt_bap_ref_safe check if the instance is attached

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v3,3/3] shared/bap: Make bt_bap_ref_safe check if the instance is attached"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:1132:2: warning: Use of memory after it is freed
        DBG(bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1145:2: warning: Use of memory after it is freed
        DBG(stream->bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1240:33: warning: Use of memory after it is freed
        for (entry = queue_get_entries(bap->state_cbs); entry;
                                       ^~~~~~~~~~~~~~
src/shared/bap.c:1698:3: warning: Use of memory after it is freed
                stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
4 warnings generated.



---
Regards,
Linux Bluetooth


--===============2129523119202357791==--
