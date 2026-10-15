Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0635DA78
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048389; cv=none; b=Stpj1HgutOxh3XBxJ36wRxmTEVCq52s/ziXGnQ5lciwOT4P06B87uVxZBsIMyt9xreDdhi5T9RWwX2SDMdpwfaxAqhCHBzzlKqiNbqczhGZ2Vlqf5eQEWVnlHI8colW8aF089Uy372wyi6HZv+Pvr7KdbpMzuuPzmJsQRep3Fds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048389; c=relaxed/simple;
	bh=m1ErJpXhe90WQjdpwA0xHy3hw/Xh1nQV30lon2sZpfY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EVQOf+jB4ooz1vbedsVG60x3Hne0pG7FJ/kip3CPJBLk5qR3uPnv/5SMzITPqM/cGQEX4kL/1RWCZsXnh6Bx15FU38VC1vd728Tm2CON5ce42ts2GjQz93in6WJbMiEzwwV8hLxKjt33v5lghUsstryU9c4RbE7kUAZsup62U4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOGD07XK; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOGD07XK"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91b8306b9f8so58048246d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792048373; x=1792653173; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P2i+HxlaRDSNXB+4mrzFYvO8Exi/tTQ6QeyBMEK1IY0=;
        b=YOGD07XKzmOXRfdFMlUNOeRzo2jVNnJX7EE/NtvI2zHVDZhxB/DXiMDhbDxe5/URjA
         k5hj2qyHTFl/Re4GUt9IIbHXprvTYfehnCFRC7LtRfYk53IkIFVB31+QCorE4p8lM8lA
         lB0wUHVw9peDl6AabZsSGw1rIc4YuezzcvHCDKk1DUSMca4lha1l417Pnz2+IPI8zHJA
         FJxp5Vh/aU0786OKhjzjjtnkP3QN4Qe05tX2xcQYL6hd6YT3XXBMR3b2zvyy/i2Ego3/
         MJcc8fxit6elQ/uf4/ig0Egrs1ET20YVpCQ19AD1BEIahq3uGupMzHROQSAARcz4B8lO
         WZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792048373; x=1792653173;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P2i+HxlaRDSNXB+4mrzFYvO8Exi/tTQ6QeyBMEK1IY0=;
        b=2lY8KbyzsLjeIUjr1M2C1HEJPPURK1T71zvvpbGPC+ID8WjInBsxwxTdL87yx4h1/7
         MfAzAz+KLiwIHnaFLlhFAYbNM8TztRlwUPM+YfHpN1g8tganpknHaERwnQP2r4aW4xD6
         /MjH/GOUyQOBmhpyg79lxtBtm2nWEto0wZQjFRTSm72sJGuQhH4t4b9TUkMSPkQCCrsc
         6ovbwYt0g+JrAKdEH5TAWs8P+8gAdqTcogg44MH+KavJrYS/YU3NtVzbKbV74Kp+xbQk
         0/C34bGsVQ4agyF/ITqci5tkzM1Qfqn96X8kcAVkn1FsfaVJ0ME2EPyAP+XrWDRGK9GC
         Jbiw==
X-Gm-Message-State: AFq9FYIqaAyRkg4zIbonuh0pSxljKc5w/uzMxg21jwZaQjUGvKDIF/zc
	lL3XwuWLpcOdQr4rqAoV6ap3G+BG5uO/rxNZnlcOKTM5xQaCcXE35a5pk/mKrA==
X-Gm-Gg: AYBFou0cf9GkMweHQzf6ho7qk16boirDVIWHh+QHn58W3h9CNa4r5EOm2uknSkxmqV/
	jvegssdXjbgai7EvixPVvS8Jpb58uRcnAWmqgbAX/oa3mBFJ0uDCS5JoSscFETMGJ22vP4HEKwE
	QBrbI5YQ3tA+Lz0fWUc7EJxUWpeQiuC4LUfg9fp2gFqAwGnIl64FGxzEFAfOHCmKvj9aatw5Wmf
	E6S5iz4K8iwSuvNzlPqXIAsK1gNlW6I0jPhRNtuXI0LPqFFwDe4J8bzGqAx/tqG1ZKeo5KEDAGc
	LasAFQ7D/W5vXFrT1Q+DUpzERaHpE/hFEUWFV+IinWGXgvh5PADyvO7XbkS8KMqzU0o/lCgdQPe
	c5xLv8ZWsSaHv90UmAB1vBYPQtsEyGaW8av+NVtY+PqSBsWgwWzhrr0R0dH7FlyuojQrOoRW6df
	o0gvybuDaD5fcYFcdraVOkbo6y2o11hCr5o5jCdAGpScFdrp3iHWxpXJfjgnw0t3VZIdWdAdJmy
	7E1uK8=
X-Received: by 2002:a05:6214:2b8b:b0:919:5ec0:bce4 with SMTP id 6a1803df08f44-91b55576506mr307330106d6.37.1792048373301;
        Thu, 15 Oct 2026 00:12:53 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.93.132])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91babadf6b5sm39013246d6.4.2026.10.15.00.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:12:52 -0700 (PDT)
Message-ID: <6ad07cf4.edebadab.43ece.02d4@mx.google.com>
Date: Thu, 15 Oct 2026 00:12:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8135567222429633759=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC,v2] Bluetooth: l2cap: prefer compatible local LE intervals
In-Reply-To: <20261015043336.47734-1-cochcoder@proton.me>
References: <20261015043336.47734-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8135567222429633759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186108/

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.45 seconds
CheckAllWarning               PASS      33.54 seconds
CheckSparse                   PASS      37.36 seconds
BuildKernel32                 PASS      29.54 seconds
CheckKernelLLVM               PASS      34.08 seconds
TestRunnerSetup               PASS      705.13 seconds
TestRunner_l2cap-tester       PASS      12.94 seconds
IncrementalBuild              PASS      27.88 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC,v2] Bluetooth: l2cap: prefer compatible local LE intervals

22: B1 Line exceeds max length (81>80): "passes 2/4 (rejects HID/idle); this revision passes 4/4. Its full reference-guest"


https://github.com/bluez/bluetooth-next/pull/940

---
Regards,
Linux Bluetooth


--===============8135567222429633759==--
