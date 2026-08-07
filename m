Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9463932F0
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 04:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786076032; cv=none; b=ntiOkJDXP+fK/uMG3WE3LVt2cT8LRiU8X7noZnw3Qj50Z9/RSaZxhalvu08cYLvGtsIe+cg/6J5J2R/WPi4pjIeiFf8348rDdvEXWjT1l8TKj1V2D10Z5jqp+Uv/rOUvxSzyn9qvffu3K7qde4poXLS8IKd6OK86vd582gYchmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786076032; c=relaxed/simple;
	bh=4CYkAmpkN3Zap4tpABwjt2BqMjCdbfGrvHRBeHdq4Eo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TSKWoUf5Pe/zJgf5bSCOWf1tEbWTsuTvaDn74KiAAjYA6U8QjdFOkSSjKra/yzYfzxkKK4ASVXMbx39VH6r/NAExR4xueur5NlbxM+mzZgqO45/gWnupq60kgE0waD7wE/GSikgoXltL/KBc220dO62Boi5DNQTxR0c97y3xdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoJQcD1i; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoJQcD1i"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so24912236d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 21:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786076029; x=1786680829; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yl7JUdO3dznW2DV7ydAaUmhpSU1P5EymcySPLlPUEMY=;
        b=hoJQcD1iWRZKo4/kUS+cSXHo1Fjn9gJveVFpWaS0IBnzmnQ7qgVaHijwdNpkmL7qP8
         RW5+4JiAEYvVjhG/SZGnqpGJC17oKBbm6ZBU6PelKa69nEBMprpXVVGnvZC1GBLvr17v
         8jnZF+YX1bian6PJ94V3BHkcm04xFQ4QgSERWZlguDWFKMrOtHuh9CTVxMMk3HOWFjwF
         vcp711C51egUpzlY8NP7Xl9yDLFt6hBoLXpTiOpKyp7m0IAKGsRfNWV/G4hC+QHaNn18
         DgIhp6LbPKikv/G4jmMzCzgtu77b0InTlh+4Z1q1b7L3nqYPsh0bJvqst2HIjuW0wUut
         gFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786076029; x=1786680829;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yl7JUdO3dznW2DV7ydAaUmhpSU1P5EymcySPLlPUEMY=;
        b=eo7xFMkJfESHwJQ+ND+SAMUV2c0EE/SEYMawuFFN97AlZ+DoReuiHBzc6iEtdc+YDg
         1Hsw8n7q2tlc6Nn0Wwusq1ExeB7PaqTP/Yrr2W1TyFXqfAtPaZq+sECW6OEQIVgdtoPu
         FsSuy4zFIHyQ4GV+ODPecIFuBE7SApgAvmO/TlpIIPWjFvvqpg+5PcUkYrPIKaxz/Vw/
         PE+B1eoGbzfunAvXh049hII15YJuxsY0Pulrfs/8Pnlkwq6nOqHjbpTBDyZLtAxrBEOG
         Wim5SSwMxELXvpRDH91NxvH7PbkU5nFiBP9f5ku2FdIfa/zH0cCZIPy/LN1g7LJ7cVd+
         bFjQ==
X-Gm-Message-State: AOJu0YyRQhUA3/pB3NPwMmVEa4tz7tVQd/GoqStS11SjhvkF0tS9t+HZ
	zTSGgR1AXjqgedO179ki95hxwdfZ/tvOn4MkTju/RKalwbsrpKfQh3iDk/spTA==
X-Gm-Gg: AR+sD13QJBdoiuynXh+W24+H8JacqSnxN/I2FOooDDbdOrTfIqfEK4WCmKroxz38f7y
	xrd7ykpUaDmTDnwQmpx1I0b8tbes3y72upP7b66oGM7Q6oTTmtMAcKraBZ0OQxZikG/PDAjFV2g
	VzoNY0t7+v+pgNsP4YAebbC++Hylmv+0hdzWSnN5xZpLqEb+prpwwdLFskJpdxjcjtk2a1KNTcH
	xzOEFRofYEGuIi6xQqZ1b3Hl7FxM58QMYp6Ud4oc8apE2MZQJFNQGfp+vSSpdmYioACw7VnFEWi
	gwlHuaamVef1zH5v9npJECXgo9lWMi1KyD58MRipW5oTqzzKoBArB6UjjXkUd2tkn3yvOIO6ezi
	a8ffd5/12Wnbv3F2OTncDkCVRuzFhD6hjGhiuMEPnLUnY0ucetDQC6a8jwDpjSWcP1nvZFHrYEo
	eTxRO1/0u5HNdChq5sgopJSah/3MDyWhoPeGOB9Sg+Yg7JUHucDlqA6lCwpav9EmzVSw==
X-Received: by 2002:a05:6214:e8d:b0:907:5c68:54d1 with SMTP id 6a1803df08f44-9088126d26dmr231493076d6.18.1786076029411;
        Thu, 06 Aug 2026 21:13:49 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.239.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a918dbc5sm526126d6.3.2026.08.06.21.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:13:49 -0700 (PDT)
Message-ID: <6a755b7d.b5fd3087.3bac09.bff1@mx.google.com>
Date: Thu, 06 Aug 2026 21:13:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2376150230091862645=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ali@iusegentoo.com
Subject: RE: Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept
In-Reply-To: <20260807020345.111346-1-ali@iusegentoo.com>
References: <20260807020345.111346-1-ali@iusegentoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2376150230091862645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1141866

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.20 seconds
CheckAllWarning               PASS      28.22 seconds
CheckSparse                   PASS      26.57 seconds
BuildKernel32                 PASS      24.86 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      465.90 seconds
TestRunner_rfcomm-tester      PASS      26.00 seconds
IncrementalBuild              PASS      24.10 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept

6: B3 Line contains hard tab characters (\t): "	if (test_and_clear_bit(RFCOMM_DEFER_SETUP, &d->flags)) {"
7: B3 Line contains hard tab characters (\t): "		rfcomm_dlc_accept(d);"
8: B3 Line contains hard tab characters (\t): "		return 0;"
9: B3 Line contains hard tab characters (\t): "	}"
13: B3 Line contains hard tab characters (\t): "	struct sock *sk = d->session->sock->sk;"
26: B3 Line contains hard tab characters (\t): "	d->state = BT_CLOSED;"
27: B3 Line contains hard tab characters (\t): "	__rfcomm_dlc_close(d, err);"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/546

---
Regards,
Linux Bluetooth


--===============2376150230091862645==--
