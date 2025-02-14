Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081684037
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520437; cv=none; b=CDIz/HSN12t7PrznUUqagpAYWtAxJWY5c2IX+iPRSw3960SUtyZk1ilEVt1qMr5EqPjoJrJhr9XBXgXFY+e2uH0XkbAIZtJNfcxHzPfpRbUEgslAl0yR+qH+43dJnKVsOXWrDSnOm9GGAEYa/UJ1Qs/MoFN8EV7iBiYsEllDJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520437; c=relaxed/simple;
	bh=6V2NcHjLuypjJMOjNdbsN8U+HI4iOq46wmB5BFcCF4Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QxCspKSo8ZGaNJFrg4SIHKeIqegmIKkk6bMjy5l+/YvDCXrrtacoVYK+fTV61gWznUDc/wK3nUL9uRfjcgdpF88ilOLSWQqDeOEAloKspJ9LklVocZvzABN9m69HBZro77XPj51KGE0WSxVtC2OJcO+1WsoZGDiFyHVvQGPYi2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFVGXIOJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFVGXIOJ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471c8bdabcfso10570291cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 00:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739520434; x=1740125234; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LRoaPK/IS7EfSTlZ/ejTJwNRpg+KOz9Vv45kapMGGUE=;
        b=GFVGXIOJ7uS97GfLW/b2KSRTA48fjtgcvuZ99XvAE41YVh8jl/wG9oarkyiGT/I2fi
         5wo0nT5bxEDP9wlKYUbFHwyMkD3KGGLQFL9DmAIqEAMt9gIlAn2vq0Mctm9Jl1a2YKwp
         URhlkVbm9QAZjD/s+nR7b++EJTTgJMyt3EuHTVkcNlu9vNrEo5jJTHlr0dt+gdzUD3Y/
         LvXW0sdUarDX+ZN0IdlGV1rYUFDSLQE4dN3cydO8RIBH1qkni3s/qM9o63CHvNqCZmuB
         q11R0KkrFjW6/xTmrNw11UtjfEladlqiVAsQcxBPDexOCyW+ugd95H4GORXy/5O5v9a6
         adbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739520434; x=1740125234;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRoaPK/IS7EfSTlZ/ejTJwNRpg+KOz9Vv45kapMGGUE=;
        b=O5GHh5KJD/jKoQ6lC1GMo7hoHPcPjmQiUuAFP/RYhHXsSGjDdGXSfjbqtLincisc/q
         a4UGzNFVAdFAesz7vjbN04f/Z3X3krD2bKvhJVtVf1JDmURqVlV+XdpOvARQJLDLAQEI
         LwY1VVU8BAK6YxrjKcinzUWUVJV22ccoyj9xBuFBXfjQG3GyYe+bBfn4FcPnyBxKS+BL
         4RmisPwOanSpMGP632hz9M0xZI2s/62NxM67qckgkvomPnismbTuk6OeXdNJvUDhkoP3
         TW4iVMPwSQ+6Fk6J1A/xb9qD8Ay+TbAgTs1JCt3PO1S9+FOPgR56QGli44BUjtXZQmvv
         37aw==
X-Gm-Message-State: AOJu0YyN3tOBYPQ882O552jAewVkcimpGzyGgvyZhEsyEP1tMgEg5KQF
	hF0C/5HyEhpkLQCUeO6OB3oCw4M2ABjQVdjw9HMaCRlaGMqjujRT0ILnsQ==
X-Gm-Gg: ASbGncu98PZV+dkztKKqyn3abCbn5CpcMQGMe9t5dXKnyPNJvkg6muOyhcza1b5eirZ
	H4ahB3GA+JljqhAuJX8S1QoK1uphvu7aNClAIOAaOh6Pzato+XFWTz3U6hNp3H6pc+QYpiOFMmA
	W04IOuKyrvK0oK8A/y2C2fwbst9DTlxXIGJl0cerfEfXI3cGWpkKr881bKW9SF5Goz5QitROxmP
	DO0d5bA0icwpv1oluaiDVMaDzi0SxZn0eh62h52QXr0wALHOa1qqpwtw6qvmAvg6LAlxQYLQh3G
	bD5IeVv2TPJ8DB/aLwU=
X-Google-Smtp-Source: AGHT+IGJSMtXXWjBWWGxScQLKsGveHR40VIQ0OGrbCEJ5jALKBYdB+dSjwJ/k9f9f869BblMuO56lQ==
X-Received: by 2002:a05:6214:2128:b0:6e5:a0fc:f65f with SMTP id 6a1803df08f44-6e65bf45a97mr111831026d6.21.1739520433734;
        Fri, 14 Feb 2025 00:07:13 -0800 (PST)
Received: from [172.17.0.2] ([20.57.79.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77923bsm18742876d6.6.2025.02.14.00.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 00:07:13 -0800 (PST)
Message-ID: <67aef9b1.0c0a0220.172de2.63af@mx.google.com>
Date: Fri, 14 Feb 2025 00:07:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0360552097725252079=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] test-runner: Allow to use host CPU on demand
In-Reply-To: <20250214064527.159950-1-arkadiusz.bokowy@gmail.com>
References: <20250214064527.159950-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0360552097725252079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933899

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.38 seconds
BluezMake                     PASS      1430.06 seconds
MakeCheck                     PASS      13.97 seconds
MakeDistcheck                 PASS      157.46 seconds
CheckValgrind                 PASS      213.31 seconds
CheckSmatch                   PASS      282.48 seconds
bluezmakeextell               PASS      97.54 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      859.92 seconds

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


--===============0360552097725252079==--
