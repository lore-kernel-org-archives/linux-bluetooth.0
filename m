Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522B151CE6
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898946; cv=none; b=A9EsPfuXWqxCLW4tQ32rFngeNnKj7xbaZ5Sxo2sFcKkn5+eNwiu6y3bRuUu72dFjb+486g5ATsKWOC9OwYCGlBN2x/PKFXw2qufs5GFytG4FzPRP5mYOS2Tyc+jqf+LpGoUaV9oQMRcm+q41UHLC5GuhewGq5OGdVkWMGW2QAzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898946; c=relaxed/simple;
	bh=BvUgP2oubJgORt/E2UwMnqEscTQ+wrB3DEGFf4eEaLA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V2iJgK04DmDXbALujIkT9Gds1YnAD+GwQVEvHeJqyhn+uQYMns5F/vwtSKoYjinRtiNdLsmgcjqZ1fay+4LbdcP2TOx1pzUGMH5qc+fWiO0cecjEV2V9B3JhUiorvsBq9SahKZgIfpwrkt3pxaOZxH+VtHHFseD6hezvFzvPCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTdaa6FK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTdaa6FK"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a4516ec5dso17342661cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Feb 2024 10:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706898943; x=1707503743; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dy/3tZeqaf7Oc3ZgvtL61+391pgiFClct4lVQ/xmDTc=;
        b=dTdaa6FKyp40/r02Zwq3U2hmsqiGrWHb2ZhNgsGVdiDANhS2/rklKdiMMtQ8JzpEJK
         Sp/cNnfubIuAbj6wH02zqEzJ1ahZxi1qHySV5nRWY3jWforpSncFggnloeTDLW0gcBU/
         sTaW2fucz02NqtFuUgw7SCsBaLUO35AbQE69XNOJCZVnHEM9va//+LpLJOj4MhFIP7JK
         U+JgFSwgrSvYpsFshUGNMACazLyG8tx/hDrxzyeYpptxndCvuHnMZ1w9uP5l1az4ggAV
         xKvl5ANOm3xMnHx2b61TTkqYWz13VC6VJsTWUqsk+hPR3MafI1Lqvs661eyzm2IhAWM6
         q74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898943; x=1707503743;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dy/3tZeqaf7Oc3ZgvtL61+391pgiFClct4lVQ/xmDTc=;
        b=DQtbypOh8eHiAv6q9stOdU0+q0ewz8BU1J+S/ZMfJ4hM2dU7mEtRPets6oYnXh+HXv
         QxUX30uiWaFz5Se3J4FqXz0wnujZfNu6JMU3aqOpIlxbsO8/aYea2ftSYgzA4dvOOoob
         DX55gAJzzHBQ4byzwaVrUSRB/NO3D0yYntyROjwZ3z7xdKfEnY4dmB+IaFTj9JIRzG+o
         Eiq8T3I+0jvbc5LgV983ISJQj5ppj8G6b0mjO7JyuaQ3E/QPV82lBanmnbJqsrD12hch
         Kub8OJWhEO5llsSvUbL0B2loJ1gm9h2Wbo7pidwiJFbjembWDFxqWZoauVJm34NyiQ0H
         12wg==
X-Gm-Message-State: AOJu0YzYQTSXiFvW96BxuKaoi7WiSb/byecgCbvEJOv8P1ZB6/jHGFw5
	ajSF1rLxO2IDbKw0XtNZvTsPnv3EDFHWcHBoLhOr0oAokGu7cCseEjwPy3/D
X-Google-Smtp-Source: AGHT+IGov7oSKrAIlfokunqH1Kq/a/NtQWGgyiIFx1t7wbTdC5Z5CMPMgbZx+el2yYA672vilpnVDA==
X-Received: by 2002:ac8:7f8f:0:b0:42b:e5e4:a6a0 with SMTP id z15-20020ac87f8f000000b0042be5e4a6a0mr7076281qtj.24.1706898943398;
        Fri, 02 Feb 2024 10:35:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzJ82bvUs4c9FfWicldtpzGwcQDlyYW+w3xxyTvddVuN2NfncSietEKF7OzZXgX40CR39glli7vqpgzSwKQEibfCAOIJVf
Received: from [172.17.0.2] ([20.109.60.255])
        by smtp.gmail.com with ESMTPSA id r12-20020ac8520c000000b0042aaa37e316sm1043500qtn.22.2024.02.02.10.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:35:43 -0800 (PST)
Message-ID: <65bd35ff.c80a0220.214e3.6a77@mx.google.com>
Date: Fri, 02 Feb 2024 10:35:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3094312335693113302=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_jhugo@quicinc.com
Subject: RE: dt-bindings: net: bluetooth: qualcomm: Fix bouncing @codeaurora
In-Reply-To: <20240202181122.4118105-1-quic_jhugo@quicinc.com>
References: <20240202181122.4118105-1-quic_jhugo@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3094312335693113302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822633

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 FAIL      0.31 seconds
BuildKernel                   PASS      29.10 seconds
CheckAllWarning               PASS      31.48 seconds
CheckSparse                   PASS      36.43 seconds
CheckSmatch                   PASS      100.67 seconds
BuildKernel32                 PASS      27.77 seconds
TestRunnerSetup               PASS      435.44 seconds
TestRunner_l2cap-tester       PASS      22.85 seconds
TestRunner_iso-tester         PASS      46.89 seconds
TestRunner_bnep-tester        PASS      6.89 seconds
TestRunner_mgmt-tester        PASS      160.45 seconds
TestRunner_rfcomm-tester      PASS      10.71 seconds
TestRunner_sco-tester         PASS      14.82 seconds
TestRunner_ioctl-tester       PASS      11.93 seconds
TestRunner_mesh-tester        PASS      8.82 seconds
TestRunner_smp-tester         PASS      9.62 seconds
TestRunner_userchan-tester    PASS      7.17 seconds
IncrementalBuild              PASS      26.42 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============3094312335693113302==--
