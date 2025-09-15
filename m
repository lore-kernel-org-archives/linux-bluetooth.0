Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F330DEBB
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943571; cv=none; b=I8rzwF0+U5RClyYP2UhwOXqsqU59vVwpCBr3eHHc0JvgUXWLkftmAl26T4kcQAvuwmAKLlhQe+9WJa00FLRAPhNY4G0oB5P1e1yUPpm7Q+4OpXdFu9WuDPzSU52RMV3DsbADdfdOs3gbUXwDzhMPhtE48U8JC2fBB75XKjqclHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943571; c=relaxed/simple;
	bh=ZSLkIC3wjanNLhPephGBHLC5LJhA0e8sxIyc6RMkG3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=seAwm8DnqjOJayYRkqEbo7AlNi4pY3pJwRB7XfIJpEcIpn+1J9eD1l7xdnrMcFTpT5rmq61VgYKhNBSQ234ePZF2IRSb8sxOpGcHLksvwQKM9dPgx9++8LK/7Gi3ab0E9ihEWMokxypbtyGM6k6wRTQkz2cCFoUG9AFPns4vmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCLwNmGn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCLwNmGn"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-33730e1cda7so40127311fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943566; x=1758548366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5doNIPmgauFF/bd0hq5fZ2/f1nIDf33FJgA1y0oCb0=;
        b=cCLwNmGnVDP9ERAAX2GX/V5xeNeruqkXMiqkxloYiu/Zm1bSRF+5OCHzpZP7tiRYZe
         wbYWYAVnulGlKtOZYMYyWq9xs62HU/JHS2rI8Q5NjCW5O7vDxHwpOwvoTTHe8I7vLLmn
         2FlTtZ63vxXpcgF9Yawfaax7YgdKFjRar5/YpXdhSzLcOAVSyAAM9eMSuTnA1BANbSKq
         L8DgjpMcMn07snNN3trJzJAsF9yiJyRE4UPWBXKcNleMxIjPdofR/pd2vrV79T9OilUV
         5SuzmA9rAkCvxBnCD+JLkAYF1Bci864DsJbXHn9dJIG7gmb/Eu1ISkkNXOFfY8CfLbDA
         Go4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943566; x=1758548366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5doNIPmgauFF/bd0hq5fZ2/f1nIDf33FJgA1y0oCb0=;
        b=uBRIipgAC+SC3Ys4v3k4oWEpWGD5IXPc96zPQGCKfN6I6BLAHeUnd7MbFSoOTdaoZr
         ULmZQZhyrhmj2+uRdrvF4ABssIFaQYNyQlXBYdz0ZFZ0kKv2lr09kMLpkIN0m5r0jhs7
         2TZWO2YKKthdrcw4iWZbPe+NsQtMs/PhPk1D2bn6e6mvg6YEzkpToO7bLdZCa8cNSCfa
         H/8A8rm5ED3Pp+n4LXqC1O7Vd8Wn/FdG9FHQVFHjjXITfOLVCN9lpJuXJg5evo64ygbw
         sX/7DjDU7flYtNsJ1211dOQNh3k4xpSuqRVUUtwMGJUYjGkbMNphTWk8aNnPEY/WDzOx
         KXFw==
X-Gm-Message-State: AOJu0Yx7wIe3gRaNPtTvdOqsId2mORzGj7yql+JFvWFW0+pobOi2Ba82
	YKv3ebWNG+uEN0gMyjz5ZL7zbq98iW2ZA0+ZZUfmZ+MFjcmZyjM1V7hYML5eSAvPDeukcEh1znc
	1hOJtRToHo2LGG6uKJ0wXpq4sByK1MTzNE3sD
X-Gm-Gg: ASbGncsDlvKhF89YzcrL9nSMzxYq0cTqOCOqMlpUqpFbJ7+t5Ooo+lSwqdsXtXVxSvb
	a148mW6aJtwVlfcrqJMbu90uGDjavXbGpeV8Q/L/tc8uU/JUHsU6VGpMsxmwwADvyXnzXFWaY6F
	IuBb5Cd93eeXqoL9zg/+yaNBdBd7KGXvFUyDsiDS5sFrnnN1aK25hsU+7lIcJrSjJrQvlDg6lo1
	a1FPg==
X-Google-Smtp-Source: AGHT+IFt+2nHPB8JQpdIITI0h+Uq/8SCX7DiWRhB8roUSq/6VzN8YhuMuTR6gigEwTKAESBDiYvrw4xDyi9RFTwJUGg=
X-Received: by 2002:a05:651c:b0f:b0:336:dd88:69e0 with SMTP id
 38308e7fff4ca-3513e12da16mr33352101fa.29.1757943566162; Mon, 15 Sep 2025
 06:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7fed0c48a73265242c440611825888c096c4c93a.1757712988.git.pav@iki.fi>
 <68c49f9f.050a0220.225601.db74@mx.google.com>
In-Reply-To: <68c49f9f.050a0220.225601.db74@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Sep 2025 09:39:13 -0400
X-Gm-Features: AS18NWAusDuYeHerpK_dDiDGV4PswdkscZRRTF3iCHvx72UFwVgSY9UkrKZ4KS4
Message-ID: <CABBYNZKB81S-sghOxcw-KnJUa_VMt8vTckVcfJDFAwn1J=BdoQ@mail.gmail.com>
Subject: Re: [RFC,1/2] Bluetooth: hci_core: add lockdep check to hci_conn_hash lookups
To: linux-bluetooth@vger.kernel.org
Cc: pav@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Sep 12, 2025 at 6:33=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D100=
1955
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PENDING   0.28 seconds
> GitLint                       PENDING   0.25 seconds
> SubjectPrefix                 PASS      0.22 seconds
> BuildKernel                   PASS      24.45 seconds
> CheckAllWarning               PASS      27.25 seconds
> CheckSparse                   PASS      30.74 seconds
> BuildKernel32                 PASS      24.44 seconds
> TestRunnerSetup               PASS      486.11 seconds
> TestRunner_l2cap-tester       FAIL      25.68 seconds
> TestRunner_iso-tester         FAIL      38.99 seconds
> TestRunner_bnep-tester        PASS      6.18 seconds
> TestRunner_mgmt-tester        FAIL      129.91 seconds
> TestRunner_rfcomm-tester      FAIL      9.69 seconds
> TestRunner_sco-tester         FAIL      15.34 seconds
> TestRunner_ioctl-tester       FAIL      10.41 seconds
> TestRunner_mesh-tester        FAIL      11.39 seconds
> TestRunner_smp-tester         FAIL      8.84 seconds
> TestRunner_userchan-tester    PASS      6.20 seconds
> IncrementalBuild              PENDING   0.57 seconds
>
> Details
> ##############################
> Test: CheckPatch - PENDING
> Desc: Run checkpatch.pl script
> Output:
>
> ##############################
> Test: GitLint - PENDING
> Desc: Run gitlint
> Output:
>
> ##############################
> Test: TestRunner_l2cap-tester - FAIL
> Desc: Run l2cap-tester with test-runner
> Output:
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> Total: 68, Passed: 68 (100.0%), Failed: 0, Not Run: 0
> ##############################
> Test: TestRunner_iso-tester - FAIL
> Desc: Run iso-tester with test-runner
> Output:
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> Total: 135, Passed: 135 (100.0%), Failed: 0, Not Run: 0
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.104 s=
econds
> LL Privacy - Add Device 3 (AL is full)               Failed       0.224 s=
econds
> LL Privacy - Set Flags 4 (RL is full)                Failed       0.270 s=
econds
> ##############################
> Test: TestRunner_rfcomm-tester - FAIL
> Desc: Run rfcomm-tester with test-runner
> Output:
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> Total: 11, Passed: 11 (100.0%), Failed: 0, Not Run: 0
> ##############################
> Test: TestRunner_sco-tester - FAIL
> Desc: Run sco-tester with test-runner
> Output:
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> Total: 24, Passed: 24 (100.0%), Failed: 0, Not Run: 0
> ##############################
> Test: TestRunner_ioctl-tester - FAIL
> Desc: Run ioctl-tester with test-runner
> Output:
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> Total: 28, Passed: 28 (100.0%), Failed: 0, Not Run: 0
> ##############################
> Test: TestRunner_mesh-tester - FAIL
> Desc: Run mesh-tester with test-runner
> Output:
> WARNING: suspicious RCU usage
> Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0
>
> Failed Test Cases
> Mesh - Send cancel - 1                               Timed out    2.012 s=
econds
> Mesh - Send cancel - 2                               Timed out    1.996 s=
econds
> ##############################
> Test: TestRunner_smp-tester - FAIL
> Desc: Run smp-tester with test-runner
> Output:
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage
> WARNING: suspicious RCU usage

Hmm, it would have been better that this prints the function name as
well, but it doesn't seem it prints the message from
HCI_CONN_HASH_LOCKDEP_CHECK for some reason or perhaps we are missing
some config option?

> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> ##############################
> Test: IncrementalBuild - PENDING
> Desc: Incremental build with the patches in the series
> Output:
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
