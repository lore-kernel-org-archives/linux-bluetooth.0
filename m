Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92294A21
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Apr 2025 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743971571; cv=none; b=rIw0z3etLr6y1NHw4AgN/6sNU7mM/jbluToe/SX5lKxIhbL54XJuTcI78TzMvMG9iA7t03sgBm9+tSQ05CWWCbCVVopN2p3BN5eqqtRHtsm5YXMGuIRKxtQeKYa82fnEYhYBPEJSjdypAvAWl9sjYT+b1XqTqrBGHB4vO8A4YPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743971571; c=relaxed/simple;
	bh=0SMhI6ohLfJr857JQ8spy2otIImrCtnT4dwbm9zKMz0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A3xICICD/fZiZkCbQnLCwlHtXAjdhBfF1OxKyhG3o8z06bIfCli6PhQTQnZ7p1hjmXQkagxP4eHdDqnTjDLZeXRVbGR8xp9WAYCPulYclJ4Aee8vFREeLpsOnueWF716r+/ga3d65ucGusQlh/zBoNNE0/XXD5sq11paNVy0HAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADc2aHbV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADc2aHbV"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so3537306d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Apr 2025 13:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743971568; x=1744576368; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MuetwYGiN+HkoCXYMyesgInbUVRJYglZPSsKWKOvs1A=;
        b=ADc2aHbV/awyHbKpP/rm1EAm+WOBxasCEtWSSdWH1gVLRaaxyGlfLU8PF/D5kqjDVL
         rz4540nOqa8eH2w15FgImjxAZIcc761cA+20Z5vIpo/6090yHXyN+Oj1CGkw5Drazg51
         Q6lgQL64HKlT6SoRNXIT+i6f/Iww+Sjl0P5ikooSFwoNSCqax85sC4BaYsTbJ+lMVp1H
         HSv9GoYf67e5S89tMNKEDx6LEJtFzzXyweK4EXtEfQUy0PO1NO/eep2ltrnOB6bwdJN+
         KqsIUOiJqefvVewcIvppAoeiH+tnYg8G74lq/Bj/JXJog0PBWGLy4Ul602oaN3Z0BIDw
         cvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743971568; x=1744576368;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuetwYGiN+HkoCXYMyesgInbUVRJYglZPSsKWKOvs1A=;
        b=s+5etSa8+96KIrcpdCu9E0UPQUo7nxYYG7nr4r/9nkZ5v+4SsunOSI3yd1bbM43eVw
         eq4C4Klg+UQtIOBOQrfnAFVmtn23fLIOwvM3YUqlfpPYXM7jxG5YvZAcHNNComxHt9B2
         J39lmRGEeoy0EKAt1Jjf7ZMhKgrqhBjSZo3JmWjnG0TchSIALC0F/CTKiYNm9bB/hhon
         lI6kq9ep7Lg/qtOZrTkwVsu6b0/mB7muUqOBCfK70WDvH1N6KIO3svNxIcRcLa/4bCWz
         1QJ28H3MxQbZEA6tSgxjjF7qafSh1rFGLj+AJB9Og367hWV8QbO5CuFDnm6JsJExlV2L
         NayA==
X-Gm-Message-State: AOJu0YzaG5/R/p73VQtm9eof+zkcuk1PRgdlBVK9th31AA9xNSyvOa1u
	wRC1XbB/G35MAjfuKhSvu/oj6JjtLhpbAnXu5YsXWes3McHbIIw9YHrL1w==
X-Gm-Gg: ASbGncu1FLBDmIwhH1yZxwimho/dfNG5VM1stcXs3zflxpVtGi91AfUVm++/wKqhCz8
	hpQPz/H5RSyAfTXDkSr/bVtWr1jOPD6xxRhumkqiw4PCvFNweXh5ozeCdL1zDcjWuxNixZWxzvz
	InUvqXir1bOa0YreXC79Fj2UEefWTaPOqQRlfxX1zoB7hZyxo6uq9bsv5lfo9gM3jeaX2LMVjjr
	HAOk2uL1qJFN3styKa1KyucTmbI1gmxax6PLqnIwr3QzI/6n3WjFZWLNbxvwchYMC1Wn5N+HVmp
	pFTPiTM/FWGq98317GzX2rdoeBlY8Rf+R7BedZ3AUjnyPo0R
X-Google-Smtp-Source: AGHT+IGvwa8m7LXaps5DCBV0D0cvfVN4qtrBadY2t7bCXmFDWfzH6d53ndExiCDgkroYnqNTeJmFIQ==
X-Received: by 2002:a05:6214:2a8c:b0:6ea:d033:2853 with SMTP id 6a1803df08f44-6f0584ea122mr152959646d6.16.1743971568188;
        Sun, 06 Apr 2025 13:32:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f00f2b6sm49540166d6.42.2025.04.06.13.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 13:32:47 -0700 (PDT)
Message-ID: <67f2e4ef.d40a0220.19983c.d5b8@mx.google.com>
Date: Sun, 06 Apr 2025 13:32:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0393211063392029699=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: [1/2] Bluetooth: btmrvl_sdio: Fix wakeup source leaks on device unbind
In-Reply-To: <20250406201017.47727-1-krzysztof.kozlowski@linaro.org>
References: <20250406201017.47727-1-krzysztof.kozlowski@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0393211063392029699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=950265

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      26.16 seconds
CheckAllWarning               PASS      27.32 seconds
CheckSparse                   PASS      30.67 seconds
BuildKernel32                 PASS      24.68 seconds
TestRunnerSetup               PASS      438.72 seconds
TestRunner_l2cap-tester       PASS      23.41 seconds
TestRunner_iso-tester         PASS      35.17 seconds
TestRunner_bnep-tester        PASS      4.78 seconds
TestRunner_mgmt-tester        PASS      122.06 seconds
TestRunner_rfcomm-tester      PASS      10.97 seconds
TestRunner_sco-tester         PASS      12.61 seconds
TestRunner_ioctl-tester       PASS      8.36 seconds
TestRunner_mesh-tester        PASS      6.35 seconds
TestRunner_smp-tester         PASS      7.24 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
IncrementalBuild              PENDING   0.65 seconds

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


--===============0393211063392029699==--
