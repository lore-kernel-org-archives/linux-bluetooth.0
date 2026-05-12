Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6537CD53
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621003; cv=none; b=NDJsZU4VGIfcWLsGqrolve6DtmCri50zrZKWpiddqWgD9SVbM45u3+gAzWWbq8x0SwYKWcrASrjHnFm9NsYA3Dfrcbygga+nil5A5cszZ/JVX/NjAksbT6pyXtqf4CZ8dSNWhL+QEwkSe0r4F0XOmmZ3kjx4EdsAW+7KHrM5aEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621003; c=relaxed/simple;
	bh=NNGKIz0NQOCCAjnN2uxGJ26WQpBDveGwFOAabhxRfNs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dvIhXJw/UF0HPw0YoRHBfpgHlkFfMvMkY0UXhebodrdL79vAfUGWN4vcAaImWFJgfW4jQpMSDWQ9t6YPIh5pcwlmoTMOZSbtQsCXa7ieLprEZY/94WDTZ1kOADArgFS74QQ5kyj4V9jdfY0gHvAkevjrlYvkjrP42AefRzLdF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtvLZmKC; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtvLZmKC"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso4374613eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621001; x=1779225801; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MYvg6PGntFkWxwojor+Adw0/39rDBv8fQvV/vtTwBpM=;
        b=HtvLZmKCOzkAXKDwB9W3feL2sLdkKvUWIW9EfA405W9HDIn2YdiykT2Cz5gK643eoj
         ZOBRvqAuR4OSV//sw5MFN2l2vWFNeIS+roDkp+4SDor2oqeqtMLeodZd+z6Wzc/70CiJ
         muTvoD/qtFHcLRE37ijMJ3tv8noR7F/WyAyEaJaobrU7bux8MhA6Sk9vL8gqutt7lJzj
         IeF2vhymrEKt3KG3qSkuMJYdtvDtAzL8XeL8LQYC9leIw1gH23br85a82Jrsovtt9qfB
         hviKLOXm73dscgTIkkogLA7JdRXcRQCYfFij1lem+CPgp6+/bbdeCdKvxoz6+0o40jP0
         LR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621001; x=1779225801;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYvg6PGntFkWxwojor+Adw0/39rDBv8fQvV/vtTwBpM=;
        b=RYbOp/I0lgjVORK2hn/ojGl7R77hETYu40skuNLCe8ukhjhuZUtEY4SpWrmxBO0RmL
         7z1VUGrz6pNG6MOZ3X5e8QbBVMDYzHUB5EkHEtMnlj3Al7mARJM3sa4toiU1TsT+w/X4
         cKxRqJFsmPe7leq5OIHN6ewRpO/h/GkxLnXY9nF0gdXwuHsdGn4SOkqma1MNxc/HftPG
         UG6B7naxF92aSqhOZBZT+hzfGhnGhLsYNH1x/ChEtYvWl5vAImz3KFLloFSSmdfoWmPW
         cDHa4WZt5Yi8UanfMlgkWjrzNCJd1Yqyk4KgTuc1ymqUq80/Hj8LG3AwZEaZ3yoy8HRN
         btHw==
X-Gm-Message-State: AOJu0YzKxo8z2nZXzSfshjasKCmzXDTT0sbjWc6l8D114XUsPScKsnkd
	THKwgNVzOp/r5Fz8Eoq4zOG6fjCELQbVDdiDcSdbBMnHkpAC3Souy7wf9a/WFg==
X-Gm-Gg: Acq92OE/oiAYovARgPpXurBlQW7rYfdZrsjMFPuvFskAlQCO8PDW9hLvKeeLUdggbMf
	XKIAt+JxwAj0yCM0xGhy7fPoO2I0V7SNm8fsKn4nZNzwQ1QVu2ZWzB4y/JIXBUgTRG5Sc+8b3HW
	e0AsPYVCirwMVoeOZijwtgVIjY2/MuvT4ovrBcSrZgv/wEvPc0/d5Gg35iPtGoT9Y/LnpoASOXY
	0a8L+bNMKgSLebXgwDWfDei/t79dYsyiMhyQU7rf4MFNQqR5pLxaeILBTejuNAuqtrp9C2bugi5
	s4KFSQcefuE3oZ9ntEnRdvXxSWJM+LgtEHtHmELE0I+BCepjPu7sKjGiNYh7SNebEa9M4x54czc
	XLwWdkm3tfqvoZm7SGL9BTjQmLRt+RScL1G+207Pkqj2A24bfgFLUDjN4LMVxWNwCHJqX+4A7y3
	Q83ZYTAPTp1qu7cGXvqEBt69GzIsg=
X-Received: by 2002:a05:7300:3212:b0:2f3:b7b2:cbd3 with SMTP id 5a478bee46e88-301174808fbmr447000eec.5.1778621001363;
        Tue, 12 May 2026 14:23:21 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.42.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafc2sm24610244eec.4.2026.05.12.14.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:23:20 -0700 (PDT)
Message-ID: <6a039a48.050a0220.11fbaa.7675@mx.google.com>
Date: Tue, 12 May 2026 14:23:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3157746752124520596=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jannh@google.com
Subject: RE: Bluetooth: bnep: Fix UAF read of dev->name
In-Reply-To: <20260512-bnep-add-uaf-v1-1-f62ff8f61d50@google.com>
References: <20260512-bnep-add-uaf-v1-1-f62ff8f61d50@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3157746752124520596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093767

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       FAIL      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.75 seconds
CheckAllWarning               PASS      29.78 seconds
CheckSparse                   PASS      27.99 seconds
BuildKernel32                 PASS      26.10 seconds
TestRunnerSetup               PASS      579.08 seconds
TestRunner_bnep-tester        PASS      19.09 seconds
IncrementalBuild              PASS      24.48 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: bnep: Fix UAF read of dev->name

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
27: B2 Line has trailing whitespace: "--  "


https://github.com/bluez/bluetooth-next/pull/179

---
Regards,
Linux Bluetooth


--===============3157746752124520596==--
