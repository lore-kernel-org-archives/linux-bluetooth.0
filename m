Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710466FD3
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151385; cv=none; b=l9x8epSe5VbStQtao/5f6WCv6i8Gb9IpUkQ0V2gl8TYTAJYG1KcyEzpVLX2Yp0QZngGOs7uRQEpg0X6jtmY9ECniYcmiDDOtiA9ia7rteZZpf3L9WDNl6QlSeHzT5dKuxReGoY2Crt9E8BardPjZ6i/XvPlA+OeTfbtvIurIr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151385; c=relaxed/simple;
	bh=nFiG4lAI9L74D2jgLeYXLcfu/ygeiRzAsy2ukzgZv9k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iPZKWq1sR9CiX2isWDtNKL6Es1VQIKkQUYXBFL/oJN4bKFX3scCpk2051KxOAv4OF0dNMA3VbxdqVlDkswSxKo/1Gnve2/b+nD5Wa/DIPX3YWJVDk+u4b/xVzphy9JAw0/aStqpn+BJUjs4mu/Dw9KZMjk2ZiFZKXt9IRiiIEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQieuyN6; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQieuyN6"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22edbef3b4eso861895fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714151383; x=1714756183; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue5U7VNEVtm6PZTA85ffMyShJl41mw3qoIi2FdQJo2s=;
        b=bQieuyN6IINaMjUVe5x92StFZGKqSRB/h2ZYKLT4wPpwODmIVpUBiGX7xQyMnKb8OP
         LLRwmhDPeyhqXxlJNgBlH0CJozJL0Jg7GRvr3x7JM5ak4m2VhLQaHf78nQmNJHmB8lTk
         slpqrL85jEsQG01J7HOyzfg5EQPcoO9O9v1QZZWNjIwZ1ZwmwjA0NEfHGrdCBy0ywzQN
         41ZLPGdWqAbbsZuq9AZinvJaxC9B7fSky6cm2QqKMrXmues9xd3bEoUR78UinJ4NFpWF
         KKTiIBBhZRAYMGG78z3LZm/v7gRTnf1lRx/3i4AZVvUOPzOknIfXdEdKForKMPmWHWJx
         EACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714151383; x=1714756183;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ue5U7VNEVtm6PZTA85ffMyShJl41mw3qoIi2FdQJo2s=;
        b=YMPzc+LQ0ptZd298a66th4wujQM/vekT55kKPFiGVDLS/S66wtNJSumsmzyyKH3Psx
         FcDpNOdEqfqMfK9QVorvV9MVL0yoiP/wSu7jRB+t5ScAnO2ijDBxEhnwqM2DtjF/ia6M
         n6ZRCC5T/SJ2r8WkOjzXrpj7AihhH2JyE50OeAzVjlnaP9bMP7gxKQHWkvMKOpWyzqu4
         n8Tx9l0kuY66zZtTUW/TxUWGw9Dqg2llCZGpkm76jxB+D3xb2JOQdkUGc+vl22YUanlI
         xW0jlcyslMVNpcrWNu6pm/gAPyJ+DbisZmEZP4t6z7ChN71NTQ1snNicSBbAC9g4ygWR
         GCHw==
X-Gm-Message-State: AOJu0Yz/xfi7O4fs6RSRkhLFnxaReXYrv0cKTjHQloEGwAgpr5hX1WOf
	h9Q2QOz1T95jsFoHU57lWSGScfIlXfYzps/rBTtWDauyHjAr3UU5T9KqCw==
X-Google-Smtp-Source: AGHT+IH2PLxzVbz9qgCQ/fNPeLGWCh60AkdFvwpdSvsuv4okvLOjQJIklhZHMnzjkKmu/QWImB5TJw==
X-Received: by 2002:a05:6870:82a0:b0:22a:1ce4:c0cf with SMTP id q32-20020a05687082a000b0022a1ce4c0cfmr3677310oae.55.1714151383366;
        Fri, 26 Apr 2024 10:09:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.191.34])
        by smtp.gmail.com with ESMTPSA id vv4-20020a05620a562400b0078d66c78d43sm8118508qkn.44.2024.04.26.10.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:09:43 -0700 (PDT)
Message-ID: <662bdfd7.050a0220.f9cef.a941@mx.google.com>
Date: Fri, 26 Apr 2024 10:09:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3013596306158418982=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] org.bluez.Gatt: Add org.bluez.Error.ImproperlyConfigured error to WriteValue
In-Reply-To: <20240426144826.2608852-1-luiz.dentz@gmail.com>
References: <20240426144826.2608852-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3013596306158418982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=848285

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       FAIL      0.82 seconds
BuildEll                      PASS      28.35 seconds
BluezMake                     PASS      1800.99 seconds
MakeCheck                     PASS      13.23 seconds
MakeDistcheck                 PASS      183.76 seconds
CheckValgrind                 PASS      253.94 seconds
CheckSmatch                   PASS      357.66 seconds
bluezmakeextell               PASS      122.10 seconds
IncrementalBuild              PASS      3066.12 seconds
ScanBuild                     PASS      1025.88 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] org.bluez.Gatt: Add org.bluez.Error.ImproperlyConfigured error to WriteValue

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (91>80): "[BlueZ,v1,1/2] org.bluez.Gatt: Add org.bluez.Error.ImproperlyConfigured error to WriteValue"
[BlueZ,v1,2/2] gatt-database: Implement support to org.bluez.Error.ImproperlyConfigured

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[BlueZ,v1,2/2] gatt-database: Implement support to org.bluez.Error.ImproperlyConfigured"


---
Regards,
Linux Bluetooth


--===============3013596306158418982==--
