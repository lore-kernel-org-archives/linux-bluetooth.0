Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42098483803
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558748; cv=none; b=EDxsqVTCYjWaNVN3wguV6QaeG+xeDhnuOqMc8lM6ms7GIM2vIn3tg+o0GPHV7RsD83NYEfyopOB965rZyh50htnY6vbCrnnXwnmBePyzuKvDhosUGNwOHoNjEFXx5qjS1ESijzIgo2hoZ4UK0+Aw1Y6oS21ePcPVzhvTgI7IAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558748; c=relaxed/simple;
	bh=FE7n097I4a4D4Y9YRGqfKvVya7ksgf7BH51tuefZ/ug=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m4GxVtCQU3MUqTs2/8uLZh3b6+jwa89FJMylasFqZXz9PFBci2qnTmBunyW1blGHjJETD1ZJhbKYy/dKm7QOGrczBujmqYZ7LTc+qcxRdyb9rLNhxBqmaEOVF2gxMmoAE3eSk9eJRF3UQXsOqDe//oEVNLDhWEyg+VlveHtdi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPJq4Kna; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPJq4Kna"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so8451456d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786558745; x=1787163545; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U33OWmLXRyB/86wRHHN9oA2idm59EE2kB2RV5Naf1GI=;
        b=gPJq4Knal1lO1NxfG0+JaJP9Y968A9K9RnCCAi6ZY0OUU14HiJ+UHlQGmDwtX8HoTh
         YV41TNiUZ7q3FGBtfHx8voC1ViVvrkdP/YsZh7vMnsqBeFOLeJP2SEd90lvbIZBHPns3
         1XfD5tV/76X0jjPXPu5I9XtCVxI6wsSVohAW0CO0IBt436VJ7/KgysrCwkzSm/R/OW2D
         igKYSfkfYKgPjuRYQpQMWL/GswCOv0QESBO/8uus/JkAM/z1GjJOdJILx8hEzMcve8oY
         gDre2hHK1yKpSPYi3XfxLpDKB45M7pbO8DmIpQvaPhmvKMyd4h6pcWz0gxwyqxwW7NTg
         89Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786558745; x=1787163545;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U33OWmLXRyB/86wRHHN9oA2idm59EE2kB2RV5Naf1GI=;
        b=VaZQ61rq8g2KUPfE4Qc2045JAD4Fcw4VW1qX4YfOH1wU5cg6CRcftGofLNGimt6tbz
         a5lgXnMpQ+/NQV/G2PzfQhvL9axweDgJVNfodCpyQeeYJ1Ypje0S7msAhxZxTGF5Vxpp
         x6VyEXwHFWu8dXYh53kUNNcwjDmoPcH5f+HSk2fE22q1yYCTUI51N0NfFKLc98D5wPLC
         cofud3HB0WNC9G8ngrAwdMCaC66F/5t1shVB6vvN0dDiQNuDjkErF5uqmFiWjudMIece
         Nvf2iX4S4EfW2i1XIkqPK8S3T12ApXcoFPTF2AfAPIlcp8RfIC42lD8KArXao6RuCpzI
         oGiQ==
X-Gm-Message-State: AOJu0YxNw9jt84xYHXOeOIaI+PvD8/F4FQP+YLGd2vie/CCq7PfZJTNH
	tMoqQ04qjMP2XlgaAsQmMU3/1xquDK2Pmlomdnln468cqNOK/+N9MAiHrYIg8A==
X-Gm-Gg: AR+sD10DJSLKnrQOQiPL0kjJfYvRA4aqwfChuzOkrE6bBotGhGwxnJ6/o/7scYmmeaW
	LWs92Z/B+VBBRRzngCuiVwdE+1A+eVOnV0Ve8RspjWb0oQi38+P6tNIU5akOT4phJXp39yQutar
	itYb/OphFai7B5UBBKOq9ktGbMFsfkdyABhry+FQK6ocluURh8jiiT2Lm+w6KRjtoroXgI58K7p
	1da5MChIn9AfcZa0/lvzVDWTAIBlYBEQVXaU4D1OmyqFHgqfLugrSH54B4ecOfEKtuwTCKhQXFe
	mS5NnGMHW/lcUKYMlmVHD/CnJgAPSVVmzk/nRZ0zMHLN+6ZcSQTOuTOC271bUAChmeGixsA9F1L
	mmVKWn0fc/YDnQqAqWQikoHdqBLAO0BFReTEtTE2Op77Q55HZ4Ee83zaHrDX13N12zrv+LVFub/
	BNHg830XhbMIg2bGAe7Fk6LCRf0RuxZ2yRewxGtEZmOCrEYY7t32c+Nud3A5oY6gU=
X-Received: by 2002:a05:6214:5c49:b0:8f0:4e44:79e0 with SMTP id 6a1803df08f44-90a6ff0f086mr68787606d6.1.1786558744783;
        Wed, 12 Aug 2026 11:19:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.15.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c2b30c5sm26776996d6.19.2026.08.12.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:19:04 -0700 (PDT)
Message-ID: <6a7cb918.362730bf.1234f3.1cc6@mx.google.com>
Date: Wed, 12 Aug 2026 11:19:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1920277043123661198=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: Bluetooth: btintel: validate version TLV value lengths
In-Reply-To: <20260812171434.82729-1-acharyalaxman8848@gmail.com>
References: <20260812171434.82729-1-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1920277043123661198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1144884

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.58 seconds
VerifySignedoff               PASS      1.05 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.24 seconds
CheckAllWarning               PASS      30.08 seconds
CheckSparse                   PASS      30.36 seconds
BuildKernel32                 PASS      26.78 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      474.44 seconds
IncrementalBuild              PASS      26.19 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/574

---
Regards,
Linux Bluetooth


--===============1920277043123661198==--
