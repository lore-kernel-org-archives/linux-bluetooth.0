Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28104405C4D
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072995; cv=none; b=Wa9dmLRGuCEGIyHz2G8rPoy/hF1r7HeCUaJyzkRgyxM6cirVeb84KZqCNMNbg3W2ov1ACJGvoEtgMN1vpIymYRDznwVLRw0cU+3Bb/TKkb9JBNZOeNwKech5oWxL2em1eGhEqodpCGa0b8/ADervPlpVD56jxfZPUWrsnDAhS1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072995; c=relaxed/simple;
	bh=HRUZChm4dUrHg7lm+Pyr8pcCeNWZ2ViEpo2VbLjapZ4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nPyyQApeEEQbnJ3I0/IDvy39Ipb5rLD17Fxs0XS7YREXFaEeyr+hY9li4TQPpVYsJ/D7/70SmpdFia4M523FmNZjeyUBA8TBpkdg1t6RBZUHt3/iCFiXs/Cs679UoaxiWtpKjlg0fyPJjGZXpwLFsxCRT4qUMpiKnySNA9sQSt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF/XebbT; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF/XebbT"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-303dbfbec77so599104eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 19:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779072993; x=1779677793; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vYuiYCuN6V/xx4HSJfEzMshQbACN89RvvrVsBce0pZw=;
        b=nF/XebbTbwfyGMlrHjl4m1LN2l6yLcnh/EwxoUiF4pxzmZGTnYFx6Fz8hEYSQOytIo
         zBsdxRQqc+lVvAp0wtLOJdbx/EudwvTztn/7m1GEwV7WNz6QBqP88UeUjqhMsbmh+Zo7
         5nesAtgEFZZE0NYevPQFYF+LmRwfdYp/xH3/64F31QKxPAbfp3Map28I3d71ryM2GYCe
         5plgMC9hNAnordjHOar3nsipTXTOSta5RpQT8UdlWCHqc4Jhzni7IcOSISsB9WYfk4R+
         fPP9l7aAtNguOLPPfqbhMrQhRrpMBCe6MEA9icZE6OFWOf9t/qcyPGhBEnfC+bq0Bly0
         Nc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779072993; x=1779677793;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYuiYCuN6V/xx4HSJfEzMshQbACN89RvvrVsBce0pZw=;
        b=Q3ll9lvFBkAbFrpKR1hkoHNKEcR4GGRY/o1bQxo/DomVAs/sEm589G3len/Ap2r/kR
         uG95L7V8+LCvWRF/zLBtbCEkwJZ1QPHjCJyMHdGISAben39UwNC82/6gse9bsbGiC1Dj
         UnqZw4a/iiJIJe61HH9TxSDQ3iDE7Oe1zFxrFWydW1bNQEF1DTIiSKV3WIN/ZDioDklJ
         KX8fdSEh+Y8sPt++4Tir9mDydvw3/LplOuQ4KANOM0tCxMsAyhy5FMAZcNZ/g1BTpE+y
         uaAH7fxd+X5pqlB+TPP+r3avGs62loVRs8iTd8sswVAJoqsgeqtcFkSr+5Uq0sQi4ixn
         OYZQ==
X-Gm-Message-State: AOJu0YzCS7makRC+WUFNkXWEsd6/+j7mKXvlnkodPGY7hS6JyVniQfSq
	hlGdyl313lImHk4OigQ2ksYq6EgNcHgZxflEsB5AWamjiysVJsNG5C/FuZWGwA==
X-Gm-Gg: Acq92OGsmtz3uVJCh7eSQkkdJgYjzBSn4jWpSmWgK3fMbuNO8pmyMuRxVH1Hvnm9bxg
	nasxEJqgDGJgfjtVcC5eAL9akrn6MDj3UlpdAajnRE4MPERA4KCbisTIutpqU66VgMc45Dmpu5T
	MoigLX7DCfSTHlShNPJZkg8QB68ZUoCk61fOyaGMLtHcgKRjK83pG9/RaJvILO+oCcqSlmtnucx
	/XSJRcGI5jK+X4ofP2kTj8nBycFJfTUO5UtBtwqBBTI02tfZLhFYHHv8JHxLNvXUDI9+dYo/pyX
	BKtuboaEDeoowwmjHfgcODVWHcyKx7idaw4oXS/zTlpCxTkKPevLGGgZKgQS1Yy9o3cYVLSgWY/
	o031mEJJYiWDu0WAE/gRbjWeQrqHsq6mY7+JyBWKz+m5lznrNs0/+hR7huUlwt46hBo2y2PAnTt
	MMrNFOBgfTgL3m8HUuPPa5tpjxd+sMnJs=
X-Received: by 2002:a05:7301:7c0b:b0:2e6:e77d:7bcf with SMTP id 5a478bee46e88-30398618b7cmr6201390eec.22.1779072993239;
        Sun, 17 May 2026 19:56:33 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.160.164])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bcc5asm12746894eec.22.2026.05.17.19.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 19:56:32 -0700 (PDT)
Message-ID: <6a0a7fe0.fb1bf61a.3bbfe1.cf80@mx.google.com>
Date: Sun, 17 May 2026 19:56:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3953742951440786867=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: Bluetooth: HIDP: fix missing length checks in hidp_input_report()
In-Reply-To: <20260517234805.116570-1-meatuni001@gmail.com>
References: <20260517234805.116570-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3953742951440786867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096211

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.57 seconds
CheckAllWarning               PASS      27.88 seconds
CheckSparse                   PASS      26.78 seconds
BuildKernel32                 PASS      24.79 seconds
TestRunnerSetup               PASS      530.22 seconds
TestRunner_l2cap-tester       PASS      378.32 seconds
TestRunner_iso-tester         PASS      596.24 seconds
TestRunner_bnep-tester        PASS      18.62 seconds
TestRunner_mgmt-tester        PASS      2023.70 seconds
TestRunner_rfcomm-tester      PASS      63.42 seconds
TestRunner_sco-tester         PASS      141.24 seconds
TestRunner_ioctl-tester       PASS      133.47 seconds
TestRunner_mesh-tester        PASS      59.92 seconds
TestRunner_smp-tester         PASS      17.98 seconds
TestRunner_userchan-tester    PASS      19.13 seconds
TestRunner_6lowpan-tester     PASS      51.17 seconds
IncrementalBuild              PASS      23.75 seconds



https://github.com/bluez/bluetooth-next/pull/206

---
Regards,
Linux Bluetooth


--===============3953742951440786867==--
