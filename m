Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A50157496
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545089; cv=none; b=Q0Ol4SBNGuj5GW6IeYz3sQlZzCUELtR+7PkuFFKhJYkv+THklTCvfHpIAZIwmrMN0mJw7JRdVUxUgKlQkpk61dvLwgsZFTQ0jC7zMhobZTffaAK7nUfVUIAbq9CA6BL+1Rb3MY/sXrpnmguAUTad7nS5rApaEklqXdlODf9a9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545089; c=relaxed/simple;
	bh=y1N8vecXLDG9r+koYssutEO3i1KlAFzPCGcoXdvuxKQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hogaj1uP8hKzIPEup0m8dPsb+TCFBpN12FcyyqGiXQyuwzG1e5inlX5W8upoh/kSjMGgzwhM7uArBa8aLsF7tzRXvLWEsWilcOS4B+wuvgefXItTAvA6S1G2UKykMCqOQFHAIp6fTE4ASvgIJJUFaYmkZt4pBL8EIjSkMNT+Rq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLBxaK7W; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLBxaK7W"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690e2d194f6so44645776d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 06:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711545086; x=1712149886; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg9F5lxjit7xXwA1LzPm1IIc/+DHhuaZN2sRlEqzwfo=;
        b=NLBxaK7WZCA5/db43BOKTI+01WWW4Yl11pM1d8Pr0wWZqpXtfUiYMy/sjkzNqDFC69
         t3hU/em7nBtdwt46xiR24Ti/iRPscNJq+DfTsXGVz+rsF3rDzK/MaW6CxrIFgqtZ+Q9U
         DNb8wn8O1CpTRLLGB98UDN+xkB5UBu0cwbURkZkvjdyERWcia7WaiVoE10czLGtf6r3r
         mIphFuTy3JS/KcjgwabNjYI4iEXdhCXQjUTdV5rbH9+lYOx3R9qpUGRBSahlHJOLwPYk
         n6pC3k3yr02KlbGo3d98xoz74xUrxLBLb518vRpotkMMtnytRDyGGjcHLXi/gXgCUaiy
         YEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545086; x=1712149886;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wg9F5lxjit7xXwA1LzPm1IIc/+DHhuaZN2sRlEqzwfo=;
        b=DDxE4+LD73fX9RW3FheyUsikepFSGrG97QUH2mZPfKzgKZCR9hRn+KSjtZ7IvXNdOL
         b6lK04L6mu+/7Vi7ND9e8kLnbhHTdIGsLBtg8aZMraoNjauNF0DvenQhWraYm5qpf/ye
         xUvRzdgyCSaMQLBbUBQE0ZpolLT9mir9gytfSKqtHE/0CcD+S8R6D/Bvp+2JocLexa48
         0MU/rKNRur+1yaIiEQ4+8DhZy87EAOkBdELy+mrDfmCHKIrQWQdOaVfn+/5KlgubfGWR
         s0KS4Dk0q/LXIH/XhdW76J6WX4fAZ987S1B/HiMBfgMsD+zKFRuPz8EI2IErrCET8FJ5
         zG1A==
X-Gm-Message-State: AOJu0Yz6yQyPh0bOh2z2+N18y6pXUXtKG4ihqudXi7eHF6RWLk93vxrq
	zI1ehYx8/4Bf6GorGLomxqy0BVNJpCpRyZselTKP4ogUj0WZqo9vYmJfid/A
X-Google-Smtp-Source: AGHT+IHZgSn5CAGdf9icmLB+1LYulNRZPxaajdJzB3Yu1Be9GsXDm6kYpWu8E56lsAsQ9pEaVmjOcQ==
X-Received: by 2002:a05:6214:250d:b0:696:8c86:b510 with SMTP id gf13-20020a056214250d00b006968c86b510mr1414773qvb.2.1711545086523;
        Wed, 27 Mar 2024 06:11:26 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.138.58])
        by smtp.gmail.com with ESMTPSA id t1-20020a0562140c6100b006968bde77dbsm3477503qvj.138.2024.03.27.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:11:26 -0700 (PDT)
Message-ID: <66041afe.050a0220.8c0dc.fb3b@mx.google.com>
Date: Wed, 27 Mar 2024 06:11:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1078384719758865597=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: virtio: store owner from modules with register_virtio_driver()
In-Reply-To: <20240327-module-owner-virtio-v1-1-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-1-0feffab77d99@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1078384719758865597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=838871

---Test result---

Test Summary:
CheckPatch                    PASS      11.02 seconds
GitLint                       PASS      5.32 seconds
SubjectPrefix                 FAIL      2.18 seconds
BuildKernel                   PASS      28.39 seconds
CheckAllWarning               PASS      30.91 seconds
CheckSparse                   PASS      38.98 seconds
CheckSmatch                   PASS      102.80 seconds
BuildKernel32                 PASS      27.28 seconds
TestRunnerSetup               PASS      520.10 seconds
TestRunner_l2cap-tester       PASS      20.37 seconds
TestRunner_iso-tester         PASS      30.80 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      114.76 seconds
TestRunner_rfcomm-tester      PASS      7.32 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      7.84 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      4.96 seconds
IncrementalBuild              PASS      109.17 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============1078384719758865597==--
