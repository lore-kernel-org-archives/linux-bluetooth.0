Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A4322533
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280676; cv=none; b=O9wP1bwyzTepNtfNvy5L1su0egy8OruE04k6UgqiuB+xf/3v6B7jb/Xmse30x7yR9yS32gEzySfaJi79Rs36kfbZFV5XHXAVkEaU4VISLsj9Dh2awWaSJLWqXGz9pPG8XwVCrzvisqmaz+Asg/VpRM0EEsPyZohQDJ3YlbxvCHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280676; c=relaxed/simple;
	bh=J3eCzEAu2oRUzydRjSmgnnr5PH/nVuPQFdVrVhVV0B8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ogGVUCM3lfBn9xgCPYKUOJ45gJdXCb323Se2kEDe1Bs/JXGM+4SkstA06tW7OVfQvlp7fmXMNiaPZ9zmUrtdKtCuHz6m7ciUuEV6vKD2OxzNa1NrVoynmctwoCw2OBTcAwqbn9m1uvJfLv4bEKteORh7x5SdOIoqq0xXRplkUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaPFfF36; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaPFfF36"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-307d0405e07so1801307eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 09:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781280675; x=1781885475; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5ADqmSLAt6rZR1JOAZ+o/TnO+KilgpTyVLN17qpVO8M=;
        b=EaPFfF36p5PuKZGZyM8bl9W8/k+ti4gZOpJah8EcVdbgYPfrPRooaU2yVAm9tX/Ef4
         GoFxTkF3fbWQR0CjG+2VqCu+mR6I1iJcAz5Y1FlqjSKaWk7clo7zBKKBHPsacwPQsN3f
         oGBuam4o90gE59vKp8tT9tDlNYrZU/SOF0tmjFXjLZKhBDd5eEb8E0oj4q3TwO1sj2Ib
         pas+HQFZx3PXIbjaWPL5HWB1Ph9uP3cV0X/5xeEInNfIhgvhjfUekmvC2wMnDewDh+s7
         Bk4YQSvpejtX51kVjoBKoOZGRUSls6F/ATNsFlv8r7kBX7TEQdLHMlB4eYaBdU6tH6kH
         x7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781280675; x=1781885475;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ADqmSLAt6rZR1JOAZ+o/TnO+KilgpTyVLN17qpVO8M=;
        b=sAEoTWsmQ/FuTiSGj0CfLgcQbh5bEfwjDe8/GdFgmAtQT8YM2fcTePfbyrXOr/qepU
         VlmaFiWiwK2tXk4oKl7+Nt8tFNb9dy22AoH4rmJnMTzLTkMUjnr9FdJcH2o9BCKwBHDa
         A5sa8s1b5qeI2LUtjOIEt16AOFhO7XwvaoAghgiLjl28KNw/FbzPpsqWwHSO0jpWIWNE
         QSS/yFyLZLA8Pcm0cWHQemG4By0oqPTgOgWVo90K+y3zDgPfhHUEsnTApOs69o60J6KH
         wB4fKfucuzjSIHA8oPkq3dfS7A3T61dJrxWHNdE/pmCNHxRDWK+99BgarvRbdNo76Oa3
         7crg==
X-Gm-Message-State: AOJu0YxPhEODFtXPzP0ZwBCPxwI/QyX/1xs68ruM3tbEoyaDAv50dDk7
	JWrZm/x2kzDWnejPqOKuXrTJl20DFfc/JobnN4qF0joVB5T6L0wwtrw71VR0Cg==
X-Gm-Gg: Acq92OFe3LhjGLUgKVFfMN4miTQV1dzRVySTNqfGkyaU5xrSRvGYt60a2M4IrfsQfP7
	YsqHU1CKZvFfCle+wSxRDb0fy7QFYppSzvGKth/SiiM6bMhzVLoQPBJZSdTzy496DPTWty0o8YI
	5/pM4Rd5o+tBzustE3VUu2yCgPmrHoA0Fh7ipicfjCWvqCclMfQ7qMI4RLrJCfhGdPvMAOaNt0x
	YX+O6BPc3NmSb7MWGdvKyT15GZdODqd0HtIFedRP7ZB4XQsO6YfM5VeUQ5Zubl5euRK84UniwDh
	qkOb8UDxV7ZGPV6do0LaaNPND0ff2NqweffaPBWafZcXT+qPg7qAhwsrmOm5YBOlBBDYRmajkV1
	gEmtFtzSL1pxm37ZXAhfvZXd8XnI6Etjn82J2R6RVsPMzinSrAGTFjJoaqrKt+/r7yXqjKLHmoA
	fvD2AAmu00zQnG+m3K4Ak49c/tXC1PCQ==
X-Received: by 2002:a05:7300:5781:b0:304:3c33:7ad6 with SMTP id 5a478bee46e88-309367669c4mr221845eec.11.1781280674717;
        Fri, 12 Jun 2026 09:11:14 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.216.114])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f88bsm3977435eec.16.2026.06.12.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:11:14 -0700 (PDT)
Message-ID: <6a2c2fa2.965034cc.8c06b.70c6@mx.google.com>
Date: Fri, 12 Jun 2026 09:11:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8711764881294670207=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, stig@hornang.me
Subject: RE: Bluetooth: L2CAP: fix tx ident leak for commands without a response
In-Reply-To: <20260612143818.167643-1-stig@hornang.me>
References: <20260612143818.167643-1-stig@hornang.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8711764881294670207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1110718

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.18 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      19.74 seconds
CheckAllWarning               PASS      23.06 seconds
CheckSparse                   PASS      21.28 seconds
BuildKernel32                 PASS      20.47 seconds
TestRunnerSetup               PASS      415.18 seconds
TestRunner_l2cap-tester       PASS      47.98 seconds
IncrementalBuild              PASS      20.41 seconds



https://github.com/bluez/bluetooth-next/pull/310

---
Regards,
Linux Bluetooth


--===============8711764881294670207==--
